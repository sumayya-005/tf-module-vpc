locals {
  subnet_tags ={
    Name  = "${var.env}-vpc"
    ENV   = var.env
    PROJECT ="roboshop"
  }
}


