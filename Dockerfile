FROM tomcat
RUN mkdir /usr/local/tomcat/webapps/myapps
COPY /project/target/project-1.0-RAMA.war /usr/local/tomcat/webapps
CMD "catalina.sh" "run"
