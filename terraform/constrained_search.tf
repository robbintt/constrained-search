data "aws_route53_zone" "ftl_cc" {
  name = "ftl.cc"
}

resource "aws_route53_record" "search" {
  zone_id = data.aws_route53_zone.ftl_cc.zone_id
  name    = aws_s3_bucket.search_ftl_cc_bucket.bucket
  type    = "A"

  alias {
    name                   = "s3-website-us-east-1.amazonaws.com."
    zone_id                = aws_s3_bucket.search_ftl_cc_bucket.hosted_zone_id
    evaluate_target_health = true
  }
}

resource "aws_s3_bucket" "search_ftl_cc_bucket" {
  bucket = "search.ftl.cc"
  tags   = merge(local.base_tags, {})
}


resource "aws_s3_bucket_ownership_controls" "search_ftl_cc_bucket" {
  bucket = aws_s3_bucket.search_ftl_cc_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "search_ftl_cc_bucket" {
  bucket = aws_s3_bucket.search_ftl_cc_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "search_ftl_cc_bucket" {
  depends_on = [
    aws_s3_bucket_ownership_controls.search_ftl_cc_bucket,
    aws_s3_bucket_public_access_block.search_ftl_cc_bucket,
  ]

  bucket = aws_s3_bucket.search_ftl_cc_bucket.id
  acl    = "public-read"
}

resource "aws_s3_bucket_policy" "search_ftl_cc_s3_public_read" {
  bucket = aws_s3_bucket.search_ftl_cc_bucket.id
  policy = data.aws_iam_policy_document.search_ftl_cc_s3_public_read.json
}

resource "aws_s3_bucket_website_configuration" "search_ftl_cc" {
  bucket = aws_s3_bucket.search_ftl_cc_bucket.id

  index_document {
    suffix = "index.html"
  }
}

# nb: comment this and comment the s3 bucket policy to get the bucket ARN, they are cyclic
# policy from: https://docs.aws.amazon.com/AmazonS3/latest/user-guide/static-website-hosting.html
# wildcard principal: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document#wildcard-principal
data "aws_iam_policy_document" "search_ftl_cc_s3_public_read" {
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
      "arn:aws:s3:::search.ftl.cc/*"
    ]
  }
}

output "search_ftl_cc_s3_bucket_arn" {
  value = aws_s3_bucket.search_ftl_cc_bucket.arn
}
output "search_ftl_cc_s3_website_endpoint" {
  value = aws_s3_bucket.search_ftl_cc_bucket.website_endpoint
}
