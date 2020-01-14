FROM docker:19.03.5-dind

LABEL mantainer="Allan Batista <allan@allanbatista.com.br>"

######################################################################
#                      set environments defaults                     #
######################################################################
ENV DOCKER_HOST="tcp://localhost:2375"
ENV DOCKER_TLS_CERTDIR=""
ENV PYTHONUNBUFFERED=1
ENV HOME_APP=/opt/app

######################################################################
#                           install python                           #
######################################################################
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

######################################################################
#                            create workdir                          #
######################################################################
RUN mkdir -p ${HOME_APP}
COPY . ${HOME_APP}
WORKDIR ${HOME_APP}

######################################################################
#                          install requirements                      #
######################################################################
RUN pip install -r requirements.txt
RUN chmod +x builder.sh && chmod +x execute.sh

######################################################################
#                              executing                             #
######################################################################
CMD ["bash", "execute.sh"]