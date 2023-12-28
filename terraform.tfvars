sqs-queue-names = ["devi-queue-terraform-task","devi-q2"]
sns-topic-names = ["devi-sns-topic-terraform-task"]
bucket_names = [ "devi-module-bucket-2","devi-module-bucket-3","devi-module-bucket-4" ]
bucket_configurations = {
  "devi-module-bckt-8" = {
    name = ""
    is_private = false
    queue_details = {
        "devi-queue-1" = {
            # arn = aws_sqs_queue.sqs-queue.arn
            events = ["s3:ObjectRemoved:*"]
        }
        "devi-queue-2" = {
          events = ["s3:ObjectCreated:*"]
        }
    }
  }
  "devi-module-bckt-10" = {
    is_private = true
  }
}