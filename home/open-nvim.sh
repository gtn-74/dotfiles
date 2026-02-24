#!/bin/bash

# @raycast.schemaVersion 1
# @raycast.title Open Nvim
# @raycast.mode silent
# @raycast.icon 📝
# @raycast.argument1 { "type": "dropdown", "placeholder": "project", "data": [{"title": "menuapp", "value": "~/projects/menuapp"}, {"title": "tarot-app", "value": "~/projects/tarot-app"}, {"title": "dotfiles", "value": "~/dotfiles"}] }

DIR="${1/#\~/$HOME}"
open -a WezTerm -n --args start --cwd "$DIR" -- nvim .