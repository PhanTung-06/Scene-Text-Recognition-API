FROM pytorch/pytorch:1.4-cuda10.1-cudnn7-devel

RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "80"]

ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility
