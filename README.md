# Terraform Prereqs

This assumes that have terraform installed on your local computer. 
This particular code has been tested to run on the 1.2.7 version, but should work on any 1.2.x version. 

# Setup
You'll need to cd into the `dev` directory, then run terraform init, and then a terrform apply, and then uncomment the state file location, and then run terraform apply again. 

So:

- `cd dev`
- Run `terraform init`
- Run `terraform apply` and type `yes`
- Then uncomment the backend block in the provider.tf file.
- Run `terraform apply` again and type `yes` 

And then terrform should be applied with a remote state file. 