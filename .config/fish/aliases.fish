
alias ls="ls -lha"

# git commands simplified
alias gc="git commit"
alias gl="git log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"
alias gm="git merge --log"
alias gpl="git pull --prune"
alias gp="git push"
alias gpt="git push --tags"
alias gst="git status -s"

# turn on coloring on grep
alias grep='grep --color=auto'

alias history="history | nl | less +G"

alias weather="curl -4 wttr.in/Geraardsbergen"

alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'

alias myip="dig +short myip.opendns.com @resolver1.opendns.com"
