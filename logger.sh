#!/bin/bash
if [[ ! -d logs ]]; then mkdir logs; fi
IMG=neurodebian.sqsh
singularity exec $IMG apt list --installed | tee logs/apt_package_list.txt
singularity exec $IMG pip2 freeze | tee logs/python2_package_list.txt
