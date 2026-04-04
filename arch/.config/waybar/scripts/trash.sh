#!/bin/bash
count=$(ls ~/.local/share/Trash/files/ 2>/dev/null | wc -l)
if [ "$count" -gt 0 ]; then
    echo "{\"text\": \"󰩹 ${count}\", \"tooltip\": \"ゴミ箱: ${count}件\", \"class\": \"has-items\"}"
else
    echo "{\"text\": \"󰩹\", \"tooltip\": \"ゴミ箱は空\", \"class\": \"empty\"}"
fi
