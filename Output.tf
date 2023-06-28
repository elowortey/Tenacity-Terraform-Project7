output "vpc_id" {
  value = aws_vpc.prod_vpc.id
  description = "vpc"
}

output "vpc_cidr_block" {
  value = aws_vpc.prod_vpc.cidr_block
}

output "public_subnet-1_id" {
  value = aws_subnet.prod_public_subnet-1.id
}

output "public_subnet-2_id" {
  value = aws_subnet.prod_public_subnet-2.id
}

output "private_subnet-1_id" {
  value = aws_subnet.prod_private_subnet-1.id
}

output "private_subnet-2_id" {
  value = aws_subnet.prod_private_subnet-2.id
}