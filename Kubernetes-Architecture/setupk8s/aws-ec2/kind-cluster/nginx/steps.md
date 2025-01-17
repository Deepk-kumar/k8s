# Kubernetes Nginx Deployment Steps

## Steps to Deploy Nginx Using Kubernetes

### 1. **Create a Namespace**

Namespaces provide isolation and organization for Kubernetes resources.

#### Command:
```sh
kubectl create namespace nginx
```

---

### 2. **Apply Nginx Pod Manifest**

A Pod represents a single instance of Nginx.

#### Example Manifest (pod.yml):
```yaml
 kind: Pod
 apiVersion: v1
 metadata:
   name: nginx-pod
   namespace: nginx
spec:
  containers:
  - name: nginx-container
    image: nginx:latest
    ports:
    - containerPort: 80
```

#### Command to Apply:
```sh
kubectl apply -f pod.yaml -n nginx
```

#### Verify the Pod:
```sh
kubectl get pods -n nginx
```

#### Access Pod Details:
```sh
kubectl describe pod/nginx-pod -n nginx
```

#### Enter the Pod:
```sh
kubectl exec -it nginx-pod -n nginx -- bash
```

---

### 3. **Apply Nginx Service Manifest**

A Service provides a stable network endpoint for the Nginx Pod.

#### Example Manifest (nginx-service.yaml):
```yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
  namespace: nginx
spec:
  selector:
    app: nginx-app
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
```

#### Command to Apply:
```sh
kubectl apply -f nginx-service.yaml -n nginx
```

#### Verify the Service:
```sh
kubectl get services -n nginx
```

---

### 4. **Apply Nginx Deployment Manifest**

A Deployment manages replicas, updates, and self-healing for Nginx Pods.

#### Example Manifest (deployment.yaml):
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  namespace: nginx
spec:
  replicas: 2
  selector:
    matchLabels:
      app: nginx-app
  template:
    metadata:
      labels:
        app: nginx-app
    spec:
      containers:
        - name: nginx-container
          image: nginx:latest
```

#### Command to Apply:
```sh
kubectl apply -f deployment.yaml -n nginx
```

#### Verify the Deployment:
```sh
kubectl get deployments -n nginx
```

---

### 5. **Verify All Resources**

To ensure all resources are created successfully:

#### Check Namespace:
```sh
kubectl get ns
```

#### Check Pods:
```sh
kubectl get pods -n nginx
```

#### Check Services:
```sh
kubectl get services -n nginx
```

#### Check Deployments:
```sh
kubectl get deployments -n nginx
```

---

## Notes:

- **Scalability**: Use `replicas` in the Deployment to scale Pods.
- **Selectors and Labels**: Ensure `selector` in the Service matches the `labels` in the Pod/Deployment.
- **Stateful Sets**: For stateful applications, consider using StatefulSets instead of Deployments.
