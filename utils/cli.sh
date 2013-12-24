function buren {
  if  [[ -z "$1" ]]; then
    __buren-help
  else
    __buren_functions "$@"
  fi
}

function __buren_functions {
  if   [[ "$1" == "self-destruct" ]]; then
    __b_self_destruct
  elif [[ "$1" == "update" ]]; then
    __b_update "$2"
  elif [[ "$1" == "setup" ]]; then
    __b_setup "$2"
  else
    echo "Unknown command '$1'"
    __buren-help
  fi
}


###############
#        FUNCTIONS        #
###############

function __b_self_destruct {
  if [[ "$1" == "--help" || "$1" == "-help " ]]; then
    echo "usage:"
    echo -e "\t buren self-destruct"
    echo "removes the script entirely (rm -rf ~/.buren)"
  else
    while true; do
      read -p "Are you sure? (y\n)" yn
      case $yn in
        [Yy]* ) __b_self_destruct_execute "$1"; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
      esac
    done
  fi
}

function __b_self_destruct_execute {
  rm -rf ~/.buren
}

function __b_update {
  if   [[ "$1" == "--help" || "$1" == "-help" ]]; then
    echo "usage:"
    echo -e "\t buren update <pkg>"
    echo "no argument will update all packages"
    echo "available packages: git-story, dot-bash, util-scripts"
  else
    local CURRENT_FOLDER=$(pwd)
    if [ "$1" == "git-story" ]; then
      __b_update_git_story
    elif [ "$1" == "util-scripts" ]; then
      __b_update_util_scripts
    elif [ "$1" == "dot-bash" ];then
      __b_update_dot_bash
    elif [ -z "$1" ]; then
      __b_update_dot_bash
      __b_update_util_scripts
      __b_update_git_story
    fi
    cd $CURRENT_FOLDER
  fi
}

function __b_update_dot_bash {
  echo "Updating dot-bash"
  cd ~/.buren/dot-bash && git pull origin master
}

function __b_update_git_story {
  echo "Updating git-story"
  cd ~/.buren/git-story && git pull origin master
}

function __b_update_util_scripts {
    echo "Updating util_scripts"
    cd ~/.buren/util_scripts && git pull origin master
}

function __b_setup {
  if [[ "$1" == "--help" || "$1" == "-help" ]]; then
    echo "usage:"
    echo -e "\t buren setup <arg>"
    echo "available args: os, defaults"
    echo ""
    echo "Command explaination:"
    echo -e "\t os            Installs packages for current platform"
    echo -e "\t defaults      Sets default values (startup options etc) for current platform"
  elif [ "$1" == "os" ]; then
    __b_setup_os
  elif [[ $1 == "defaults" ]]; then
    __b_setup_defaults
  else
    echo "Unknown option '$1'"
    __b_setup --help
  fi
}

function __b_setup_os {
  if [[ "$(uname)" == "Darwin" ]]; then
    sh ~/.buren/setup/os-install/install-osx.sh
  elif [[ "$(expr substr $(uname -s) 1 5)" == "Linux" ]]; then
    sh ~/.buren/setup/os-install/install-linux.sh
  fi
}

function __b_setup_defaults {
  if [[ "$(uname)" == "Darwin" ]]; then
    echo "Setting up defaults for OSX"
    __setup_osx_defaults
  elif [[ "$(expr substr $(uname -s) 1 5)" == "Linux" ]]; then
    echo "No defaults configured on Linux"
  fi
}


###############
#             HELP            #
###############

function __buren-help {
  echo "usage: "
  echo -e "\t buren update <pkg>"
  echo -e "\t buren self-destruct"
  echo "help:"
  echo -e "\t buren <command> -help"
}
