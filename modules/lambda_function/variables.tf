variable "function_name" {
  description = "Name of the Lambda function"
  type        = string
}

variable "handler" {
  description = "Lambda function handler"
  type        = string
  default     = "index.handler"
}

variable "runtime" {
  description = "Lambda function runtime"
  type        = string
  default     = "python3.12"
}

variable "filename" {
  description = "Path to the function deployment package zip"
  type        = string
}

variable "source_code_hash" {
  description = "Base64-encoded SHA256 hash of the package. Used to detect code changes"
  type        = string
}

variable "memory_size" {
  description = "Amount of memory in MB to allocate to the function. AWS default is 128"
  type        = number
  default     = 128
}

variable "timeout" {
  description = "Seconds before the function times out. AWS default is 3, set higher for DynamoDB workloads"
  type        = number
  default     = 30
}

variable "environment_variables" {
  description = "Environment variables for the Lambda function"
  type        = map(string)
  default     = {}
}

variable "alias_name" {
  description = "Name of the Lambda alias that API Gateway will invoke"
  type        = string
  default     = "live"
}

variable "function_version" {
  description = "The Lambda version the alias points to. Defaults to the latest published version. Override in canary deployments to pin to a stable version"
  type        = string
  default     = null
}

variable "routing_config" {
  description = "Optional routing configuration for canary deployments"
  type        = map(number)
  default     = null
}

variable "dynamodb_table_arn" {
  description = "ARN of the DynamoDB table the function needs access to"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources in this module"
  type        = map(string)
  default     = {}
}
