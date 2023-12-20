data "aws_iam_policy_document" "topic" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["s3.amazonaws.com"]
    }

    actions   = ["SNS:Publish"]
    resources = ["arn:aws:sns:*:*:${var.sns-topic-name}"]

    condition {
      test     = "ArnLike"
      variable = "aws:SourceArn"
      values   = [module.aws_s3_bucket.bucket_arn]
    }
  }
}

resource "aws_sns_topic" "topic" {
  name   = var.sns-topic-name
  policy = data.aws_iam_policy_document.topic.json
}