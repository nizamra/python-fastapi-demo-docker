# Release Process
This document outlines the steps to release a new version of the BookShelf application to Production.

## Prerequisites
- All code changes merged to the main branch.
- CI Pipeline has successfully built and tested the Docker image.
- You have the Git SHA of the commit you wish to release.

## Steps
1. Trigger Infrastructure (first time/on change)
- If you have modified Terraform code (infra/), ensure the Infrastructure Pipeline has run successfully and both Dev and Prod clusters are healthy.

2. Verify CI Build
- Navigate to the "CI - Build & Push Docker Image" workflow in GitHub Actions.
- Identify the Git SHA of the commit you want to release (e.g., a1b2c3d).

3. Promote to Production
- Go to the "CD - Deploy to GKE" workflow in GitHub Actions.
- Click Run workflow.
- Fill in the inputs:
  - source_tag: Enter the Git SHA (e.g., sha-a1b2c3d) or dev.
  - target_tag: Enter the semantic version (e.g., v1.0.0).
  - environment: Select prod.
- Click Run workflow.

4. Manual Approval
- The workflow will pause at the Manual Approval step.
- An authorized maintainer must review the changes and click Approve in the GitHub Actions UI.
- This is the final gate before production is modified.

5. Deployment Execution
- Upon approval, the workflow will:
- Tag the image in Artifact Registry as v1.0.0.
- Update the GKE Production deployment.
- Perform a rolling update of pods.

6. Verification
- Check the Production URL (found in SUBMISSION.md) to ensure the new version is live.
- Monitor the GKE Dashboard for pod health.
