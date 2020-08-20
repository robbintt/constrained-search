export files="
allowed_sites.txt
construct_search.js
index.html
favicon.ico
"
for file in $files
do
  aws s3 cp $file s3://adv-search-static-site-d5f00b24-956f-4d31-8eb0-44e5d7e70834
done
