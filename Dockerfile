FROM ubuntu:bionic
WORKDIR /app
USER root

RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
RUN apt-get update
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