#!/bin/bash

OS=$(lsb_release -is)
CODE=$(lsb_release -cs)
OFFLINE_PACKAGE_FILE=eva-offline-${OS}-${CODE}.tar.gz

support=""

# checks Ubuntu version.
case ${CODE} in
  "xenial")
    support="yes"
    ;;
  "Maipo")
    support="yes"
    ;;
esac

if [ "${support}" != "yes" ];then
  echo "The ${OS}-${CODE} is not supported"
  exit -1
fi

if [ $USER != "root" ] ; then
  echo "should be root."
  exit 1
fi

if [ "${OS}" == "RedHatEnterpriseServer" ]; then
  echo "RHEL offline repository : should mount DVD."
  # below section: specialized for RHEL.
  # TODO
elif [ "${OS}" == "CentOS" ]; then
  echo "CentOS offline repository : should mount DVD."
  # below section: specialized for CentOS.
  # TODO
elif [ "${OS}" == "Ubuntu" ]; then
  # below section: specialized for Ubuntu.
  if [ -e ${OFFLINE_PACKAGE_FILE} ]; then
    if [ ! -e ./offline ]; then
      echo "create offline folder to offline install..."
      mkdir offline
    fi

    pushd . > /dev/null
    cd offline

    if [ ! -e docker-ce_17.09.0~ce-0~ubuntu_amd64.deb ]; then
      echo "Extracting offline packages into offline apt repostry..."
      tar xvf  ../${OFFLINE_PACKAGE_FILE}
    fi

    echo
    echo "Preparing apt package repositry at $PWD"
    if [ -e Packages.gz ]; then
      rm Packages.gz
    fi
    if [ -e Sources.gz ]; then
      rm Sources.gz
    fi
    if [ -e Contents-$(dpkg --print-architecture).gz ]; then
      rm Contents-$(dpkg --print-architecture).gz
    fi

    apt-ftparchive sources  . > Sources
    apt-ftparchive packages . > Packages
    apt-ftparchive contents . > Contents-$(dpkg --print-architecture)
    apt-ftparchive release  . > Release
    gzip -c9 Sources  > Sources.gz
    gzip -c9 Packages > Packages.gz
    gzip -c9 Contents-$(dpkg --print-architecture) > Contents-$(dpkg --print-architecture).gz

    echo "Register apt repositry with insecure."
    if [ ! -e sources.list ] ; then
      echo "deb [ allow-insecure=yes allow-downgrade-to-insecure=yes  ] file:${PWD}/ / " > ../sources.list
    fi
    popd
    cp sources.list /etc/apt/

    if [ ! -e /etc/apt/apt.conf.d/99necevasettings ]; then
      echo 'APT::Get::AllowUnauthenticated "true";' > /etc/apt/apt.conf.d/99necevasettings
    fi
  fi
fi

