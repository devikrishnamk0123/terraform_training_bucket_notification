variable "sqs-queue-names" {
  type = list(string)
  default = []
}

variable "sns-topic-name" {
  type = string
  default = ""
}
