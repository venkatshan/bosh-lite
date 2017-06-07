


Install [Vagrant](http://www.vagrantup.com/downloads.html)

    Known working version:

    ```
    $ vagrant --version
    Vagrant 1.9.5
    ```



### Install and Boot a Virtual Machine

Installation instructions for different Vagrant providers:

* VirtualBox (below)
* [AWS](docs/aws-provider.md)

#### Using the VirtualBox Provider

1. Make sure your machine has at least 8GB RAM, and 100GB free disk space. Smaller configurations may work.

1. Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads)

    Known working version:

    ```
    $ VBoxManage --version
    Version 5.1.22 r115126 (Qt5.6.2)
    ```

1. Clone this repository

    ```
    $ cd ~/workspace
    $ git clone https://github.com/cloudfoundry/bosh-lite
    $ cd bosh-lite
    ```

    ```
    $ vagrant up 
    ```

    Your VM should be ready in about an hour depending on Internet conneciton speed and your laptop/pc config.

2. Stop/Start. 
      It is recommended to use vagrant {suspend/resume}
      
      After statring the VM. Login and issue folling commands
       ```
         ~vagrant/bosh-lite/bin/add-route
         bosh cck
       ```
         
 3. Deploy Play application from windows
       ```
        cf api https://api.bosh-lite.com
        cf auth admin admin
        cf push {application-name} -p target\universal\{application-name}.zip
        
        Goto {application-name}.bosh-lite.com to access the application
       ```
      
