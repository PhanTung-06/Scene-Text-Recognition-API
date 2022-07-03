FROM pytorch/pytorch:1.4-cuda10.1-cudnn7-devel

RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/3bf863cc.pub
RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64/7fa2af80.pub

RUN apt-get update \
 && apt-get install -y wget htop byobu git gcc g++ libgl1-mesa-glx libgtk2.0-0 libsm6 libxext6

WORKDIR /workspace
RUN git clone https://github.com/PhanTung-06/Scene-Text-Recognition-API.git
WORKDIR /workspace/Scene-Text-Recognition-API
 

RUN pip install ninja yacs cython matplotlib tqdm opencv-python shapely scipy tensorboardX pyclipper Polygon3 weighted-levenshtein editdistance
RUN pip install detectron2==0.2 -f  https://dl.fbaipublicfiles.com/detectron2/wheels/cu101/torch1.4/index.html
RUN pip install dict-trie
RUN python setup.py install
RUN python setup.py build develop
RUN pip install -r requirements.txt
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility

# EXPOSE 8000:8000
# CMD ["uvicorn", "app:app", "--reload"]

