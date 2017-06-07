# BOSH Lite

* Slack: #bosh on <https://slack.cloudfoundry.org>
* Mailing lists:
  - [cf-bosh](https://lists.cloudfoundry.org/pipermail/cf-bosh) for asking BOSH usage and development questions
  - [cf-dev](https://lists.cloudfoundry.org/pipermail/cf-dev) for asking CloudFoundry questions
* CI: <https://bosh-lite.ci.cf-app.com/pipelines/bosh-lite>
* Roadmap: [Pivotal Tracker](https://www.pivotaltracker.com/n/projects/956238) (label:bosh-lite)

BOSH Lite is a pre-built [Vagrant](https://www.vagrantup.com/) box which includes [the Director](http://bosh.io/docs/terminology.html#director). It uses containers (via Warden/Garden CPI) to emulate VMs which makes it an excellent choice for:

- General BOSH exploration without investing time and resources to configure an IaaS
- Development of releases (including BOSH itself)
- Testing releases locally or in CI

This readme walks through deploying Cloud Foundry with BOSH Lite. BOSH and BOSH Lite can be used to deploy just about anything once you've got the hang of it.

1. [Install BOSH Lite](#install-bosh-lite)
    1. [Prepare the Environment](#prepare-the-environment)
    1. [Install and Boot a Virtual Machine](#install-and-boot-a-virtual-machine)
    1. [Customizing the Local VM IP](#customizing-the-local-vm-ip)
1. [Deploy Cloud Foundry](#deploy-cloud-foundry)
1. [Troubleshooting](#troubleshooting)
1. [Upgrading the BOSH Lite VM](#upgrading-the-bosh-lite-vm)
1. [Miscellaneous](#miscellaneous)

## Install BOSH Lite

### Prepare the Environment

1. Install latest version of `bosh_cli`

   ```
   $ gem install bosh_cli --no-ri --no-rdoc
   ```

   Refer to [BOSH CLI installation instructions](http://docs.cloudfoundry.org/bosh/bosh-cli.html) for more information and troubleshooting tips.

1. Install [Vagrant](http://www.vagrantup.com/downloads.html)

    Known working version:

    ```
    $ vagrant --version
    Vagrant 1.7.4
    ```

1. Clone this repository

    ```
    $ cd ~/workspace
    $ git clone https://github.com/cloudfoundry/bosh-lite
    $ cd bosh-lite
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
    5.1...
    ```

    Note: If you encounter problems with VirtualBox networking try installing [Oracle VM VirtualBox Extension Pack](https://www.virtualbox.org/wiki/Downloads) as suggested by [Issue 202](https://github.com/cloudfoundry/bosh-lite/issues/202). Alternatively make sure you are on VirtualBox 5.1+ since previous versions had a [network connectivity bug](https://github.com/concourse/concourse-lite/issues/9).

1. Start Vagrant from the base directory of this repository, which contains the Vagrantfile. The most recent version of the BOSH Lite boxes will be downloaded by default from the Vagrant Cloud when you run `vagrant up`. If you have already downloaded an older version you will be warned that your version is out of date.

    ```
    $ vagrant up 
    ```


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
      
