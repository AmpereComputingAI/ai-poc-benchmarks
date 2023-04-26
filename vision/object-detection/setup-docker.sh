#!/bin/bash

cont_id="amperecomputingai/pytorch"
tag="1.5.2"

echo "docker pull $cont_id:$tag"
docker pull -q $cont_id:$tag

cont_name="yolo-aio-pytorch-1.5.2"
echo "Starting container $cont_name"

docker run \
  -it --init --rm -d \
  -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
  -v $HOME:/workspace \
  --network host \
  --ipc host \
  --name $cont_name \
  --entrypoint /bin/bash \
  --workdir /workspace \
  $cont_id:$tag

if [ $? -ne 0 ]; then
	echo "Error: Docker can't be started, exiting"
	exit
fi

workdir=/workspace/ai-poc-benchmarks/vision/object-detection/yolov5-6.2
cat <<EOF | docker exec -i -w $workdir $cont_name bash
apt update -y
apt install -y libgl-dev libglib2.0-0 libsm6 cargo ffmpeg curl vim
pip uninstall -y opencv-contrib-python-headless
pip install -U pip setuptools
pip install --no-cache-dir -r requirements.txt
pip install --no-cache-dir pafy youtube_dl==2020.12.2
EOF
