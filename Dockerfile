FROM floydhub/pytorch:1.5.0-gpu.cuda10cudnn7-py3.55

WORKDIR /root
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


