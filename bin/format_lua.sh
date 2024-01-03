#!/bin/bash

IF [ "$#" -ne 1 ]; then
    echo "Usage: $0 <root_dir>"
    exit 1
fi
ROOT_DIR=$1
stylua $ROOT_DIR/**/*.lua
