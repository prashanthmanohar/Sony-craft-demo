FROM ubuntu:18.04

RUN mkdir /app
WORKDIR /app
ADD . /app/

RUN apt-get update && \
    apt-get install -y jq && \
    apt-get install -y curl && \
    apt-get clean

RUN chmod 755 /app/script.sh

#EXPOSE 8080

ENTRYPOINT ["/app/script.sh"]
CMD ["--countryCodes=AU"]
