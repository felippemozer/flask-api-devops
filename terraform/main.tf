module "kubernetes" {
  # ! IT DOES NOT EXIST. IT IS JUST AN EXAMPLE ACCORDING TO COURSE
  source = "git@github.com:felippemozer/flask-api-terraform?ref=main" 

  cidr_block   = "10.34.0.0/16"
  project_name = "restapi"
  region       = "us-west-2"
  tags = {
    Department = "DevOps"
  }
}