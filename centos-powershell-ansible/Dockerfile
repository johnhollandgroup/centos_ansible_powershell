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
RUN rpm -ivh https://github.com/Versent/unicreds/releases/download/v1.5.0/unicreds-1.5.0_1.rpm
RUN pip install xmltodict
RUN pip install pywinrm
RUN pip install paramiko 
RUN pip install PyYAML Jinja2 httplib2 six
# RUN pip install ansible
RUN pip install ansible
RUN pip install awscli
RUN pip install "azure==2.0.0rc5"
RUN pip install boto
RUN yum -y install sshpass
# Change this URL to the exact version you want to install
ENV POWERSHELL_DOWNLOAD_URL https://github.com/PowerShell/PowerShell/releases/download/v6.0.0-alpha.10/powershell-6.0.0_alpha.10-1.el7.centos.x86_64.rpm

RUN curl -L $POWERSHELL_DOWNLOAD_URL --output powershell_linux.rpm
RUN yum -y install powershell_linux.rpm
RUN rm powershell_linux.rpm --force

RUN yum -y install ntp
RUN chkconfig ntpd on
RUN ntpdate pool.ntp.org
RUN /etc/init.d/ntpd start
RUN yum clean packages
RUN yum clean all