#!/bin/bash
# shellcheck disable=SC2034

# 适用于出厂安卓13的机型
unpack_partiton="system odm system_ext product vendor mi_ext system_dlkm vendor_dlkm"
# 适用于升级到安卓13的机型
# unpack_partiton="system odm system_ext product vendor mi_ext"
# 适用于没有官方安卓13的机型
# unpack_partiton="system odm system_ext product vendor"

mkdir -p "$GITHUB_WORKSPACE"/get_files

get_prop_files() {
  mkdir -p "$GITHUB_WORKSPACE"/get_files/system
  mkdir -p "$GITHUB_WORKSPACE"/get_files/vendor
  mkdir -p "$GITHUB_WORKSPACE"/get_files/system_ext/etc
  mkdir -p "$GITHUB_WORKSPACE"/get_files/odm/etc
  mkdir -p "$GITHUB_WORKSPACE"/get_files/product/etc
  mkdir -p "$GITHUB_WORKSPACE"/get_files/mi_ext
  mi_ext_build_prop=$(sudo find "$GITHUB_WORKSPACE"/"$device"/mi_ext -name "build.prop")
  sudo cp "$GITHUB_WORKSPACE"/"$device"/system/system/build.prop "$GITHUB_WORKSPACE"/get_files/system/system
  sudo cp "$GITHUB_WORKSPACE"/"$device"/vendor/build.prop "$GITHUB_WORKSPACE"/get_files/vendor
  sudo cp "$GITHUB_WORKSPACE"/"$device"/system_ext/etc/build.prop "$GITHUB_WORKSPACE"/get_files/system_ext/etc
  sudo cp "$GITHUB_WORKSPACE"/"$device"/odm/etc/build.prop "$GITHUB_WORKSPACE"/get_files/odm/etc
  sudo cp "$GITHUB_WORKSPACE"/"$device"/product/etc/build.prop "$GITHUB_WORKSPACE"/get_files/product/etc
  sudo cp "$mi_ext_build_prop" "$GITHUB_WORKSPACE"/get_files/mi_ext
}

get_files_config() {
  mkdir -p "$GITHUB_WORKSPACE"/get_files/config
  cp -r "$GITHUB_WORKSPACE"/"$device"/config/* "$GITHUB_WORKSPACE"/get_files/config
}

get_camera() {
  mkdir -p "$GITHUB_WORKSPACE"/get_files/product/priv-app/
  cp -r "$GITHUB_WORKSPACE"/"$device"/product/priv-app/MiuiCamera "$GITHUB_WORKSPACE"/get_files/product/priv-app
}

get_device_features() {
  mkdir -p "$GITHUB_WORKSPACE"/get_files/product/etc
  cp -r "$GITHUB_WORKSPACE"/"$device"/product/etc/device_features "$GITHUB_WORKSPACE"/get_files/product/etc
}
get_overlay() {
  mkdir -p "$GITHUB_WORKSPACE"/get_files/product
  cp -r "$GITHUB_WORKSPACE"/"$device"/product/overlay "$GITHUB_WORKSPACE"/get_files/product
}

extract_files() {
  cp "$GITHUB_WORKSPACE"/info.txt "$GITHUB_WORKSPACE"/get_files
  get_prop_files
  get_files_config
}
