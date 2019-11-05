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
convert $1 -resize 736x -gravity center -crop 736x410+0+0 $TMP_DIR/output1.jpg
convert $2 -resize 736x -gravity center -crop 736x410+0+0 $TMP_DIR/output2.jpg
convert $3 -resize 736x -gravity center -crop 736x410+0+0 $TMP_DIR/output3.jpg
convert $4 -resize 736x -gravity center -crop 736x410+0+0 $TMP_DIR/output4.jpg

#make collage
montage -tile 2x2 -geometry +40+10 -background ${BACKGROUND_COLOR} $TMP_DIR/output*.jpg  $TMP_DIR/montage_2x2.png

#crop montage
convert $TMP_DIR/montage_2x2.png -gravity center -crop 1550x841+0+0 $TMP_DIR/montage_crop.jpg

#set into template
composite $TMP_DIR/montage_crop.jpg  Template_Maske.png -geometry +100+260 $IMAGE_DIR/${TIME}_Ausdruck.png

#print Ausdruck
lp -d photo_printer -n ${COUNT_PRINTS} $IMAGE_DIR/${TIME}_Ausdruck.png -o landscape -o fit-to-page -o media=4x6

#remove tmp_dir
rm -rf $TMP_DIR
