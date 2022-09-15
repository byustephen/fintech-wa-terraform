#  ███╗   ███╗ █████╗ ██╗███╗   ██╗
#  ████╗ ████║██╔══██╗██║████╗  ██║
#  ██╔████╔██║███████║██║██╔██╗ ██║
#  ██║╚██╔╝██║██╔══██║██║██║╚██╗██║
#  ██║ ╚═╝ ██║██║  ██║██║██║ ╚████║
#  ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝
#   


resource "aws_instance" "primary-public-instance-a" {
  ami                         = "ami-0d70546e43a941d70"
  instance_type               = "t2.small"
  subnet_id                   = var.subnet_ids[0]

  associate_public_ip_address = "true"  
  vpc_security_group_ids      = [aws_security_group.primary_public_security_group.id]
  disable_api_termination     = false

  root_block_device {   
    volume_type = "gp3" 
    volume_size = 10
    delete_on_termination = true
  }
  
  tags = {
    Name = "Primary - Public Instance A"
  }
}  

resource "aws_instance" "primary-public-instance-b" {
  ami                         = "ami-0d70546e43a941d70"
  instance_type               = "t2.small"
  subnet_id                   = var.subnet_ids[1]

  associate_public_ip_address = "true"  
  vpc_security_group_ids      = [aws_security_group.primary_public_security_group.id]
  disable_api_termination     = false

  root_block_device {   
    volume_type = "gp3" 
    volume_size = 10
    delete_on_termination = true
  }
  
  tags = {
    Name = "Primary - Public Instance B"
  }
}  

resource "aws_eip" "primary-eip-instance-a" {
  instance = aws_instance.primary-public-instance-a.id
  tags = {
    Name = "Primary - Public Instance A"
  }
}

resource "aws_eip" "primary-eip-instance-b" {
  instance = aws_instance.primary-public-instance-b.id
  tags = {
    Name = "Primary - Public Instance B"
  }
}