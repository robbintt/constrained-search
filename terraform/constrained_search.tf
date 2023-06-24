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

resource "aws_s3_bucket" "search_site_bucket" {
  bucket = "search.tauinformatics.com"
  tags   = merge(local.base_tags, {})
  acl    = "public-read"
  policy = data.aws_iam_policy_document.s3_public_read.json

  website {
    index_document = "index.html"
  }
}

# note there is a new aws_s3_bucket_website_configuration resource... maybe try it
resource "aws_s3_bucket" "search_ftl_cc_bucket" {
  bucket = "search.ftl.cc"
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
      "arn:aws:s3:::search.tauinformatics.com/*",
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
