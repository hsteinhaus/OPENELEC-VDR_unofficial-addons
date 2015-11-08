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

PKG_NAME="vdr-rpihddevice"
PKG_VERSION="1.0.0"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://projects.vdr-developer.org/projects/plg-rpihddevice/files"
PKG_URL="http://srv04/$PKG_NAME-$PKG_VERSION.tgz"
PKG_SOURCE_DIR="rpihddevice-${PKG_VERSION}"
PKG_DEPENDS_TARGET="toolchain vdr"
PKG_PRIORITY="optional"
PKG_SECTION="multimedia"
PKG_SHORTDESC="vdr-plugin-rpihddevice: output device for RPi"
PKG_LONGDESC="vdr-plugin-rpihddevice: output device for RPi"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

pre_configure_target() {
  export CFLAGS="$CFLAGS -fPIC"
  export CXXFLAGS="$CXXFLAGS -fPIC"
  export LDFLAGS="$LDFLAGS -fPIC"
}

make_target() {
  VDR_DIR=$(get_build_dir vdr)
  make VDRDIR=$VDR_DIR \
    LIBDIR="." \
    LOCALEDIR="./locale" \
    SYSROOT=$SYSROOT_PREFIX \
    OPTVC=$ROOT/$BUILD/bcm2835-driver-7f01b12/hardfp/opt/vc
}

makeinstall_target() {
  : # installation not needed, done by create-addon script
}