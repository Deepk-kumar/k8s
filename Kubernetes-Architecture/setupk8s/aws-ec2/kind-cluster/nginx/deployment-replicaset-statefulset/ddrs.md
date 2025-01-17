# Kubernetes Workloads: Deployment, ReplicaSet, and StatefulSet

In Kubernetes, **Deployment**, **ReplicaSet**, and **StatefulSet** are workload resources used to manage the lifecycle of application containers. Each serves a distinct purpose and is suited for specific types of applications.

---

## Deployment

### **Purpose**
- Used to manage stateless applications.
- Handles rolling updates, rollbacks, and scaling automatically.

### **Use Case**
- Ideal for applications where pod identity doesn’t matter, such as web servers or APIs.

### **Example**: Deploying a stateless Nginx web server
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

---

## ReplicaSet

### **Purpose**
- Ensures a specified number of pod replicas are running at any given time.
- Typically managed by a Deployment; rarely used directly.

### **Use Case**
- Useful for finer control over a group of stateless pods without advanced features like rolling updates.

### **Example**: ReplicaSet managing Nginx pods
```yaml
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: nginx-ReplicaSet
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
          ports:
        - containerPort: 80        
```

---

## StatefulSet

### **Purpose**
- Manages stateful applications that require stable storage and consistent pod identities.
- Ensures pods are created and deleted in an ordered sequence.

### **Use Case**
- Suitable for databases and distributed systems (e.g., MySQL, MongoDB, Kafka).

### **Example**: StatefulSet for a MySQL database
```yaml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: mysql-statefulset
spec:
  serviceName: "mysql-service"
  replicas: 3
  selector:
    matchLabels:
      app: mysql
  template:
    metadata:
      labels:
        app: mysql
    spec:
      containers:
      - name: mysql
        image: mysql:5.7
        ports:
        - containerPort: 3306
        volumeMounts:
        - name: mysql-persistent-storage
          mountPath: /var/lib/mysql
  volumeClaimTemplates:
  - metadata:
      name: mysql-persistent-storage
    spec:
      accessModes: ["ReadWriteOnce"]
      resources:
        requests:
          storage: 10Gi
```

---


## DaemonSet

### **Purpose**
- Ensures that a copy of a pod runs on all (or specific) nodes in the cluster.
- Used for cluster-wide services such as logging, monitoring, or networking tools.

### **Use Case**
- Ideal for running node-specific daemons like Fluentd, Prometheus Node Exporter, or Calico.

### **Example**: DaemonSet for Fluentd
```yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: fluentd-daemonset
spec:
  selector:
    matchLabels:
      name: fluentd
  template:
    metadata:
      labels:
        name: fluentd
    spec:
      containers:
      - name: fluentd
        image: fluent/fluentd:v1.14
        resources:
          limits:
            memory: "200Mi"
            cpu: "100m"
        volumeMounts:
        - name: varlog
          mountPath: /var/log
        - name: containers
          mountPath: /var/lib/docker/containers
        readOnly: true
      volumes:
      - name: varlog
        hostPath:
          path: /var/log
      - name: containers
        hostPath:
          path: /var/lib/docker/containers
```

---

## Comparison

| Feature           | Deployment         | ReplicaSet      | StatefulSet        | DaemonSet         |
|--------------------|--------------------|-----------------|--------------------|-------------------|
| **Use Case**       | Stateless apps    | Stateless pods  | Stateful apps      | Node-specific apps|
| **Pod Identity**   | Random            | Random          | Stable             | Node-bound        |
| **Storage**        | Shared/Ephemeral  | Shared/Ephemeral| Dedicated/Stable   | Shared/Ephemeral  |
| **Scaling**        | Automatic         | Automatic       | Sequential         | Per Node          |
| **Rolling Updates**| Yes               | No              | Yes (Ordered)      | Yes               |

---

Each workload has its own unique strengths. Use **Deployment** for scalable stateless applications, **ReplicaSet** for simpler use cases, **StatefulSet** for applications needing stable identities and storage, and **DaemonSet** for node-specific services.
