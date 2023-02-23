#! /bin/bash
## # zplug-helper plugin
##
## Provides functions to show plugin on Markdown format
##
## Requires: fzf and/or gum to provide fuzzy search

export BASE_DIR=$ZPLUG_HOME/repos
to_skip=("oh-my-zsh" "spaceship")

zplug-plugin-help () {
  ### Looks for all plugins with README.md files and shows the selected one content
  findargs=()
  for i in "${to_skip[@]}"; do
       findargs+=('-not' '-path' '*'"$i*"'*')
  done
  find_cmd=$(echo find ${BASE_DIR} -mindepth 4 -name 'README.md' -and "${findargs[@]}" )
  if [ ! -z "${DEBUG}" ]
  then
    echo "Find command ->" ${find_cmd}
  fi
  help_dir=$(find ${BASE_DIR} -mindepth 4 -name 'README.md' -and "${findargs[@]}" | xargs -I {} dirname {} | sort | uniq | fzf)
  cat ${help_dir}/README.md | gum format
}

alias zh=zplug-plugin-help

if [ ! -z "${DEBUG}" ]
then
  zplug-plugin-help
fi
