#!/bin/bash

cd /etc/fail2ban
cp jail.conf jail.local
nano jail.local
systemctl enable fail2ban
systemctl start fail2ban
systemctl status fail2ban
