#!/bin/bash

# replace general loglevel

echo "You can pass this Env Vars to container:"
echo "- COMMAND - command to run. Default: testrunner.sh"
echo "- XMX - replace the max memory for java - testrunner and loadtestrunner - default 1024m"
echo "- LOG_LEVEL - replace the level of LOG to system out - ERROR, DEBUG, INFO, etc. Default DEBUG"

echo "============================================================================================="
echo "============================================================================================="
echo "============================================================================================="

echo "You can add the parameters in the CMD part of your docker call. Just like the README on the github project https://github.com/marlinhares/soapui-docker"


echo "Lets Replace the Log Level"

sed -i "s|<<REPLACE_LOG_LEVEL>>|${LOG_LEVEL-DEBUG}|g" /usr/local/SmartBear/SoapUI-5.5.0/bin/soapui-log4j.xml


echo "Everything set. Now it will run the command you passed...."
echo "Waiting 5 secs it will run the following command: "

COMANDO="${COMMAND-testrunner.sh}"

echo "Command: $COMANDO"
echo "Parameters: $@"


sleep 5

$COMANDO $@
