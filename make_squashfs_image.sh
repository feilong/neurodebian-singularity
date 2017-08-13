image=$1
basename=${image/%.img/}
out_dir=$basename.export
tar_fn=$basename.export.tar
sqsh_fn=$basename.sqsh

echo Image file is $image
echo Basename is $basename

if [[ -f $image ]]; then
    if [[ ! -f $sqsh_fn ]]; then
        if [[ ! -f $tar_fn ]]; then
            singularity export -f $tar_fn $image
        fi
        if [[ ! -d $out_dir ]]; then
            mkdir $out_dir
            sudo tar xf $tar_fn -C $out_dir
        fi
        sudo mksquashfs $out_dir $sqsh_fn
    fi

    if [[ -f $sqsh_fn ]]; then
        if [[ -d $out_dir ]]; then sudo rm -rf $out_dir; fi
        if [[ -f $tar_fn ]]; then sudo rm $tar_fn; fi
    fi
fi
