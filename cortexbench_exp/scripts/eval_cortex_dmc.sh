#!/bin/bash

# export LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libGLdispatch.so.0      # if libgpu_partition.so confilts with gym and robosuite
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${HOME}/.mujoco/mujoco200/bin
export CUDA_VISIBLE_DEVICES=0

source activate bcib

EVAL_ALL=True
LOAD_PATHS=(
/baishuanghao/code2/BC-IB/outputs/cortexbench/partial_ft_spatial_fuse/bc_policy/VC1/dmcontrol/dmc_cheetah_run-v1/demo10/0201_1719_seed0    # the directory of testing model
)

# bash cortexbench_exp/scripts/eval_cortex_dmc.sh

for LOAD_PATH in "${LOAD_PATHS[@]}"; do
    python eval_cortex.py \
        --config-path=${LOAD_PATH} \
        --config-name=config.yaml \
        eval.load_path=${LOAD_PATH} \
        eval.eval_all=${EVAL_ALL}
done