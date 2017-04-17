
# up 'n' folders
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

alias ls='ls -lhaG'
alias l='ls -CF'
alias la="ls -la"
alias ll='ls -hlF'
alias lsd='ls -l | grep --color=never "^d"'
alias lss='ls -al | grep --color=never "\->"'

# git commands simplified
alias gst='git status'
alias gc='git commit'
alias gcm='git commit -m'
alias gpl='git pull'
alias gp='git push'
alias gd="git diff"
alias gdc="git diff --cached"
alias gad='git add .'
alias gcm='git checkout master'
alias gm='git merge --no-commit --log'
alias gcob="git checkout -b"
alias gco="git checkout"
alias gl="git log"
alias glp="git log --pretty=format:'%h - %an, %ar : %s'"
alias glr="git ls-remote"
alias glg="git log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"
alias glg2="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all"
alias grm="git rm"
alias gcr!='git commit -v --amend --no-edit'
function ga --description "Add files to git index"
    git add $argv
end
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

alias history="history | nl | less +G"

alias weather="curl -4 wttr.in/Geraardsbergen"
alias moon="curl -4 wttr.in/Moon"
alias https='http --default-scheme=https'

alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'


# DPP AWS
#alias lsec2="aws ec2 describe-instances --query 'Reservations[*].Instances[*].[Tags[?Key==`Name`].Value|[0],Tags[?Key==`Squad`].Value|[0],InstanceId,State.Name,InstanceType,PrivateIpAddress,PublicIpAddress,Placement.AvailabilityZone,ImageId,LaunchTime]' --filters Name=instance-state-name,Values=pending,running,shutting-down,stopping,stopped --output table"
#alias lsec2s="aws ec2 describe-instances --query 'Reservations[*].Instances[*].[Tags[?Key==`Name`].Value|[0],InstanceId,State.Name,InstanceType,PrivateIpAddress,PublicIpAddress,SubnetId,Placement.AvailabilityZone,ImageId,LaunchTime]' --filters Name=instance-state-name,Values=pending,running,shutting-down,stopping,stopped --output table"
#alias lsami="aws ec2 describe-images --query 'Images[*].[Tags[?Key==`Name`].Value|[0],Name,ImageId,State,CreationDate]' --filters Name=image-type,Values=machine Name=is-public,Values=false --output table"
#alias lss3="aws s3api list-buckets --query 'Buckets[*].[Name]' --output table"
#alias lsefs="aws efs describe-file-systems --query 'FileSystems[*].[Name,FileSystemId]' 
