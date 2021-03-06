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

PKG_NAME="vdr-markad"
PKG_VERSION="0.1.5pre"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://srv04/vdr-plugin-mcli/"
PKG_URL="http://srv04/$PKG_NAME-$PKG_VERSION.tgz"
PKG_SOURCE_DIR="markad-${PKG_VERSION}"
PKG_DEPENDS_TARGET="toolchain libxml2 vdr"
PKG_PRIORITY="optional"
PKG_SECTION="multimedia"
PKG_SHORTDESC="vdr-plugin-mardad: remove ads"
PKG_LONGDESC="vdr-plugin-mcli: Netceiver support for the Video Disk Recorder (VDR)"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  VDR_DIR=$(get_build_dir vdr)
  export PKG_CONFIG_PATH=$VDR_DIR:$PKG_CONFIG_PATH
  export CPLUS_INCLUDE_PATH=$VDR_DIR/include

  make \
    VDRDIR=$VDR_DIR \
    LIBDIR="." \
    LOCDIR="./locale" \
    all
}

post_make_target() {
  VDR_DIR=$(get_build_dir vdr)
  VDR_APIVERSION=`sed -ne '/define APIVERSION/s/^.*"\(.*\)".*$/\1/p' $VDR_DIR/config.h`
  LIB_NAME=lib${PKG_NAME/-plugin/}

  $STRIP plugin/libvdr-*.so*
  $STRIP command/markad
}

makeinstall_target() {
  : # installation not needed, done by create-addon script
}
