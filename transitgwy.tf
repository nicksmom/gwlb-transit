########################################################
# Transit Gateway
########################################################
data "aws_ec2_transit_gateway" "existing_tgw" {
  id = ""
}

# Route Table - FGT VPC
resource "aws_ec2_transit_gateway_route_table" "tgwy-fgt-route" {
  depends_on         = [data.aws_ec2_transit_gateway.existing_tgw]
  transit_gateway_id = data.aws_ec2_transit_gateway.existing_tgw.id
  tags = {
    Name = "tgwy-fgt-route"
  }
}

# VPC attachment - FGT VPC
resource "aws_ec2_transit_gateway_vpc_attachment" "tgw-att-vpc-fgt" {
  appliance_mode_support                          = "enable"
  subnet_ids                                      = [aws_subnet.transitsubnetaz1.id]
  transit_gateway_id                              = data.aws_ec2_transit_gateway.existing_tgw.id
  vpc_id                                          = data.aws_vpc.fgtvm-vpc.id
  transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false
  tags = {
    Name = "tgwy-fgt-attachment"
  }
  depends_on = [data.aws_ec2_transit_gateway.existing_tgw]
}

# Route Tables Associations - FGT VPC
resource "aws_ec2_transit_gateway_route_table_association" "tgw-rt-vpc-fgt-assoc" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.tgw-att-vpc-fgt.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.tgwy-fgt-route.id
}
