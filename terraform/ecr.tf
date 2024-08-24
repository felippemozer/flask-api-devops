resource "aws_ecr_repository" "this" {
  name         = "restapi"
  force_delete = true
}
