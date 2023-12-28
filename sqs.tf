locals {
  buckets_with_queue_details = {
    for k, v in var.bucket_configurations : k => {for k2, v2 in v.queue_details: k2 => merge(v2,{bucket_name = k})} if v.queue_details != null
    # merge(v.queue_details,{bucket_name = k})      
  }
  
  
  
  queues = merge(values(local.buckets_with_queue_details)...)

  queues_with_arn = {
    for k,v in local.queues: k => merge(v,{arn = aws_sqs_queue.sqs-queue[k].arn})
  }
  
  
}
resource "aws_sqs_queue" "sqs-queue" {
  for_each = local.queues
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
          "ArnEquals": { "aws:SourceArn": "arn:aws:s3:::${each.value.bucket_name}"}
        }
      }
    ]
  }
  POLICY
}
 


output "buckets_with_queue_details" {
  value = local.buckets_with_queue_details
}

output "queues" {
  value = local.queues
}

output "queue-with-arn" {
  value = local.queues_with_arn
}