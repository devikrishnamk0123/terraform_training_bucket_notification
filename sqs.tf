# data "aws_iam_policy_document" "queue" {
#   statement {
#     effect = "Allow"

#     principals {
#       type        = "*"
#       identifiers = ["*"]
#     }

#     actions   = ["sqs:SendMessage"]
    
    
#     resources = ["arn:aws:sqs:*:*:, ${var.sqs-queue-names[0]}", ]

#     condition {
#       test     = "ArnEquals"
#       variable = "aws:SourceArn"
#       values   = [module.aws_s3_bucket.bucket_arn]
#     }
#   }
# }

resource "aws_sqs_queue" "sqs-queue" {
  for_each = toset(var.sqs-queue-names)
  name   = each.key
  policy = <<POLICY
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": "*",
        "Action": "sqs:SendMessage",
        "Resource": "arn:aws:sqs:*:*:${each.key}",
        "Condition": {
          "ArnEquals": { "aws:SourceArn": "${module.aws_s3_bucket.bucket_arn}" }
        }
      }
    ]
  }
  POLICY
}