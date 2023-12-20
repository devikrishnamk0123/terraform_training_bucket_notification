resource "aws_s3_bucket" "module_bucket" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_ownership_controls" "bucket_ownership" {
  bucket = aws_s3_bucket.module_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}


resource "aws_s3_bucket_public_access_block" "module_bucket_acl" {
  bucket                  = aws_s3_bucket.module_bucket.id
  block_public_acls       = var.bucket_is_private
  block_public_policy     = var.bucket_is_private
  ignore_public_acls      = var.bucket_is_private
  restrict_public_buckets = var.bucket_is_private

}

resource "aws_s3_bucket_acl" "bucket_acl" {
  depends_on = [aws_s3_bucket_ownership_controls.bucket_ownership]

  bucket = aws_s3_bucket.module_bucket.id
  acl    = var.bucket_is_private ? "private" : "public-read"
}


resource "aws_s3_bucket_notification" "sqs-bucket_notification" {
  bucket = aws_s3_bucket.module_bucket.id

  dynamic "queue" {
    for_each = var.queue_details
    content {
      id        = queue.key
      queue_arn = queue.value["arn"]
      events    = queue.value["events"]
    }
  }

  dynamic "topic" {
    for_each = var.sns_topic_details
    content {
      topic_arn = topic.value["arn"]
      events    = topic.value["events"]
    }
  }

}
