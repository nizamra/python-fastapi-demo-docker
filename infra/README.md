# Infrastructure as Code (Terraform)

This directory contains the Terraform configuration to provision Google Cloud Platform (GCP) resources for the BookShelf application.

## Prerequisites

1.  [Terraform](https://www.terraform.io/downloads.html) >= 1.14.2 installed.
2.  [Google Cloud SDK](https://cloud.google.com/sdk/docs/install) installed and authenticated (`gcloud auth application-default login`).
3.  A GCP Project with APIs enabled (Container, Artifact Registry, Cloud Storage).

## Directory Structure

1.  `bootstrap/`: One-time setup to create the remote state bucket and enable required APIs.
2.  `modules/`: Reusable Terraform modules (GKE Cluster, Artifact Registry).
3.  `envs/`: Environment-specific configurations (`dev`, `prod`).

## How to Run

### 1. Bootstrap (First time only)

This step creates the Google Cloud Storage bucket required to store the Terraform state file.

1.  Navigate to the bootstrap directory:
    ```bash
    cd bootstrap
    ```
2.  Initialize Terraform:
    ```bash
    terraform init
    ```
3.  Apply the configuration:
    ```bash
    terraform apply -var-file="values.tfvars"
    ```
4.  **Important**: Note the output `terraform_state_bucket_name`. You will need this value if you configure the backend manually later, though our scripts automate this.

### 2. Deploy Environment (Dev or Prod)

**Note**: This step is fully automated via GitHub Actions. See `.github/workflows/infra-pipeline.yml`. 
Running these commands locally is optional and typically reserved for debugging or initial setup without triggering a pipeline run.

1.  Navigate to the environment directory:
    ```bash
    cd envs/dev  # or envs/prod
    ```

2.  Initialize Terraform.
    This command downloads the Google provider and configures the remote backend to use the bucket created in the bootstrap step.
    ```bash
    terraform init
    ```

3.  Review the plan.
    Always check what Terraform intends to create before applying:
    ```bash
    terraform plan -var-file="values.tfvars"
    ```

4.  Apply the changes.
    This will create the resources in GCP:
    ```bash
    terraform apply -auto-approve -var-file="values.tfvars"
    ```

## Outputs

After a successful `apply`, Terraform will print valuable connection information to your terminal.

1.  **Cluster Endpoint**: The internal IP of the Kubernetes API.
2.  **Get Credentials Command**: Terraform will provide a `gcloud` command similar to this:
    ```bash
    gcloud container clusters get-credentials bookshelf-dev-cluster --region us-central1 --project gcp-capstone-481414
    ```
3.  **Action**: Copy and paste this command into your terminal. It configures your local `kubectl` to communicate with the new GKE cluster.

## Troubleshooting

1.  **Error: Backend configuration changed**: Ensure you have run the `bootstrap` step first and the bucket exists.
2.  **Error: API not enabled**: The bootstrap script should handle this, but if you encounter errors regarding `container.googleapis.com`, enable it manually in the GCP Console.
3.  **Module not found**: Ensure you are running commands from inside `envs/dev` or `envs/prod`, not the root `infra` folder.
