# Rollback Procedure

This document describes how to rollback the application if a deployment introduces a critical bug or failure.

## Important Note on Database Rollbacks

Rolling back the application code does **not** automatically rollback the database schema.
*   **Risk**: If the failed deployment included a database migration (e.g., via `init.sh`), simply reverting the code might cause errors if the old application code expects the previous database schema structure but the database has already been updated.
*   **Action**: In such events, manual SQL intervention may be required to revert schema changes before rolling back the application.

---

## Scenario 1: Immediate Rollback via CLI (Fastest)

If you have `kubectl` access to the cluster and need to revert to the previous version immediately:

1.  **Verify current status**:
    Check the history of the deployment to see available revisions.
    ```bash
    kubectl rollout history deployment/fastapi-deployment -n my-cool-app
    ```

2.  **Rollback to the previous revision**:
    This command reverts the deployment to the state immediately preceding the current one.
    ```bash
    kubectl rollout undo deployment/fastapi-deployment -n my-cool-app
    ```

3.  **Verify the rollback**:
    Watch the status to ensure the pods are restarting with the old image and becoming healthy.
    ```bash
    kubectl rollout status deployment/fastapi-deployment -n my-cool-app
    ```

---

## Scenario 2: Rollback via GitHub Actions (Specific Version)

If the previous revision is also corrupted, or if you need to jump back to a specific known-good version (e.g., `v1.0.0`):

1.  Navigate to the **Repository Actions** tab.
2.  Select the **CD - Deploy to GKE** workflow.
3.  Click **Run workflow**.
4.  Configure the inputs:
    *   `source_tag`: The tag of the specific version you want to restore (e.g., `v1.0.0`).
    *   `target_tag`: The new version name (optional, you can reuse the old tag or name it `v1.0.1-rollback`).
    *   `environment`: `prod` (or `dev`).
5.  Run the workflow and complete the **Manual Approval**.

**Result**: This will force the GKE Deployment to update the Pods to run the Docker image associated with the specific tag you provided.

---

## Scenario 3: Rollback via CLI (Specific Image)

If you cannot use the GitHub Actions pipeline but know the exact image URL:

1.  Update the deployment image directly:
    ```bash
    kubectl set image deployment/fastapi-deployment \
      web=us-central1-docker.pkg.dev/gcp-capstone-481414/bookshelf-docker-repo/fastapi-app:v1.0.0 \
      -n my-cool-app
    ```
2.  Watch the rollout:
    ```bash
    kubectl rollout status deployment/fastapi-deployment -n my-cool-app
    ```
