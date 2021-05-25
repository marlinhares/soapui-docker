# SOAPUI - Docker

## General

This conteiner runs a Soapui 5.5. Can be used to run functional or load tests.
The advantage is: 
- runs in Jenkins or any Pipeline that supports docker
- no need to install or configure Soapui
- no Memory Consumption based on the GUI interface of SOAPUI
- all tests must run in command line

In my case, I use it to run remotely on my jenkins conteiner:  functional tests and load tests written in SOAPUI

## How to Use

- go to the folder where your Soapui project is saved
- you do not need to build this image, use this pre-built instead: 
	- ``` docker pull linhares/soapui-docker:5.5.0-1.0.0 ```
- run the appropriate docker command. See examples bellow

## Parameters

**Environment**
- LOG_LEVEL - sets the log level on soapui log4 - Eg:  
	- ``` -e "LOG_LEVEL=ERROR"  ```  
	- Default value is DEBUG


- XMX - sets the max memory for Java - Eg:
	- ```  -e "XMX=4000m" ``` 
	- Default value is 1024m

- COMMAND - this env parameter just tells conteiner what command it will run - Eg:
	- ```  -e "COMMAND=loadtestrunner.sh" ``` 
	- Default value is testrunner.sh


**Command of the Conteiner**
Here you pass the soapui parameters just like calling it via command line.
Follow examples bellow

## Examples

All examples assume: 
- you are in the folder where your Soapui tests resids
- the test project xml is Barramento-API-V3-soapui-project.xml
- there is a test suite named: SuiteTestes1
- there is a test case named: TestCase-EnvioRecebimento-MultiAnexos
- there is a test load named: LoadTest 1

Just replace for your own names on the examples.

- **call simple test**
	- ``` docker run --rm -it -v "$PWD":/project linhares/soapui-docker:5.5.0-1.0.0 /project/Barramento-API-V3-soapui-project.xml ```

- **call simple test but specifying suite and testcase to run**
	- ``` docker run --rm -it -v "$PWD":/project linhares/soapui-docker:5.5.0-1.0.0 -sSuiteTestes1 -cTestCase-EnvioRecebimento-MultiAnexos /project/Barramento-API-V3-soapui-project.xml ```

- **call load test**
 
	- ``` docker run --rm -it -e "LOG_LEVEL=ERROR" -e "XMX=4000m" -e "COMMAND=loadtestrunner.sh" -v "$PWD":/project linhares/soapui-docker:5.5.0-1.0.0 /project/Barramento-API-V3-soapui-project.xml ``` 

	- Pay attention to the env parameters: COMMAND, XMX and LOG_LEVEL

- **call specific load test saving the results to a dir with others parameters**
	- ``` docker run --rm -it -e "TZ=America/Sao_Paulo" -e "XMX=4000m" -e "COMMAND=loadtestrunner.sh" -v "$PWD":/project linhares/soapui-docker:5.5.0-1.0.0 -sSuiteTestes1 -cTestCase-EnvioRecebimento-MultiAnexos -PQtdArquivosProcesso=2 -m5 -n2 -r -f/project/result -l"LoadTest 1" /project/Barramento-API-V3-soapui-project.xml ```

	- -m change how many iterations the load test will run
	- -n how many threads will be created in parallel
	- -r export statistics
	- -f output folder of the results
	- -l inform the specific Load Test in case you have many
	- etc. Here you can use all parameters of the soapui loadrunner

## Considerations

Initially the logs will show some error messages, just ignore then. Thats because the conteiner does not have a GUI. The tests will run at the end. Just follow the logs.

I used this image as a start point: https://hub.docker.com/r/ilyaavdeev/soapui-testrunner
There it installs the SOAPUI 5.5.
I just made some tweaks to run heavy load tests.
