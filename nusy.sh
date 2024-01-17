#!/bin/bash

cd $NUGET
git add .
git commit -m "update"
git pull
git push
