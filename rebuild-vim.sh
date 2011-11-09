cd ~/devel/vim

make distclean
hg pull
hg update -C

./configure --without-x --disable-gui --disable-xim --disable-darwin --enable-perlinterp --enable-rubyinterp --enable-pythoninterp --enable-multibyte
make

sudo make install

