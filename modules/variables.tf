variable "bucket_name" {
  type = string
}

variable "bucket_is_private" {
  type = bool
  default = true
}

variable "queue_details" {
  type = map(object({
    arn = string
    events = list(string)
  }))
  default = {}
}

variable "sns_topic_details" {
  type = map(object({
    arn = string
    events = list(string)
  }))
  default = {}
}