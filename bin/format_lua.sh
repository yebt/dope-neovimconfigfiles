#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <root_dir>"
    exit 1
fi
ROOT_DIR=$1
cd $ROOT_DIR
echo "Running formatter in $ROOT_DIR"
stylua -g '**/*.lua' -- ./