#!/bin/bash
# define layouts array

# style layout symbols
typeset -A layouts=(
[tile]=""
[rtile]=""
[mono]=""
[none]=""
[grid]=""
[spiral]=""
[dwindle]=""
[tstack]=""
)

layout=$(dkcmd status num=1 | grep '^L' | sed 's/^L//')
layout="${layouts[$layout]}"
echo $layout
