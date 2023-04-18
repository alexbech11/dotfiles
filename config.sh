#!/usr/bin/env bash

declare -a FILES_TO_SYMLINK=(
  'git/gitignore'
  'git/gitconfig'
  'misc/isort.cfg'
  'vim'
  'vim/vimrc'
  'zsh/zpreztorc'
  'zsh/scripts'
  'zsh/zshrc'
  'zsh/p10k.zsh'
)

declare -a BINARIES=()

declare -a BREW_APPS=(
  ack
  awscli
  coreutils
  docker
  fasd
  gh
  git
  gnupg # To generate GPG keys for github (https://help.github.com/articles/generating-a-new-gpg-key/)
  gradle
  gradle-completion
  htop
  java11
  jenv
  jq
  node
  nvm
  openssl
  openvpn
  perl-build
  perltidy
  pinentry-mac
  plenv
  vim
  yarn
  pyenv
)

declare -a APT_GET_APPS=(
  build-essential # Needed by linuxBrew
  curl # Needed by linuxBrew
  file # Needed by linuxBrew
  git # Needed by linuxBrew
  default-jdk
)

declare -a BREW_CASK_APPS=(
  docker
  firefox
  intellij-idea-ce
  iterm2
  postman
  spotify
  leapp
  visual-studio-code
  google-chrome
  mongodb-compass
)

declare -a GEM_APPS=(
)

declare -a PIP_APPS=(
  Pygments
  databricks
  databricks-cli
  dbx
  autopep8
)

declare -a YARN_APPS=(
  
)

declare -a NPM_PACKAGES=(
  eslint # Needed to check js code on vscode
  npm-check-updates # Needed to check if the other packages are up to date
  serverless@2.67.0
)

declare -a VSCODE_PACKAGES=(
  alefragnani.project-manager
  apollographql.vscode-apollo
  atlassian.atlascode
  brpaz.file-templates
  byi8220.indented-block-highlighting
  dbaeumer.vscode-eslint
  eamodio.gitlens
  esbenp.prettier-vscode
  foxundermoon.shell-format
  GitHub.vscode-pull-request-github
  Gruntfuggly.todo-tree
  hediet.vscode-drawio
  IronGeek.vscode-env
  janisdd.vscode-edit-csv
  JerryHong.autofilename
  johnpapa.vscode-peacock
  Kaktus.perltidy-more
  mathiasfrohlich.Kotlin
  mechatroner.rainbow-csv
  mohsen1.prettify-json
  ms-azuretools.vscode-docker
  ms-python.isort
  ms-python.python
  ms-python.vscode-pylance
  ms-toolsai.jupyter
  ms-toolsai.jupyter-keymap
  ms-toolsai.jupyter-renderers
  ms-toolsai.vscode-jupyter-cell-tags
  ms-toolsai.vscode-jupyter-slideshow
  nsfilho.tosnippet
  PKief.material-icon-theme
  RandomFractalsInc.vscode-data-table
  redhat.java
  redhat.vscode-commons
  redhat.vscode-yaml
  RoscoP.ActiveFileInStatusBar
  secanis.jenkinsfile-support
  sfodje.perlcritic
  VisualStudioExptTeam.intellicode-api-usage-examples
  VisualStudioExptTeam.vscodeintellicode
  vncz.vscode-apielements
  vscjava.vscode-java-debug
  vscjava.vscode-java-test
  vscjava.vscode-lombok
  yzhang.markdown-all-in-one
)

declare -a APP_STORE_APPS=(
  # Please note that it won't allow you to install (or even purchase) an app for the first time: it must already be in the Purchased tab of the App Store, so download it manually first
)

# Check vim/plugins.vim for enabled plugins
# Check setup_osx function from lib/osx.sh for osx defaults
