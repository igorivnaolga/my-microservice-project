#!/bin/bash

# Debian and Ubuntu

export DEBIAN_FRONTEND=noninteractive

apt-get update

if dpkg -l | grep -q "docker"; then
    echo "docker already installed"; 
else apt-get install -y docker
fi

if dpkg -l | grep -q "docker-compose"; then
    echo "docker-compose already installed"; 
else apt-get install -y docker-compose
fi

if dpkg -l | grep -q "python3.12"; then
    echo "python3.12 already installed"; 
else apt-get install -y python3.12-full
fi

if dpkg -l | grep -q "python3.12-pip"; then
    echo "python3.12-pip already installed"; 
else apt-get install -y python3-pip && apt-get install -y python3.12-venv
fi

if dpkg -l | grep -q "django"; then
    echo "django already installed"; 
else python3 -m venv venv && . venv/bin/activate && pip install -y django
fi
