FROM kuberlab/tensorflow:cpu-36-1.9.0-base

RUN apt-get update && apt-get install -y \
  git \
  protobuf-compiler \
  python-pil \
  python-lxml \
  python-tk \
  build-essential && \
  pip install pillow lxml cython

COPY ./research /research
WORKDIR /research

RUN git clone https://github.com/cocodataset/cocoapi.git && \
 cd cocoapi/PythonAPI && make && make install && cd /research && \
 protoc object_detection/protos/*.proto --python_out=. && \
 python setup.py sdist && \
 (cd slim && python setup.py sdist) && \
 pip install dist/* && pip install slim/dist/* && \
 rm -rf /research/*

#RUN pip --no-cache-dir install jupyter_contrib_nbextensions && \
#  jupyter contrib nbextension install --system && \
#  pip --no-cache-dir install jupyter_nbextensions_configurator && \
#  jupyter nbextensions_configurator enable --system
#
#COPY jupyter_notebook_config.py /root/.jupyter/jupyter_notebook_config.py
#COPY jupyter_notebook_config.py /etc/jupyter/jupyter_notebook_config.py
WORKDIR /notebooks
#VOLUME ["/notebooks"]
#
#EXPOSE 8888
#
#CMD ["/run_jupyter.sh","--allow-root"]
