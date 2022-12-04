FROM jupyter/scipy-notebook:python-3.8.13

USER root

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -q && apt-get install -y \
    xvfb \
    ghostscript \
    imagemagick \
    python3-tk &&\
    rm -rf /var/lib/apt/lists/*

ARG NB_USER=jovyan
ARG NB_UID=1000
ENV USER ${NB_USER}
ENV NB_UID ${NB_UID}
ENV HOME /home/${NB_USER}

USER ${NB_USER}

COPY ./requirements.txt . 

RUN python3 -m pip install --no-cache-dir notebook jupyterlab jupyterhub &&\
    pip install --no-cache-dir -r requirements.txt &&\
    pip install jupyter_contrib_nbextensions &&\
    jupyter contrib nbextension install --user &&\
    jupyter nbextension enable varInspector/main && \
    rm -rf requirements.txt

COPY ./notebooks ${HOME}/notebooks

RUN Xvfb :1 -screen 0 1600x1200x16 &
ENV DISPLAY=:1.0

USER root
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}