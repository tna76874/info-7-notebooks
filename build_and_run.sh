#!/bin/bash
docker build -t my-image . && docker run -it --rm -p 8888:8888 my-image jupyter notebook --NotebookApp.default_url=/lab/ --ip=0.0.0.0 --port=8888
