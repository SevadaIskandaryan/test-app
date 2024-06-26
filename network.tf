resource "aws_vpc" "main"{
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "main"
    }
}

#internet gateway
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id
    tags = {
      Name = "igw"
    }
  
}

#nat
resource "aws_eip" "nat" {
  domain   = "vpc"

  tags = {
    Name = "nat"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public-us-east-1a.id

  tags = {
    Name = "nat"
  }

  depends_on = [aws_internet_gateway.igw]
}
