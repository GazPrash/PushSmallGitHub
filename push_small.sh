#! /bin/bash

function update_gitignore {
    base_directory=$1
    filedir=$2

    if [ -f "$base_directory/.gitignore" ]; then
        echo -e ".gitignore file created at Base \n"
    fi
    echo $filedir > "$base_directory/.gitignore"
}


function scan_files {
    base_directory=$1
    filesz_limit=$2
    update_gitignore=$3
    echo -e "Selected Directory : $base_directory \n"
    echo -e "File size limit : $filesz_limit \n"
    echo "-------------------------------------"
    
    find $base_directory -type d | while read -r innerdir
    do
        echo -e "Dir is : $innerdir \n"
        echo "-----------------------"
        files=$(find "$innerdir" -type f)
        for filename in $files; do
            filesz=$(stat -c %s $filename)
            if [ $filesz -gt $filesz_limit && $update_gitignore ]; then
                update_gitignore $base_directory $filename
                echo "File : $filename | Size : $filesz - TRNSFRD"
            elif [ $filesz -gt filesz_limit ]; then
                echo "File : $filename | Size : $filesz"
            fi
        done
    done

}


if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <Repoistory Directory>"
    exit 1
fi

search_folder=$1
echo $search_folder