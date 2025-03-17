# # ripgrep plugins

 Several functions to help with ripgrep integration


 Requires:

    * rg (ripgrep)
    * fzf to provide fuzzy search


## Functions



## Aliases

* *rg_ignore_candidates_pwd*: 'rb_ignore_candidates "$(pwd)"'
* *rg_ignore*: 'rg_ignore_candidates | head -n 3 | tee -a .ignore'
* *rg_ignore_pwd*: 'rg_ignore_candidates "$(pwd)" | head -n 3 | tee -a .ignore'
