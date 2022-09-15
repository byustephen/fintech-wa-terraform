resource "aws_s3_bucket" "terraform_state_s3_bucket" {
    #Let's call it something that we definately won't conflict with
    bucket = "test-wafd-terraform-state-file-storage"
 
    tags = {
      Name = "Terraform State File Storage"
    }      
}

resource "aws_s3_bucket_acl" "terraform_state_s3_acl" {
  bucket = aws_s3_bucket.terraform_state_s3_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "terraform_state_s3_versioning" {
  bucket = aws_s3_bucket.terraform_state_s3_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}