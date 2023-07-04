# Ansible Playbook for Mail Server Setup

This playbook installs and configures a mail server on a remote host. It installs required packages and sets up a Docker container running a poste.io mail server.
## Prerequisites :writing_hand:

    A remote host with a user account that has sudo privileges or public key deployed
    Ansible installed on your local machine

## Usage :mechanical_arm:

    Update the hosts file with the IP address or hostname of your remote host.

    Update the variables in the host_vars files to match your desired configuration. The following variables must be defined:
 
       - path_for_data: the path to the directory where mail data will be stored
       - image_with_tag: the Docker image to use for the mail server
       - serv_hostname: the hostname of the mail server to run docker with
       - mem_limit: the amount of memory to allocate to the Docker container

    Run the playbook with the following command:
```
ansible-playbook -i hosts setup.yml
```
## Playbook tasks :man_mechanic:

   - Install aptitude package manager.
   - Install required system packages including curl, fail2ban, docker.io, mc, and tree.
   - Set the timezone to Kyiv.
   - Create a directory for mail data.
   - Create a Docker container running the poste.io mail server.
   - Delete the snapd package.
   - Copy the fail2ban configuration script f2bconf.sh to the remote host.

## Notes :notebook:

    The become: true statement at the top of the playbook enables privilege escalation, allowing Ansible to execute tasks with sudo privileges.

    The commented out tasks can be uncommented and customized to your needs, such as creating a new user with sudo privileges, setting up passwordless sudo, adding an authorized key for the remote user, and disabling password authentication for root.

