#!/usr/bin/env python3

# Copyright (c) Meta Platforms, Inc. and affiliates.
# This source code is licensed under the CC-BY-NC license found in the
# LICENSE file in the root directory of this source tree.

"""
This is a launcher script for launching mjrl training using hydra
"""

import os
os.environ["MUJOCO_GL"] = "egl"

import hydra
from hydra.core.hydra_config import HydraConfig
import warnings
import lightning
import multiprocessing
from omegaconf import DictConfig, OmegaConf

from cortexbench_exp.algos import *


@hydra.main(config_path="cortexbench_exp/configs/dmcontrol/bc_policy", config_name="partial_ft_spatial_fuse", version_base=None)
def main(config: DictConfig) -> None:
    print("========================================")
    print("Job Configuration")
    print("========================================")
    work_dir = HydraConfig.get().runtime.output_dir
    config.experiment_dir = work_dir
    warnings.simplefilter("ignore")
    lightning.seed_everything(config.train.seed)
    OmegaConf.save(config=config, f=os.path.join(work_dir, "config.yaml"))

    algo = get_algo_class(config.algo.algo_type)(config, inference=True)
    algo.inference()


if __name__ == "__main__":
    multiprocessing.set_start_method("spawn")
    main()
