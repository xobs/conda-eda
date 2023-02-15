#!/bin/bash

set -e
# set gf180mcuc defaults
cat > $PREFIX/etc/conda/activate.d/open_pdks_activate.sh <<EOF
export PDK_ROOT=\$CONDA_PREFIX/share/pdk
export PDK=gf180mcuC
EOF

cat > $PREFIX/etc/conda/activate.d/klayout_activate.sh <<EOF
export KLAYOUT_HOME=\$CONDA_PREFIX/share/pdk/gf180mcuC/libs.tech/klayout
EOF

mv $PREFIX/bin/magic $PREFIX/bin/magic.real
cat > $PREFIX/bin/magic <<EOF
magic.real -rcfile \$CONDA_PREFIX/share/pdk/gf180mcuC/libs.tech/magic/gf180mcuC.magicrc \$@
EOF
chmod +x $PREFIX/bin/magic

mv $PREFIX/bin/xschem $PREFIX/bin/xschem.real
cat > $PREFIX/bin/xschem <<EOF
xschem.real --rcfile \$CONDA_PREFIX/share/pdk/gf180mcuC/libs.tech/xschem/xschemrc \$@
EOF
chmod +x $PREFIX/bin/xschem
cat >> $PREFIX/share/pdk/gf180mcuC/libs.tech/xschem/xschemrc <<EOF
set XSCHEM_START_WINDOW \${PDK_ROOT}/gf180mcuC/libs.tech/xschem/tests/0_top.sch
append XSCHEM_LIBRARY_PATH :\${PDK_ROOT}/gf180mcuC/libs.tech/xschem
EOF
sed -i -e 's/ngspice\/models/gf180mcuC\/libs.tech\/ngspice/' $PREFIX/share/pdk/gf180mcuC/libs.tech/xschem/xschemrc 

# fix up yosys dep
(cd $PREFIX/lib && ln -s libffi.so.7 libffi.so.6)
