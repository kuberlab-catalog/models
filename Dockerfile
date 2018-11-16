FROM kuberlab/tensorflow:cpu-36-1.9.0-base

RUN apt-get update && apt-get install -y \
  python-pil \
  python-lxml \
  python-tk \
  build-essential \
  unzip && \
  pip install pillow lxml Cython contextlib2 && \
  wget -O protobuf.zip https://github.com/google/protobuf/releases/download/v3.0.0/protoc-3.0.0-linux-x86_64.zip && \
  mkdir proto && unzip protobuf.zip -d proto && \
  mv proto/bin/protoc /usr/bin/protoc && rm -rf protobuf.zip proto

COPY ./research /research

RUN cd /research && git clone https://github.com/cocodataset/cocoapi.git && \
 cd cocoapi/PythonAPI && make && \
 cp -r pycocotools /research/ && \
 site_dir=$(python -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())") && \
 cp -r pycocotools $site_dir/ && cd /research && \
 protoc object_detection/protos/*.proto --python_out=. && \
# Do not install code into container, only "slim" package
# python setup.py sdist && \
# pip install dist/* && \
 (cd slim && python setup.py sdist) && \
 pip install slim/dist/* && \
 rm -rf /research/*

WORKDIR /notebooks
