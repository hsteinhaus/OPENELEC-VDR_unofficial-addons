################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2012 Stephan Raue (stephan@openelec.tv)
#
#  This Program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2, or (at your option)
#  any later version.
#
#  This Program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.tv; see the file COPYING.  If not, write to
#  the Free Software Foundation, 51 Franklin Street, Suite 500, Boston, MA 02110, USA.
#  http://www.gnu.org/copyleft/gpl.html
################################################################################

PKG_NAME="spice-gtk"
PKG_VERSION="0.30"
PKG_REV="1"
PKG_ARCH=""
PKG_LICENSE="GPL"
PKG_SITE="http://www.spice-space.org"
PKG_URL="${PKG_SITE}/download/gtk/${PKG_NAME}-${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_TARGET="toolchain x11 font-bitstream-type1 cairo gtk+ libXinerama spice-protocol usbredir glib:host pulseaudio six:host pyparsing:host"
PKG_PRIORITY="optional"
PKG_SECTION="x11/app"
PKG_SHORTDESC="A SPICE client"
PKG_LONGDESC="A SPICE client"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_CONFIGURE_OPTS_TARGET="\
	--prefix=/usr \
        --with-gtk=2.0 \
        --without-python \
	--with-audio=pulse"
	

pre_configure_target() {
    SDIR=$(get_build_dir spice-protocol)
    export PKG_CONFIG_PATH=$SDIR:$PKG_CONFIG_PATH
    export SPICE_PROTOCOL_PREFIX=$SYSROOT_PREFIX
}


post_install() {
  enable_service spicy.service
}

