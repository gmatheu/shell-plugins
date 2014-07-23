zsh-explain-shell
=======================

**Handy functions for [Zsh](http://www.zsh.org) to explain commands using
    [http://www.explainshell.com](Explain Shell).**

*Requirements: zsh

How does it work
----------------

Running `explain-command` or `explain` will open a browser on [http://www.explainshell.com](Explain Shell)
explaining the command given as argument.
> E.g: explain-command fs aux

`explain-last` and `explain-last-command` will explain the last command.


How to install
--------------

### In your ~/.zshrc

* Download the script or clone this repository:

        git clone git://github.com/gmatheu/zsh-explain-shell.git

* Source the script **at the end** of `~/.zshrc`:

        source /path/to/zsh-explain-shell/zsh-explain-shell.zsh

* Source `~/.zshrc`  to take changes into account:

        source ~/.zshrc


### With oh-my-zsh

* Download the script or clone this repository in [oh-my-zsh](http://github.com/robbyrussell/oh-my-zsh) plugins directory:

        cd ~/.oh-my-zsh/custom/plugins
        git clone git://github.com/gmatheu/zsh-explain-shell.git

* Activate the plugin in `~/.zshrc` (in **last** position):

        plugins=( [plugins...] zsh-explain-shell)

* Source `~/.zshrc` to take changes into account:

        source ~/.zshrc

