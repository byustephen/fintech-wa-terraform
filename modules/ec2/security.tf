resource "aws_security_group" "primary_public_security_group" {
  name        = "Primary - Public Instance Security Group"
  description = "Security group to all http, https, and ssh "
  vpc_id      = var.vpc_id


  #These are very rough and incomplete rules for access. Need to add access to util servers, tms prod servers, and anything else. 

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
    description = "VPC - SSH"
  }

  ingress{
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 80
    protocol = "tcp"
    to_port = 80
    description = "HTTP Access"
  }

  ingress{
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 443
    protocol = "tcp"
    to_port = 443
    description = "HTTPS Access"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Outbound - All Traffic"
  }

  tags = {
    Name = "Primary - Public Subnet"
  }
}