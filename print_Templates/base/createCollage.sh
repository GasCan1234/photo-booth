#!/bin/bash

TEMPLATE_DIR = $PWD
PYTHON_DIR="$TEMPLATE_DIR/../.."
TMP_DIR="tmp_convert"
IMAGE_DIR="photos"
TIME=`date +%Y-%m-%d_%H-%M-%S`
COUNT_PRINTS=1

#create tmp dir
cd $PYTHON_DIR
mkdir $TMP_DIR

#first convert images
convert $1 -resize 725x -gravity center -crop 725x400+0+0 $TMP_DIR/output1.jpg
convert $2 -resize 725x -gravity center -crop 725x400+0+0 $TMP_DIR/output2.jpg
convert $3 -resize 725x -gravity center -crop 725x400+0+0 $TMP_DIR/output3.jpg
convert $4 -resize 725x -gravity center -crop 725x400+0+0 $TMP_DIR/output4.jpg

#get random Template_Maske
TEPMLATE_FILE = `ls $TEMPLATE_DIR/Template_Maske* | shuf -n 1`

#set into template
composite $TMP_DIR/output1.jpg  $TEPMLATE_FILE -geometry +134+164 $TMP_DIR/output_Ausdruck.jpg
composite $TMP_DIR/output2.jpg  $TMP_DIR/output_Ausdruck.jpg -geometry +930+164 $TMP_DIR/output_Ausdruck.jpg
composite $TMP_DIR/output3.jpg  $TMP_DIR/output_Ausdruck.jpg -geometry +134+616 $TMP_DIR/output_Ausdruck.jpg
composite $TMP_DIR/output4.jpg  $TMP_DIR/output_Ausdruck.jpg -geometry +930+616 $IMAGE_DIR/${TIME}_Ausdruck.jpg

#print Ausdruck
lp -d photo_printer -n ${COUNT_PRINTS} $IMAGE_DIR/${TIME}_Ausdruck.jpg -o landscape -o fit-to-page -o media=4x6

#remove tmp_dir
rm -rf $TMP_DIR
