#!/bin/bash

echo "Setting up GitHub repository..."

# Check if GitHub CLI is installed
if ! command -v gh &> /dev/null; then
    echo "GitHub CLI not found. Please install it from: https://cli.github.com/"
    echo "Or manually create repository at: https://github.com/new"
    exit 1
fi

# Create repository on GitHub
echo "Creating repository on GitHub..."
gh repo create devops-exercises --public --description "Comprehensive DevOps exercises from basic to beginner level"

# Add remote and push
echo "Adding remote and pushing..."
git remote add origin https://github.com/$(gh api user --jq .login)/devops-exercises.git
git branch -M main
git push -u origin main

echo ""
echo "✅ Repository created successfully!"
echo "📍 View at: https://github.com/$(gh api user --jq .login)/devops-exercises"