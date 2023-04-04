<center> <h1>Benchmarking YOLOv5 against YOLOv8</h1> </center>

This guide outlines the necessary steps to set up the host and docker environments, and run benchmarks for YOLOv5 and YOLOv8.

## Get Ampere Altra System
Before running the demos, please create a 32 cores Ampere instance (You may use lower number of cores if you choose to run at a lower number of threads) on one of our cloud service provider partners.

 
[Oracle Cloud Ampere A1 instance](https://www.oracle.com/cloud/compute/pricing.html)  
[Google Cloud GCP t2a instance](https://cloud.google.com/compute/all-pricing)  
[Azure Dps/Dpds v5](https://www.enterpriseai.news/2022/04/05/microsoft-azure-adds-altra-arm-based-virtual-machines/)  
[Tencent SR1](https://pcr.cloud-mercato.com/providers/tencent/flavors/sr1.16xlarge128/pricing)

Please visit Ampere Computing webpage [Ampere Solutions](https://amperecomputing.com/solutions) for the latest information about our wide selection of compute platforms.

## Host Setup
Execute the following script to complete the host setup which includes preparing the host, installing docker and docker-compose, downloading YOLOv5, YOLOv8 source code, and applying patches.
```
$ ./setup-host.sh
```

## Docker Setup
Execute the following script to start the docker container with volume mount and install pre-requisites for YOLOv5 and YOLOv8 source.
```
$ ./setup-docker.sh
```

## Running Benchmarks
Execute the following script on the host (not on the docker) to run benchmarks for YOLOv5 and YOLOv8. The script runs the benchmark for nano and small models, for 3 times, and logs can be found at `yolov5/results.log` and `yolov8/results.log`.
```
$ ./run.sh 
Log files: yolov5-6.2/out.log yolov5-6.2/results.log
Num cores: 32 AIO_NUM_THREADS: 32
[yolov5n] Starting export... -> yolov5n.torchscript
[yolov5n] Starting inference... 
[1] Speed: 0.1ms pre-process, 10.6ms inference, 0.9ms NMS per image at shape (1, 3, 640, 640)
[2] Speed: 0.1ms pre-process, 10.5ms inference, 0.9ms NMS per image at shape (1, 3, 640, 640)
[3] Speed: 0.1ms pre-process, 10.4ms inference, 0.9ms NMS per image at shape (1, 3, 640, 640)
[yolov5s] Starting export... -> yolov5s.torchscript
[yolov5s] Starting inference... 
[1] Speed: 0.1ms pre-process, 21.6ms inference, 0.9ms NMS per image at shape (1, 3, 640, 640)
[2] Speed: 0.1ms pre-process, 21.6ms inference, 0.9ms NMS per image at shape (1, 3, 640, 640)
[3] Speed: 0.1ms pre-process, 21.6ms inference, 0.9ms NMS per image at shape (1, 3, 640, 640)
Log files: yolov8-8.0.54/out.log yolov8-8.0.54/results.log
Num cores: 32 AIO_NUM_THREADS: 32
[yolov8n] Starting export... -> yolov8n.torchscript
[yolov8n] Starting inference... 
[1] Speed: 0.1ms preprocess, 15.7ms inference, 0.9ms postprocess per image at shape (1, 3, 640, 640)
[2] Speed: 0.1ms preprocess, 15.7ms inference, 0.9ms postprocess per image at shape (1, 3, 640, 640)
[3] Speed: 0.1ms preprocess, 15.7ms inference, 0.9ms postprocess per image at shape (1, 3, 640, 640)
[yolov8s] Starting export... -> yolov8s.torchscript
[yolov8s] Starting inference... 
[1] Speed: 0.1ms preprocess, 33.6ms inference, 0.9ms postprocess per image at shape (1, 3, 640, 640)
[2] Speed: 0.1ms preprocess, 33.6ms inference, 0.9ms postprocess per image at shape (1, 3, 640, 640)
[3] Speed: 0.2ms preprocess, 33.8ms inference, 0.9ms postprocess per image at shape (1, 3, 640, 640)
```