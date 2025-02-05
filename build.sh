#!/usr/bin/env bash

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

BIN_DIR="$SCRIPT_DIR/build"
AS="$SCRIPT_DIR/tools/sysdarft-system"
SOURCE_ROOT="$SCRIPT_DIR"

cd "$SCRIPT_DIR" || exit 1

if ! [ -e "$BIN_DIR" ]; then
    echo "Creating runtime build directory..."
    mkdir -p "$BIN_DIR"
else
    echo "Runtime directory is already created, skipping..."
fi

g_build_target=""

function add_target()
{
    g_build_target="$g_build_target \"$BIN_DIR/$1\""
    local target="$1"
    local include="$SOURCE_ROOT/$2"
    local sysdarft_cmd_arg=""

    shift 2
    for file in "$@"; do
        sysdarft_cmd_arg+=" -c $SOURCE_ROOT/$file"
    done

    sysdarft_cmd_arg+=" -I $include "

    echo "Building $target..."
    echo -e "$AS $sysdarft_cmd_arg" -o "$BIN_DIR/$target" -f bin
    echo -ne "\033[31;1m"
    if ! echo "$sysdarft_cmd_arg" -f bin -o "$BIN_DIR/$target" | xargs "$AS" 2>&1; then
        echo -ne "\033[0m"
        exit 1
    fi

    if ! echo "$sysdarft_cmd_arg" -f sys -o "$BIN_DIR/$target.sys" | xargs "$AS"; then
        echo -ne "\033[0m"
        exit 1
    fi

    echo -ne "\033[0m"
}

function clean_target()
{
    for FILE in $(cat "$BIN_DIR"/target.s);
    do
        TargetLocation="${FILE//\"/}"
        echo "Cleaning $TargetLocation..."
        rm -rf "$TargetLocation"
    done
}

function disassmeble()
{
    if [[ "X$1" = "XBIOS" ]]; then
        "$AS" -d "$BIN_DIR/bios.bin.sys" -V -g 0xC1800
        exit $?
    fi

    echo -e "Unknown target" >&2
    exit 1
}

if [[ "X$1" = "Xclean" ]]; then
    clean_target
    exit 0
fi

if [[ "X$1" = "Xd" ]]; then
    disassmeble "$2"
    exit 0
fi

echo "Building BIOS firmware..."
add_target bios.bin BIOS/include    \
    BIOS/main.asm                   \
    BIOS/int_hdler.asm              \
    BIOS/stack_frame.asm            \
    BIOS/printf.asm

echo "$g_build_target" > "$BIN_DIR"/target.s
