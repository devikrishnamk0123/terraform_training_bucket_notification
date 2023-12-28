# data "aws_iam_policy_document" "topic" {
#   statement {
#     effect = "Allow"

#     principals {
#       type        = "Service"
#       identifiers = ["s3.amazonaws.com"]
#     }

#     actions   = ["SNS:Publish"]
#     resources = ["arn:aws:sns:*:*:${var.sns-topic-name}"]

#     condition {
#       test     = "ArnLike"
#       variable = "aws:SourceArn"
#       values   = [module.aws_s3_bucket.bucket_arn]
#     }
#   }
# }

# resource "aws_sns_topic" "topic" {
#   for_each = toset(var.sns-topic-names)
#   name   = each.key
#   policy = <<POLICY
#   {
#       "Version":"2012-10-17",
#       "Statement":[{
#           "Effect": "Allow",
#           "Principal": { "Service": "s3.amazonaws.com" },
#           "Action": "SNS:Publish",
#           "Resource": "arn:aws:sns:*:*:${each.key}",
#           "Condition":{
#               "ArnLike":{"aws:SourceArn":"${module.aws_s3_bucket.bucket_arn}"}
#           }
#   }   ]
# }
# POLICY
# }
