echo "Initializing submodules"
echo "======================="

git submodule init
for i in $(git submodule | sed -e 's/.* //'); do
    spath=$(git config -f .gitmodules --get submodule.$i.path)
    surl=$(git config -f .gitmodules --get submodule.$i.url)
	if [ $(echo $spath | grep -c "subtitle") -ne 0 ]; then
		git submodule update --depth 1 -- $spath
	else
		git submodule update --init -- $spath
	fi
done

echo "Installing oh-my-zsh"
echo "===================="
curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh
mv oh-my-zsh ~/.oh-my-zsh

echo "Installing zsh theme"
echo "===================="
mv zsh/themes/* ~/.oh-my-zsh/themes/

echo "Installing zsh plugins"
echo "======================\n\n"
cd zsh
echo "Cloning zsh plugins"
filename="plugins.txt"
while read in; do
	git clone $in
	echo "\n======================================================\n"
done < $filename
cd ..

echo "Installing vim plugins"
echo "======================\n\n"
cd vim
# echo "Installing Pathogen in vim/autoload"
if [ ! -d autoload ]; then
    mkdir autoload
    echo "Created vim/autoload"
fi
if [ ! -d bundle ]; then
    mkdir bundle 
    echo "Created vim/bundle"
fi
echo "Cloning vundle"
echo "==============\n"
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
echo "Done!\n\n"
# echo "Cloning vim plugins"
echo "Installing vundle plugins"
vim +PluginInstall +qall
# filename="plugins.txt"
# while read in; do
# 	git clone $in
# 	echo "\n======================================================\n"
# done < $filename
echo "\nDone!"
echo "\n=========================\n"

if [ -d ~/.vim ]; then
    mv ~/.vim ~/.vim.bak
    echo "WARN: ~/.vim already exists, backing it up"
    echo "Renamed ~/.vim to ~/.vim.bak"
fi
cp -r vim ~/.vim
if [ -d ~/.vimrc ]; then
    mv ~/.vimrc ~/.vimrc.bak
    echo "WARN: ~/.vimrc already exists, backing it up"
    echo "Renamed ~/.vimrc to ~/.vimrc.bak"
fi
mv ~/.vim/vimrc ~/.vimrc

echo "Installing tmux plugins"
echo "===============\n"
cd tmux
echo "Cloning tmux plugins"
filename="plugins.txt"
while read in; do
	git clone $in
	echo "\n=====================================================\n"
done < $filename
cd ..

if [ -d ~/.tmux ]; then
	mv ~/.tmux ~/.tmux.bak
	echo "WARN: ~/.tmux already exists, backing it up"
	echo "Renamed ~/.tmux to ~/.tmux.bak"
fi
cp -r tmux ~/.tmux
if [ -d ~/.tmux.conf ]; then
	mv ~/.tmux.conf ~/.tmux.conf.bak
	echo "WARN: ~/.tmux.conf already exists, backing it up"
	echo "Renamed ~/.tmux.conf to ~/.tmux.conf.bak"
fi
mv ~/.tmux/tmux.conf ~/.tmux.conf

