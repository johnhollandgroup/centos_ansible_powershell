# Docker Image - ToolBox

Wherever you need an ECR with ansible, feel free to run this:

```
AWS_PROFILE=<aws profile> ansible-playbook setup.yml -e githubtoken=<github PAT for jhg-cloudops>
```

You will then have a pipeline which builds a new image whenver this repo is updated.

Check ECR for the URL of your image.

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
$( AWS_PROFILE=build-nonprod aws --region ap-southeast-2 ecr get-login --no-incl )
```

Windows
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

Mount your AWS credentials:
```
docker run -it -v ~/.aws:/root/.aws:ro toolbox
```
NOTE: This is useful when you use saml2aws on your host, and you want your profiles to work inside the container


## Create an alias

Lets say you're sick of typing all that stuff, you can set an alias

Linux:
```
alias toolbox='docker run -it -v ~/.aws:/root/.aws:ro toolbox'
```

Windows:
```
function toolbox {docker run -it -v ~/.aws:/root/.aws:ro toolbox}
```

Now you can just use `toolbox`

## Create a permanent alias

Linux: (depends on your shell of choice)
```
echo "\nalias toolbox='docker run -it -v ~/.aws:/root/.aws:ro toolbox'" >> ~/.profile
```

Windows:
```
Out-File -Append -Force -Path '~\Documents\profile.ps1' -InputObject "`nfunction toolbox {docker run -it -v ~/.aws:/root/.aws:ro toolbox}"
```
