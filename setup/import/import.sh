source ~/.buren/dot-bash/profiles/unix-profile.sh

if [ -f ~/.buren/git-story/src/git_story.sh ]; then
  source ~/.buren/git-story/src/git_story.sh
else
  cd ~/.buren && git clone git@github.com:buren/git-story.git && source ~/.buren/git-story/src/git_story.sh
fi

if [ ! -d ~/.buren/util_scripts/ ]; then
  cd ~/.buren && git clone git clone git@github.com:buren/util_scripts.git
fi

if [ "$(uname)" == "Darwin" ]; then
    source ~/.buren/dot-bash/profiles/osx-profile.sh
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    source ~/.buren/dot-bash/profiles/linux-profile.sh
fi

source ~/.buren/dot-bash/setup/profile-install/unix-profile-install.sh