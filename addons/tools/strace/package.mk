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

PKG_NAME="strace"
PKG_VERSION="4.10"
PKG_REV="3"
PKG_ARCH="any"
PKG_LICENSE="BSD"
PKG_SITE="http://sourceforge.net/projects/strace/"
PKG_URL="$SOURCEFORGE_SRC/strace/strace/$PKG_VERSION/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="tools"
PKG_SHORTDESC="strace: Trace system calls and signals"
PKG_LONGDESC="In the simplest case strace runs the specified command until it exits. It intercepts and records the system calls which are called by a process and the signals which are received by a process. The name of each system call, its arguments and its return value are printed on standard error or to the file specified with the -o option."

PKG_IS_ADDON="no"
#PKG_ADDON_TYPE="xbmc.python.script"
#PKG_ADDON_PROVIDES=""
#PKG_ADDON_REPOVERSION="4.3"
#
PKG_AUTORECONF="yes"

PKG_MAINTAINER="unofficial.addon.pro"


makeinstall_target() {
  make all
  mkdir -p $INSTALL/usr/bin
  echo "====== $PKG_BUILD/.$TARGET_NAME/strace $INSTALL/usr/bin/"
  cp -P $PKG_BUILD/.$TARGET_NAME/strace $INSTALL/usr/bin/
}
