# CITY MALL ASSIGNMENT


## Create AWS Auto Scaling Group using Terraform

### Terraform Configuration

The Terraform configuration is located in the `AWS_ASG` directory. In this directory, you will find the following files:

-   `main.tf`: The main Terraform configuration file, where you will define the AWS Auto Scaling Group.
-   `variables.tf`: The Terraform variable file, where you will define variables used in the `main.tf` file.
-   `versions.tf`: The file where terraform provider details are located like AWS in this case.
- The GitHub Actions workflow is defined in the `.github/workflows/terraform.yml` file.
- To run terraform script using GitHub Actions, do an empty commit/changes to GitHub master branch which will automatically trigger the terraform script and will create an AWS Autoscaling group on AWS.
- Add `AWS_REGION` at the environment of github project settings.
- Make sure to add `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` as secret in github

## Deploy Stateful application on k8s cluster (minikube)

Follow these steps to deploy RabbitMQ service on k8s minikube cluster:

- Follow the steps mentioned on https://minikube.sigs.k8s.io/docs/start to install minikube if it is not installed on local.
- If minikube is already installed on the system, open the terminal on the system and run `minikube start` to start the minikube service.
- Run the following steps to deploy the rabbitmq service under `rabbitMQ_statefulset/` folder

    - `kubectl apply -f configmap.yaml` to deploy configmap which will enable required plugins and set the required configuration
    - `kubectl apply -f rabbitmq-secret.enc.yaml` which will add erlang_cookie to enable and run rabbitmq service.
    - `kubectl apply -f rbac.yaml` to create role and role bindings for rabbitmq
    - `kubectl apply -f statefulset.yaml` to deploy the stateful rabbitmq service on the cluster.
- These steps will spin rabbitMQ services on minikube which can be accessed internally by other services using the internal connection endpoint or using the rabbitMQ management console.
- To run rabbitmq management console, use the `kubectl port-forward --namespace default svc/rabbitmq 15672:15672` command and run `127.0.0.1:15672` on the browser, use `guest` as username and password to login.

## Add Application load balancer (ALB) in nginx helm chart

- Follow the steps mentioned on https://minikube.sigs.k8s.io/docs/start to install minikube if it is not installed locally.
- If minikube is already installed on the system, open the terminal on the system and run `minikube start` to start the minikube service.
- Run `minikube addons enable ingress` to enable ingress on the minikube so we can use ingress locally, it will deploy nginx ingress controller to run the supported services.
- Run `helm install <helm release name> .` under `nginx-helm-chart` folder
- It will deploy nginx on minikube and create a hostname `nginx2.com` to run the nginx service from the browser.
- Run the commands which is mentioned on the terminal after installing the helm chart, it will look like
> export CLUSTER_IP=$(minikube ip) # On Minikube. Use: `kubectl cluster-info` on others K8s clusters

>echo "NGINX URL: http://nginx2.com"

>echo "$CLUSTER_IP  nginx2.com" | sudo tee -a /etc/hosts

### NOTE:
- To create the ALB with the help of helm chart and ingress, we have to install `aws-loadbalancer-controller` on the Kubernetes cluster (like EKS) which will create a new entry based on ingress service. Follow https://docs.aws.amazon.com/eks/latest/userguide/aws-load-balancer-controller.html to deploy `aws-loadbalancer-controller`.
- Remove `{}` from ingress annotation at line https://github.com/vipulJain05/DevOps_project/blob/master/nginx-helm-chart/values.yaml#L594 and uncomment the line number [L595](https://github.com/vipulJain05/DevOps_project/blob/master/nginx-helm-chart/values.yaml#L595), [L597](https://github.com/vipulJain05/DevOps_project/blob/master/nginx-helm-chart/values.yaml#L597), [L599](https://github.com/vipulJain05/DevOps_project/blob/master/nginx-helm-chart/values.yaml#L599), [L601](https://github.com/vipulJain05/DevOps_project/blob/master/nginx-helm-chart/values.yaml#L601) to create AWS ALB and set its rules on AWS
