FROM ubuntu:18.04

RUN mkdir /app
WORKDIR /app
ADD . /app/

RUN apt-get update && \
    apt-get install -y jq && \
    apt-get clean

EXPOSE 8080
CMD ["sh", "/app/script.sh"]
