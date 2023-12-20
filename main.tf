module "aws_s3_bucket" {

  source            = "./modules"
  bucket_name       = "devi-module-bucket"
  bucket_is_private = false
  queue_details = { (aws_sqs_queue.sqs-queue["devi-queue-terraform-task"].name) = {
    arn    = aws_sqs_queue.sqs-queue["devi-queue-terraform-task"].arn
    events = ["s3:ObjectRemoved:*"]
    }, (aws_sqs_queue.sqs-queue["devi-q2"].name) = {
    arn    = aws_sqs_queue.sqs-queue["devi-q2"].arn
    events = ["s3:ObjectCreated:*"]
  } }
}

