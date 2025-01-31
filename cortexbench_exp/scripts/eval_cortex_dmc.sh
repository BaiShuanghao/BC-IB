#!/bin/bash

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${HOME}/.mujoco/mujoco200/bin
export MUJOCO_GL=egl
export CUDA_VISIBLE_DEVICES=0

source activate bcib

EVAL_ALL=True
LOAD_PATHS=(
    # the directory of testing model
)

# bash cortexbench_exp/scripts/eval_cortex_dmc.sh

for LOAD_PATH in "${LOAD_PATHS[@]}"; do
    python eval_cortex.py \
        --config-path=${LOAD_PATH} \
        --config-name=config.yaml \
        eval.load_path=${LOAD_PATH} \
        eval.eval_all=${EVAL_ALL}
done