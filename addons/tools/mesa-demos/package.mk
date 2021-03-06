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

PKG_NAME="mesa-demos"
PKG_VERSION="8.2.0"
PKG_REV="2"
PKG_ARCH="x86_64"
PKG_LICENSE="OSS"
PKG_SITE="http://www.mesa3d.org/"
PKG_URL="ftp://ftp.freedesktop.org/pub/mesa/demos/$PKG_VERSION/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain libX11 Mesa glu glew"
PKG_PRIORITY="optional"
PKG_SECTION="tools"
PKG_SHORTDESC="mesa-demos: Mesa 3D demos"
PKG_LONGDESC="Mesa 3D demos - installed are the well known glxinfo and glxgears."

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.python.script"
PKG_ADDON_PROVIDES=""
PKG_ADDON_REPOVERSION="4.3"

PKG_AUTORECONF="yes"

PKG_MAINTAINER="unofficial.addon.pro"

makeinstall_target() {
  : # nop
}

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/bin
  cp -P $PKG_BUILD/.$TARGET_NAME/src/xdemos/glxdemo $ADDON_BUILD/$PKG_ADDON_ID/bin/
  cp -P $PKG_BUILD/.$TARGET_NAME/src/xdemos/glxgears $ADDON_BUILD/$PKG_ADDON_ID/bin/
  cp -P $PKG_BUILD/.$TARGET_NAME/src/xdemos/glxinfo $ADDON_BUILD/$PKG_ADDON_ID/bin/
}
