# mormont

Build Challenge 1 by executing below commands:

`docker build . -t tf-deployment:1 && docker run --rm -i -v $PWD:/terraform -v ~/.aws/:/root/.aws/ tf-deployment:1 "terraform init"`

`docker build . -t tf-deployment:1 && sudo docker run --rm -i -v $PWD:/terraform -v ~/.aws/:/root/.aws/ tf-deployment:1 "terraform plan --var-file=challenge1/environments/dev/dev-eu-west-2.tfvars --auto-approve"`

`docker build . -t tf-deployment:1 && sudo docker run --rm -i -v $PWD:/terraform -v ~/.aws/:/root/.aws/ tf-deployment:1 "terraform apply --var-file=challenge1/environments/dev/dev-eu-west-2.tfvars --auto-approve"`
