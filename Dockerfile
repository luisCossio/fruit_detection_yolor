FROM nvidia/cuda:10.2-cudnn7-devel-ubuntu18.04

ARG DEBIAN_FRONTEND=noninteractive # for ubuntu 20.04

RUN apt-get update  -y \
  && apt-get install -y git cmake make gnupg build-essential software-properties-common gdb unzip\
  && add-apt-repository ppa:deadsnakes/ppa \
  && apt update -y && apt-get install -y python3.7-dev \
  && update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.7 1 \
  && apt-get install -y python3-pip ffmpeg libsm6 libxext6 \
  && pip3 install --upgrade pip

RUN git clone https://github.com/luisCossio/fruit_detection_yolor.git && mkdir -p fruit_detection_yolor/weights \
  && mkdir datasets && pip3 install Cython==0.29.23 numpy==1.20.1

RUN  cd /fruit_detection_yolor && pip3 install -r requirements.txt && \
git clone https://github.com/thomasbrandon/mish-cuda && mv mish-cuda mish_cuda
# python3 setup.py install

WORKDIR /fruit_detection_yolor