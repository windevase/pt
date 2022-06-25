# 가용 영역 a의 pub sub
resource "aws_subnet" "hjko_puba" {
  vpc_id = aws_vpc.hjko_vpc.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "ap-northeast-2a"
  tags = {
    "Name"  =   "hjko-puba"
  } 
}
# 가용 영역 c의 pub sub
resource "aws_subnet" "hjko_pubc" {
  vpc_id = aws_vpc.hjko_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-northeast-2c"
  tags = {
    "Name"  =   "hjko-pubc"
  } 
}

# 가용 영역 a의 pri sub
resource "aws_subnet" "hjko_pria" {
  vpc_id = aws_vpc.hjko_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "ap-northeast-2a"
  tags = {
    "Name"  =   "hjko-pria"
  } 
}
# 가용 영역 c의 pri sub
resource "aws_subnet" "hjko_pric" {
  vpc_id = aws_vpc.hjko_vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "ap-northeast-2c"
  tags = {
    "Name"  =   "hjko-pric"
  } 
}

# 가용 영역 a의 db sub
resource "aws_subnet" "hjko_pridba" {
  vpc_id = aws_vpc.hjko_vpc.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "ap-northeast-2a"
  tags = {
    "Name"  =   "hjko-pridba"
  } 
}
# 가용 영역 c의 db sub
resource "aws_subnet" "hjko_pridbc" {
  vpc_id = aws_vpc.hjko_vpc.id
  cidr_block = "10.0.5.0/24"
  availability_zone = "ap-northeast-2c"
  tags = {
    "Name"  =   "hjko-pridbc"
  } 
}