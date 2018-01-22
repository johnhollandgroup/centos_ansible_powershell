FROM centos:latest

# Change this URL to the exact version you want to install
ENV POWERSHELL_DOWNLOAD_URL https://github.com/PowerShell/PowerShell/releases/download/v6.0.0/powershell-6.0.0-1.rhel.7.x86_64.rpm

RUN yum update -y && yum -y install epel-release \
    && yum update -y \
    && yum groupinstall -y 'Development Tools'