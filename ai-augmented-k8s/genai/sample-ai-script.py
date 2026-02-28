#!/usr/bin/env python3
"""Simple summarizer example (uses OpenAI-compatible API).
Replace OPENAI_API_KEY and endpoint as needed.
"""
import os
import requests

API_KEY = os.getenv("OPENAI_API_KEY")
if not API_KEY:
    print("Please set OPENAI_API_KEY environment variable")
    raise SystemExit(1)

text = """
Example alert: Pod wordpress-123 CrashLoopBackOff with OOMKilled observed repeatedly.
"""

resp = requests.post(
    "https://api.openai.com/v1/chat/completions",
    headers={"Authorization": f"Bearer {API_KEY}", "Content-Type": "application/json"},
    json={
        "model": "gpt-4o-mini",
        "messages": [{"role": "user", "content": f"Summarize: {text}"}],
        "max_tokens": 200,
    },
)
resp.raise_for_status()
print(resp.json()["choices"][0]["message"]["content"])