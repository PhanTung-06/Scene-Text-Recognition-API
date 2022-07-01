FROM pytorch/pytorch:1.4-cuda10.1-cudnn7-devel

WORKDIR /root
RUN git clone https://github.com/PhanTung-06/Scene-Text-Recognition-API.git
WORKDIR /root/Scene-Text-Recognition-API

RUN pip install -r requirements.txt
RUN pip install opencv-contrib-python
RUN pip install detectron2==0.2 -f  https://dl.fbaipublicfiles.com/detectron2/wheels/cu101/torch1.4/index.html

RUN pip install dict-trie
RUN python setup.py install
RUN python setup.py build develop


ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility


