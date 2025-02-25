#Write a script that reads a text file and counts the occurrences of each word, 
#displaying the top 5 most frequent words along with their counts.

#requirements:
#text file loc
#while loop to read the text file

#!/bin/bash

#!/bin/bash

# Check if a file argument is provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 filename"
    exit 1
fi

# Assign the first argument to a variable
FILE="$1"

# Check if the file exists
if [ ! -f "$FILE" ]; then
    echo "Error: File not found!"
    exit 1
fi

# Read the file, convert to lowercase, extract words, sort, count occurrences, sort by frequency, and get the top 5
tr '[:upper:]' '[:lower:]' < "$FILE" |  # Convert to lowercase
tr -c '[:alnum:]' '[\n*]' |              # Replace non-alphanumeric characters with newlines
grep -v '^$' |                           # Remove empty lines
sort |                                   # Sort words alphabetically
uniq -c |                                # Count occurrences
sort -nr |                               # Sort numerically in descending order
head -n 5                                # Display the top 5 words
