abbr -a ls exa -lha --group-directories-first --git --icons
abbr -a cat bat
abbr -a find fd
abbr -a tree exa -Tl
abbr -a htop btm -bTg --color nord
abbr -a vim nvim
abbr -a vi nvim

abbr -a brew_full_update "brew update; echo '== OUTDATED ====='; brew outdated --greedy --quiet; echo '=============='; brew upgrade (brew outdated --greedy --quiet); brew cleanup -s"
abbr -a brew_graph_installed "brew graph --highlight-outdated --installed | dot -Tpng -o/var/tmp/graph.png; open /var/tmp/graph.png"

# git commands simplified
abbr -a gc git commit
abbr -a gl git log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all
abbr -a gm git merge --log
abbr -a gpl git pull --prune
abbr -a gp git push
abbr -a gpt git push --tags
abbr -a gst git status -s

# turn on coloring on grep
abbr -a grep grep --color=auto

abbr -a history "history | nl | less +G"

abbr -a weather curl -4 wttr.in/Geraardsbergen

abbr -a showFiles "defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app"
abbr -a hideFiles "defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app"

abbr -a myip dig +short myip.opendns.com @resolver1.opendns.com

# Docker aliases
abbr -a docker_prune docker system prune --volumes -f
