export files="
allowed_sites.txt
construct_search.js
index.html
favicon.ico
"
for file in $files
do
  aws s3 cp $file s3://search.tauinformatics.com
done
