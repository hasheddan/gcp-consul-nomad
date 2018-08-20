# Provisioning a Consul / Nomad Cluster on Google Cloud with Terraform

*Note: Using this Terraform configuration can incur charges on a Google Cloud account. However, they do provide a generous $300 to new users for experimenting. Destroy the cluster (Step 4) as soon as possible after usage to minimize any costs.*

This repository contains the code for the blog post (coming soon) of the same name on [danielmangum.com](https://danielmangum.com/). There are simple usage directions in this document, but there the post will contain much more robust documentation on how and why this setup works.

## Usage

*Note: This assumes that you have already installed Terraform on your local machine.*

**Step 1: Google Cloud Setup**

The first thing you need to do is go to the [Google Cloud](https://cloud.google.com/) page and setup a new account by clicking Try Free.

Next, you will need to setup a new project from the Google Cloud Console. Name it whatever you like.

Lastly, we need to setup the Google Cloud SDK so that we can interact with our project from the command line. Follow this [link](https://cloud.google.com/sdk/docs/quickstarts) to find the quickstart guide for your operating system. Make sure to select the project you created when prompted.

**Step 2: Execute Terraform Scripts**

Now we can execute the Terraform scripts to provision our infrastrcuture. While you may modify any of the variables in ```main.tf``` (or any of the other files), you only need to provide one variable to run the scripts in their current configuration. You may do this one of two ways:

---
*Command Line Flag*

(You will need to execute the terraform steps outlined below before using this command.)

```
terraform apply -var 'gcp_project=my-gcp-project-name'
```

*Variable File*

Terraform will automatically load variables from any file named ```terraform.tfvars``` or ends in ```*.auto.tfvars```. The contents of this file in our case will consist of one line:

```
gcp_project = "my-gcp-project-name"
```

---

Now we can go about executing our scripts with the following three commands:
```
terraform init
terraform plan
terraform apply
```

**Step 3: View Nomad UI**

Wait until Terraform finishes applying the infrastructure changes, then wait a few minutes to guarantee time for the Consul and Nomad servers / clients to discover each other and elect leaders. Then you can go to your GCP console and go to the VM Instances page under Compute Engine. Copy the public IP address of one of the machines whose name begins with "servers" and navigate to port 4646 of that IP address in your browser.
Example:
```
35.274.43.18:4646
```
You should see the Nomad UI with three servers and two clients that mirror the instances you see in your GCP console.

**Step 4: Clean Up**

As to not incur any charges on your Google Cloud account, we will destroy the cluster to finish up.
```
terraform destroy
```