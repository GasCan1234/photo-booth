#!/bin/bash

PYTHON_DIR="/home/pi/photo-booth"
TMP_DIR="tmp_convert"
IMAGE_DIR="/home/pi/photo-booth/photos"
TIME=`date +%Y-%m-%d_%H-%M-%S`
BACKGROUND_COLOR="#fcd5a5"
COUNT_PRINTS=1

#create tmp dir
cd $PYTHON_DIR
mkdir $TMP_DIR

#first convert images
convert $1 -resize 725x -gravity center -crop 725x400+0+0 $TMP_DIR/output1.jpg
convert $2 -resize 725x -gravity center -crop 725x400+0+0 $TMP_DIR/output2.jpg
convert $3 -resize 725x -gravity center -crop 725x400+0+0 $TMP_DIR/output3.jpg
convert $4 -resize 725x -gravity center -crop 725x400+0+0 $TMP_DIR/output4.jpg

#set into template
composite $TMP_DIR/output1.jpg  print_templates/epages/Template_Maske_1.jpg -geometry +134+164 $IMAGE_DIR/${TIME}_Ausdruck.png

#print Ausdruck
#lp -d photo_printer -n ${COUNT_PRINTS} $IMAGE_DIR/${TIME}_Ausdruck.png -o landscape -o fit-to-page -o media=4x6

#remove tmp_dir
rm -rf $TMP_DIR
