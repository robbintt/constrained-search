export files="
sites.json
functions.js
init.js
index.html
favicon.ico
"
for file in $files
do
  aws s3 cp $file s3://search.tauinformatics.com
done
