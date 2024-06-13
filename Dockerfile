ARG IMAGE=intersystemsdc/irishealth-community:latest
# ARG IMAGE=containers.intersystems.com/intersystems/iris-community:2023.1.0.235.1
# ARG IMAGE=containers.intersystems.com/intersystems/iris-community-arm64:2023.1.0.235.1
FROM $IMAGE
USER root

# i386
# RUN apt update && apt install -y fontconfig xfonts-75dpi xfonts-base && rm -rf /var/lib/apt/lists/* \
#   && wget -q -O /tmp/wkhtmltox https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6-1/wkhtmltox_0.12.6-1.bionic_i386.deb \
#   && dpkg -i /tmp/wkhtmltox \
#   && rm /tmp/wkhtmltox

#AMD64
RUN apt update && apt install -y fontconfig xfonts-75dpi xfonts-base && rm -rf /var/lib/apt/lists/* \
  && wget -q -O /tmp/wkhtmltox https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6.1-2/wkhtmltox_0.12.6.1-2.jammy_amd64.deb \
  && dpkg -i /tmp/wkhtmltox \
  && rm /tmp/wkhtmltox
  
# ARM64
# RUN apt update && apt install -y fontconfig xfonts-75dpi xfonts-base && rm -rf /var/lib/apt/lists/* \
#   && wget -q -O /tmp/wkhtmltox https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6.1-2/wkhtmltox_0.12.6.1-2.jammy_arm64.deb \
#   && dpkg -i /tmp/wkhtmltox \
#   && rm /tmp/wkhtmltox

WORKDIR /app
RUN chown ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} /app
USER ${ISC_PACKAGE_MGRUSER}

COPY Installer.cls .
COPY src src
COPY iris.script /tmp/iris.script
COPY requirements.txt .

USER ${ISC_PACKAGE_MGRUSER}

RUN pip3 install -r requirements.txt

RUN export JAVA_HOME=/usr/lib/jvm/adoptopenjdk-8-hotspot-amd64
RUN export PATH=$PATH:$JAVA_HOME/bin

ENV JAVA_HOME=/usr/lib/jvm/adoptopenjdk-8-hotspot-amd64
ENV PATH=$PATH:$JAVA_HOME/bin

RUN iris start IRIS \
	&& iris session IRIS < /tmp/iris.script \
    && iris stop IRIS quietly