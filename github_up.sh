#!/bin/bash

GIT_REPO="https://github.com/ivando0209/my_shell_script.git"

git init

git  remote add origin $GIT_REPO

git pull origin master

git branch

git status

git add .

git commit -m "the first commit"

git push -u origin master


git log

echo "Push Done"


