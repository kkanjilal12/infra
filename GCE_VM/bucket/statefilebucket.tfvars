# This file is for gcs bucket state file which is a prerequisite to run terrform code to create other infra like cloudsql etc.
# copy/clone all plugins and utils and files for terraform run and browse to the folder

project = "test-project1-dev"    # this defines the project where you want to create your bucket

# if you need encryption, enable cloud kms api and then use the centralized kms gcp project if present for encrypting data in bucket(best practice)

kms_project = "test-kms-project1-dev"
region = "asia-east2"
name = "test-bucket-dev-tfstate"  # provide the bucket name you want to create

# Execute above file

# cd /path/to/terraform-module/statefilebucket

# terrform init --plugin-dir=/path/to/terraform-providers
# terraform plan --var-file=/path/to/var-file/statefilebucket.tfvars
# terraform apply --var-file=/path/to/var-file/statefilebucket.tfvars
