#!/usr/bin/env bash

set -e

docker build -t kuberlab/tf-object-detection:1.9.0 -f Dockerfile .
docker build -t kuberlab/tf-object-detection:1.9.0-gpu -f Dockerfile.gpu .
