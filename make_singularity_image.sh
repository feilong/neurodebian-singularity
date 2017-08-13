#!/bin/bash

bare_img=bare.img
bare_tmp=bare.tmp
bare_def=bare.def

if [[ ! -f $bare_img ]]; then
    sudo singularity create -s --force 1024 $bare_tmp && \
        sudo singularity bootstrap $bare_tmp $bare_def && \
        sudo mv $bare_tmp $bare_img
    if [[ -f $bare_tmp ]]; then sudo rm $bare_tmp; fi
fi



function bootstrap_from_image {
    set +e
    echo $# arguments, $@
    if [[ $# -lt 2 ]]; then return 1; fi
    if [[ -f $2.img ]]; then return 0; fi
    cp $1.img $2.tmp
    if [[ $# -ge 3 ]]; then sudo singularity expand -s $3 $2.tmp; fi
    sudo singularity bootstrap $2.tmp $2.def
    sudo mv $2.tmp $2.img
    set -e
}

bootstrap_from_image bare basic 3072
bootstrap_from_image basic neurodebian 4096
# bootstrap_from_image neurodebian python3
