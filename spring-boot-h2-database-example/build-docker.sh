#!/usr/bin/env bash
set -e

###Para construir la imagen de manera más rápida y simular lo que hace el CI

JAR_FILE=$(< pom.properties grep "jar.file" | cut -d"=" -f2)
MAIN_CLASS=$(< pom.properties grep "main.class" | cut -d"=" -f2)
DOCKER_IMAGE_NAME=$(< pom.properties grep "docker.image.name" | cut -d"=" -f2)
DOCKER_TAG=$(< pom.properties grep "docker.image.tag" | cut -d"=" -f2)

###Realiza build utilizando la imagen docker de maven, utilizando el usuario actual para generar los artefactos
podman run -v "$PWD":/usr/src/mymaven -v "$HOME/.m2":/var/maven/.m2 -w /usr/src/mymaven -ti --rm -u $UID \
        -e MAVEN_CONFIG=/var/maven/.m2 \
        maven:3.6.1-jdk-11-slim \
        mvn -Duser.home=/var/maven -DskipTests clean package

podman build -f Dockerfile -t \
        "${DOCKER_IMAGE_NAME}":"${DOCKER_TAG}" \
        --build-arg MAIN_CLASS="${MAIN_CLASS}" --build-arg JAR_FILE="${JAR_FILE}" .