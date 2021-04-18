#!/bin/bash
sed "s/tagVersion/$1/g" /home/ec2-user/java-app/deployment.yml > /home/ec2-user/java-app/deployment2.yml
