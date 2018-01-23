# Docker Image - Ansible

Wherever you need an ECR with ansible, feel free to run this:

```
AWS_PROFILE=<aws profile> ansible-playbook setup.yml -e githubtoken=<github PAT for jhg-cloudops>
```

You will then have a pipeline which builds a new image whenver this repo is updated.

Check ECR for the URL of your image.
