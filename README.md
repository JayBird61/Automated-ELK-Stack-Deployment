## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

![Network Diagram](https://github.com/JayBird61/Automated-ELK-Stack-Deployment/blob/207cc67375eb174340a05366e0658887b6f2680a/Diagrams/Updated%20Network%20Diagram.JPG)

These files have been tested and used to generate a live ELK deployment on Azure. 
They can be used to either recreate the entire deployment pictured above or alternatively, 
select portions of the playbook.yml file(s) may be used to install only certain pieces of it, such as Filebeat.

[Ansible Playbooks](https://github.com/JayBird61/Automated-ELK-Stack-Deployment/tree/main/Ansible)

This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build

### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D..n Vulnerable Web Application.

Load balancing ensures that the application will be highly available, in addition to restricting access to the network.

-A load balancer distributes web traffic making it more difficult to overload the servers to which it is directing the traffic. In the case of this build the load balancer directs traffic to the public-facing webserver containers (DVWA) without exposing the virtual machines themselves.

-The Jumpbox allows simultaneous and, if desired, identical configuration of all the systems without exposing the system to the greater internet. It also keeps the virtual machines hosting the docker containers "compartmentalized" or segmented away from direct internet exposure allowing only the machine specified in the NSG rules to access it. This reduces the surface of attack against the network.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the network and system logs. This build utilizes Filebeat and Metricbeat to accomplish that task.

-Filebeat monitors specified logs and locations and collects the logs to forward them to either Logstash or, in our case, Elasticsearch.

-Metricbeat collects statistics and metrics about every other container running in the network. In a similar fashion, Metric beat also forwards what it collects to Elasticsearch.

The configuration details of each machine may be found below:
| Name    | Function   | IP Address | Operating System |
|---------|------------|------------|------------------|
| JumpBox | Gateway    | 10.0.0.4   | Linux            |
| Web1    | Webserver  | 10.0.0.5   | Linux            |
| Web2    | Webserver  | 10.0.0.6   | Linux            |
| ELK VM  | Monitoring | 10.2.0.4   | Linux            |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the Jumpbox Provisioner machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses: <workstation external ip> with ssh key instead of username/password. This is prevents bruteforce attacks against the network. It is not particularly scalable though because it would require manually updating the NSG for every new machine added to the network. Accessing the network via VPN could be an alternative if greater scaling is necessary.
  
Machines within the network can only be accessed by ssh from the JumpBox (10.0.0.4).

A summary of the access policies in place can be found in the table below:
| Name    | Publically Accessible? | Allowed IP Addresses |
|---------|------------------------|----------------------|
| JumpBox | Yes                    | Home IP & vNet       |
| Web1    | No                     | vNet only            |
| Web2    | No                     | vNet only            |
| ELK VM  | Read-only via Kibana   | vNet only            |
  
### ELK Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because Ansible can be used to configure multiple containers and vms through the use of playbooks (.yml files). This allows this method to be very scalable and efficient once it's set up.
  
The [ELK playbook](https://github.com/JayBird61/Automated-ELK-Stack-Deployment/blob/0b19034fd2a1476f01b89bacd8d8cca1a444076f/Ansible/ELK_Playbook_Push.yml) implements the following tasks:
- Install docker.io
- Install Python3
- Install docker using Python
- Increase virtual memory
- Increase available memory
- Download and launch ELK container with restart policy set to "always"
  
  The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.
  ![Elk Playbook Success](https://github.com/JayBird61/Automated-ELK-Stack-Deployment/blob/d0b3a07b9e8932f5cc954fe49231d24c4c2b20e0/Successful%20Images/ELK%20Ansible%20Edit.jpg)
  
  ### Target Machines & Beats
This ELK server is configured to monitor the following machines:
-JumpBox Provisioner
-Web1
-Web2
  
We have installed the following Beats on these machines which collect information from each machine:
Filebeat: collects logs such as errors and system logs and pushes them to Elasticsearch which we can monitor via Kibana.
Metricbeat: monitors metrics such as uptime and pushes them to Elasticsearch as well.
  
### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already
configured. Assuming you have such a control node provisioned: 
  
SSH into the control node and follow the steps below:
- Copy/curl the ![ELK Playbook]((https://github.com/JayBird61/Automated-ELK-Stack-Deployment/blob/0b19034fd2a1476f01b89bacd8d8cca1a444076f/Ansible/ELK_Playbook_Push.yml) file to /etc/ansible/hosts/roles
- Update the hosts file to include [elk] group
- Run the playbook, and navigate in a browser to http://[your_ELK_vm_ext_IP]:5601/app/kibana to check that the installation worked as expected.
- In the browser you should see something that looks similar to ![Kibana](https://github.com/JayBird61/Automated-ELK-Stack-Deployment/blob/d0b3a07b9e8932f5cc954fe49231d24c4c2b20e0/Successful%20Images/Kibana%20Success%20Edit.png)
  
Questions:
-Which file is the playbook?
  ![ELK Playbook]((https://github.com/JayBird61/Automated-ELK-Stack-Deployment/blob/0b19034fd2a1476f01b89bacd8d8cca1a444076f/Ansible/ELK_Playbook_Push.yml) file to /etc/ansible/hosts/roles

-Where do you copy it? 
  /etc/ansible
  
-Which file do you update to make Ansible run the playbook on a specific machine? 
  /etc/Ansible/Hosts
  
-How do I specify which machine to install the ELK server on versus which to install Filebeat on? 
  Specify the group in the respective *.yml files. (the server belongs on the machine it runs on whereas the beats run on the machines to monitor. In our case the beats are on the webservers)

-Which URL do you navigate to in order to check that the ELK server is running?
http://[ELK_EXT_IP]:5601/app/kibana#/home/tutorial/systemLogs then click "Check data" next to module status
  
In /etc/ansible run:
curl https://raw.githubusercontent.com/JayBird61/Automated-ELK-Stack-Deployment/main/Ansible/ELK_Playbook_Push.yml > ELK_Playbook.yml to get the ELK_Playbook.yml file

Update the hosts file:
sudo nano hosts
  add this to the hosts file in the groups section:
    [elk]
    <private IP of ELK machine> ansible_python_interpreter=/usr/bin/python3
Then run the ELK_Playbook.yml by running
      ansible-playbook ELK_Playbook.yml
      
This will install the ELK Server container on the ELK VM
Next, enter http://[your.ELK-VM.External.IP]:5601/app/kibana into your browser to confirm the install was successful. 
      
To install the beats:
Click "Explore On My Own" and then "Add log data" on the now open Kibana page
From there, for Filebeat choose "System Logs" and choose your OS. Then follow the onscreen instructions.
      For Metricbeat go back to the "Explore On My Own" page then go to "Add metric data." Choose "Docker Metrics" then your OS and follow the instructions
Note: at the end of the instructional pages for both Filebeat and Metricbeat, the final step allows you to check that everything is configured properly.
