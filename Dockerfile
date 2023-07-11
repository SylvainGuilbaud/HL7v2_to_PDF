ARG IMAGE=intersystemsdc/irishealth-community:latest
# ARG IMAGE=containers.intersystems.com/intersystems/iris-community:2023.1.0.235.1
# ARG IMAGE=containers.intersystems.com/intersystems/iris-community-arm64:2023.1.0.235.1
FROM $IMAGE
USER root
WORKDIR /app
RUN chown ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} /app
USER ${ISC_PACKAGE_MGRUSER}

COPY Installer.cls .
COPY src src
COPY iris.script /tmp/iris.script
COPY requirements.txt .
COPY wkhtmltox_0.12.6.1-2.jammy_arm64/usr/local /usr/local

USER ${ISC_PACKAGE_MGRUSER}

RUN pip3 install -r requirements.txt

RUN export JAVA_HOME=/usr/lib/jvm/adoptopenjdk-8-hotspot-amd64
RUN export PATH=$PATH:$JAVA_HOME/bin

ENV JAVA_HOME=/usr/lib/jvm/adoptopenjdk-8-hotspot-amd64
ENV PATH=$PATH:$JAVA_HOME/bin

RUN iris start IRIS \
	&& iris session IRIS < /tmp/iris.script \
    && iris stop IRIS quietly