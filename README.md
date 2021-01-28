### What is this repository for?
This is an automated setup for Debian 10 machines as minimal servers to be used as a Nginx webserver that will run any application that is able to being deployed with docker and docker-compose.

### Prerequisites
**[Ansible 2.10](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) on your local machine**

Ansible is currently only working on Unix or Unix-like operating systems. If you are a Windows 10 User I recommend using [WSL](https://docs.microsoft.com/en-us/windows/wsl/install-win10) to get a Unix-like environment to use Ansible with.

**SSH access to a server with password**

Might need to install sshpass when run on Ubuntu 20.04

**Disabled firewall on the target system**

This needs to be done when a firewall is configured to not let you download needed packages from outside the network.

**Access from your network to the machine**

Make sure that you are able to connect from your network to the machine hosted on the network you want to modify. It might be necessary to connect via VPN.

### How to use this?

Pull the repository, insert credentials in the inventory and save. To check if the inventory file is setup correctly run in terminal

```
./testConnection.sh
```

To get all needed roles required locally for the installation of the packages run in terminal

```
./setupLocalhost.sh
```

Now change the `server_hostname` variable in`vars/main.yml`to your given hostname and run `./setupSudoServer.sh` to install sudo privilage for the local user. This step is necessary so permissions for executing the packages inside the next playbook are configured correctly. On `BECOME password:` prompt, enter the **root** user password.

After success run

```
ansible-playbook -i inventory -K playbook.yml
```

 On `BECOME password:` prompt, enter the **local** user password.

The server should now be able to deploy a docker container running on port 3000 and be accessible from outside over the hostname.

### What is Ansible doing?
**Installing sudo**

The issue with initial Deb10 buster server setup is that it is missing the sudo permission for the local user after installation. So the first task is to install the sudo package and modify the sudoers group

**Installing and configuring Nginx**

Nginx is configured to run all requests from 80 or 443 to localhost:3000

**Installing selfmanaged SSL Certificate**

WIP

**Installing Docker & docker-compose**

Installs latest version of Docker and 1.26.0 docker-compose

**Installing and configuring UFW**

Rules: Allows all requests to OpenSSH

​			Allow all traffic to 80/tcp

​			Allow all traffic to 443/tcp