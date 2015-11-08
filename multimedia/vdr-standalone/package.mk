################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2014 Stephan Raue (stephan@openelec.tv)
#      Copyright (C) 2011 Anthony Nash (nash.ant@gmail.com)
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

PKG_NAME="vdr-standalone"
PKG_VERSION="6.0"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.openelec.tv"
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain attr remote libcap nfs-utils vdr vdr-plugin-vnsiserver vdr-plugin-dvbapi vdr-live vdr-epgsearch vdr-mcli vdr-rpihddevice vdr-skinenigmang vdr-skinnopacity vdr-cecremote vdr-markad"
PKG_PRIORITY="optional"
PKG_SECTION="service.multimedia"
PKG_SHORTDESC="vdr: A powerful DVB TV application"
PKG_LONGDESC="This project describes how to build your own digital satellite receiver and video disk recorder. It is based mainly on the DVB-S digital satellite receiver card, which used to be available from Fujitsu Siemens and the driver software developed by the LinuxTV project."
PKG_AUTORECONF="no"
PKG_IS_ADDON="no"


make_target() {
  : # nothing to do here
}

makeinstall_target() {
  VDR_DIR="$(get_build_dir vdr)"
  VDRCONFIG=$INSTALL/usr/config/vdr
  VDRPLUGINS=$INSTALL/usr/lib/vdr
  PLUGIN_LIB=$INSTALL/usr/lib/vdr
  PLUGIN_RES=$INSTALL/usr/lib/vdr
  VDR_LOCALE=$INSTALL/usr/share/locale/

  mkdir -p $INSTALL/etc/
  mkdir -p $INSTALL/usr/bin
  mkdir -p $VDRCONFIG
  mkdir -p $VDRCONFIG/plugins
  mkdir -p $VDRPLUGINS
  mkdir -p $PLUGIN_LIB
  mkdir -p $PLUGIN_RES
  mkdir -p $VDR_LOCALE

  mkdir -p $INSTALL/usr/share/vdr/
  ln -sf /storage/.config/vdr $INSTALL/etc/
  ln -sf /storage/.config/vdr/plugins $INSTALL/usr/share/vdr/plugins

  # install VDR
  cp -P $VDR_DIR/vdr $INSTALL/usr/bin
  cp -a $VDR_DIR/locale/* $VDR_LOCALE
  cp $PKG_DIR/bin/* $INSTALL/usr/bin

  # install copy vdr default config
  cp $PKG_DIR/config/*  $VDRCONFIG
  cp $VDR_DIR/diseqc.conf $VDRCONFIG
  cp $VDR_DIR/keymacros.conf $VDRCONFIG
  cp $VDR_DIR/scr.conf $VDRCONFIG
  cp $VDR_DIR/sources.conf $VDRCONFIG

  # install plugins
  
  VDR_LIVE_DIR="$(get_build_dir vdr-live)"
  VDR_PLUGIN_MCLI_DIR="$(get_build_dir vdr-mcli)"
  VDR_PLUGIN_SKINENIGMANG="$(get_build_dir vdr-skinenigmang)"
  VDR_PLUGIN_RPIHDDEV_DIR="$(get_build_dir vdr-rpihddevice)"
#  VDR_PLUGIN_REMOTE_DIR="$(get_build_dir vdr-remote)"
  VDR_PLUGIN_CECREMOTE_DIR="$(get_build_dir vdr-cecremote)"
  VDR_PLUGIN_MARKAD_DIR="$(get_build_dir vdr-markad)"
  VDR_PLUGIN_VNSISERVER_DIR="$(get_build_dir vdr-plugin-vnsiserver)"
  VDR_PLUGIN_STREAMVEV_DIR="$(get_build_dir vdr-plugin-streamdev)"
  VDR_PLUGIN_XMLTV2VDR="$(get_build_dir vdr-plugin-xmltv2vdr)"
  VDR_PLUGIN_EPGFIXER_DIR="$(get_build_dir vdr-plugin-epgfixer)"
  VDR_PLUGIN_RESTFULAPI_DIR="$(get_build_dir vdr-plugin-restfulapi)"
  VDR_PLUGIN_SKINNOPACITY_DIR="$(get_build_dir vdr-plugin-restfulapi)"

  ln -s /usr/lib/vdr/live $VDRCONFIG/plugins/live

  mkdir -p $VDRCONFIG/plugins/epgsearch

  mkdir -p $PLUGIN_RES/live
  cp -PR $VDR_LIVE_DIR/live/* $PLUGIN_RES/live

  mkdir -p $VDRCONFIG/plugins

  mkdir -p $VDRCONFIG/epgsources/
#  cp $VDR_PLUGIN_XMLTV2VDR/dist/epgdata2xmltv/epgdata2xmltv.dist $VDRCONFIG/epgsources/epgdata2xmltv

  mkdir -p $VDRPLUGINS
  cp -PR $VDR_PLUGIN_VNSISERVER_DIR/libvdr*.so.* $VDRPLUGINS
  cp -PR $VDR_PLUGIN_MCLI_DIR/libvdr*.so.* $VDRPLUGINS
  cp -PR $VDR_PLUGIN_RPIHDDEV_DIR/libvdr*.so.* $VDRPLUGINS

  mkdir -p $VDRCONFIG/plugins/cecremote
  cp -PR $VDR_PLUGIN_CECREMOTE_DIR/libvdr*.so.* $VDRPLUGINS
  cp -PR $VDR_PLUGIN_CECREMOTE_DIR/contrib/cecremote.xml $VDRCONFIG/plugins/cecremote
  cp -PR $VDR_PLUGIN_CECREMOTE_DIR/locale/* $VDR_LOCALE

  mkdir -p $INSTALL/var/lib/markad
  cp -PR $VDR_PLUGIN_MARKAD_DIR/plugin/libvdr*.so.* $VDRPLUGINS
  cp -PR $VDR_PLUGIN_MARKAD_DIR/command/markad $INSTALL/usr/bin
  cp -PR $VDR_PLUGIN_MARKAD_DIR/command/logos/* $INSTALL/var/lib/markad/

#  cp -PR $VDR_PLUGIN_REMOTE_DIR/libvdr*.so.* $VDRPLUGINS
#  cp -PR $VDR_PLUGIN_REMOTE_DIR/locale/* $VDR_LOCALE

#  cp -PR $(get_build_dir vdr-iptv)/libvdr*.so.* $VDRPLUGINS
#  cp -PR $(get_build_dir vdr-wirbelscan)/libvdr*.so.* $VDRPLUGINS
#  cp -PR $(get_build_dir vdr-wirbelscancontrol)/libvdr*.so.* $VDRPLUGINS
  cp -PR $(get_build_dir vdr-plugin-dvbapi)/libvdr*.so.* $VDRPLUGINS
#  cp -PR $(get_build_dir vdr-plugin-eepg)/libvdr*.so.* $VDRPLUGINS
#  cp -PR $VDR_PLUGIN_STREAMVEV_DIR/server/libvdr*.so.* $VDRPLUGINS
#  cp -PR $VDR_PLUGIN_STREAMVEV_DIR/client/libvdr*.so.* $VDRPLUGINS
  cp -PR $VDR_LIVE_DIR/libvdr*.so.* $VDRPLUGINS
  cp -PR $VDR_LIVE_DIR/locale/* $VDR_LOCALE


  cp -PR $(get_build_dir vdr-epgsearch)/libvdr*.so.* $VDRPLUGINS
#  cp -PR $VDR_PLUGIN_XMLTV2VDR/libvdr*.so.* $VDRPLUGINS
#  cp -PR $(get_build_dir vdr-dummydevice)/libvdr*.so.* $VDRPLUGINS
#  cp -PR $(get_build_dir vdr-satip)/libvdr*.so.* $VDRPLUGINS
#  cp -PR $VDR_PLUGIN_EPGFIXER_DIR/libvdr*.so.* $VDRPLUGINS
#  cp -PR $VDR_PLUGIN_RESTFULAPI_DIR/libvdr*.so.* $VDRPLUGINS

  mkdir -p $PLUGIN_RES/skinenigmang
  mkdir -p $VDRCONFIG/themes
  cp -PR $(get_build_dir vdr-skinenigmang)/libvdr*.so.* $VDRPLUGINS
  cp -PR $(get_build_dir vdr-skinenigmang)/locale/* $VDR_LOCALE
  cp -PR $(get_build_dir vdr-skinenigmang)/themes/* $VDRCONFIG/themes
  cp -PR $(get_build_dir vdr-skinenigmang)/symbols/* $PLUGIN_RES/skinenigmang/
  cp -PR $(get_build_dir vdr-skinenigmang)/logos $PLUGIN_RES/skinenigmang/
  cp -PR $(get_build_dir vdr-skinenigmang)/flags $PLUGIN_RES/skinenigmang/
  cp -PR $(get_build_dir vdr-skinenigmang)/icons $PLUGIN_RES/skinenigmang/

  mkdir -p $PLUGIN_RES/skinnopacity
  cp -PR $(get_build_dir vdr-skinnopacity)/libvdr*.so.* $VDRPLUGINS
  cp -PR $(get_build_dir vdr-skinnopacity)/locale/* $VDR_LOCALE
  cp -PR $(get_build_dir vdr-skinnopacity)/themes/* $VDRCONFIG/themes/
  cp -PR $(get_build_dir vdr-skinnopacity)/symbols/* $PLUGIN_RES/skinnopacity/
  cp -PR $(get_build_dir vdr-skinnopacity)/logos $PLUGIN_RES/skinnopacity/
  cp -PR $(get_build_dir vdr-skinnopacity)/icons $PLUGIN_RES/skinnopacity/
  chmod -R u+rw $PLUGIN_RES/skinnopacity



#  mkdir -p $VDRCONFIG/plugins/eepg
  mkdir -p $VDRCONFIG/plugins/vnsiserver
  cp -PR $VDR_PLUGIN_VNSISERVER_DIR/vnsiserver/allowed_hosts.conf $VDRCONFIG/plugins/vnsiserver

#  cp -P $VDR_PLUGIN_XMLTV2VDR/dist/epgdata2xmltv/epgdata2xmltv $INSTALL/usr/bin

  cp -PL $(get_build_dir tntnet)/.install_pkg/usr/lib/libtntnet.so.12 $PLUGIN_LIB

#  mkdir -p $VDRCONFIG/plugins/streamdev-server
#  cp -PR $VDR_PLUGIN_STREAMVEV_DIR/streamdev-server/streamdevhosts.conf $VDRCONFIG/plugins/streamdev-server

#  mkdir -p $VDRCONFIG/plugins/epgfixer
#  cp -PR $VDR_PLUGIN_EPGFIXER_DIR/epgfixer/*.conf $VDRCONFIG/plugins/epgfixer

#  mkdir -p $PLUGIN_RES/restfulapi
#  cp -P $VDR_PLUGIN_RESTFULAPI_DIR/web/* $PLUGIN_RES/restfulapi
#  cp -P $VDR_PLUGIN_RESTFULAPI_DIR/API.html $PLUGIN_RES/restfulapi
#
}

post_install() {
   enable_service vdr-network.service 
   enable_service vdr-dhcp.service
   enable_service vdr-mount.service
   enable_service vdr.service

   ln -sf vdr.target $INSTALL/usr/lib/systemd/system/default.target

   ln -sf /var/cache/resolv.conf $INSTALL/etc/resolv.conf
}

