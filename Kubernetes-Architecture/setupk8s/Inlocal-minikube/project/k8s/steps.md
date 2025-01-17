
# Kubernetes Deployment Guide for Three-Tier Application

## Prerequisites

- Kubernetes cluster is set up and running
- kubectl CLI tool is installed
- Docker images for your applications are available
- Deployment YAML files are prepared

## Deployment Steps

### Step 1: Deploy MySQL Database
```bash
kubectl apply -f mysql-deployment.yaml
```
This command deploys the MySQL database service and creates necessary persistent volumes if configured in the YAML file.

### Step 2: Deploy Spring Boot Backend
```bash
kubectl apply -f springboot-backend-deployment.yaml
```
This deploys your Spring Boot application along with its service.

### Step 3: Deploy React Frontend
```bash
kubectl apply -f frontend-deployment.yaml
```
This deploys your React frontend application along with its service.

### Step 4: Port Forwarding
To access your applications locally, set up port forwarding:

#### For Spring Boot Backend:
```bash
kubectl port-forward service/springboot-backend-service 8080:8080
```
This makes your backend accessible at `localhost:8080`.

#### For React Frontend:
```bash
kubectl port-forward service/react-frontend-service 3000:80
```
This makes your frontend accessible at `localhost:3000`.

## Verification Steps

- Check if all pods are running:
  ```bash
  kubectl get pods
  ```

- Check if services are created:
  ```bash
  kubectl get services
  ```

- Verify deployments:
  ```bash
  kubectl get deployments
  ```

## Accessing the Application

- **Frontend**: [http://localhost:3000](http://localhost:3000)
- **Backend API**: [http://localhost:8080](http://localhost:8080)

## Troubleshooting

If you encounter issues:

- Check pod logs:
  ```bash
  kubectl logs <pod-name>
  ```

- Check pod status:
  ```bash
  kubectl describe pod <pod-name>
  ```

- Check service status:
  ```bash
  kubectl describe service <service-name>
  ```