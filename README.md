# DevOps-Project-3tier-Application-Deployment-eks-RabbitMQ-Memcache-MySQL
![image](https://github.com/singhritesh85/DevOps-Project-3tier-Application-Deployment-eks-RabbitMQ-Memcache-MySQL/assets/56765895/23fe579f-ba90-41ae-b108-1d1d31ee58f0)

In the Architecture diagram shown above a basic architecture of three-tier application is shown. In this diagram the first layer or tier is Presentation Layer or web tier. The second layer or tier is Application Layer or Business Tier and third layer or tier is Database Layer or Database tier. For web tier Nginx Service, for Application tier Tomcat and for Database tier MySQL and Memcache(for cache purpose) has been used as shown in the Architecture diagram above.
<br><br/>
The three tier Application is implemented using EKS as shown in the diagram below. It's Architecture diagram is same as explained above but instead of Nginx Sever, Elastic LoadBalancer has been used.
![image](https://github.com/singhritesh85/DevOps-Project-3tier-Application-Deployment-eks-RabbitMQ-Memcache-MySQL/assets/56765895/46fa5a3d-969a-4112-88fe-9923110a4882)

I have used terraform script as provided in this repository to create the EC2 Instances, ALBs, EKS, Memcached and RDS. 
<br><br/>
I have created RabbitMQ cluster with three instances. Follow below procedures to achieve the same.
```
Using the above terraform script and the bootstrap script used with terraform three EC2 Instances for RabbitMQ will be created along with the Application LoadBalancer.
The Bootstrapping script will install RabbitMQ on three EC2 Instances. Then list the plugins, enable rabbitmq_management plugin and restart the rabbitmq-server on the three EC2 Instances. To achieve this I have used below commands.
(a) rabbitmq-plugins list
(b) rabbitmq-plugins enable rabbitmq_management
(c) systemctl restart rabbitmq-server
Finally you can ensure that rabbitmq_management plugin is enabled or not using the command rabbitmq-plugins list
```
**First Node, Consider it as Node-1**
![image](https://github.com/singhritesh85/DevOps-Project-3tier-Application-Deployment-eks-RabbitMQ-Memcache-MySQL/assets/56765895/dadaa610-9b90-46b1-aaf5-0fb36211da88)
![image](https://github.com/singhritesh85/DevOps-Project-3tier-Application-Deployment-eks-RabbitMQ-Memcache-MySQL/assets/56765895/6b4d1587-63dd-42ff-918d-b7d3b2a3ea5a)
**Second Node, Consider it as Node-2**
![image](https://github.com/singhritesh85/DevOps-Project-3tier-Application-Deployment-eks-RabbitMQ-Memcache-MySQL/assets/56765895/a245cb65-11bc-48c6-a0b0-4069eabc8b0f)
![image](https://github.com/singhritesh85/DevOps-Project-3tier-Application-Deployment-eks-RabbitMQ-Memcache-MySQL/assets/56765895/bbf39f48-ad6e-4aeb-a3e6-af3edd3ea2e0)
**Third Node, Consider it as Node-3**
![image](https://github.com/singhritesh85/DevOps-Project-3tier-Application-Deployment-eks-RabbitMQ-Memcache-MySQL/assets/56765895/4b74c273-3862-4ee1-b516-70ae56d0bca0)
![image](https://github.com/singhritesh85/DevOps-Project-3tier-Application-Deployment-eks-RabbitMQ-Memcache-MySQL/assets/56765895/077f493b-3d6c-4812-84a9-874dd068215d)

To create RabbitMQ cluster of three nodes follow the below procedures.
```
On Node-1 (RabbitMQ-Server-1) open the file /var/lib/rabbitmq/.erlang.cookie using cat command and copy the hash value of cookie and paste it on Node-2 and Node-3 in the file /var/lib/rabbitmq/.erlang.cookie.
Then restart rabbitmq-server service, then stop rabbitmq application using the command rabbitmqctl stop_app on Node-2 (RabbitMQ-Server-2) and Node-3 (RabbitMQ-Server-3). Finally run the command rabbitmqctl join_cluster rabbit@<IP_Address_Node1> and start the rabbitmq application using the command rabbitmqctl start_app on Node-2 and Node-3.
```
**Node-1**
![image](https://github.com/singhritesh85/DevOps-Project-3tier-Application-Deployment-eks-RabbitMQ-Memcache-MySQL/assets/56765895/d08384f9-c25b-4a33-a376-918f2d3cc006)
**Node-2**
![image](https://github.com/singhritesh85/DevOps-Project-3tier-Application-Deployment-eks-RabbitMQ-Memcache-MySQL/assets/56765895/e9303430-a3a8-42ee-a5c2-d86929ab5e82)
![image](https://github.com/singhritesh85/DevOps-Project-3tier-Application-Deployment-eks-RabbitMQ-Memcache-MySQL/assets/56765895/10425ff9-8aa4-45ad-8e7a-3f6e692fbfa6)
![image](https://github.com/singhritesh85/DevOps-Project-3tier-Application-Deployment-eks-RabbitMQ-Memcache-MySQL/assets/56765895/529395f5-6e59-4b88-8260-d1a4bf803c5d)
![image](https://github.com/singhritesh85/DevOps-Project-3tier-Application-Deployment-eks-RabbitMQ-Memcache-MySQL/assets/56765895/ea69e831-7a8b-40fd-bafc-5620574921b6)
![image](https://github.com/singhritesh85/DevOps-Project-3tier-Application-Deployment-eks-RabbitMQ-Memcache-MySQL/assets/56765895/cae4b0ac-eb30-4cdc-b5a5-33f95eadb9d2)
![image](https://github.com/singhritesh85/DevOps-Project-3tier-Application-Deployment-eks-RabbitMQ-Memcache-MySQL/assets/56765895/a74224ea-4540-4944-9ab5-88b385a61292)
**Node-3**
![image](https://github.com/singhritesh85/DevOps-Project-3tier-Application-Deployment-eks-RabbitMQ-Memcache-MySQL/assets/56765895/e72565cf-34de-484f-9872-9ff1a314ff08)
![image](https://github.com/singhritesh85/DevOps-Project-3tier-Application-Deployment-eks-RabbitMQ-Memcache-MySQL/assets/56765895/d9bea6cf-18ca-484d-92db-e10a6a202c0e)
![image](https://github.com/singhritesh85/DevOps-Project-3tier-Application-Deployment-eks-RabbitMQ-Memcache-MySQL/assets/56765895/654159fc-3a68-41a3-8d78-9b7afe58cf31)
![image](https://github.com/singhritesh85/DevOps-Project-3tier-Application-Deployment-eks-RabbitMQ-Memcache-MySQL/assets/56765895/362306a2-e61b-4e11-9bfa-fc58379c52a1)
![image](https://github.com/singhritesh85/DevOps-Project-3tier-Application-Deployment-eks-RabbitMQ-Memcache-MySQL/assets/56765895/338c63ce-63ed-42c5-951b-2e5c9f50f457)
<br><br/>
Finally copy the DNS Name of the Application LoadBalancer of RabbitMQ and create the Record Set in hosted zone of Route 53. Access the URL and you will see the default console for RabbitMQ, you can use the initial username and password as guest and login into the RabbitMQ console.
![image](https://github.com/singhritesh85/DevOps-Project-3tier-Application-Deployment-eks-RabbitMQ-Memcache-MySQL/assets/56765895/36cc38be-a1ad-4ede-883a-398ae2bc73b5)

On Jenkins Slave node create a file using the file present in Repository https://github.com/singhritesh85/Three-tier-WebApplication.git, at the path Three-tier-WebApplication/src/main/resources/db_backup.sql with the name db.sql and create a database with the name accounts then import it as shown in the screenshot below.
![image](https://github.com/singhritesh85/DevOps-Project-3tier-Application-Deployment-eks-RabbitMQ-Memcache-MySQL/assets/56765895/64aecad1-b3f4-4fca-a488-7d822217df79)
![image](https://github.com/singhritesh85/DevOps-Project-3tier-Application-Deployment-eks-RabbitMQ-Memcache-MySQL/assets/56765895/58a93fea-3357-43c1-be57-38746b5e345d)
<br><br/>
Configure the Jenkins Slave Node as shown in the screenshot below.
![image](https://github.com/singhritesh85/DevOps-Project-3tier-Application-Deployment-eks-RabbitMQ-Memcache-MySQL/assets/56765895/d75bb1b4-4958-4d60-9d74-cde617cd25f1)
Install the SonarQube Scanner, Nexus Artifact Uploader and Pipeline Utility Step as shown in the screenshot below.
![image](https://github.com/singhritesh85/DevOps-Project-3tier-Application-Deployment-eks-RabbitMQ-Memcache-MySQL/assets/56765895/5d9f4070-a2ab-422f-8541-65c1197eea1f)
![image](https://github.com/singhritesh85/DevOps-Project-3tier-Application-Deployment-eks-RabbitMQ-Memcache-MySQL/assets/56765895/a602dc14-ef29-49fe-90da-50cbbb60c643)
![image](https://github.com/singhritesh85/DevOps-Project-3tier-Application-Deployment-eks-RabbitMQ-Memcache-MySQL/assets/56765895/a2967255-a6dd-483e-a1f7-fe1b6ee93d39)
<br><br/>
To install nginx ingress controller and ArgoCD follow the below procedure
```
kubectl create ns ingress-nginx
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm install ingress-nginx ingress-nginx/ingress-nginx -n ingress-nginx

After creating it you need to edit the service and provide ssl certificate details and etc. in annotations as written below:- 
=================================================================
service.beta.kubernetes.io/aws-load-balancer-backend-protocol: http
service.beta.kubernetes.io/aws-load-balancer-connection-idle-timeout: "60"
service.beta.kubernetes.io/aws-load-balancer-cross-zone-load-balancing-enabled: "true"
service.beta.kubernetes.io/aws-load-balancer-ssl-cert: arn:aws:acm:us-east-2:XXXXXXXX:certificate/XXXXXX-XXXXXXX-XXXXXXX-XXXXXXXX
service.beta.kubernetes.io/aws-load-balancer-ssl-ports: https
service.beta.kubernetes.io/aws-load-balancer-type: elb

===================================================================
You need to change the targetPort for https to http in nginx ingress controller service as written below:-
-------------------------------------------------------------------------------------------------------------------------------
Before:

  ports:
    - name: http
      port: 80
      protocol: TCP
      targetPort: http
    - name: https
      port: 443
      protocol: TCP
      targetPort: https
After:

  ports:
    - name: http
      port: 80
      protocol: TCP
      targetPort: http
    - name: https
      port: 443
      protocol: TCP
      targetPort: http
=================================================================

kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

Use the argocd-ingress-rule.yaml file as provided with Repository and create the URL, do the entry for this URL with DNS Name in Record Set of hosted zone of Route53. 

You can get the password of ArgoCD using the command written below-
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d

Now login into ArgoCD using the username admin and password as obtained above. After Login into ArgoCD change the password.

Finally Install ArgoCD cli on your Jenkins Slave.
```
<br><br/>
Create the Jenkins Job using the Jenkinsfile as provided in this Repository and update the file **application.properties** present at the path Three-tier-WebApplication/src/main/resources as shown in the screenshot below.
![image](https://github.com/singhritesh85/DevOps-Project-3tier-Application-Deployment-eks-RabbitMQ-Memcache-MySQL/assets/56765895/4d97eae9-fe92-42aa-a568-b7f99dc0fc3a)
![image](https://github.com/singhritesh85/DevOps-Project-3tier-Application-Deployment-eks-RabbitMQ-Memcache-MySQL/assets/56765895/a7f17aa3-8d10-474c-9530-d3f6b70e1e11)

Now Run the Jenkins Job after providing the parameters. Create the URL using ingress rule for service present in the file ingress-rule.yaml in this repository. Do the entry for this URL with DNS Name in Record Set of Route53. Access the newly created URL and provide username **admin_vp** and password **admin_vp**.   
![image](https://github.com/singhritesh85/DevOps-Project-3tier-Application-Deployment-eks-RabbitMQ-Memcache-MySQL/assets/56765895/247e8919-1266-4d7e-90fc-0947efb94e0b)
![image](https://github.com/singhritesh85/DevOps-Project-3tier-Application-Deployment-eks-RabbitMQ-Memcache-MySQL/assets/56765895/553d72db-536d-4ad2-9594-36705cae1de4)
![image](https://github.com/singhritesh85/DevOps-Project-3tier-Application-Deployment-eks-RabbitMQ-Memcache-MySQL/assets/56765895/0eb48ba5-26ad-4bbb-872f-2cce654b7d20)
When you click on the User for the first time it will get the values from MySQL Database and store it in Memcache, so that next time when you click on the same user it will provide the values from the Memcache itself.
![image](https://github.com/singhritesh85/DevOps-Project-3tier-Application-Deployment-eks-RabbitMQ-Memcache-MySQL/assets/56765895/1ebf7501-0fe9-468d-b94e-64c69c15114d)
![image](https://github.com/singhritesh85/DevOps-Project-3tier-Application-Deployment-eks-RabbitMQ-Memcache-MySQL/assets/56765895/067bd76c-9ce6-4af2-b72f-fbef5a1291b4)
![image](https://github.com/singhritesh85/DevOps-Project-3tier-Application-Deployment-eks-RabbitMQ-Memcache-MySQL/assets/56765895/e14f5c2c-f5f7-4fd7-8fa9-29d64d176a01)
<br><br/>
After running the Jenkins Job the Screenshot for RabbitMQ, SonarQube, Nexus Artifactory and ArgoCD is as shown in the Screenshot below.
![image](https://github.com/singhritesh85/DevOps-Project-3tier-Application-Deployment-eks-RabbitMQ-Memcache-MySQL/assets/56765895/14e616b7-7c21-4923-ba49-a654905240b3)
![image](https://github.com/singhritesh85/DevOps-Project-3tier-Application-Deployment-eks-RabbitMQ-Memcache-MySQL/assets/56765895/0088339c-299f-4d97-8119-ced4fe14654b)
![image](https://github.com/singhritesh85/DevOps-Project-3tier-Application-Deployment-eks-RabbitMQ-Memcache-MySQL/assets/56765895/564e6944-1ccf-490e-86df-ff77e0a71c31)
![image](https://github.com/singhritesh85/DevOps-Project-3tier-Application-Deployment-eks-RabbitMQ-Memcache-MySQL/assets/56765895/208d28d6-8d76-4610-86c5-632c8b97ef9c)
![image](https://github.com/singhritesh85/DevOps-Project-3tier-Application-Deployment-eks-RabbitMQ-Memcache-MySQL/assets/56765895/9fb1bcc2-f035-4130-a034-f4c5c49445f0)

<br><br/>
<br><br/>
<br><br/>
<br><br/>
<br><br/>
```
Source Code:-  https://github.com/singhritesh85/Three-tier-WebApplication.git
```
<br><br/>
<br><br/>
<br><br/>
<br><br/>
<br><br/>
```
Reference:-  https://github.com/logicopslab/vprofile-project.git
```
