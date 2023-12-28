variable "sqs-queue-names" {
  type = list(string)
  default = []
}

variable "sns-topic-names" {
  type = list(string)
  default = []
}

variable "bucket_names" {
  type = list(string)
  default = []
}

variable "bucket_configurations" {
  type = map(object({
    is_private = bool
    queue_details = optional(map(object({
      # arn = string
      events = list(string)
    })))
    
  }))
 
  validation {
    condition = alltrue([for k in keys(var.bucket_configurations): startswith(k,"devi")])
    error_message =  "Invalid bucket name, should begin with devi"
  }
}