###### ES
# A docker image that includes
# - elasticsearch 
FROM qnib/terminal
MAINTAINER "Christian Kniep <christian@qnib.org>"

EXPOSE 9200
VOLUME ["/var/lib/elasticsearch"]

# Java
RUN yum install -y java-1.8.0-openjdk

ADD etc/yum.repos.d/elasticsearch-1.4.repo /etc/yum.repos.d/
# which is needed by ES
RUN yum install -y which

# elasticsearch
RUN yum install -y elasticsearch
# Convinient name, but not generic enough
RUN sed -i '/# cluster.name:.*/a cluster.name: logstash' /etc/elasticsearch/elasticsearch.yml
ADD etc/supervisord.d/elasticsearch.ini /etc/supervisord.d/elasticsearch.ini
ADD etc/consul.d/check_elasticsearch.json /etc/consul.d/
ADD etc/elasticsearch/elasticsearch.yml /etc/elasticsearch/
