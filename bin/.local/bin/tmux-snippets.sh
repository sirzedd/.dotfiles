#!/bin/bash

# Convert this to RUST or GO
# find ~/.dotfiles/snippets -type f | fzf --preview 'cat {}'
# selected=$(find ~/.dotfiles/snippets -type f | tr ' ' '\n' | fzf)
selected=$(fd . ~/.dotfiles/snippets | fzf --preview 'bat --style numbers,changes --color=always {}')

#echo $selected
#cat $selected | pbcopy ;
export SNIPPET_FILE_FOUND=$selected
#$(rusty-snippets)

#  # Might be nice to identify any queries it has and take user input to fill them out, then copy. 
#  # Maybe based on brackets like {class name} then "Enter class name: " prompt.  Replace all {class name} with query.
#  file_content=$(cat $selected)
#  
#  #queries=($(echo "$file_content" | grep -Eo '{{.*}}'))
#  
#  queries=$(grep -Eo '{{.*}}' <<< "$file_content")
#  
#  echo "Queries found $queries"
#  
#  #while IFS= read -r line; do
#  #  echo "lines $line"
#  #  read -p "Enter $line: " query
#  #  file_content=${file_content//$i/$query}
#  #done <<< "$queries"
#  
#  #while IFS= read -r line; do
#  #  read -u 1 -p "Query $line: " 
#  #  file_content=${file_content//$line/$REPLY}
#  #done <<< $queries
#  
#  echo $file_content
#  
#  for i in $queries
#   do
#      read -p "Enter $i: " query
#      file_content=${file_content//$i/$query}
#      echo $file_content
#   done
#  
#  echo $file_content | pbcopy ;
