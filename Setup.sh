#!/usr/bin/env sh

. ./.env

if [ ${GET_LATEST_SOURCE} = "true" ]; then
  echo "# ------------------------------------------"
  echo "# Downloading LATEST FreeCAD Source Files."
  echo "# ------------------------------------------"
  git clone https://github.com/FreeCAD/FreeCAD.git ${SOURCE_FOLDER}
fi




if [ ! -f "${TAG_NUMBER}${COMPRESS_FORMAT}" ]; then
  echo "# ------------------------------------------"
  echo "# Downloading ARCHIVED FreeCAD version."
  echo "# https://github.com/FreeCAD/FreeCAD/archive/refs/tags/${TAG_NUMBER}${COMPRESS_FORMAT}"
  echo "# ------------------------------------------"
  curl \
    -L "https://github.com/FreeCAD/FreeCAD/archive/refs/tags/${TAG_NUMBER}${COMPRESS_FORMAT}" \
    -o "${TAG_NUMBER}${COMPRESS_FORMAT}"
fi

echo "# ------------------------------------------"
echo "# UNCOMPRESS: The FreeCAD source code."
echo "# ------------------------------------------"
rm -fR "${SOURCE_FOLDER}"
mkdir -p "${SOURCE_FOLDER}"

if [ ${COMPRESS_FORMAT} = ".tar.gz" ]; then
  tar -zxf "${TAG_NUMBER}${COMPRESS_FORMAT}" --strip-components 1 -C "${SOURCE_FOLDER}"
  rm -f "${TAG_NUMBER}${COMPRESS_FORMAT}"
fi

if [ ${COMPRESS_FORMAT} = ".zip" ]; then
  TEMPORAL_DIRECTORY=$(mktemp -d)
  unzip -q "${TAG_NUMBER}${COMPRESS_FORMAT}" -d "${TEMPORAL_DIRECTORY}"
  # shellcheck disable=SC2039
  mv "${TEMPORAL_DIRECTORY}"/*/{.[!.],}* "${SOURCE_FOLDER}"
  rm -fR "${TEMPORAL_DIRECTORY}"
  rm -f "${TAG_NUMBER}${COMPRESS_FORMAT}"
fi

echo "# ------------------------------------------"
echo "# Download FreeCAD Docker Image"
echo "# ------------------------------------------"

docker pull registry.gitlab.com/daviddaish/freecad_docker_env:latest

xhost si:localuser:root