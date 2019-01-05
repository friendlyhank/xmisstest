FROM centos

MAINTAINER hank

RUN mkdir -p /data/go_webs/xmiss
COPY myapp /data/go_webs/xmiss/
RUN chmod 755 /data/go_webs/xmiss/xmiss

WORKDIR /data/go_webs/xmiss/
EXPOSE 8888

ENTRYPOINT ["./xmiss"]