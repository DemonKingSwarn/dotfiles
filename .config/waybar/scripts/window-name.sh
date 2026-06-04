#!/usr/bin/env bash

class=$(niri msg focused-window | grep -E "App ID: .[a-zA-Z0-9_-]*" | cut -d'"' -f2)

case "$class" in
	com.mitchellh.ghostty) echo Ghostty ;;
	Helium) echo Helium ;;
	*) niri msg focused-window | grep -Eo "Title: .[a-zA-Z0-9_-]*" | cut -d'"' -f2 ;;
esac
