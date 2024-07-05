# DevOps-Project-3tier-Application-Deployment-eks-RabbitMQ-Memcache-MySQL
![image](https://github.com/singhritesh85/DevOps-Project-3tier-Application-Deployment-eks-RabbitMQ-Memcache-MySQL/assets/56765895/23fe579f-ba90-41ae-b108-1d1d31ee58f0)

In the Architecture diagram shown above a basic architecture of three-tier application is shown. In this diagram the first layer or tier is Presentation Layer or web tier. The second layer or tier is Application Layer or Business Tier and third layer or tier is Database Layer or Database tier. For web tier Nginx Service, for Application tier Tomcat and for Database tier MySQL and Memcache(for cache purpose) has been used as shown in the Architecture diagram above.
<br><br/>
The three tier Application is implemented using EKS as shown in the diagram below. It's Architecture diagram is same as explained above but instead of Nginx Sever, Elastic LoadBalancer has been used.
![image](https://github.com/singhritesh85/DevOps-Project-3tier-Application-Deployment-eks-RabbitMQ-Memcache-MySQL/assets/56765895/bf5bee56-6c50-4579-9c21-316334c56a83)

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

Finally copy the DNS Name of the Application LoadBalancer of RabbitMQ and create the Record Set in hosted zone of Route 53. Access the URL and you will see the default console for RabbitMQ, you can use the initial username and password as guest and login into the RabbitMQ console.
![image](https://github.com/singhritesh85/DevOps-Project-3tier-Application-Deployment-eks-RabbitMQ-Memcache-MySQL/assets/56765895/36cc38be-a1ad-4ede-883a-398ae2bc73b5)

On Jenkins Slave node create a file using the file present in Repository https://github.com/singhritesh85/Three-tier-WebApplication.git, at the path Three-tier-WebApplication/src/main/resources/db_backup.sql with the name db.sql and create a database with the name accounts then import it as shown in the screenshot below.
![image](https://github.com/singhritesh85/DevOps-Project-3tier-Application-Deployment-eks-RabbitMQ-Memcache-MySQL/assets/56765895/64aecad1-b3f4-4fca-a488-7d822217df79)
![image](https://github.com/singhritesh85/DevOps-Project-3tier-Application-Deployment-eks-RabbitMQ-Memcache-MySQL/assets/56765895/58a93fea-3357-43c1-be57-38746b5e345d)


