

resource "aws_s3_bucket" "search_site_bucket" {
  bucket = "search-static-site-d5f00b24-956f-4d31-8eb0-44e5d7e70834"
  tags   = merge(local.base_tags, {})
  acl    = "public-read"
  policy = data.aws_iam_policy_document.s3_public_read.json

  website {
    index_document = "index.html"
  }
}

# nb: comment this and comment the s3 bucket policy to get the bucket ARN, they are cyclic
# policy from: https://docs.aws.amazon.com/AmazonS3/latest/user-guide/static-website-hosting.html
# wildcard principal: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document#wildcard-principal
data "aws_iam_policy_document" "s3_public_read" {
  statement {
    sid = "PublicReadGetObject"
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    actions = [
      "s3:getobject"
    ]
    resources = [
      "arn:aws:s3:::search-static-site-d5f00b24-956f-4d31-8eb0-44e5d7e70834/*"
    ]
  }
}

output "search_s3_bucket_arn" {
  value = aws_s3_bucket.search_site_bucket.arn
}
output "search_s3_website_endpoint" {
  value = aws_s3_bucket.search_site_bucket.website_endpoint
}
