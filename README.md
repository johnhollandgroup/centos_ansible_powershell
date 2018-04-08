# Docker Image - ToolBox

# Examples

Lets say you want to know if your `saml2aws` is working, you can test your profile:
```
$ toolbox aws --profile sandpit whoami
{
    "Account": "046885338755",
    "UserId": "AROAIMIKGJVB3T35R5FH4:Peter.McIntyre@jhg.com.au",
    "Arn": "arn:aws:sts::046885338755:assumed-role/AWS-Admin-jhg-ops-sandpit/Peter.McIntyre@jhg.com.au"
}
```

Or maybe you're on Windows and you want to use Ansible:
```
$ toolbox ansible --version
ansible 2.4.2.0
  config file = None
  configured module search path = [u'/root/.ansible/plugins/modules', u'/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python2.7/site-packages/ansible
  executable location = /usr/bin/ansible
  python version = 2.7.5 (default, Aug  4 2017, 00:39:18) [GCC 4.8.5 20150623 (Red Hat 4.8.5-16)]
```

# Using the toolbox

## Get it

You can build it yourself, or use a pre-build image hosted on AWS (in the JHG build-nonprod account)

### Build yourself

```
docker build -t toolbox .
```

### Get it from AWS

#### 1. Authenticate to AWS using saml2aws

See https://github.com/Versent/saml2aws

Assuming you have set it up:
```
saml2aws login -p build-nonprod
```

#### 2. Authenticate to AWS ECR

NOTE: Below assumes profile name `build-nonprod`

Linux:
```
$( AWS_PROFILE=build-nonprod aws ecr get-login --no-include-email --region ap-southeast-2 )
```

Windows

# Verify the AWSPowerShell module is Available
```
Get-Module -Name AWSPowerShell
```

# Install and Import the AWSPowerShell module
```
Install-Module -Name AWSPowerShell
Import-Module AWSPowerShell
```

```
# http://btburnett.com/2017/01/docker-login-for-amazon-aws-ecr-using-windows-powershell.html
$token = Get-ECRAuthorizationToken -Region ap-southeast-2 -ProfileName build-nonprod
$tokenSegments = [System.Text.Encoding]::ASCII.GetString([System.Convert]::FromBase64String($token.AuthorizationToken)).Split(":")
$hostName = (New-Object System.Uri $token.ProxyEndpoint).DnsSafeHost
docker login -u $($tokenSegments[0]) -p $($tokenSegments[1]) $hostName
```

#### 3. Pull it

This also creates an alias to `toolbox`
```
docker pull 292594605242.dkr.ecr.ap-southeast-2.amazonaws.com/cloudops/toolbox
docker tag 292594605242.dkr.ecr.ap-southeast-2.amazonaws.com/cloudops/toolbox toolbox
```

## Use it

Vanilla use:
```
docker run -it toolbox
```

Share your host Filesystem with Docker from the system tray Docker > Settings > Shared Drives and authenticate with your admin account.

Mount your current directory to `/parent`:
```
docker run -it -v <FullPathonHostFileSystem>:/parent toolbox
```

Mount your AWS credentials:
```
docker run -it -v <FullPathonHostFileSystem>:/parent -v ~/.aws:/root/.aws:ro toolbox
```
NOTE: This is useful when you use saml2aws on your host, and you want your profiles to work inside the container


## Create an alias

Lets say you're sick of typing all that stuff, you can set an alias

Linux:
```
alias toolbox='docker run -it -v <FullPathonHostFileSystem>:/parent -v ~/.aws:/root/.aws:ro toolbox'
```

Windows:
```
function toolbox {docker run -it -v <FullPathonHostFileSystem>:/parent -v ~/.aws:/root/.aws:ro toolbox $args}
```

Now you can just use `toolbox`

## Create a permanent alias

Linux: (depends on your shell of choice)
```
echo "\nalias toolbox='docker run -it -v <FullPathonHostFileSystem>:/parent -v ~/.aws:/root/.aws:ro toolbox'" >> ~/.profile
```

Windows:
```
Out-File -Append -Force -Path '~\Documents\profile.ps1' -InputObject "`nfunction toolbox {docker run -it -v <FullPathonHostFileSystem>:/parent -v ~/.aws:/root/.aws:ro toolbox $args}"
```

# Maintaining the AWS hosted image

## CodePipeline

This deploys the pipeline to build-nonprod (already done, don't do this)

```
AWS_PROFILE=build-nonprod ansible-playbook setup.yml -e githubtoken=<github PAT for jhg-cloudops>
```

You will then have a pipeline which builds a new image whenver this repo is updated.

## Updating the image

Just make your updates and commit to master. The pipeline will then run.