FROM centos:latest

# Change this URL to the exact version you want to install
ENV POWERSHELL_DOWNLOAD_URL https://github.com/PowerShell/PowerShell/releases/download/v6.0.0/powershell-6.0.0-1.rhel.7.x86_64.rpm

RUN yum update -y && yum -y install epel-release \
    && yum update -y \
    && yum install -y \
        "Development Tools" \
        git \
        readline-devel \
        zlib-devel \
        gcc \
        openssl-devel \
        libffi-devel \
        python-devel \
        python-pip \
        python-crypto \
        sshpass \
    && curl -L $POWERSHELL_DOWNLOAD_URL --output powershell_linux.rpm \
    && yum -y install powershell_linux.rpm \
    && rm powershell_linux.rpm --force \
    && yum clean packages && yum clean all && rm -rf /var/cache/yum

RUN pip install --upgrade pip \ 
    && pip install \
        cryptography \
        pycparser==2.13 \
        xmltodict \
        pywinrm \
        paramiko  \
        PyYAML Jinja2 httplib2 six \
        packaging \
        ansible \
        awscli \
        "azure==2.0.0rc5" \
        msrestazure \
        boto \
        boto3

# Add JHG CA's
RUN yum update -y && yum install -y ca-certificates
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
