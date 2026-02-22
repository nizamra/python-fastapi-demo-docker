# Deployment Strategy

## Promotion Path

The deployment strategy follows a strict promotion model from Development to Production.

### 1. Development Environment (Automatic)
- **Trigger**: Push to `main` branch (changes in `server/` or `Dockerfile`).
- **Process**:
  1. CI Pipeline builds the Docker image.
  2. Image is tagged with the Git SHA and `:dev`.
  3. Image is pushed to Artifact Registry.
  4. CD Pipeline is NOT triggered automatically for Dev in this workflow (Manual dispatch is used for consistency), but conceptually it deploys the `:dev` tag.

### 2. Production Environment (Manual Promotion)
- **Trigger**: Manual Workflow Dispatch.
- **Process**:
  1. User selects a specific source Git SHA (verified in Dev).
  2. User defines a Semantic Version tag (e.g., `v1.0.0`).
  3. Pipeline requires **Manual Approval**.
  4. Upon approval:
     - The Docker image is re-tagged in Artifact Registry (SHA -> v1.0.0).
     - `kubectl apply` updates the GKE Production Deployment.
     - GKE performs a Rolling Update.

## Why Tagging?
We use immutable tags (`v1.0.0`) for Production instead of mutable tags (`latest`). This ensures we can identify exactly what code is running and allows for instant rollbacks by redeploying a previous tag.
