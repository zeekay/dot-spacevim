#!/usr/bin/env bash
#
# zeekay/vim
#
# My spacevim-based vim configuration.

# Forward ellipsis commands to vim addons
helper() {
    $1

    # run command for each vice installed addon
    for addon in ~/.vim/addons/*; do
        # git status/push only repos which are ours
        if [ $1 = "git.pull" ] || [ "$(cat $addon/.git/config | grep url | grep $ELLIPSIS_USER)" ]; then
            cd $addon
            $1 vim/$(basename $addon)
        fi
    done
}

pkg.install() {
    # install spacevim
    git.clone https://github.com/SpaceVim/SpaceVim $PKG_PATH/spacevim

    # install dependencies
    mkdir -p $PKG_PATH/spacevim/addons && cd $PKG_PATH/spacevim/addons
    git.clone https://github.com/zeekay/vice
    git.clone https://github.com/MarcWeber/vim-addon-manager
    git.clone https://github.com/ternjs/tern_for_vim
    git.clone https://github.com/Shougo/vimproc

    # use vim as git mergetool
    git.add_include '~/.vim/gitinclude'
}

pkg.link() {
    files=(inputrc gvimrc vimrc vimgitrc vimpagerrc xvimrc SpaceVim.d)

    for file in ${files[@]}; do
        fs.link_file $file
    done

    # link spacevim
    fs.link_file $PKG_PATH/spacevim ~/.vim
    fs.link_file $PKG_PATH/spacevim ~/.nvim
    fs.link_file $PKG_PATH/spacevim ~/.config/nvim
    fs.link_file $PKG_PATH/spacevim ~/.SpaceVim
}

pkg.pull() {
    helper git.pull
}

pkg.status() {
    helper git.pull
}

pkg.push() {
    helper git.push
}
