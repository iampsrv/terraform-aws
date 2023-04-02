variable "instance_name" {
  description = "Name of the instance to be created"
  default     = "awsbuilder-demo"
}

variable "instance_type" {
  default = "t2.micro"
}

# variable "vpc" {
#   description = "The VPC to use"
#   default     = "vpc-0b0ac92664981972b"
# }

# variable "sg" {
#   description = "The Security group to use"
#   default     = "sg-02d85b5dd5f74c7a7"
# }

# variable "vpc_security_group_ids" {
#   type = map(list(string))
#   default = {
#     "myflaskappsg" = ["sg-02d85b5dd5f74c7a7"]
#   }
# }

variable "ami_id" {
  description = "The AMI to use Ubuntu"
  default     = "ami-007855ac798b5175e"
}

variable "number_of_instances" {
  description = "number of instances to be created"
  default     = 1
}

variable "bucket_name" {
  description = "Name of S3 bucket"
  default     = "tfbucketps"
}
