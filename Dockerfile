FROM centos:6.7

# Python 2.7
RUN \
    yum install -y wget curl strace telnet yum-plugin-ovl openssl-devel sqlite-devel bzip2-devel tar xz xz-libs gcc && \
    wget http://www.python.org/ftp/python/2.7.6/Python-2.7.6.tar.xz -P /usr/src/ && \
    xz -d /usr/src/Python-2.7.6.tar.xz && \
    tar -xf /usr/src/Python-2.7.6.tar -C /usr/src/ && \
    cd /usr/src/Python-2.7.6/ && \
    ./configure --prefix=/usr/local --enable-shared && \
    make && \
    make altinstall && \
    rm /usr/src/Python-2.7.6.tar

# Modify LD_LIBRARY_PATH permanently
RUN \
    echo "/usr/local/lib" >> /etc/ld.so.conf.d/local_lib.conf && \
    ldconfig

# PIP
RUN \
    wget --no-check-certificate https://pypi.python.org/packages/source/s/setuptools/setuptools-1.4.2.tar.gz -P /usr/src/ && \
    tar -zxf /usr/src/setuptools-1.4.2.tar.gz -C /usr/src/ && \
    python2.7 /usr/src/setuptools-1.4.2/setup.py install && \
    curl -k1 https://bootstrap.pypa.io/get-pip.py | python2.7 - && \
    rm /usr/src/setuptools-1.4.2.tar.gz
