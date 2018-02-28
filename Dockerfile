FROM tensorflow/tensorflow:nightly

RUN apt-get update && apt-get install protobuf-compiler python-pil python-lxml python-tk build-essential -y
RUN pip install jupyter matplotlib pillow lxml cython

RUN apt-get install git -y

COPY ./research /research
WORKDIR /research
RUN git clone https://github.com/cocodataset/cocoapi.git && cd cocoapi/PythonAPI && make && cp -r pycocotools /research/

RUN python setup.py sdist && (cd slim && python setup.py sdist) && pip install dist/* && pip install slim/dist/*

RUN export PYTHONPATH=$PYTHONPATH:/research:/research/slim

