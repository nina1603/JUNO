FROM python:3.7-slim

RUN pip install --no-cache --upgrade pip && pip install --no-cache jupyter notebook


ARG NB_USER
ARG NB_UID
ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}
WORKDIR ${HOME}

COPY . ${HOME}
USER root
RUN chown -R ${NB_UID} ${HOME}

RUN apt-get update && apt-get install -y \
        zip \
        unzip
 
#CMD /bin/sh


#RUN apt-get update \
#    && apt-get install -y build-essential \
#    git wget libzmq3-dev ca-certificates python3-pip \
#    && rm -rf /var/lib/apt/lists/* && pip3 install jupyter notebook --no-cache-dir \
  
#RUN sudo pip install --no-cache --upgrade pip && sudo pip3 install jupyter notebook --no-cache-dir
#RUN sudo python3 -m venv myenv && . myenv/bin/activate
RUN pip install --trusted-host pypi.python.org -r requirements.txt
#RUN pip install -r ~/requirements.txt

USER ${NB_USER}
