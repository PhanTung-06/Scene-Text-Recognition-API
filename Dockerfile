# FROM floydhub/pytorch:1.5.0-gpu.cuda10cudnn7-py3.55
# FROM pytorch/pytorch:1.4-cuda10.1-cudnn7-runtime
FROM anibali/pytorch:1.5.0-cuda10.2-ubuntu18.04

WORKDIR /root
RUN sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/3bf863cc.pub
RUN sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64/7fa2af80.pub
RUN sudo apt-get update \
 && sudo apt-get install -y libgl1-mesa-glx libgtk2.0-0 libsm6 libxext6 \
 && sudo rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/PhanTung-06/Scene-Text-Recognition-API.git
WORKDIR /root/Scene-Text-Recognition-API
 
RUN pip install -r requirements.txt
RUN pip install detectron2==0.2 -f  https://dl.fbaipublicfiles.com/detectron2/wheels/cu102/torch1.5/index.html
RUN pip install dict-trie
RUN python setup.py install
RUN python setup.py build develop
RUN pip install opencv-python
RUN pip install python-multipart

ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility


