#!/usr/bin/env bash
wal -i ${HOME}/Pictures/walls -n
waypaper --wallpaper "$(< ${HOME}/.cache/wal/wal)"
${HOME}/.config/hypr/obwal.sh ${HOME}/Documents/library
