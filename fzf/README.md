 # fzf plugin

 Helper functions to work with fzf

 Installs fzf if is not available
 
 Requires: rg (ripgrep) 


## Functions

### fzf 
   Lazy loads fzf and installs it if not present

### cli-launcher 
   Shows and launches gtk application

### edit-fzf 
   Shows fzf and opens selected file with default editor

### grep-fzf 
   Search content, fuzzy search and opens selected file with default editor

### open-fzf 
   Open files with default app selected file
  
   Argumetns: base-directory

### open-dir-fzf 
   Open directories with default file browser
  
   Argumetns: base-directory

### cd-z 
   Finds zoxide or z registered directories and changes directory. 


## Aliases

* *zo*: open-fzf
* *zd*: open-dir-fzf
* *zz*: cd-z
* *ez*: edit-fzf
* *eg*: grep-fzf
* *launcher*: cli-launcher
* *cl*: cli-launcher
