#!/bin/bash

export AIO_NUM_THREADS=`nproc`
export AIO_SKIP_MASTER_THREAD=1

test_dir=yolov8-8.0.54
cd $test_dir

# Install yolov8
pip install -q .

out_log="out.log"
results_log="results.log"
echo "Log files: $test_dir/$out_log $test_dir/$results_log"

echo >> $results_log
echo "============================" >> $results_log
echo `date` >> $results_log
echo "============================" >> $results_log
echo "Num cores: `nproc` AIO_NUM_THREADS: $AIO_NUM_THREADS" |& tee -a $results_log

src="ultralytics/assets/bus.jpg"
src="../media-files/Driving-Vegas-360p-jutah-1min.mp4"

for m_base in "yolov8n" "yolov8s"
do
    # Export
    m="$m_base.torchscript"
    export_cmd="yolo task=detect mode=export model=$m_base format=torchscript"
    echo -n "[$m_base] Starting export... " |& tee -a $results_log
    $export_cmd >& $out_log
    echo "-> $m" |& tee -a $results_log

    inference_cmd="yolo task=detect mode=predict model=$m source=$src save=False"

    # Inference
    echo "[$m_base] Starting inference... " |& tee -a $results_log
    for i in {1..3}
    do
        echo -n "[$i] " |& tee -a $results_log
        $inference_cmd >& $out_log

        #inf_time=`grep Speed $out_log | awk '{print $4}' | sed -e 's/ms//'`
        #echo "Inference time: $inf_time msec" >> $results_log
        echo "`grep Speed $out_log`" |& tee -a $results_log
    done
    echo "----------------------------" >> $results_log
done

cd -
