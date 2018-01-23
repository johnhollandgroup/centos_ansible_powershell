# Docker Image - ToolBox

Wherever you need an ECR with ansible, feel free to run this:

```
AWS_PROFILE=<aws profile> ansible-playbook setup.yml -e githubtoken=<github PAT for jhg-cloudops>
```

You will then have a pipeline which builds a new image whenver this repo is updated.

Check ECR for the URL of your image.

# Using the image

#### Authenticate to AWS using saml2aws

#### Authenticate to AWS ECR

NOTE: Below assumes profile name `saml`

Linix:
```
$( AWS_PROFILE=saml aws --region ap-southeast-2 ecr get-login --no-incl )
```

Windows
```
Invoke-Expression -Command (aws --region ap-southeast-2 --profile saml ecr get-login --no-incl)
```

#### Using the image

```
docker run -it 292594605242.dkr.ecr.ap-southeast-2.amazonaws.com/cloudops/toolbox bash
```
