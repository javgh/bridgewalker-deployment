This is an Ansible script and a set of configuration files to deploy
Bridgewalker ( https://www.bridgewalkerapp.com/ ) to a server.

It is a little bit hackish in that it revolves around the presence of an
account called "jan" which Ansible expects to be able to SSH into (using
key-based authentication) and that has root sudo rights. This account will also
be used to run the Bridgewalker server and related daemons. This could be
cleaned up to use some account "bridgewalker" or similar instead, but I have
not done this yet.

Run the following to initiate the deployment:

    ssh-add credentials/id_rsa
    ansible-playbook -i production site.yml

The first time the software is deployed to a new server, an account described as
above needs to be created first, and then a few manual steps are still
necessary:

 * Decryption of sensitive files (will be prompted by Ansible)
 * Performing initial ssh login to bwbackup@backuphost as user root
   to add host key to list of known hosts
   * via: backupninja -n -d
   * might have to run some commands (e.g. duplicity) manually once
 * Running './bridgewalker --initdb' to initialize the database
 * Create Bridgewalker configuration file (~/.bridgewalker/config)
 * Update 'metricsd\_host' in site\_graphite.yml and redeploy Graphite host

This repository also contains a second Ansible script which is used to prepare
an extra server to run Graphite ( http://graphite.wikidot.com/ ) and configure a
dashboard which displays metrics send by the Bridgewalker server (number of
users etc.). This runs on a second server to keep the attack surface of the main
Bridgewalker server as small as possible. This second server is also used as a
target for encrypted Bridgewalker backups using Backupninja and Duplicity.

Furthermore Vagrant can be used to set up a local VM as a staging environment
and run Bridgewalker inside the VM for testing purposes. This requires a Vagrant
box with the user account "jan" configured accordingly. Then run something like
this:

    cd vagrant; vagrant up
    ansible-playbook -i staging site.yml
    ssh 192.168.2.2
