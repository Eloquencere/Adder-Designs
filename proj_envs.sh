#! /bin/sh

export PROJECT_ROOT_DIR=$(pwd)
export DESIGN_DIR="$PROJECT_ROOT_DIR/Designs"
source proj/cadence/cadence_proj_init.sh
source proj/mentor_graphics/mentor_proj_init.sh

mkdir -p $PROJECT_ROOT_DIR/sim_data

# open a zellij session with the same name as the project
