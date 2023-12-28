module "aws_s3_bucket" {
  for_each = var.bucket_configurations
  source            = "./modules"
  bucket_name       = each.key
  bucket_is_private = each.value.is_private
  # queue_details = { (aws_sqs_queue.sqs-queue["devi-queue-terraform-task"].name) = {
  #   arn    = aws_sqs_queue.sqs-queue["devi-queue-terraform-task"].arn
  #   events = ["s3:ObjectRemoved:*"]
  #   }, (var.sqs-queue-names[1]) = {
  #   arn    = aws_sqs_queue.sqs-queue["devi-q2"].arn
  #   events = ["s3:ObjectCreated:*"]
  # } }
  # queue_details = {} 
  # queue_details =  local.queues
  queue_details = each.value.queue_details != null ? try(local.queues_with_arn,null):{}
  
}

