#! /bin/bash

function update_gitignore {
    base_directory=$1
    filedir=$2
    echo $filedir >> "$base_directory/.gitignore"
}

function scan_files {
    base_directory=$1
    filesz_limit=$2
    update_gitignore=$3
    folder_basename=$4
    echo "---------------*----------------"
    echo "Selected Directory : $base_directory"
    echo "File size limit : $filesz_limit"
    
    find $base_directory -type d | while read -r innerdir
    do
        skipdir=".git"
        if [ -z "${innerdir##*$skipdir*}" ] ; then
            echo "Skipping $innerdir"
            continue
        fi
        echo "---------------*----------------"
        echo -e "Current Dir : $innerdir"
        echo "---------------*----------------"
        files=$(find $innerdir -type f)
        for filename in $files; do
            if [ -z "${filename##*$skipdir*}" ] ; then
                echo "Skipping $filename"
                continue
            fi
            filesz=$(stat -c %s $filename)
            if [[ $filesz -gt $filesz_limit && $update_gitignore = true ]]; then
                inner_dirbasename="${filename#*$folder_basename/}"
                update_gitignore $base_directory $inner_dirbasename
                echo "File : $filename | Size : $filesz - TRNSFRD - $inner_dirbasename"
            elif [[ $filesz -gt filesz_limit ]]; then
                echo "File : $filename | Size : $filesz"
            fi
        done
    done

}


if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <Repoistory Directory>"
    exit 1
fi

search_folder=$1
declare -i size_limit=$2
declare -i byte_to_mb=1000000
update_gitignore=true
folder_basename=$(basename $search_folder)

# echo $search_folder $((size_limit * byte_to_mb))
scan_files $search_folder $((size_limit * byte_to_mb)) $update_gitignore $folder_basename