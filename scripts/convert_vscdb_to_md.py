#!/usr/bin/env python3
import os
import sys
import sqlite3
import json
from datetime import datetime
from pathlib import Path

def load_rows(db_path):
    conn = sqlite3.connect(db_path)
    try:
        cur = conn.cursor()
        patterns = [
            "memento/icube-ai-ng-chat-storage%",
            "memento/icube-ai-chat-storage%",
            "memento/%chat%",
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
        return []
    if isinstance(value_obj, list):
        return value_obj
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

def convert(db_path, output_md):
    rows = load_rows(db_path)
    lines = []
    lines.append(f"# VS Code state.vscdb 聊天记录导出")
    lines.append("")
    lines.append(f"> 导出时间: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    lines.append(f"> 数据库: {db_path}")
    lines.append("")
    for idx, (key, value) in enumerate(rows, 1):
        value_obj = try_json_loads(value)
        msgs = extract_messages(value_obj)
        lines.append(f"## 会话 {idx}")
        lines.append(f"- 存储键: `{key}`")
        lines.append("")
        for m in msgs:
            if isinstance(m, dict):
                ts = m.get("createdAt") or m.get("timestamp") or m.get("time") or ""
                role = role_name(m.get("role") or m.get("sender") or m.get("author"))
                content = m.get("content") or m.get("text") or m.get("message") or ""
                lines.append(f"### {role} | {iso(ts)}")
                lines.append("")
                lines.append(format_block(content))
                lines.append("")
            else:
                lines.append(str(m))
                lines.append("")
        lines.append("---")
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