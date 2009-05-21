cd ~/app/vim7
make distclean
svn revert --recursive *
svn up
cd src
curl http://jordanlewis.org/code/persistent_undo.diff | patch -p0
cd ..
./configure --without-x --disable-gui --disable-xim --disable-darwin --enable-perlinterp
make
sudo make install

