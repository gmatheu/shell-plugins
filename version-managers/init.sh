#! /bin/bash

# Lazy load nvm and rvm
export NVM_DIR="$HOME/.nvm"
if [ -s "$NVM_DIR/nvm.sh" ]; then
# then
#   function nvm(){
#     echo "Lazy loading nvm..."
#     nvm
#     source "$NVM_DIR/nvm.sh"
#   }
  #Spaceship theme requires node, that's why we need to load NVM eagerly
  source "$NVM_DIR/nvm.sh"
  . "$NVM_DIR/bash_completion"
else
  function install-nvm() {
    echo "Installing nvm"
    mkdir "${NVM_DIR}"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
    unset -f install-nvm
  }
fi

if [[ -s "$HOME/.rvm/scripts/rvm" ]]
then
  export PATH="$HOME/.rvm/bin:$PATH"
  function rvm() {
    echo "Lazy loading rvm..."
    unset -f rvm
    source "$HOME/.rvm/scripts/rvm"
    rvm
  }
else
  function install-rvm() {
    echo "Installing rvm"
    gpg --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
    curl -sSL https://get.rvm.io | bash -s stable
    unset -f install-rvm
  }
fi

export SDKMAN_DIR="${HOME}/.sdkman"
if [[ -s "${SDKMAN_DIR}/bin/sdkman-init.sh" ]]
then
  function sdk {
    echo "Lazy loading sdk..."
    unset -f sdk
    source "${SDKMAN_DIR}/bin/sdkman-init.sh"
    sdk
  }
else
  function install-sdk() {
    echo "Installing SDKman!"
    curl -s "https://get.sdkman.io" | bash
    unset -f install-sdk
  }
fi

export PYENV_ROOT="${HOME}/.pyenv"
if [[ -s "${PYENV_ROOT}/Bin/pyenv" ]]
then
  function pyenv {
    echo "Lazy loading pyenv..."
    unset -f pyenv
    export PATH="${PYENV_ROOT}/bin:$PATH"
    export PYENV_VIRTUALENV_DISABLE_PROMPT=1
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
    pyenv
  }
else
  function install-pyenv() {
    echo "Installing pyenv"
    curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
    pip install --user --upgrade pip
    unset -f install-pyenv
  }
fi

export GVM_DIR="${HOME}/.gvm"
if [[ -s "${GVM_DIR}/scripts/gvm" ]]
then
  function gvm {
    echo "Lazy loading gvm..."
    unset -f gvm
    source "${GVM_DIR}/scripts/gvm"
    gvm $@
  }
else
  function install-gvm() {
    echo "Installing gvm"
    bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
    unset -f install-gvm
  }
fi
