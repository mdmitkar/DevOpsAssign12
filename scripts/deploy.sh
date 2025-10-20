#!/bin/bash

# DevOps Assignment Deployment Script
# Run this from WSL after creating AWS instances manually

echo "🚀 Starting DevOps Assignment Deployment..."

# Check if inventory file is updated
if grep -q "YOUR_.*_IP" ansible/inventory.ini; then
    echo "❌ Please update ansible/inventory.ini with your actual AWS instance IPs first!"
    echo "Edit the file and replace YOUR_CONTROLLER_IP, YOUR_MANAGER_IP, etc. with real IPs"
    exit 1
fi

# Check if terraform-key.pem exists
if [ ! -f "../terraform/terraform-key.pem" ]; then
    echo "❌ terraform-key.pem not found! Please ensure it exists in terraform/ directory"
    exit 1
fi

# Set proper permissions for SSH key
chmod 600 ../terraform/terraform-key.pem

echo "📋 Running Ansible playbook..."

# Run the complete playbook
cd ansible
ansible-playbook -i inventory.ini playbook.yml

echo "✅ Deployment complete!"
echo "🌐 Check your Swarm Manager IP:8000 to see the Django app"
echo "📊 Run 'docker stack ps myapp' on manager to see services"
