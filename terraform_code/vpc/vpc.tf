resource "aws_vpc" "client-vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = var.instance_tenancy
  tags = {
    Name = format("%s-%s", var.vpc_name, var.stack_env)
  }
}

resource "aws_internet_gateway" "client-igw" {
  vpc_id = aws_vpc.client-vpc.id
  tags = {
    Name = format("%s-%s-igw", var.vpc_name, var.stack_env)
  }
}


resource "aws_subnet" "client-sub-pub" {
  count                   = var.public_sn_count
  vpc_id                  = aws_vpc.client-vpc.id
  cidr_block              = var.public_cidrs[count.index]
  availability_zone       = element(var.eu_availibility_zone, count.index)
  map_public_ip_on_launch = var.map_public_ip_on_launch
  tags = {
    Name = format("%s-pubsub", var.stack_env)
  }
}

resource "aws_default_route_table" "internal-rt" {
  default_route_table_id = aws_vpc.client-vpc.default_route_table_id

  route {
    cidr_block = var.rt_route_cidr_block
    gateway_id = aws_internet_gateway.client-igw.id
  }

  tags = {
    Name = format("%s-internal-rt", var.stack_env)
  }
}

resource "aws_route_table_association" "client-rta" {
  count          = var.public_sn_count
  subnet_id      = aws_subnet.client-sub-pub[count.index].id
  route_table_id = aws_default_route_table.internal-rt.id
}