# Configure google cloud provider details

provider "google" {

   credentials = "${file("serviceaccount123456.json")}"
   project = "project1-test-dev"
   region = "asia-east2"
}

# configure backend pointing to the bucket created previously

terraform {
  backend "gcs" {
    bucket = "test-bucket-dev-tfstate"
  }
}

# Configure GCE instance

resource "google_compute_instance" "default" {

   name = "test_instance1"
   machine_type = "n1-standard-1"
   zone = "asia-east2-b"

   boot_disk {
     initialize_params {
       image = "projects/project1-test-dev/global/images/family/test-dev-gce-image"
       size = "100"
       type = "pd-standard"
     }
   }

   tags = ["ingress-tag","egress-tag","traffic-to-cloudsql","traffic-to-GKE","traffic-to-other-applications-as-required","linux-ssh-tag"]

   metadata = {
     "startup_script_url" = "gs://if-you-want-to-run-any-script-at-VM-startup-path-to-file"  # This will rfer to the path of the gcs bucket where the script is hosted
   }

   network_interface {
     network = "projects/asia-vpc-project/global/networks/vpc"
     subnetwork = "projects/asia-vpc-project/regions/asia-east2/subnetworks/vpc-asia-east2"
     subnetwork_project = "project2-subnetwork-dev"
     network_ip = "xx.xx.xx.xx"


   }

   service_account {
     email = "gce-infra@project1-test-dev.iam.gserviceaccount.com"
     scopes = [ "cloud-platform" ]  # alternatively you can provide the full url as well-> https://www.googleapis.com/auth/cloud-platform
   }
}


# 1. Run terraform init
# 2. Run terraform plan to check details before finlalizing
# The image must alreday be present in order for the VM to get greated with the given image
# 3. Run terraform apply followed by YES to confirm or run with --auto-approve to remove YES prompt.
