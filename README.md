# system setup

# roles

## system

base os configuration
  * create users and copy ssh keys
  * package manager configuration & system update


## dotfiles

# install ansible modules
ansible-galaxy collection install community.general
ansible-galaxy install kewlfft.aur


# an atom search & replace
#(package: \w+=)(\{\{ item \}\}) (state=present)
#$1$2 $3 use="{{ package_manager }}"
