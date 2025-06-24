FROM ubuntu:noble

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update && apt-get -y upgrade && apt install -yq tini curl python3 python3-pip

ENV PYTHONDONTWRITEBYTECODE 1

ENV PYTHONUNBUFFERED 1

WORKDIR /usr/src/app

ADD requirements.txt /usr/src/app

RUN pip3 install --break-system-packages --no-cache-dir -r requirements.txt

ADD . /usr/src/app

RUN useradd remote

USER remote

EXPOSE 6837

ENTRYPOINT ["tini", "--", "python3", "server.py", "--certificate=certificate/cert", "--privkey=certificate/privkey", "--chain=certificate/chain"]
