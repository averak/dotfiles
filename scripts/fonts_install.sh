#!/usr/bin/env bash

# install Source Code Pro
wget https://github.com/adobe-fonts/source-code-pro/archive/2.010R-ro/1.030R-it.zip
unzip 1.030R-it.zip
mkdir -p ~/.fonts
cp source-code-pro-2.010R-ro-1.030R-it/OTF/*.otf ~/.fonts/
fc-cache -f -v

# install Nerd Fonts
git clone --branch=master --depth 1 https://github.com/ryanoasis/nerd-fonts.git
cd ./nerd-fonts
./install.sh SourceCodePro

# cleanup
cd -
rm -rf 1.030R-it.zip
rm -rf source-code-pro-2.010R-ro-1.030R-it
rm -rf ./nerd-fonts

echo ""
echo "Sucessfully installed fonts."
