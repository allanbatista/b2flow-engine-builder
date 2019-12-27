FROM docker:19.03.0-dind

LABEL mantainer="Allan Batista <allan@allanbatista.com.br>"

RUN apk upgrade --no-cache && \
    apk add --no-cache \
            curl \
            unzip \
            bash \
            python3 && \
    pip3 install --no-cache-dir --upgrade pip && \
    rm -rf /var/cache/* && \
    rm -rf /root/.cache/*

RUN cd /usr/bin \
  && ln -sf python3 python \
  && ln -sf pip3 pip

ENV PYTHONUNBUFFERED=1
ENV HOME_APP /opt/app
RUN mkdir -p ${HOME_APP}
COPY . ${HOME_APP}
WORKDIR ${HOME_APP}

RUN pip install -r requirements.txt
RUN chmod +x execute.sh

CMD ["bash", "execute.sh"]