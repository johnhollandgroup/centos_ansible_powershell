From centos:latest

RUN yum install -y epel-release
RUN yum update -y
RUN yum -y install python-pip
RUN yum group install -y "Development Tools"
RUN yum install -y git openssl-devel readline-devel zlib-devel python-devel libffi-devel
RUN pip install --upgrade pip
RUN yum -y install python-crypto
RUN rpm -ivh https://github.com/Versent/unicreds/releases/download/v1.4.0/unicreds-1.4.0_1.rpm
RUN pip install xmltodict
RUN pip install pywinrm
RUN pip install ansible
RUN ansible --version
RUN pip install awscli
RUN pip install boto

# Change this URL to the exact version you want to install
ENV POWERSHELL_DOWNLOAD_URL https://github.com/PowerShell/PowerShell/releases/download/v6.0.0-alpha.9/powershell-6.0.0_alpha.9-1.el7.centos.x86_64.rpm

RUN curl -L $POWERSHELL_DOWNLOAD_URL --output powershell_linux.rpm
RUN yum -y install powershell_linux.rpm
RUN yum clean packages
RUN yum clean all