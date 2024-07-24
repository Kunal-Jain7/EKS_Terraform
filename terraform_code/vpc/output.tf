output "public_subnet" {
  value = aws_subnet.client-sub-pub.*.id
}

output "vpc_id" {
  value = aws_vpc.client-vpc.id
}