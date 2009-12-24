cd ~/devel/vim7
make distclean
svn revert --recursive *
svn up
curl http://jordanlewis.org/code/persistent_undo.diff | patch -p0
./configure --without-x --disable-gui --disable-xim --disable-darwin --enable-perlinterp --enable-multibyte
make
sudo make install

