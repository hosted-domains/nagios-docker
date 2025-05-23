#!/usr/bin/env bash

set -e

REGISTRY_HOST="ghcr.io"
REGISTRY_USER="hosted-domains"
REGISTRY_REPO="nagios-docker"

if [ -f ".env" ];then
    echo "Sourcing Environment: .env"
    source ".env"
fi

if [ -z "${VERSION}" ];then
    if [ -z "${1}" ];then
        read -rp "Version: " VERSION
    else
        VERSION="${1}"
    fi
fi
#if [ -z "${USERNAME}" ];then
#    read -rp "Username: " USERNAME
#fi
#if [ -z "${PASSWORD}" ];then
#    read -rp "Password: " PASSWORD
#fi

echo "${REGISTRY_HOST}/${REGISTRY_USER}/${REGISTRY_REPO}:${VERSION}"

#docker login --username "${USERNAME}" --password "${PASSWORD}" "${REGISTRY_HOST}"
docker login "${REGISTRY_HOST}"

docker buildx create --use
docker buildx build --platform linux/amd64,linux/arm64 --push \
    -t "${REGISTRY_HOST}/${REGISTRY_USER}/${REGISTRY_REPO}:${VERSION}" nagios

#docker push "${REGISTRY_HOST}/${REGISTRY_USER}/${REGISTRY_REPO}:${VERSION}"
