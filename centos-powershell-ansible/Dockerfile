From centos:latest

RUN yum install -y epel-release
RUN yum update -y
RUN yum -y install python-pip
RUN pip install --upgrade pip
RUN yum group install -y "Development Tools"
RUN yum install -y git readline-devel zlib-devel
RUN yum install -y gcc openssl-devel libffi-devel python-devel
RUN echo "pycparser==2.13" > requirements.txt
RUN pip install cryptography -r requirements.txt
RUN yum -y install python-crypto
RUN rpm -ivh https://github.com/Versent/unicreds/releases/download/1.5.1/unicreds-1.5.1_1.rpm
RUN pip install xmltodict
RUN pip install pywinrm
RUN pip install paramiko 
RUN pip install PyYAML Jinja2 httplib2 six
# RUN pip install ansible
RUN pip install ansible
RUN pip install awscli
RUN pip install "azure==2.0.0rc5"
RUN pip install boto
RUN pip install boto3
RUN yum -y install sshpass
# Change this URL to the exact version you want to install
ENV POWERSHELL_DOWNLOAD_URL https://github.com/PowerShell/PowerShell/releases/download/v6.0.0-beta.3/powershell-6.0.0_beta.3-1.el7.x86_64.rpm

RUN curl -L $POWERSHELL_DOWNLOAD_URL --output powershell_linux.rpm
RUN yum -y install powershell_linux.rpm
RUN rm powershell_linux.rpm --force

RUN yum clean packages
RUN yum clean all