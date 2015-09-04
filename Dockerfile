FROM ruby
MAINTAINER inokappa
RUN apt-get update
RUN apt-get -y install openjdk-7-jdk
RUN git clone https://github.com/inokappa/oreno-kcl.git /app
RUN chmod 755 /app/start.sh
RUN gem install aws-kclrb aws-sdk aws-sdk-core dogapi --no-ri --no-rdoc

ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64
CMD /app/start.sh
