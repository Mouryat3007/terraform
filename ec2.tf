#web server

resource "aws_instance" "crm-web-server" {
  ami           = "ami-07c8c1b18ca66bb07"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.web-sn.id
  key_name = "mour"
  vpc_security_group_ids = aws_security_group.crm-web-sg.id
  user_data = file("setup.sh")



  tags = {
    Name = "crm-web-server"
  }
}