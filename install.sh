#!/usr/bin/env bash

echo "####################################"
echo "Installing dotfiles"
echo "Running this scripts should be Idempotent"
echo "####################################"




DOTFILES_PATH="${HOME}/.dotfiles"
DOTFILES_DOTFILES_PATH="${HOME}/.dotfiles/dotfiles"
DOTFILES_LOCAL_PATH="${DOTFILES_PATH}/local"
DOTFILES_ETC_PATH="${DOTFILES_PATH}/etc"


TOP_LEVEL_FILE_AND_DIR_MODE="TOP_LEVEL_FILE_AND_DIR_MODE"
RECURSIVE_REGULAR_FILE_MODE="RECURSIVE_REGULAR_FILE_MODE"
WITHOUT_SUDO=""
WITH_SUDO="sudo"

make_links() 
{
    link_target_path=$1  # The path to the dotfiles dir to link files from i.e. ~/.dotfiles or ~/.dotfiles/local/{dirname}
    link_dest_path=$2  # The path where the link files should go i.e ~/
    mode=$3
    with_sudo=$4  # with_sudo must be the last argument - as it may be the empty string

    link_target_exists_handling=$LINK_TARGET_EXISTS_HANDLING

    # Note: hosts cannot be symlinked on mac os
    ignore_files="( ! -iname "newmac_initial.bash" ! -iname "install.sh" ! -iname ".git" ! -iname ".gitignore" ! -iname "README.md" ! -iname local ! -iname etc ! -iname manual_install ! -iname "*.swp" ! -iname hosts )"

    if [ "$mode" == "$TOP_LEVEL_FILE_AND_DIR_MODE" ]; then
        echo "Symlinking all top level files and directories from ${link_dest_path} to ${link_target_path}/"
        find ${link_target_path} -maxdepth 1 -mindepth 1 ${ignore_files} -exec ${with_sudo} ln -sv${link_target_exists_handling} {} ${link_dest_path} ';'
    elif [ "$mode" == "$RECURSIVE_REGULAR_FILE_MODE" ]; then 
        echo "Symlinking recursively all regular files from ${link_dest_path} to ${link_target_path}/"
        find ${link_target_path} -type f ${ignore_files} -exec echo ln -sv${link_target_exists_handling} {} ${link_dest_path} ';'
        echo ""

        find ${link_target_path} -type f ${ignore_files} -print0 |
            while IFS= read -r -d $'\0' line; do 
                # Replace dotfile path with link_dest_path i.e. /Users/rbever/.dotfiles/etc/work/{rest-of-path} -> /etc/{rest-of-path}
                new_link_dest_path="${line/$link_target_path/$link_dest_path}"
                ${with_sudo} ln -sv${link_target_exists_handling} ${line} ${new_link_dest_path}
            done
    else
        echo "Unkown link mode ${mode}"
    fi
}




LINK_TARGET_EXISTS_HANDLING=""
while true; do
    read -p "$(echo -e 'If files exist or are already symlinked, do you want to replace?\nAnswer [y]es, [n]o, or [p]rompt: ')" yn
    case $yn in
        [Yy]* ) LINK_TARGET_EXISTS_HANDLING="f"; break;;
        [Nn]* ) LINK_TARGET_EXISTS_HANDLING=""; break;;
        [Pp]* ) LINK_TARGET_EXISTS_HANDLING="i"; break;;
        * ) echo "Please answer: ";;
    esac
done



# Main dotfile symlinks
echo ""
make_links ${DOTFILES_DOTFILES_PATH} ${HOME} ${TOP_LEVEL_FILE_AND_DIR_MODE} ${WITHOUT_SUDO}


# local dotfile symlinks
echo    # move to a new line
read -p "Do you want to install local dotfiles? " -n 1 -r
echo    # move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    printf "Please select local dotfiles folder:\n"
    select d in $(ls ${DOTFILES_LOCAL_PATH}); do test -n "$d" && break; echo ">>> Invalid Selection"; done
    link_path="${DOTFILES_LOCAL_PATH}/${d}"
    make_links ${link_path} ${HOME} ${TOP_LEVEL_FILE_AND_DIR_MODE} ${WITHOUT_SUDO}
fi

# /etc
echo    # move to a new line
read -p "Do you want to install /etc files? " -n 1 -r
echo    # move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    sudo -v
    printf "Please select etc dotfiles folder:\n"
    select d in $(ls ${DOTFILES_ETC_PATH}); do test -n "$d" && break; echo ">>> Invalid Selection"; done
    link_path="${DOTFILES_ETC_PATH}/${d}"
    make_links ${link_path} /etc ${RECURSIVE_REGULAR_FILE_MODE} ${WITH_SUDO}

    # Special handling for hosts file - use hard link
    # Note: hosts cannot be symlinked on mac os
    hosts_link_path="${DOTFILES_ETC_PATH}/${d}/hosts"
    if [ -f ${hosts_link_path} ]; then
        echo ""
        echo "Hard linking hosts file /etc/hosts to ${hosts_link_path}"
        sudo ln -v${LINK_TARGET_EXISTS_HANDLING} ${hosts_link_path} /etc/hosts
    fi
fi


# mac os customizations
echo    # move to a new line
read -p "Do you want to source macos customizations? " -n 1 -r
echo    # move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    source "${HOME}/.macos"
fi


