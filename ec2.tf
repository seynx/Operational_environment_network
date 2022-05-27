data "aws_ami" "ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*-gp2"]
  }
}

#create an EC2
resource "aws_instance" "myec2" {
  ami           = data.aws_ami.ami.id # us-west-2
  instance_type = "t2.micro"
  subnet_id = aws_subnet.pub_subnet_1.id
  key_name = data.aws_key_pair.keypair.key_name
  vpc_security_group_ids = [ aws_security_group.sec_group.id ]

 tags = {
   name = "class work"
  }
}

#key pair data source

data "aws_key_pair" "keypair" {
  key_name = "seynxtwo"
  
  }

#security group

resource "aws_security_group" "sec_group" {
  name        = "allow_ssh"
  description = "Allow_ssh"
  vpc_id      = local.vpc_id

 
  ingress {
    description      = "ssh"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_all_web_traffic"
  }
}