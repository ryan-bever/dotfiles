# Dotfiles
This repo holds my updated simplified dotfiles repo.

# Install
The install process is idempotent and can be executed again without problem.

~~~
cd
git clone git@github.com:beverku/dotfiles.git .dotfiles
.dotfiles/install.sh
~~~

# Adding new dotfile or directory

~~~
cd ~/.dotfiles
# Add the new dotfile and/or directory
# e.g. For directory and dotfiles
install.sh
~~~


# New Mac Install

## Install Font
Install Meslo powerline font: https://github.com/powerline/fonts/blob/master/Meslo%20Slashed/Meslo%20LG%20M%20Regular%20for%20Powerline.ttf
Install in Terminal 
Preferences -> Profiles -> Text

Install git by typing git in the terminal and installing the developer command line tools


~~~
caffeinate
cd
git clone git@github.com:beverku/dotfiles.git .dotfiles

.dotfiles/newmac_initial.bash
.dotfiles/install.sh
~~~
