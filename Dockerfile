# bs2 Dockerfile
# Author: Peak AI
# Created: 2019-01-22
# Tenant: Default
# Template Version: 1

FROM python:3.6


RUN apt-get update \
  && apt-get install -y curl

# Installs node.js, python, pip and setup tools
RUN apt-get install -y \
    python3 \
    python3-pip \
    python3-setuptools \
    build-essential \
    libzmq3-dev \
    wget \
    git

RUN apt-get install r-base -y


ENV LANG C.UTF-8
ENV LC_ALL=C.UTF-8

# Upgrade pip
RUN pip3 install --upgrade pip;

RUN wget https://packages.dev.peak.ai/python/orion/0.2.11/orion.tar.gz\
    && tar xf orion.tar.gz\
    && cd orion\
    && python3 setup.py install\
    && cd ..\
    && rm -rf orion*

ARG STAGE
ARG TENANT
ARG REDSHIFT_USERNAME
ARG REDSHIFT_PASSWORD
ARG REDSHIFT_HOST
ARG REDSHIFT_PORT
ARG REDSHIFT_IAM_ROLE

ENV STAGE=$STAGE\
  TENANT=$TENANT\
  REDSHIFT_USERNAME=$REDSHIFT_USERNAME \
  REDSHIFT_PASSWORD=$REDSHIFT_PASSWORD \
  REDSHIFT_HOST=$REDSHIFT_HOST \
  REDSHIFT_PORT=$REDSHIFT_PORT \
  REDSHIFT_IAM_ROLE=$REDSHIFT_IAM_ROLE

# ==================================================================================================
# Your packages/config here!

# ==================================================================================================

EXPOSE 8080

COPY . /app
WORKDIR /app

ENTRYPOINT ["python3", "launcher.py"]
