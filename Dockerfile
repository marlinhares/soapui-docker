FROM ilyaavdeev/soapui-testrunner:5.5.0

RUN apt-get update -y && \
    DEBIAN_FRONTEND="noninteractive"  apt-get install -y vim openssl tzdata && \
    apt-get clean

ENV PATH="/usr/local/SmartBear/SoapUI-5.5.0/bin/:$PATH" 

WORKDIR /usr/local/SmartBear/SoapUI-5.5.0/bin
ADD files/soapui-log4j.xml files/loadtestrunner.sh /usr/local/SmartBear/SoapUI-5.5.0/bin/
ADD files/entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
