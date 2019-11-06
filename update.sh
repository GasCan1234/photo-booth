#!/bin/bash
echo "##########################"
echo "### UPDATE Photo-Booth ###"
echo "##########################"

git status
read -p "Are you sure to overwrite local changes and update? (type: y)" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
	echo "### UPDATE START ###"
	git add .
    git reset --hard HEAD
    git pull origin master
	echo "### UPDATE DONE ###"
fi

