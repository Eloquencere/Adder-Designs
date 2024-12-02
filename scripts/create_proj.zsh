#!/bin/zsh

cd "$(dirname "${(%):-%x}")"

cd ..
current_project_folder=${PWD:t}
cd ..

new_project_folder=$1

if [[ $new_project_folder == $current_project_folder ]]; then
    echo "Choose a different name"
    exit
fi

cp --recursive $current_project_folder $new_project_folder
