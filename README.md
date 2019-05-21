shell-plugins[![Build Status](https://travis-ci.org/gmatheu/shell-plugins.svg)](https://travis-ci.org/gmatheu/shell-plugins)
=======================

How to install
--------------

### With antigen

* Having [antigen](http://github.com/zsh-users/antigen) properly installed, just run:

        antigen bundle gmatheu/zsh-plugins *plugin-name*

Current Plugins
---------------

### fzf

Installs [fzf](https://github.com/junegunn/fzf) (command line fuzzy finder) and provides some functions using it.

#### Functions
  * **cli-launcher**: Allows you to select and launch desktop applications (using [Freedesktop's Destkop Entry](https://specifications.freedesktop.org/desktop-entry-spec/desktop-entry-spec-latest.html) format.)

### git

Git

#### Functions
  * **git_remote_to_https**: Switches git remote url from ssh to https
  * **git_remote_to_ssh**: Switches git remote url from https to ssh
  * **git_switch_remote** or alias **grs**: Toggles git remote url from https to ssh and backwards


### profile-secrets

It allows you to securely keep sensitive variables (api tokens, passwords, etc) as part of your terminal init files. Using [gpg](https://gnupg.org/) to encrypt/decrypt the file with your secrets.

#### Usage
  * Define *GPG_ID* with [gpg](https://gnupg.org/) to encrypt data:

        export GPG_ID=my_gpg_id@gpg.org
  * Create secrets file (by default _~/.profile-secrets/secrets.sh_) is where sensitive data is stored. Calling _profile-secrets-encrypt_ will create it. E.g:

        export GITHUB_TOKEN=123
        export AWS_TOKEN=abc
  * Encrypt secrets file. It will ask for gpg keys password if required:

        profile-secrets-encrypt
  * Add secrets variables to current session:

        profile-secrets-source

##### Encrypt

#### Functions
  * **profile-secrets-decrypt**: Decrypts secret file.
  * **profile-secrets-encrypt**: Encrypts secret file. First time it is called will create secrets file
  * **profile-secrets-source**: Decrypts secrets file, source it and encrypts it back.

### Other Plugins
  * version-managers: Lazy loading and installation of several version managers (rvm, nvm, pyenv, sdkman!)
  * explain-shell: To open commans on explainshell.com
  * dirrc: Execute custom file (.dirrc) when entering a directory
  * docker: Docker aliases and functions
  * notify: OSD Notifier functions

