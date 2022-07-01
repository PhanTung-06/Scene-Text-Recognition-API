FROM pytorch/pytorch:1.4-cuda10.1-cudnn7-devel

RUN git clone https://github.com/PhanTung-06/Scene-Text-Recognition-API.git
RUN pip install -r /Scene-Text-Recognition-API/requirements.txt
RUN cd workspace/Scene-Text-Recognition-API
RUN pip install detectron2==0.2 -f  https://dl.fbaipublicfiles.com/detectron2/wheels/cu100/torch1.4/index.html
RUN pip install dict-trie
RUN python setup.py install
RUN python setup.py build develop

CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "80"]

ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility
