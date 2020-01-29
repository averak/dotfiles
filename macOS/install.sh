#!/bin/bash -e


if [ ! -e /usr/local/bin/brew ]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew install git wget curl openssl krb5 re2c bison libxml2 autoconf automake icu4c libjpeg libpng libmcrypt
