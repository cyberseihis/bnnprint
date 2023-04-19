#!/bin/bash

# Get the directory path from the first argument
dirpath=$1

# Hardcoded pattern and replacement strings
pattern="winequality_red"
replacement="winered"

# Check if the directory exists
if [ ! -d "$dirpath" ]; then
    echo "Error: Directory not found"
    exit 1
fi

# Define a function to recursively search for files
function search_for_files {
    local path=$1
    for file in "$path"/*; do
        if [ -d "$file" ]; then
            search_for_files "$file"
        elif [ -f "$file" ]; then
            # Replace the pattern in the file name and rename the file
            newfilename=$(echo "$file" | sed "s/$pattern/$replacement/g")
            if [ "$newfilename" != "$file" ]; then
                mv "$file" "$newfilename"
                echo "Renamed file $file to $newfilename"
            fi

            # Replace the pattern in the file contents and write the changes back to the file
            sed -i "s/$pattern/$replacement/g" "$newfilename"
            echo "Replaced pattern in file $newfilename"
        fi
    done
}

# Call the function to search for files
search_for_files "$dirpath"

echo "Done"

