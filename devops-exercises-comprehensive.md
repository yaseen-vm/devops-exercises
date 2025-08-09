# DevOps Exercises - From Basic to Beginner

## Table of Contents
1. [Basic Linux Commands](#basic-linux-commands)
2. [Version Control with Git](#version-control-with-git)
3. [Docker Fundamentals](#docker-fundamentals)
4. [CI/CD Basics](#cicd-basics)
5. [Infrastructure as Code](#infrastructure-as-code)
6. [Monitoring and Logging](#monitoring-and-logging)
7. [Cloud Platforms](#cloud-platforms)
8. [Configuration Management](#configuration-management)
9. [Networking Basics](#networking-basics)
10. [Security Fundamentals](#security-fundamentals)

---

## Basic Linux Commands

### Exercise 1: File System Navigation
**Objective**: Master basic file system operations

**Tasks**:
1. Create a directory structure: `projects/web/frontend` and `projects/web/backend`
2. Navigate between directories using `cd`, `pwd`
3. List files with different options: `ls`, `ls -la`, `ls -lh`
4. Create empty files using `touch`
5. Copy, move, and delete files and directories

**Commands to practice**:
```bash
mkdir -p projects/web/{frontend,backend}
cd projects/web/frontend
pwd
touch index.html style.css script.js
ls -la
cp index.html ../backend/
mv style.css main.css
rm script.js
cd ..
rmdir frontend
```

### Exercise 2: File Permissions and Ownership
**Objective**: Understand Linux file permissions

**Tasks**:
1. Create a script file and make it executable
2. Change file permissions using `chmod`
3. Change file ownership using `chown`
4. Understand permission notation (rwx, 755, etc.)

**Commands to practice**:
```bash
touch deploy.sh
chmod +x deploy.sh
chmod 755 deploy.sh
ls -l deploy.sh
# Practice with different permission combinations
chmod 644 deploy.sh
chmod u+x,g+r,o-r deploy.sh
```

### Exercise 3: Text Processing
**Objective**: Learn text manipulation commands

**Tasks**:
1. Use `grep` to search for patterns in files
2. Use `sed` for text replacement
3. Use `awk` for text processing
4. Combine commands with pipes

**Commands to practice**:
```bash
# Create a sample log file
echo "2024-01-01 INFO Application started" > app.log
echo "2024-01-01 ERROR Database connection failed" >> app.log
echo "2024-01-01 INFO User logged in" >> app.log

# Practice text processing
grep "ERROR" app.log
grep -i "info" app.log
sed 's/INFO/INFORMATION/g' app.log
awk '{print $1, $2, $3}' app.log
cat app.log | grep "ERROR" | wc -l
```

---

## Version Control with Git

### Exercise 4: Git Basics
**Objective**: Master fundamental Git operations

**Tasks**:
1. Initialize a Git repository
2. Configure Git with your name and email
3. Create and commit files
4. View commit history
5. Create and switch branches

**Commands to practice**:
```bash
git init my-project
cd my-project
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

echo "# My Project" > README.md
git add README.md
git commit -m "Initial commit"

git log --oneline
git branch feature-branch
git checkout feature-branch
git checkout -b another-feature
```

### Exercise 5: Git Collaboration
**Objective**: Learn collaborative Git workflows

**Tasks**:
1. Clone a repository
2. Create pull requests/merge requests
3. Handle merge conflicts
4. Use Git stash
5. Rebase vs merge

**Commands to practice**:
```bash
# Simulate collaboration
git clone https://github.com/your-username/sample-repo.git
cd sample-repo

# Create feature branch
git checkout -b feature/new-functionality
echo "New feature code" > feature.txt
git add feature.txt
git commit -m "Add new feature"

# Stash changes
echo "Work in progress" > wip.txt
git stash
git stash list
git stash pop

# Practice rebasing
git rebase main
```

### Exercise 6: Git Advanced Operations
**Objective**: Master advanced Git techniques

**Tasks**:
1. Interactive rebase to squash commits
2. Cherry-pick specific commits
3. Use Git hooks
4. Understand Git flow workflow

**Commands to practice**:
```bash
# Interactive rebase
git rebase -i HEAD~3

# Cherry-pick
git cherry-pick <commit-hash>

# Create a simple pre-commit hook
echo '#!/bin/bash\necho "Running pre-commit checks..."' > .git/hooks/pre-commit
chmod +x .git/hooks/pre-commit
```

---

## Docker Fundamentals

### Exercise 7: Docker Basics
**Objective**: Learn Docker container fundamentals

**Tasks**:
1. Pull and run Docker images
2. Create your first Dockerfile
3. Build and tag Docker images
4. Manage containers (start, stop, remove)

**Practice**:
```dockerfile
# Create a simple Dockerfile
FROM nginx:alpine
COPY index.html /usr/share/nginx/html/
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

```bash
# Docker commands to practice
docker pull nginx
docker run -d -p 8080:80 nginx
docker ps
docker stop <container-id>
docker build -t my-web-app .
docker run -d -p 8080:80 my-web-app
docker logs <container-id>
docker exec -it <container-id> /bin/sh
```

### Exercise 8: Docker Compose
**Objective**: Orchestrate multi-container applications

**Tasks**:
1. Create a docker-compose.yml file
2. Define services, networks, and volumes
3. Use environment variables
4. Scale services

**docker-compose.yml example**:
```yaml
version: '3.8'
services:
  web:
    build: .
    ports:
      - "8080:80"
    environment:
      - NODE_ENV=production
    depends_on:
      - db
  
  db:
    image: postgres:13
    environment:
      - POSTGRES_DB=myapp
      - POSTGRES_USER=user
      - POSTGRES_PASSWORD=password
    volumes:
      - db_data:/var/lib/postgresql/data

volumes:
  db_data:
```

**Commands to practice**:
```bash
docker-compose up -d
docker-compose ps
docker-compose logs web
docker-compose scale web=3
docker-compose down
```

### Exercise 9: Docker Networking and Volumes
**Objective**: Understand Docker networking and data persistence

**Tasks**:
1. Create custom Docker networks
2. Use different volume types
3. Connect containers across networks
4. Implement data persistence strategies

**Commands to practice**:
```bash
# Networking
docker network create my-network
docker run -d --network my-network --name web nginx
docker run -d --network my-network --name db postgres

# Volumes
docker volume create my-data
docker run -d -v my-data:/data nginx
docker run -d -v $(pwd):/app nginx
```

---

## CI/CD Basics

### Exercise 10: GitHub Actions
**Objective**: Create your first CI/CD pipeline

**Tasks**:
1. Create a GitHub Actions workflow
2. Set up automated testing
3. Build and deploy applications
4. Use secrets and environment variables

**.github/workflows/ci.yml**:
```yaml
name: CI/CD Pipeline

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main ]

jobs:
  test:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v2
    
    - name: Set up Node.js
      uses: actions/setup-node@v2
      with:
        node-version: '14'
    
    - name: Install dependencies
      run: npm install
    
    - name: Run tests
      run: npm test
    
    - name: Build application
      run: npm run build
    
    - name: Deploy to staging
      if: github.ref == 'refs/heads/develop'
      run: echo "Deploying to staging..."
```

### Exercise 11: Jenkins Pipeline
**Objective**: Create Jenkins pipeline as code

**Tasks**:
1. Write a Jenkinsfile
2. Set up build stages
3. Implement parallel execution
4. Add post-build actions

**Jenkinsfile example**:
```groovy
pipeline {
    agent any
    
    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/your-repo/app.git'
            }
        }
        
        stage('Build') {
            steps {
                sh 'npm install'
                sh 'npm run build'
            }
        }
        
        stage('Test') {
            parallel {
                stage('Unit Tests') {
                    steps {
                        sh 'npm run test:unit'
                    }
                }
                stage('Integration Tests') {
                    steps {
                        sh 'npm run test:integration'
                    }
                }
            }
        }
        
        stage('Deploy') {
            when {
                branch 'main'
            }
            steps {
                sh 'docker build -t myapp .'
                sh 'docker push myapp:latest'
            }
        }
    }
    
    post {
        always {
            cleanWs()
        }
        failure {
            mail to: 'team@company.com',
                 subject: "Build Failed: ${env.JOB_NAME}",
                 body: "Build failed. Check console output."
        }
    }
}
```

---

## Infrastructure as Code

### Exercise 12: Terraform Basics
**Objective**: Learn infrastructure provisioning with Terraform

**Tasks**:
1. Write your first Terraform configuration
2. Understand providers and resources
3. Use variables and outputs
4. Manage state files

**main.tf example**:
```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

resource "aws_instance" "web" {
  ami           = "ami-0c02fb55956c7d316"
  instance_type = "t2.micro"
  
  tags = {
    Name = "WebServer"
    Environment = "Development"
  }
}

output "instance_ip" {
  value = aws_instance.web.public_ip
}
```

**Commands to practice**:
```bash
terraform init
terraform plan
terraform apply
terraform show
terraform destroy
```

### Exercise 13: Ansible Playbooks
**Objective**: Learn configuration management with Ansible

**Tasks**:
1. Write Ansible playbooks
2. Use inventory files
3. Implement roles and tasks
4. Handle variables and templates

**playbook.yml example**:
```yaml
---
- name: Configure web servers
  hosts: webservers
  become: yes
  
  vars:
    nginx_port: 80
    app_name: myapp
  
  tasks:
    - name: Install nginx
      package:
        name: nginx
        state: present
    
    - name: Start nginx service
      service:
        name: nginx
        state: started
        enabled: yes
    
    - name: Copy nginx config
      template:
        src: nginx.conf.j2
        dest: /etc/nginx/nginx.conf
      notify: restart nginx
  
  handlers:
    - name: restart nginx
      service:
        name: nginx
        state: restarted
```

**inventory.ini**:
```ini
[webservers]
web1 ansible_host=192.168.1.10
web2 ansible_host=192.168.1.11

[databases]
db1 ansible_host=192.168.1.20
```

**Commands to practice**:
```bash
ansible-playbook -i inventory.ini playbook.yml
ansible webservers -i inventory.ini -m ping
ansible webservers -i inventory.ini -a "uptime"
```

---

## Monitoring and Logging

### Exercise 14: Prometheus and Grafana
**Objective**: Set up monitoring and visualization

**Tasks**:
1. Deploy Prometheus for metrics collection
2. Configure Grafana for visualization
3. Create custom dashboards
4. Set up alerting rules

**docker-compose.yml for monitoring stack**:
```yaml
version: '3.8'
services:
  prometheus:
    image: prom/prometheus
    ports:
      - "9090:9090"
    volumes:
      - ./prometheus.yml:/etc/prometheus/prometheus.yml
  
  grafana:
    image: grafana/grafana
    ports:
      - "3000:3000"
    environment:
      - GF_SECURITY_ADMIN_PASSWORD=admin
    volumes:
      - grafana-data:/var/lib/grafana

volumes:
  grafana-data:
```

**prometheus.yml**:
```yaml
global:
  scrape_interval: 15s

scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['localhost:9090']
  
  - job_name: 'node-exporter'
    static_configs:
      - targets: ['node-exporter:9100']
```

### Exercise 15: ELK Stack (Elasticsearch, Logstash, Kibana)
**Objective**: Implement centralized logging

**Tasks**:
1. Set up Elasticsearch for log storage
2. Configure Logstash for log processing
3. Use Kibana for log visualization
4. Create log parsing rules

**docker-compose.yml for ELK**:
```yaml
version: '3.8'
services:
  elasticsearch:
    image: docker.elastic.co/elasticsearch/elasticsearch:7.14.0
    environment:
      - discovery.type=single-node
      - "ES_JAVA_OPTS=-Xms512m -Xmx512m"
    ports:
      - "9200:9200"
  
  logstash:
    image: docker.elastic.co/logstash/logstash:7.14.0
    volumes:
      - ./logstash.conf:/usr/share/logstash/pipeline/logstash.conf
    depends_on:
      - elasticsearch
  
  kibana:
    image: docker.elastic.co/kibana/kibana:7.14.0
    ports:
      - "5601:5601"
    depends_on:
      - elasticsearch
```

---

## Cloud Platforms

### Exercise 16: AWS Basics
**Objective**: Learn fundamental AWS services

**Tasks**:
1. Launch EC2 instances
2. Create S3 buckets
3. Set up RDS databases
4. Configure VPC and security groups

**AWS CLI commands to practice**:
```bash
# EC2
aws ec2 describe-instances
aws ec2 run-instances --image-id ami-12345678 --count 1 --instance-type t2.micro

# S3
aws s3 mb s3://my-unique-bucket-name
aws s3 cp file.txt s3://my-unique-bucket-name/
aws s3 ls s3://my-unique-bucket-name/

# RDS
aws rds create-db-instance \
  --db-instance-identifier mydb \
  --db-instance-class db.t2.micro \
  --engine mysql \
  --master-username admin \
  --master-user-password password123
```

### Exercise 17: Kubernetes Basics
**Objective**: Learn container orchestration with Kubernetes

**Tasks**:
1. Create pods, services, and deployments
2. Use ConfigMaps and Secrets
3. Implement rolling updates
4. Set up ingress controllers

**deployment.yaml**:
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-app
spec:
  replicas: 3
  selector:
    matchLabels:
      app: web-app
  template:
    metadata:
      labels:
        app: web-app
    spec:
      containers:
      - name: web
        image: nginx:1.20
        ports:
        - containerPort: 80
        resources:
          requests:
            memory: "64Mi"
            cpu: "250m"
          limits:
            memory: "128Mi"
            cpu: "500m"
---
apiVersion: v1
kind: Service
metadata:
  name: web-service
spec:
  selector:
    app: web-app
  ports:
  - port: 80
    targetPort: 80
  type: LoadBalancer
```

**Commands to practice**:
```bash
kubectl apply -f deployment.yaml
kubectl get pods
kubectl get services
kubectl describe pod <pod-name>
kubectl logs <pod-name>
kubectl scale deployment web-app --replicas=5
kubectl rollout status deployment/web-app
```

---

## Configuration Management

### Exercise 18: Environment Configuration
**Objective**: Manage application configurations across environments

**Tasks**:
1. Use environment variables
2. Create configuration files for different environments
3. Implement secrets management
4. Use configuration templates

**config/development.yml**:
```yaml
database:
  host: localhost
  port: 5432
  name: myapp_dev
  username: dev_user
  password: dev_password

redis:
  host: localhost
  port: 6379

logging:
  level: debug
  file: logs/development.log
```

**config/production.yml**:
```yaml
database:
  host: ${DB_HOST}
  port: ${DB_PORT}
  name: ${DB_NAME}
  username: ${DB_USERNAME}
  password: ${DB_PASSWORD}

redis:
  host: ${REDIS_HOST}
  port: ${REDIS_PORT}

logging:
  level: info
  file: /var/log/myapp/production.log
```

### Exercise 19: Secrets Management
**Objective**: Securely handle sensitive information

**Tasks**:
1. Use HashiCorp Vault
2. Implement AWS Secrets Manager
3. Use Kubernetes Secrets
4. Rotate secrets automatically

**Kubernetes Secret example**:
```yaml
apiVersion: v1
kind: Secret
metadata:
  name: app-secrets
type: Opaque
data:
  database-password: <base64-encoded-password>
  api-key: <base64-encoded-api-key>
```

**Using secrets in deployment**:
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: app
spec:
  template:
    spec:
      containers:
      - name: app
        image: myapp:latest
        env:
        - name: DB_PASSWORD
          valueFrom:
            secretKeyRef:
              name: app-secrets
              key: database-password
```

---

## Networking Basics

### Exercise 20: Network Fundamentals
**Objective**: Understand networking concepts for DevOps

**Tasks**:
1. Configure firewalls and security groups
2. Set up load balancers
3. Implement SSL/TLS certificates
4. Configure DNS records

**nginx load balancer config**:
```nginx
upstream backend {
    server 192.168.1.10:8080;
    server 192.168.1.11:8080;
    server 192.168.1.12:8080;
}

server {
    listen 80;
    server_name example.com;
    
    location / {
        proxy_pass http://backend;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}
```

**iptables firewall rules**:
```bash
# Allow SSH
iptables -A INPUT -p tcp --dport 22 -j ACCEPT

# Allow HTTP and HTTPS
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT

# Allow established connections
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# Drop all other traffic
iptables -A INPUT -j DROP
```

---

## Security Fundamentals

### Exercise 21: Security Best Practices
**Objective**: Implement security measures in DevOps

**Tasks**:
1. Scan container images for vulnerabilities
2. Implement RBAC (Role-Based Access Control)
3. Set up security monitoring
4. Create security policies

**Dockerfile security best practices**:
```dockerfile
# Use specific version tags
FROM node:16.14.2-alpine

# Create non-root user
RUN addgroup -g 1001 -S nodejs
RUN adduser -S nextjs -u 1001

# Copy files with proper ownership
COPY --chown=nextjs:nodejs . .

# Switch to non-root user
USER nextjs

# Use HEALTHCHECK
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:3000/health || exit 1
```

**Kubernetes RBAC example**:
```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: pod-reader
rules:
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["get", "watch", "list"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: read-pods
subjects:
- kind: User
  name: jane
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: Role
  name: pod-reader
  apiGroup: rbac.authorization.k8s.io
```

### Exercise 22: Vulnerability Scanning
**Objective**: Implement security scanning in CI/CD

**Tasks**:
1. Use Trivy for container scanning
2. Implement SAST (Static Application Security Testing)
3. Set up dependency scanning
4. Create security gates in pipelines

**GitHub Actions security scanning**:
```yaml
name: Security Scan

on: [push, pull_request]

jobs:
  security:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    
    - name: Run Trivy vulnerability scanner
      uses: aquasecurity/trivy-action@master
      with:
        image-ref: 'myapp:latest'
        format: 'sarif'
        output: 'trivy-results.sarif'
    
    - name: Upload Trivy scan results
      uses: github/codeql-action/upload-sarif@v1
      with:
        sarif_file: 'trivy-results.sarif'
```

---

## Practice Projects

### Project 1: Complete Web Application Deployment
**Objective**: Deploy a full-stack application with CI/CD

**Requirements**:
1. Containerize a web application (frontend + backend + database)
2. Set up CI/CD pipeline with automated testing
3. Deploy to Kubernetes cluster
4. Implement monitoring and logging
5. Set up automated backups

### Project 2: Infrastructure Automation
**Objective**: Automate infrastructure provisioning and configuration

**Requirements**:
1. Use Terraform to provision cloud infrastructure
2. Use Ansible to configure servers
3. Implement auto-scaling
4. Set up disaster recovery
5. Create infrastructure documentation

### Project 3: Monitoring and Alerting System
**Objective**: Build comprehensive monitoring solution

**Requirements**:
1. Set up Prometheus and Grafana
2. Create custom metrics and dashboards
3. Implement alerting rules
4. Set up log aggregation with ELK stack
5. Create runbooks for common issues

---

## Learning Resources

### Books
- "The Phoenix Project" by Gene Kim
- "The DevOps Handbook" by Gene Kim, Patrick Debois, John Willis, and Jez Humble
- "Site Reliability Engineering" by Google
- "Infrastructure as Code" by Kief Morris

### Online Platforms
- Katacoda (Interactive DevOps scenarios)
- Play with Docker
- Play with Kubernetes
- AWS Free Tier
- Google Cloud Free Tier

### Certifications to Consider
- AWS Certified DevOps Engineer
- Google Cloud Professional DevOps Engineer
- Docker Certified Associate
- Certified Kubernetes Administrator (CKA)
- HashiCorp Certified: Terraform Associate

---

## Tips for Success

1. **Start Small**: Begin with simple exercises and gradually increase complexity
2. **Practice Regularly**: Set aside time daily for hands-on practice
3. **Build Projects**: Apply concepts in real-world scenarios
4. **Join Communities**: Participate in DevOps forums and communities
5. **Stay Updated**: Follow DevOps blogs and attend conferences
6. **Document Everything**: Keep notes and create your own reference materials
7. **Automate Everything**: Look for opportunities to automate repetitive tasks
8. **Learn from Failures**: Embrace failures as learning opportunities
9. **Collaborate**: Work on team projects to understand collaboration aspects
10. **Measure and Monitor**: Always implement monitoring in your projects

Remember: DevOps is not just about tools—it's about culture, practices, and continuous improvement!