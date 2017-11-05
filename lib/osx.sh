#!/usr/bin/env bash

function install_osx_packages() {
  _install_brew
  _install_brew_cask
  _install_gem
  _install_pip
  _install_atom
  _setup_osx
}

function _setup_osx() {
  bot "Setting up osx ..."

  # show full paths in Finder
  defaults write com.apple.finder _FXShowPosixPathInTitle -bool YES

  # Disable and kill Dashboard
  defaults write com.apple.dashboard mcx-disabled -boolean YES

  # Show all file extensions on Finder
  defaults write NSGlobalDomain AppleShowAllExtensions -bool true

  # Disable natural trackpad scrolling (TODO however it seems it does not work)
  defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

  # Don't automatically rearrange Spaces
  defaults write com.apple.dock mru-spaces -bool false

  # Set column view as preferred Finder view
  defaults write com.apple.finder FXPreferredViewStyle -string 'clmv'

  # Search the current folder by default
  defaults write com.apple.finder FXDefaultSearchScope -string 'SCcf'

  # Remove all applications from Dock
  defaults write com.apple.dock persistent-apps -array

  # Set bottom right hot corner to show/hide desktop
  defaults write com.apple.dock wvous-br-corner -int 4
  defaults write com.apple.dock wvous-br-modifier -int 0

  # Update clock to show current date and current day of the week
  defaults write com.apple.menuextra.clock DateFormat 'EEE MMM d  h:mm a'

  # Show the ~/Library directory in Finder
  chflags nohidden "${HOME}/Library"

  # Show finder status bar
  defaults write com.apple.finder ShowStatusBar -bool true

  killall Dock Finder SystemUIServer

  installation_mode=$(get_installation_mode)
  if [ $installation_mode == "install" ]; then

    # Install the Solarized Dark theme for iTerm
    open "${DOTFILES_DIR}/iterm/themes/Solarized Dark.itermcolors"
  fi
}

# [Some brew commands]
# brew outdated -> list outdated packages
# brew upgrade -> upgrade all
# brew pin mysql -> keep mysql packages to the current version to avoid upgrading it
# brew upgrade mysql
function _install_brew() {
  bot "Checking brew packages ..."

  # install homebrew
  which -s brew
  if [[ $? != 0 ]] ; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  else
    brew update
  fi

  # Install brew packages
  for pkg in ${BREW_APPS[@]}; do
    if brew list -1 | grep -q "^${pkg}\$"; then
      ok "[brew] Package '$pkg' is already installed"

      # Checking if the package needs update
      if brew outdated --quiet | grep -q "^${pkg}\$"; then
        warn "[brew] Package '$pkg' is not up to date, updating it ..."
        brew upgrade "$pkg"
      fi
    else
      warn "[brew] Package '$pkg' is not installed"
      if [ $pkg == "vim" ]; then
        brew install "$pkg" --with-lua
      fi
      brew install "$pkg"
    fi
  done
  unset BREW_APPS

  if vim --version | egrep -q '\-lua'; then
    error "[brew] Vim package installed without lua support. Lua support is needed for some plugins. Run:"
    error "brew unlink vim"
    error "brew install vim --with-lua"
  fi

  ok
}
#brew install pkg-config
#brew install pandoc
#brew install chrome-cli

function _install_brew_cask() {
  bot "Checking brew cask packages ..."

  # Install Caskroom
  brew tap caskroom/cask
  brew tap caskroom/versions

  # Install brew cask packages
  for pkg in ${BREW_CASK_APPS[@]}; do
    if brew cask list -1 | grep -q "^${pkg}"; then
      ok "[brew cask] Package '$pkg' is already installed"

      # Checking if the package needs update
      if brew cask outdated --quiet | grep -q "^${pkg}"; then
        warn "[brew cask] Package '$pkg' is not up to date, updating it ..."
        brew cask reinstall "$pkg"
      fi
    else
      warn "[brew cask] Package '$pkg' is not installed"
      brew cask install "$pkg"
    fi
  done
  unset BREW_CASK_APPS

  ok
}

function _install_gem() {
  bot "Checking gem packages ..."

  # Install gem apps
  for pkg in ${GEM_APPS[@]}; do
    if gem list | grep "^${pkg}"; then
      ok "[gem] Package '$pkg' is already installed"
    else
      warn "[gem] Package '$pkg' is not installed"
      gem install "$pkg"
    fi
  done
  unset GEM_APPS

  ok
}

function _install_pip() {
  bot "Checking pip packages ..."

  which -s pip
  if [[ $? != 0 ]] ; then
    bot "Going to install pip, if it does not work, maybe it's because the command needs sudo"
    easy_install pip
  else
    pip install --upgrade pip
  fi

  # Install pip apps
  for pkg in ${PIP_APPS[@]}; do
    if pip list --format=legacy | grep "^${pkg}"; then
      ok "[pip] Package '$pkg' is already installed"

      # Checking if the package needs update
      if pip list --outdated --format=legacy | grep "^${pkg}"; then
        warn "[pip] Package '$pkg' is not up to date, updating it ..."
        pip install "$pkg" --upgrade
      fi

    else
      warn "[pip] Package '$pkg' is not installed"
      pip install "$pkg" --user
    fi
  done
  unset PIP_APPS

  ok
}

function _install_atom_packages() {
  for pkg in ${ATOM_PACKAGES[@]}; do
    if [[ ! -d "$HOME/.atom/packages/$pkg" ]]
    then
      warn "[atom] Package '$pkg' is not installed"
      apm install $pkg
    else
      ok "[atom] Package '$pkg' is already installed"
    fi
  done
  unset ATOM_PACKAGES
}

function _install_atom() {
  bot "Checking atom packages ..."

  if ! test $(which atom)
  then
    error "atom not installed"
  else
    _install_atom_packages
  fi

  ok
}
