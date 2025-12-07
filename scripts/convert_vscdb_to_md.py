#!/usr/bin/env python3
import os
import sys
import sqlite3
import json
from datetime import datetime
from pathlib import Path
import re

def load_rows(db_path):
    conn = sqlite3.connect(db_path)
    try:
        cur = conn.cursor()
        patterns = [
            "memento/icube-ai-ng-chat-storage%",
            "memento/icube-ai-chat-storage%",
            "memento/%chat%",
            "chat.%",
            "ChatStore",
            "icube-ai-agent-storage-input-history%",
            "currentAgentData_%"
        ]
        rows = []
        for p in patterns:
            cur.execute("SELECT key, value FROM ItemTable WHERE key LIKE ?", (p,))
            rows.extend(cur.fetchall())
        return rows
    finally:
        conn.close()

def try_json_loads(s):
    try:
        if isinstance(s, bytes):
            try:
                s = s.decode('utf-8', errors='ignore')
            except Exception:
                s = str(s)
        obj = json.loads(s)
        if isinstance(obj, str):
            try:
                obj2 = json.loads(obj)
                return obj2
            except Exception:
                return obj
        return obj
    except Exception:
        return s

def iso(ts):
    try:
        if isinstance(ts, (int, float)):
            return datetime.fromtimestamp(ts/1000 if ts > 2_000_000_000_000 else ts).isoformat(timespec="seconds")
        return str(ts)
    except Exception:
        return str(ts)

def extract_messages(value_obj):
    if isinstance(value_obj, dict):
        for k in ("messages", "data", "value", "items"):
            v = value_obj.get(k)
            if isinstance(v, list):
                return v
        # icube-ai input history structure
        if "history" in value_obj and isinstance(value_obj["history"], list):
            return value_obj["history"]
        return []
    if isinstance(value_obj, list):
        return value_obj
    # Fallback: try to pull inputText via regex from raw string
    if isinstance(value_obj, str):
        hits = re.findall(r'"inputText"\s*:\s*"([\s\S]*?)"', value_obj)
        if hits:
            return [{"inputText": h} for h in hits]
    return []

def role_name(r):
    if not r:
        return "未知"
    rl = str(r).lower()
    if "user" in rl:
        return "用户"
    if "assistant" in rl or "bot" in rl or "ai" in rl:
        return "助手"
    return r

def format_block(text):
    if text is None:
        return ""
    t = str(text)
    if "```" in t:
        return t
    if any(x in t for x in ("#!/bin", "import ", "SELECT ", "git ", "curl ", "python ", "bash ")):
        return "```\n" + t + "\n```"
    return t

def sanitize(text):
    if text is None:
        return ""
    t = str(text)
    # Redact GitHub tokens and bearer strings
    t = re.sub(r"ghp_[A-Za-z0-9]{20,}", "[REDACTED_TOKEN]", t)
    t = re.sub(r"Bearer\s+[A-Za-z0-9._-]+", "Bearer [REDACTED]", t)
    # Redact SSH keys
    t = re.sub(r"-----BEGIN[\s\S]*?PRIVATE KEY-----", "[REDACTED_PRIVATE_KEY]", t)
    # Redact email addresses
    t = re.sub(r"[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+", "[REDACTED_EMAIL]", t)
    return t

def convert(db_path, output_md):
    rows = load_rows(db_path)
    # 组装消息列表并按日期分组
    sessions = []
    for key, value in rows:
        value_obj = try_json_loads(value)
        msgs = extract_messages(value_obj)
        for m in msgs:
            if isinstance(m, dict):
                ts_raw = m.get("createdAt") or m.get("timestamp") or m.get("time")
                ts_iso = iso(ts_raw)
                # 提取日期与时间
                date_part = ts_iso[:10] if len(ts_iso) >= 10 else "未知日期"
                time_part = ts_iso[11:16] if len(ts_iso) >= 16 else "--:--"
                role = role_name(m.get("role") or m.get("sender") or m.get("author") or ("用户" if "inputText" in m else None))
                content = m.get("content") or m.get("text") or m.get("message") or m.get("inputText") or ""
                sessions.append({
                    "date": date_part,
                    "time": time_part,
                    "role": role,
                    "content": sanitize(content),
                    "key": key
                })
    # 按日期排序
    sessions.sort(key=lambda x: (x["date"], x["time"]))

    # 生成history.log风格Markdown
    lines = []
    lines.append("TRAE_RTL 交互历史记录（来自 VS Code state.vscdb）")
    lines.append(f"生成时间: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    lines.append("")
    lines.append("来源与范围:")
    lines.append(f"- 来源: VS Code 全局存储 state.vscdb；解析键 memento/*chat*")
    lines.append(f"- 路径: {db_path}")
    lines.append("- 说明: 已根据存储结构尽力解析消息；若内容为空，可能是插件键名或结构不同")
    lines.append("")

    # 分组输出
    current_date = None
    for msg in sessions:
        if msg["date"] != current_date:
            current_date = msg["date"]
            lines.append(f"====== {current_date}（state.vscdb） ======")
            lines.append("")
        # 首行：时间与角色
        lines.append(f"[{msg['time']}] {msg['role']}:")
        # 内容
        content = msg["content"].strip()
        preview = content.splitlines()[0] if content else ""
        lines.append(f"- 内容: {preview}")
        # 代码片段：若检测到命令或三引号，则完整附上
        is_code = ("```" in content or any(content.strip().startswith(p) for p in ("git ", "curl ", "python ", "bash ", "SELECT ", "#!/")))
        if is_code:
            lines.append("- 代码片段:")
            # 若原文已有三引号，原样输出，否则包裹
            if "```" in content:
                lines.append(content)
            else:
                lines.append("  ```")
                lines.append("  " + content.replace("\n", "\n  "))
                lines.append("  ```")
        # 结果占位
        lines.append("- 结果: （无）")
        # 备注包含存储键
        lines.append(f"- 备注: 存储键 `{msg['key']}`")
        lines.append("")

    Path(output_md).parent.mkdir(parents=True, exist_ok=True)
    Path(output_md).write_text("\n".join(lines), encoding="utf-8")
    return output_md

def main():
    args = sys.argv[1:]
    if not args:
        default_db = Path.home() / "Library" / "Application Support" / "Code" / "User" / "globalStorage" / "state.vscdb"
        db_path = os.environ.get("VSCDB_PATH", str(default_db))
        out_md = os.environ.get("OUT_MD", "PRD/chat_from_vscdb.md")
    elif len(args) == 1:
        db_path = args[0]
        out_md = "PRD/chat_from_vscdb.md"
    else:
        db_path = args[0]
        out_md = args[1]
    output = convert(db_path, out_md)
    print(output)

if __name__ == "__main__":
    main()