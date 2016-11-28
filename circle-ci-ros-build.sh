#!/usr/bin/env bash

set -e # fail on errors
# #set -x # echo commands run
# 
export docker_image=$1

export CIRCLE_REPO_DIR=$HOME
export extra_variables="$extra_variables circle_repo_dir=/host$CIRCLE_REPO_DIR  circle_is_pull_request=$CI_PULL_REQUEST circle_test_dir=/host$CI_REPORTS circle_code_coverage_dir=/host$CIRCLE_ARTIFACTS"
export CATKIN_WS=/root/catkin_ws/src

# Download docker image
sudo docker pull $docker_image

sudo docker run -v $CIRCLE_REPO_DIR:$CATKIN_WS \
                -v $CI_REPORTS:/host$CI_REPORTS:rw \
                -v $CIRCLE_ARTIFACTS:/host$CIRCLE_ARTIFACTS:rw \
                $docker_image
