#!/bin/bash

# This script must be called outside docker

# Yolov5
workdir="/workspace/ai-poc-benchmarks/vision/object-detection"
cont_name="yolo-aio-pytorch-1.5.2"
script="/workspace/ai-poc-benchmarks/vision/object-detection/benchmark-yolov5.sh"

# Log files: yolov5-6.2/out.log yolov5-6.2/results.log

# Limit the specific CPUs a container can use
# docker update --cpuset-cpus "0-31" $cont_name

docker exec -w $workdir $cont_name $script

# Yolov8
script="/workspace/ai-poc-benchmarks/vision/object-detection/benchmark-yolov8.sh"

docker exec -w $workdir $cont_name $script
