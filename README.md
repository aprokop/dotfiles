# local\_configs

### vim

1. Create a symbolic links for vim:

    ```bash
    $ ln -s local_configs/.vimrc ~/.vimrc
    $ ln -s local_configs/.vim   ~/.vim
    $ mkdir -p ~/.vim/bundle
    ```

2. Set up [Vundle](https://github.com/VundleVim/Vundle.vim):

    `$ git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/vundle.vim`

3. Launch `vim` and run `:PluginInstall`

4. Compile `YouCompleteMe`:

    ```bash
    $ cd ~/.vim/bundle/youcompleteme
    $ cd ./install.py --clang-completer
    ```

### Other configs

    $ ln -s local_configs/<specific_config> ~

Some configs may go to the corresponding dir. For instance, for `mplayer` do

    $ ln -s local_configs/.mplayer/config ~/.mplayer/config
