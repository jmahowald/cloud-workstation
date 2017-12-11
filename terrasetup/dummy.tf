#! This terraform file exists solely so that we can preload modules and store
# them off so that they don't need to be stored on every terraform project
provider "aws" {}
provider "vault" {}
provider "random" {}
provider "postgresql" {}
provider "null" {}