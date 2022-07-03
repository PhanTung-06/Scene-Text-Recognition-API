
# FROM floydhub/pytorch:1.5.0-gpu.cuda10cudnn7-py3.55
FROM pytorch/pytorch:1.4-cuda10.1-cudnn7-devel
# FROM anibali/pytorch:1.5.0-cuda10.2-ubuntu18.04


RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/3bf863cc.pub
RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64/7fa2af80.pub
RUN apt-get update \
 && apt-get install -y wget htop byobu git gcc g++ libgl1-mesa-glx libgtk2.0-0 libsm6 libxext6 \
 && rm -rf /var/lib/apt/lists/*
 
WORKDIR /root
RUN git clone https://github.com/PhanTung-06/Scene-Text-Recognition-API.git
WORKDIR /root/Scene-Text-Recognition-API
 
RUN pip install -r requirements.txt
RUN pip install detectron2==0.2 -f  https://dl.fbaipublicfiles.com/detectron2/wheels/cu101/torch1.4/index.html
RUN pip install dict-trie
RUN python3 setup.py install
RUN python3 setup.py build develop

ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility

# EXPOSE 8000:8000
# CMD ["uvicorn", "app:app", "--reload"]:a
