#!/bin/bash

echo "start deploy my blog source..."
git pull
git status
git add *
git status
git commit -m "add a article or modify resources"
git push origin master
echo "successful commit to blog source"
