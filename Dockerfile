FROM perl:5.38.0-slim
LABEL maintainer="jonasbn"

# For tagging of the Docker image, so it can refer back to the actual
# implementation code base
# docker build -t tac_as_poc --build-arg GIT_COMMIT=$(git rev-parse HEAD) .
# REF: https://blog.scottlowe.org/2017/11/08/how-tag-docker-images-git-commit-information/?mkt_tok=eyJpIjoiWW1ObE4yVTFPVEJsTVRNMyIsInQiOiJPVkNSdVllMzdmemhaKzNKVFFibk9PS080anNzMklseGRCVCtQS05oSHRmb2FLTHA0d3NBaXFtbjJ2ckdNV29IakExbEFzdiszQ1U4a2g3UkVuU1VOcUlcL3dTZVRHYUpvamFHZkJEZW1UN0twU0ZKOHAzVUxsSjl0TjNWVkRMTFQifQ%3D%3D
ARG GIT_COMMIT=unspecified
LABEL git_commit=$GIT_COMMIT

RUN cpanm Carton

WORKDIR /usr/src/app
COPY cpanfile.snapshot /usr/src/app
COPY cpanfile /usr/src/app
RUN carton install --deployment

COPY . /usr/src/app

EXPOSE 3000

COPY ./docker-entrypoint.sh /

USER nobody

ENTRYPOINT ["/docker-entrypoint.sh"]
