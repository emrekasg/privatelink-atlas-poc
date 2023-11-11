resource "mongodbatlas_privatelink_endpoint" "test" {
  project_id    = mongodbatlas_project.poc.id
  provider_name = "AWS"
  region        = "EU_WEST_1"

  timeouts {
    create = "30m"
    delete = "20m"
  }
}

resource "aws_vpc_endpoint" "atlas" {
  vpc_id              = aws_vpc.main.id
  service_name        = mongodbatlas_privatelink_endpoint.test.endpoint_service_name
  vpc_endpoint_type   = "Interface"
  security_group_ids  = [aws_security_group.allow_all.id]
  subnet_ids          = aws_subnet.private[*].id
  private_dns_enabled = false
  tags = {
    Name = "mongodb-privatelink-poc-atlas-endpoint"
  }
}

resource "mongodbatlas_privatelink_endpoint_service" "test" {
  project_id          = mongodbatlas_project.poc.id
  provider_name       = "AWS"
  private_link_id     = mongodbatlas_privatelink_endpoint.test.private_link_id
  endpoint_service_id = aws_vpc_endpoint.atlas.id
}
