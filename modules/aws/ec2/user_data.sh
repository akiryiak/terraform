#!/bin/bash
sudo yum update -y
sudo yum install   -y
sudo service docker start
sudo usermod -a -G docker ec2-user
