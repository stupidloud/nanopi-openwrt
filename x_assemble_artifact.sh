gzip friendlywrt-*/out/*.img
rm -rf ./artifact/ && mkdir -p ./artifact/
mv friendlywrt-*/out/*img.gz ./artifact/
cp friendlywrt-*/friendlywrt/.config ./artifact/
cd ./artifact/
md5sum *img* > md5sum.txt
cd ..
zip -r artifact.zip ./artifact/
