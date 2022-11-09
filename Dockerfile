FROM smartbear/soapuios-testrunner:latest
USER root

RUN apt-get update -y && \
    DEBIAN_FRONTEND="noninteractive"  apt-get install -y vim openssl tzdata && \
    apt-get clean

ENV PATH="/usr/local/SmartBear/SoapUI-5.7.0/bin/:$PATH" 

WORKDIR /usr/local/SmartBear/SoapUI-5.7.0/bin
ADD ./files/soapui-log4j.xml ./files/loadtestrunner.sh /usr/local/SmartBear/SoapUI-5.7.0/bin/
ADD ./files/customentrypoint.sh / 
RUN chmod +x /customentrypoint.sh

ENTRYPOINT ["/customentrypoint.sh"]
