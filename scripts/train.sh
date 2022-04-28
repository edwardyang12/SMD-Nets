#!/bin/bash

#args
mode="passive"
name="train"

# setup
setup=stereo
dataset=MessyTable
#UnrealStereo4K 
#MessyTable

# path
results_path=/edward-slow-vol/checkpoints/smd
checkpoints_path=/edward-slow-vol/checkpoints/smd

# network
backbone="PSMNet"

# filenames
training_file=./filenames/train_messy.txt
testing_file=./filenames/val_messy.txt

# training settings
batch_size=2
num_epoch=200
learning_rate=1e-4
gamma=0.1

# sampling strategy (random, dda)
sampling=dda
num_sample_inout=50000

# output_representation
output_representation="bimodal"

# extras
extras="--pin_memory"
#extras="--continue_train"

# datasets
if [ $dataset == "UnrealStereo4K" ];then

    dataroot='/edward-slow-vol/UnrealStereo4K_00008/'
    aspect_ratio=0.25
    crop_width=2048
    crop_height=1536

elif [ $dataset == "KITTI" ];then

    dataroot=/media/Storage/Datasets/KITTI/2015
    aspect_ratio=1.
    crop_width=896
    crop_height=256

elif [ $dataset == "MessyTable" ];then

    dataroot='/cephfs/datasets/iccv_pnp/messy-table-dataset/v12/training/'
    aspect_ratio=1.
    crop_width=512
    crop_height=256

fi

python apps/train.py --dataroot $dataroot \
                     --checkpoints_path $checkpoints_path \
                     --training_file $training_file \
                     --testing_file $testing_file \
                     --results_path $results_path \
                     --mode $mode \
                     --name $name \
                     --batch_size $batch_size \
                     --num_epoch $num_epoch \
                     --learning_rate $learning_rate \
                     --gamma $gamma \
                     --crop_height $crop_height \
                     --crop_width $crop_width \
                     --num_sample_inout $num_sample_inout \
                     --aspect_ratio $aspect_ratio \
                     --sampling $sampling \
                     --output_representation $output_representation \
                     --backbone $backbone \
                     $extras


