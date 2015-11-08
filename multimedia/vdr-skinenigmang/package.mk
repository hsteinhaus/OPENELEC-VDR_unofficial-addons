################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2014 Stephan Raue (stephan@openelec.tv)
#
#  OpenELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  OpenELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="vdr-skinenigmang"
PKG_VERSION="0.1.2"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://andreas.vdr-developer.org/enigmang/download.html"
PKG_URL="http://projects.vdr-developer.org/attachments/download/935/$PKG_NAME-$PKG_VERSION.tgz"
PKG_SOURCE_DIR="skinenigmang-${PKG_VERSION}"
PKG_DEPENDS_TARGET="toolchain vdr"
PKG_PRIORITY="optional"
PKG_SECTION="multimedia"
PKG_SHORTDESC="vdr-skinenigmang: THE skin for VDR ;-)"
PKG_LONGDESC="vdr-skinenigmang: THE skin for VDR ;-)"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  VDR_DIR=$(get_build_dir vdr)
  export PKG_CONFIG_PATH=$VDR_DIR:$PKG_CONFIG_PATH
  export CPLUS_INCLUDE_PATH=$VDR_DIR/include
  export DEFINES="-D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE"

  make \
    VDRDIR=$VDR_DIR \
    LIBDIR="." \
    LOCALEDIR="./locale" \
    all i18n
}

post_make_target() {
  VDR_DIR=$(get_build_dir vdr)
  VDR_APIVERSION=`sed -ne '/define APIVERSION/s/^.*"\(.*\)".*$/\1/p' $VDR_DIR/config.h`
  LIB_NAME=lib${PKG_NAME/-plugin/}

#  cp -a $PKG_DIR/logos/enigma ./logos
  cp -a $PKG_DIR/logos/anthra ./logos
  cp -a $PKG_DIR/logos/skinenigmang/flags ./
  cp -a $PKG_DIR/logos/skinenigmang/icons ./
  cp --remove-destination $ROOT/$PKG_BUILD/${LIB_NAME}.so $ROOT/$PKG_BUILD/${LIB_NAME}.so.${VDR_APIVERSION}
  $STRIP libvdr-*.so*
}

makeinstall_target() {
  : # installation not needed, done by create-addon script
}
