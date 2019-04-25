function fzf() {
  unset -f fzf
  [ ! -d ~/.fzf ] \
    && echo "Cloning fzf repo" \
    && git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf \
    && $HOME/.fzf/install --no-update-rc
  [ -f ~/.fzf.zsh ] \
    && source ~/.fzf.zsh
  fzf
}
function cli-launcher() {
  application=$(find /usr/share/applications -name '*.desktop' -printf "%f\n" | cut -d '.' -f 1 | fzf)
  gtk-launch $application 2>&1 > /dev/null & disown
}
alias launcher=cli-launcher
alias cl=cli-launcher
