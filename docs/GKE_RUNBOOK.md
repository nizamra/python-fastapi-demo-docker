# GKE Runbook

## How to Deploy to GKE manually

If the CI/CD pipeline is down, or for emergency fixes:

1.  **Authenticate**:
    ```bash
    gcloud container clusters get-credentials bookshelf-dev-cluster --region us-central1
    ```

2.  **Build and Push Image** (Locally):
    ```bash
    docker build -t us-central1-docker.pkg.dev/gcp-capstone-481414/bookshelf-docker-repo/fastapi-app:manual-fix .
    docker push us-central1-docker.pkg.dev/gcp-capstone-481414/bookshelf-docker-repo/fastapi-app:manual-fix
    ```

3.  **Update Deployment**:
    Edit the image in the deployment:
    ```bash
    kubectl set image deployment/fastapi-deployment \
      web=us-central1-docker.pkg.dev/gcp-capstone-481414/bookshelf-docker-repo/fastapi-app:manual-fix \
      -n my-cool-app
    ```

## Rolling Updates

By default, GKE Deployments use a `RollingUpdate` strategy.
- **What happens**: GKE gradually replaces old Pods with new ones.
- **Configuration**: Defined in `kubernetes/fastapi-app.yaml` under `strategy`.
- **Monitoring**: Watch the status with `kubectl rollout status deployment/fastapi-deployment -n my-cool-app`.

## Rollbacks

See `docs/ROLLBACK.md`. The primary command is:
```bash
kubectl rollout undo deployment/fastapi-deployment -n my-cool-app
```

Checking Logs
Application Logs:
```bash
kubectl logs -f deployment/fastapi-deployment -n my-cool-app
```

Database Logs:
```bash
kubectl logs -f statefulset/fastapi-postgres -n my-cool-app
```
