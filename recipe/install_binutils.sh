#!/bin/bash

set -e

cd build

make install-strip
export HOST="${ctng_cpu_arch}-${ctng_vendor}-linux-gnu"
export NEW_HOST="${ctng_cpu_arch}-conda-linux-gnu"
mkdir -p $PREFIX/$NEW_HOST/bin
# Remove hardlinks and replace them by softlinks
for tool in addr2line ar as c++filt dwp elfedit gprof ld ld.bfd ld.gold nm objcopy objdump ranlib readelf size strings strip; do
  rm -rf $PREFIX/$HOST/bin/$tool
  ln -s $PREFIX/bin/$HOST-$tool $PREFIX/$HOST/bin/$tool || true;
  ln -s $PREFIX/bin/$HOST-$tool $PREFIX/bin/$NEW_HOST-$tool || true;
done

rm $PREFIX/bin/$HOST-ld || true;
rm $PREFIX/bin/$NEW_HOST-ld || true;
rm $PREFIX/$NEW_HOST/bin/ld || true;
rm $PREFIX/$HOST/bin/ld || true;
