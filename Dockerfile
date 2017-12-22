FROM alpine

RUN mkdir -p /opt/repo

ADD server /opt/repo
ADD static /opt/repo

EXPOSE 8080

CMD [ "/opt/repo/server" ]