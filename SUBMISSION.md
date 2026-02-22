# Project Submission: BookShelf Cloud

## Repository Link
[https://github.com/nizamra/python-fastapi-demo-docker](https://github.com/nizamra/python-fastapi-demo-docker)

## CI/CD Evidence

### CI Pipeline (Docker Build)
- **Link to Run**: [GitHub Actions - CI Build](https://github.com/nizamra/python-fastapi-demo-docker/blob/main/.github/workflows/docker-build-gcp.yml)
- **Status**: ✅ [Success](https://github.com/nizamra/python-fastapi-demo-docker/actions/runs/22283333449) - Build and Push to Artifact Registry.

### CD Pipeline (GKE Deploy)
- **Link to Run**: [GitHub Actions - CD Deploy](https://github.com/nizamra/python-fastapi-demo-docker/blob/main/.github/workflows/deploy-gke.yml)
- **Status**: ✅ [Success](https://github.com/nizamra/python-fastapi-demo-docker/actions/runs/22284723811) - Deployed to GKE Dev/Prod.

### Infrastructure Pipeline
- **Workflow Name**: Infrastructure (GKE & Registry)
- **Link to Run**: [GitHub Actions - Infra](https://github.com/nizamra/python-fastapi-demo-docker/actions/workflows/infra-pipeline.yml)
- **Status**: ✅ [Success](https://github.com/nizamra/python-fastapi-demo-docker/actions/runs/22283115694/job/64456861834) - Provisioned the GKE Autopilot cluster and Artifact Registry.

### Release Evidence
- **Release v1.0.0**: [https://github.com/nizamra/python-fastapi-demo-docker/releases/tag/v1.0.0](https://github.com/nizamra/python-fastapi-demo-docker/releases/tag/v1.0.0)
- **Promoted Image**: `us-central1-docker.pkg.dev/gcp-capstone-481414/bookshelf-docker-repo/fastapi-app:v1.0.0`

## Artifact Evidence

The Docker artifacts are stored in Google Cloud Artifact Registry.

- **Registry Name**: `bookshelf-docker-repo`
- **Location**: `us-central1`
- **View Artifacts**: [Link to GCP Console Artifact Registry](https://console.cloud.google.com/artifacts/docker/gcp-capstone-481414/us-central1/bookshelf-docker-repo?hl=en&project=gcp-capstone-481414)

## Service URL

The application is exposed via a GKE LoadBalancer Service.

- **Application Endpoint**: [http://34.173.120.218/](http://34.173.120.218/)

## Summary
The project implements a fully automated DevOps pipeline for a Python FastAPI application on GCP. We utilized Terraform for Infrastructure as Code (IaC), managing GKE Autopilot clusters and Artifact Registry securely via remote state. A 3-tier pipeline architecture was adopted: a manual Infrastructure pipeline, a CI pipeline for Docker image building, and a CD pipeline for GKE deployment. We implemented image promotion strategies using semantic versioning and ensured security via Workload Identity Federation, avoiding hardcoded credentials.

**Next Steps**: With more time, I would implement a dedicated Terraform module for Google Cloud SQL to replace the StatefulSet Postgres instance, ensuring higher availability and automated backups. I would also add Integration Tests to the CI pipeline and set up a Monitoring Dashboard (GCP Cloud Monitoring) for better observability and alerting.