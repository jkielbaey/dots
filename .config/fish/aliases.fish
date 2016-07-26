alias ..="cd .."
alias -="cd -"

alias l='ls -CF'
alias la="ls -la"
alias ll='ls -hlF'

# List only directories
function lsd --description "List only directories"
    ls -al $argv | grep "^d"
end

# List only symbolic links
function lss --description "List only symbolic links"
    ls -al $argv | grep "\->"
end

################################
###  File ShortCut
################################
alias D="cd ~/Downloads"
alias g="git"
alias v="vim"

################################
###  Program ShortCut
################################

# git related shortcut
alias gd="git diff"
alias gdc="git diff --cached"

function ga --description "Add files to git index"
    git add $argv
end
alias grm="git rm"
alias gc="git commit"
alias gcm="git commit -m"
alias gcr!='git commit -v --amend --no-edit'
alias gbd="git branch -d"
alias gst="git status -sb --ignore-submodules"
alias gm="git merge --log --no-commit"
alias gpl="git pull"
alias gp="git push"
alias gcob="git checkout -b"
alias gco="git checkout"
alias gcp="git cherry-pick"
alias gl="git log"
alias glp="git log --pretty=format:'%h - %an, %ar : %s'"
alias gpom="git pull origin master"
alias glup="git log origin/master..HEAD"
alias gr="git remote -v"
alias glr="git ls-remote"
alias glg="git log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"
alias glg2="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all"
alias gs="git stash"
alias gsl="git stash list"
function gss
  git stash show -p stash@\{$argv[1]\}
end
alias gsal="git stash apply"
function gsa
  git stash apply stash@\{$argv[1]\}
end
function gsd
  git stash drop stash@\{$argv[1]\}
end

# turn on coloring on grep
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Quick check running state of a process
alias psef="ps -ef | grep "

# Add aliases and function per OS.
set OS (uname)
if [ "$OS" = "Darwin" ]
    alias top="top -o cpu"
    alias ps="ps -SAcr -o 'uid,pid,ppid,time,rss,command'"

    function lockme
      /System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend
    end

    # http://osxnotes.net/spotlight.html
    alias spotlight="mdfind"
end


alias history="history | nl | less +G"

alias weather="curl -4 wttr.in/Geraardsbergen"
alias moon="curl -4 wttr.in/Moon"

alias https='http --default-scheme=https'

