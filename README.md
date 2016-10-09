# local\_configs

### .vimrc

1. Create a symbolic links for vim:

    `$ ln -s local_configs/.vimrc ~/.vimrc`

    `$ ln -s local_configs/.vim ~/.vim`

2. Set up [Vundle](https://github.com/VundleVim/Vundle.vim):

    `$ git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim`

3. Launch `vim` and run `:PluginInstall`

### Other configs

`cd $HOME && $ ln -s local_configs/<specific_config> .`

Some configs may go to the corresponding dir. For instance, for `mplayer` do
`cd $HOME/.mplayer/ && ln -s local_configs/.mplayer/config .`
