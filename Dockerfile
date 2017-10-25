FROM perl:5.26
MAINTAINER jonasbn

RUN cpanm Carton

WORKDIR /usr/src/app
COPY cpanfile.snapshot /usr/src/app
COPY cpanfile /usr/src/app
RUN carton

COPY . /usr/src/app

EXPOSE 3000

COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
