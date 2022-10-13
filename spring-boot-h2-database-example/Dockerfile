#FROM registry.global.ccc.srvb.cl.paas.cloudcenter.corp/produban/javase-11:latest
 
COPY target/*.jar /opt/app/
 
ARG JAR_FILE
 
COPY target/${JAR_FILE} .

EXPOSE 8080
EXPOSE 9150
 
ENTRYPOINT ["/bin/sh", "-c" , "java -jar /opt/app/${JAR_FILE} "]

