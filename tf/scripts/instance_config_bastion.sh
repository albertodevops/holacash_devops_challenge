#!/bin/bash
cp /etc/ssh/ssh_host_rsa_key /home/holacash-user/.ssh/id_rsa
chown holacash-user:holacash-user /home/holacash-user/.ssh/id_rsa
chmod 400 /home/holacash-user/.ssh/id_rsa

printf "Host 10.200.10.10\n\tHostname 10.200.10.10\n\tuser holacash-user\n\tIdentityFile ~/.ssh/id_rsa\n\tPort 22\n" >> /home/holacash-user/.ssh/ssh_config
chown holacash-user:holacash-user /home/holacash-user/.ssh/ssh_config
chmod 644 /home/holacash-user/.ssh/ssh_config
