resource "null_resource" "name" {
  
  depends_on = [ module.ec2-bastion ]

  connection {
    type = "ssh"
    user = "ec2-user"
    private_key = file("${path.module}/private-key/terraform-key.pem")
    host = aws_eip.bastion_host.public_ip
  }

  provisioner "file" {
    source = "private-key/terraform-key.pem"
    destination = "/tmp/terraform-key.pem"
  }

  provisioner "remote-exec" {
    inline = [ "chmod 400 /tmp/terraform-key.pem" ]
  }
  
}