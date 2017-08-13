#!/bin/bash
if [[ ! -d logs ]]; then mkdir logs; fi
singularity exec neurodebian.img.shrunk.img apt list --installed | tee logs/apt_package_list.txt
singularity exec neurodebian.img.shrunk.img pip2 freeze | tee logs/python2_package_list.txt
