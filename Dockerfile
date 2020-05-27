FROM ubuntu:bionic
WORKDIR /app
USER root

RUN apt-get update
RUN apt-get install -y locales locales-all
RUN apt-get remove fonts-vlgothic
RUN apt-get install -y fonts-vlgothic
RUN locale-gen ja_JP.UTF-8
ENV LANG ja_JP.UTF-8
ENV LC_CTYPE ja_JP.UTF-8
RUN localedef -f UTF-8 -i ja_JP ja_JP.utf8

RUN apt-get install -y \
  wget \
  firefox-geckodriver \
  git \
  golang \
  netcat-traditional \
  nmap \
  whois \
  libyara3 \
  python3 \
  python3-pip

# install rdap
RUN go get -u github.com/openrdap/rdap/cmd/rdap
ENV PATH="${PATH}:/root/go/bin"

COPY . .
RUN LC_CTYPE="en_US.UTF-8" pip3 install --no-cache-dir -r requirements.txt
ENTRYPOINT ["python3","web_preserve.py"]