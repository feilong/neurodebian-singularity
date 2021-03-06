# Reduce image size
# https://github.com/singularityware/singularity/issues/623

image=$1
echo $image
if [[ -f $image ]]; then
    stripped_img=`tempfile --directory=.`
    tail -n +2 $image > $stripped_img
    e2fsck -f $stripped_img
    resize2fs -M $stripped_img
    shrunk_img=`tempfile --directory=.`
    head -n 1 $image > $shrunk_img
    cat $stripped_img >> $shrunk_img
    rm $stripped_img
    mv $shrunk_img $image.shrunk.img
    chmod a+x $image.shrunk.img
fi
