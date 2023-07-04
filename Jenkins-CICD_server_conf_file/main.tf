provider "aws" {
 region = var.Region
 access_key = var.Access_Key
 secret_key = var.Secret_Key
}
resource "aws_instance" "instance1" {
    ami                   = "ami-053b0d53c279acc90"
    instance_type         = "t2.micro"
    subnet_id = "${aws_subnet.first.id}"
    vpc_security_group_ids = ["${aws_security_group.first_sg.id}"]
    key_name = "project"
    user_data = <<EOF
#!/bin/bash
sudo apt-get update -y
sudo apt install openjdk-17-jre -y
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update -y
sudo apt-get install jenkins -y
EOF

    tags = {
        Name = "CI/CD-server"
    }
}