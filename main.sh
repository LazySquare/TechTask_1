#!/bin/bash

if [ $# -ne 2 ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

input_dir=$1
output_dir=$2

cd "$input_dir"

function my_func {
    current_dir="$1"
    for file in "$current_dir"/*; do
        if [ -d "$file" ]; then
            my_func "$file"
        else 
            name="${file##*/}"
            final="${file#*.}"
            if [ -f "$output_dir"/"$name" ]; then
                count=1
                while [ -f "$output_dir"/"$name"_$count ]; do
                    count=$[$count + 1]
                done 
                cp "$file" "$output_dir"/"${name%.*}"_$count.$final
            else
            cp "$file" "$output_dir"
            fi
        fi
    done
}


my_func "$input_dir"
