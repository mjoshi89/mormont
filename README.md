# mormont

**Build Challenge 1 by executing below commands:**

`export TF_VAR_db_username="setusernamehere"`
`export TF_VAR_db_password="setpasswordhere"`
`terraform init`
`terraform plan -var-file=environments/dev/dev-eu-west-2.tfvars`
`terraform apply -var-file=environments/dev/dev-eu-west-2.tfvars --auto-approve`

**Or if you want to use Docker to execute the terraform code use the below commands:**

`docker build . -t tf-deployment:1 && docker run --rm -i -v $PWD/challenge1:/terraform -v ~/.aws/:/root/.aws/ tf-deployment:1 "terraform init"`

`docker build . -t tf-deployment:1 && sudo docker run --rm -i -v $PWD/challenge1:/terraform -v ~/.aws/:/root/.aws/ -e TF_VAR_db_username="setusernamehere" -e TF_VAR_db_password="setpasswordhere" tf-deployment:1 "terraform plan -var-file=environments/dev/dev-eu-west-2.tfvars"`

`docker build . -t tf-deployment:1 && sudo docker run --rm -i -v $PWD/challenge1:/terraform -v ~/.aws/:/root/.aws/ -e TF_VAR_db_username="setusernamehere" -e TF_VAR_db_password="setpasswordhere" tf-deployment:1 "terraform apply -var-file=environments/dev/dev-eu-west-2.tfvars --auto-approve"`
