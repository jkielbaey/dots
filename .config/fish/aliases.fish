
# up 'n' folders
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

alias ls="ls -lha"
alias l="ls -CF"
alias la="ls -la"
alias ll="ls -hlF"

# git commands simplified
alias gad="git add ."
alias gc="git commit"
alias gcr!="git commit -v --amend --no-edit"
alias gcom="git checkout master"
alias gcob="git checkout -b"
alias gco="git checkout"
alias gd="git diff"
alias gdc="git diff --cached"
alias gl="git log"
alias glp="git log --pretty=format:'%h - %an, %ar : %s'"
alias glg="git log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"
alias gm="git merge --log"
alias gpl="git pull"
alias gp="git push"
alias gs="git stash"
alias gsl="git stash list"
alias gst="git status"

# turn on coloring on grep
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias history="history | nl | less +G"

alias weather="curl -4 wttr.in/Geraardsbergen"
alias https='http --default-scheme=https'

alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'

alias resetdns='sudo killall -HUP mDNSResponder'

alias vi="nvim"
alias vim="nvim"

# DPP AWS
alias lsec2="aws ec2 describe-instances --query 'Reservations[*].Instances[*].[Tags[?Key==`Name`].Value|[0],Tags[?Key==`Squad`].Value|[0],InstanceId,State.Name,InstanceType,PrivateIpAddress,PublicIpAddress,Placement.AvailabilityZone,ImageId,LaunchTime]' --filters Name=instance-state-name,Values=pending,running,shutting-down,stopping,stopped --output table"
alias lss3="aws s3api list-buckets --query 'Buckets[*].[Name]' --output table"
alias lsefs="aws efs describe-file-systems --query 'FileSystems[*].[Name,FileSystemId,SizeInBytes.Value]' --output table"
alias lsvpcs='aws ec2 describe-vpcs --query "Vpcs[*].{Name:Tags[?Key==`Name`].Value|[0],Squad:Tags[?Key==`Squad`].Value|[0],ID:VpcId,CIDR:CidrBlock,DHCP:DhcpOptionsId,State:State}" --filter "Name=isDefault,Values=false"'
alias lskeypairs="aws ec2 describe-key-pairs --query 'KeyPairs[*]' --output table"
