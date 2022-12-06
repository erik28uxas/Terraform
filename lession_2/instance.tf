resource "aws_key_pair" "id_rsa" {
    key_name   = "id_rsa"
    public_key = file(var.PATH_TO_PUBLIC_KEY)
}

resource "aws_instance" "example" {
    ami           = var.AMIS[var.AWS_REGION]
    instance_type = "t2.micro"
    key_name      = aws_key_pair.id_rsa.key_name

    provisioner "file" {
      source      = "/home/erikgoul/Documents/bash_Scripts/myscript11_echo.sh"
      destination = "/tmp/myscript11_echo.sh"
    }

    provisioner "remote-exec" {
        inline = [
          "chmod +x /tmp/myscript11_echo.sh",
          "sudo sed -i -e 's/\r$//' /myscript11_echo.sh",
          "sudo /tmp/myscript11_echo.sh",
        ]
    }

    connection {
      host        = coalesce(self.public_ip, self.private_ip)
      type        = "ssh"
      user        = var.INSTANCE_USERNAME
      private_key = file(var.PATH_TO_PRIVATE_KEY)
    }
}