#!/bin/bash

# args
mode=passive
name="test" 

# setup
setup=stereo
dataset=MessyTable
#UnrealStereo4K

# network
backbone="PSMNet"

# path
results_path=./results/
checkpoints_path=/edward-slow-vol/checkpoints/smd/train/net_latest

# filenames
testing_file=./filenames/test_messy.txt

# testing settings
superes_factor=4

# uncertainty
output_representation="bimodal"

# extras
extras="--pin_memory"
#extras="--differential_entropy"

# datasets
if [ $dataset == "UnrealStereo4K" ];then
    dataroot=/media/Storage/Datasets/UnrealStereo4K
    aspect_ratio=0.25

elif [ $dataset == "KITTI" ];then
    dataroot=/media/Storage/Datasets/KITTI/2015
    aspect_ratio=1.

elif [ $dataset == "MessyTable" ];then
    dataroot='/cephfs/datasets/iccv_pnp/messy-table-dataset/real_v9/training/'
    aspect_ratio=1.
fi

python apps/test.py --dataroot $dataroot \
                    --testing_file $testing_file \
                    --results_path $results_path \
                    --mode $mode \
                    --batch_size 1 \
                    --superes_factor $superes_factor \
                    --aspect_ratio $aspect_ratio \
                    --output_representation $output_representation \
                    --load_checkpoint_path $checkpoints_path \
                    --backbone $backbone \
                    $extras



 
