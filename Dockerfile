FROM centos:latest

# Change this URL to the exact version you want to install
ENV POWERSHELL_DOWNLOAD_URL https://github.com/PowerShell/PowerShell/releases/download/v6.0.0/powershell-6.0.0-1.rhel.7.x86_64.rpm

RUN yum update -y && yum -y install epel-release \
    && yum update -y \
    && yum groupinstall -y 'Development Tools' \
    && yum install -y \
        ca-certificates \
        gcc \
        git \
        libffi-devel \
        openssl-devel \
        python-crypto \
        python-devel \
        python-pip \
        readline-devel \
        sshpass \
        zlib-devel \
    && curl -L $POWERSHELL_DOWNLOAD_URL --output powershell_linux.rpm \
    && yum -y install powershell_linux.rpm \
    && rm powershell_linux.rpm --force \
    && yum clean packages && yum clean all && rm -rf /var/cache/yum

RUN pip install --upgrade pip \ 
    && pip install \
        "azure==2.0.0rc5" \
        ansible \
        awscli \
        boto \
        boto3 \
        cryptography \
        msrestazure \
        packaging \
        paramiko  \
        pycparser==2.13 \
        pywinrm \
        PyYAML Jinja2 httplib2 six \
        xmltodict \
    && rm -rf ~/.cache/pip

# aws cli aliases
RUN git clone https://github.com/awslabs/awscli-aliases.git \
 && mkdir -p ~/.aws/cli \
 && cp awscli-aliases/alias ~/.aws/cli/alias

# Add JHG CA's
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x entrypoint.sh
ADD certs /certs
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/bin/bash"]
