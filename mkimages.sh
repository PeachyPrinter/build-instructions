export LIGHTBOX_SIZE=500x500
export SLIDER_SIZE=522x350
for i in images/**/*
do
  echo $i
  DIR=`dirname $i`
  mkdir -p lightbox/$DIR
  mkdir -p slider/$DIR
  convert -resize $LIGHTBOX_SIZE $i -background none -gravity center -extent $LIGHTBOX_SIZE lightbox/$i
  convert -resize $SLIDER_SIZE $i -background none -gravity center -extent $SLIDER_SIZE slider/$i
done


