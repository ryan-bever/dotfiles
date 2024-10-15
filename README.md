# Dotfiles
This repo holds my updated simplified dotfiles repo.

# Install
The install process is idempotent and can be executed again without problem.

~~~
cd
git clone git@github.com:ryan-bever/dotfiles.git .dotfiles
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
Install git by typing git in the terminal and installing the developer command line tools


~~~
caffeinate
cd
git clone git@github.com:ryan-bever/dotfiles.git .dotfiles
# See dotfiles-local README.md for linking local files first

.dotfiles/newmac_initial.bash
.dotfiles/install.sh

Set iterm and terminal to use Hack Nerd Font Mono
~~~

Download and install Visual Studio Code
**When signing into settings sync. Make sure to sign in to Microsoft nv account, not github.**
Github can still be signed into, afterwards, to enable co-pilot.
