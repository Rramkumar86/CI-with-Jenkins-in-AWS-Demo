FROM tomcat:jre8-alpine

# For wget to work
RUN   apk update \                                                                                                                                                                                                                        
&&   apk add ca-certificates wget \                                                                                                                                                                                                      
&&   update-ca-certificates 

RUN mkdir /usr/local/tomcat/webapps/myapps

# Copy tomcat server.xml
WORKDIR /usr/local/tomcat

COPY /project/target/project-1.0-RAMA.war /usr/local/tomcat/webapps/project-1.0-RAMA.war

# Start tomcat
CMD ["catalina.sh", "run"]
