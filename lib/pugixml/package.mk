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

PKG_NAME="pugixml"
PKG_VERSION="1.7"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_SITE="http://pugixml.org/"
PKG_URL="http://github.com/zeux/pugixml/releases/download/v$PKG_VERSION/$PKG_NAME-$PKG_VERSION.tar.gz"
#PKG_SOURCE_DIR="pugixml-$PKG_VERSION"
PKG_DEPENDS_HOST="cmake:host"
PKG_DEPENDS_TARGET="toolchain zlib"
PKG_PRIORITY="optional"
PKG_SECTION="lib"
PKG_SHORTDESC="xml parser"
PKG_LONGDESC="Light-weight, simple and fast XML parser for C++ with XPath support"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

#PKG_CONFIGURE_OPTS_TARGET="--without-x --disable-docs"

pre_configure_host() {
  export CFLAGS="$CFLAGS -fPIC -DPIC"
  export CPPFLAGS="$CPPFLAGS -I$ROOT/$TOOLCHAIN/include"
}

pre_configure_target() {
  export CFLAGS="$CFLAGS -fPIC -DPIC"
  export CPPFLAGS="$CPPFLAGS -I$SYSROOT_PREFIX/usr/include"
}

make_target() {
  cmake -DCMAKE_INSTALL_PREFIX:PATH=/usr -DBUILD_SHARED_LIBS=true scripts/
  make
}

make_install_target() {
  cp -P $BUILD/usr/lib/libpugixml.so* $INSTALL/usr/lib/
}
