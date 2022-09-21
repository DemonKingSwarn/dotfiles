#!/usr/bin/env python3

import os

url = "https://github.com/DemonKingSwarn/dotfiles-3/raw/main/.config/dunst/notif.ogg"

if os.listdir()[0] == 'notif.ogg':
    print("notif.ogg is there!")
else:
    print("downloading notif.ogg...")
    os.system(f"wget {url}")
