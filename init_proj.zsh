#! /bin/zsh

cd "$(dirname "${(%):-%x}")"

export PROJECT_ROOT_DIR=$(pwd)
export DESIGN_DIR="$PROJECT_ROOT_DIR/hdl"
export TOOL_PROJECTS_DIR=$PROJECT_ROOT_DIR/proj

source $TOOL_PROJECTS_DIR/init_tool_projects_env.zsh

\zellij attach "$(basename ${PROJECT_ROOT_DIR})" --create

