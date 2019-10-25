echo "Setting up the system"

echo "Setting up ~/local folder"
if [ ! -d $HOME/local ]; then
	mkdir $HOME/local
fi

echo "Setting up ~/local/bin folder"
if [ ! -d $HOME/local/bin ]; then
	mkdir $HOME/local/bin
fi

echo "Adding path to bashrc"
echo "export PATH=$HOME/local/bin:$PATH" >> $HOME/.bashrc

echo "Creating folder ~/tools"
if [ ! -d $HOME/tools ]; then
	mkdir $HOME/tools
fi

cd $HOME/tools
echo "In tools"

echo "Downloading tmux"
wget https://github.com/tmux/tmux/releases/download/2.9/tmux-2.9.tar.gz
tar -xvzf tmux-2.9.tar.gz
rm tmux-2.9.tar.gz

echo "Downloading libenvent"
wget http://monkey.org/~provos/libevent-1.4.14b-stable.tar.gz
tar xzf libevent-1.4.14b-stable.tar.gz
rm libevent-1.4.14b-stable.tar.gz
cd libevent-1.4.14b-stable
./configure --prefix=$HOME/local
make -j 8
make install
cd ..
echo "Installed libevent"

echo "Setting up tmux"
cd tmux-2.9
./configure --prefix=$HOME/local LDFLAGS="-L$HOME/local/lib" CFLAGS="-I$HOME/local/include"
make -j 8
make install
cd ..

echo "Downloading zsh"
wget http://www.zsh.org/pub/zsh-5.7.1.tar.xz
# wget -O zsh.tar.xz https://sourceforge.net/projects/zsh/files/latest/download
tar -xvf zsh-5.7.1.tar.xz 
rm zsh-5.7.1.tar.xz

echo "Setting up zsh"
cd zsh-5.7.1/
./configure --prefix=$HOME/local
make -j 8
make install
cd ..

echo "Adding zsh to bashrc"
echo "[ -f $HOME/local/bin/zsh ] && exec $HOME/local/bin/zsh -l" >> $HOME/.bashrc

echo "Setting up libssl"
wget https://www.openssl.org/source/openssl-1.1.1d.tar.gz
tar -xvf openssl-1.1.1d.tar.gz
rm openssl-1.1.1d.tar.gz

cd openssl-1.1.1d
./config --prefix=$HOME/local --openssldir=$HOME/local/ssl shared
make -j 8
make test
make install
#mkdir $HOME/local/ssl/lib
mkdir lib/
#cp ./*.{so,so.1.1,a,pc} $HOME/local/ssl/lib/
cp ./*.{so,so.1.1,a,pc} lib/
cd ..

echo "Setting up python 3.7"
wget https://www.python.org/ftp/python/3.7.4/Python-3.7.4.tgz
tar -xvf Python-3.7.4.tgz
rm Python-3.7.4.tgz

echo "Setting up python3.7.4"
cd Python-3.7.4
#./configure --prefix=$HOME/local --with-ensurepip=install LDFLAGS="-L$HOME/local/lib" CPPFLAGS="-I$HOME/local/include" --with-ssl-default-suites
LD_LIBRARY_PATH=$HOME/local/lib ./configure --prefix=$HOME/local --with-openssl=$HOME/tools/openssl-1.1.1d --with-ensurepip=install
make -j 8
make install
cd ..

echo "Downloading vim 8"
git clone https://github.com/vim/vim.git
cd vim
#./configure --prefix=$HOME/local --with-features=huge --enable-multibyte --enable-pythoninterp=yes --with-python-config-dir=/usr/lib/python2.7/config --enable-python3interp=yes --with-python3-config-dir=/usr/lib/python3.7/config --enable-perlinterp=yes --enable-luainterp=yes --enable-rubyinterp=yes --enable-gui=gtk2 --enable-cscope
./configure --prefix=$HOME/local --with-features=huge --enable-multibyte --enable-pythoninterp=yes --enable-python3interp=yes --with-python3-config-dir=$HOME/local/lib/python3.7/config --enable-perlinterp=yes --enable-luainterp=yes --enable-rubyinterp=yes --enable-gui=gtk2 --enable-cscope
make VIMRUNTIMEDIR=$HOME/local/share/vim/vim81
make install
cd ..
cd ..

echo "Set up tmux zsh and vim"
