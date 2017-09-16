echo start
# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

#use mvim instead of vim to get updates
alias vim='mvim -v'

alias watch='sh ~/bin/maven-watch.sh'
alias run='sh ~/bin/run-spring.sh'

#docker alias
alias drm="docker rm"
alias dps="docker ps"

function dup() {
  sh ~/bin/docker-compose.sh
}

alias ddn="docker-compose down"
alias dbd="docker-compose build"

function gitdiff() {
  git diff --no-prefix -U1000 $1
}

function docker-stop-remove() {
  docker stop $1 && docker rm $1
}
function docker-ip() {
  docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $1
}

function mvndcbuild() {
  mvn clean package && docker-compose build
}
function mvndcup() {
  mvn clean package && docker-compose build && docker-compose up -d
}
function dockerbuild() {
  mvn clean package docker:build
}
function dexec() {
  docker exec -it $1 /bin/sh -c "export TERM=xterm; exec sh"
}
function copyWar() {
  cp **.war $CATALINA_HOME/webapps
}
function tomcatstart() {
  sh $CATALINA_HOME/bin/startup.sh
}
function tomcatstop() {
  sh $CATALINA_HOME/bin/shutdown.sh
}

function rumble() {
  perl ~/bin/rumbleready
}

function ap() {
    groovy ~/bin/bin/atom-project.groovy $@
}

function diffpipe() {
  # compare the pipe tmp files
  diff /tmp/atom-project-tmp /tmp/atom-project-tmp2 >> project-tmp.patch
  groovy ~/bin/bin/atom-project.groovy -f /tmp/project-tmp.batch
}

function pipe2() {
  # find better way that doesn't need this
   echo "" >> /tmp/atom-project-tmp2
   MY_INPUT=$(</dev/stdin)
   echo $MY_INPUT > /tmp/atom-project-tmp2
   groovy ~/bin/bin/atom-project.groovy -n /tmp/atom-project-tmp2
}

function pipe() {
  # ability to pipe to multiple files instead of pipe2 and ability to open or not open app
   echo "" >> /tmp/atom-project-tmp
   MY_INPUT=$(</dev/stdin)
   echo $MY_INPUT > /tmp/atom-project-tmp
   groovy ~/bin/bin/atom-project.groovy -n /tmp/atom-project-tmp
}

function rumbler() {
 perl /apps/gitlab/dev-scripts/rumbler/rumbler $@
}

# Git alias
function gitpullbranch () {
  CURRENT_BRANCH=$(git branch | grep \* | cut -d ' ' -f2)
  git checkout $1
  git pull
  git checkout $CURRENT_BRANCH
}
function gitpullmaster () {
  CURRENT_BRANCH=$(git branch | grep \* | cut -d ' ' -f2)
  git checkout master
  git pull
  git checkout $CURRENT_BRANCH
}
function newbox () {
  docker run --name $1 --volumes-from=volume_container -it -v /var/run/docker.sock:/var/run/docker.sock -e BOX_NAME=$1 jhendricks/devbox
}

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"
ZSH_THEME="agnoster2"
#ZSH_THEME="agnoster"

#keybinds
bindkey "[C" forward-word
bindkey "[D" backward-word


DEFAULT_USER="jhendricks"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git mvn brew sbt npm history node bower spring docker docker-compose)

# User configuration
export JAVA_HOME=$(/usr/libexec/java_home)
export SIR_DEV=/Users/jhendricks/files/dev
export M2_HOME=$SIR_DEV/maven
export GROOVY_HOME=/usr/local/opt/groovy/libexec
export GRADLE_HOME=$SIR_DEV/gradle/current
export ANT_HOME=$SIR_DEV/ant
export PYTHONPATH=/usr/local/lib/python2.7/site-packages/
export MYSQL_HOME=/usr/local/mysql
# export PYTHONPATH=/usr/local/Cellar/python3/3.4.3
export CATALINA_HOME=/Users/jhendricks/files/dev/tools/tomcats/apache-tomcat-7.0.62
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$MYSQL_HOME/bin:$M2_HOME/bin:$SIR_DEV/bin:$ANT_HOME/bin:$GROOVY_HOME/bin:$GRADLE_HOME/bin:/Users/jhendricks/files/dev/scripts/bin:$PATH

# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

export EDITOR='vim'

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Allow mvn to happen in another directory
#function mvn-there() {
#  DIR="$1"
#  shift
#  (cd $DIR; mvn "$@")
#}
#

alias re='sudo $(fc -ln -1)'

alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'

#Call mvn in multiple repositories
function mvn-there() {
  groovy ~/files/dev/groovy-scripts/mvnthere.groovy $@
}
function gits() {
  sh ~/files/dev/groovy-scripts/gitthere.sh $@
}

function luke() {
  (cd ~/files/dev/tools/luke && ./luke.sh)
}

go() { cd /apps/$1; }
    _go() { _files -W /apps -/; }
    compdef _go go




#David's script for quickly sshing into sandboxes
function sb() {
	if [ -z "$1" ] ; then
	  echo "Usage: `basename $0` <host|number>"
	  exit -1
	fi

	host=$1
	if [ "$host" = "${host//[^0-9]/}" ] ; then
	 host=dsandpr$(printf "%03d" $host)
	fi

	ssh sandbox@$host
}

function diff-branch () {
	sh ~/files/dev/scripts/git-diff-branch.sh $@
}
function dt () {
	sh ~/files/dev/scripts/git-difftool-branch.sh $@
	#groovy ~/files/dev/groovy-scripts/git-diff-branch.sh $@
}
function reload() {
	source ~/.zshrc
}

local knownhosts
knownhosts=( ${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[0-9]*}%%\ *}%%,*} )
zstyle ':completion:*:(ssh|scp|sftp):*' hosts $knownhosts

rg()
{
    filepat="$1"
    pat="$2"
    shift 2
    grep -Er --include=$filepat $pat ${@:-.}
}

#Instead of doing cd ~/Somefolder/Anotherfolder/project/, you can just do z proj
. `brew --prefix`/etc/profile.d/z.sh


function findgrep-atom()
{
filepat="$1"
pat="$2"
find . -name $filepat -type f -exec grep -nl $pat {} \; | open -fa /Applications/Atom.app
}
function findgrep-copy()
{
filepat="$1"
pat="$2"
find . -name $filepat -type f -exec grep -nl $pat {} \; | pbcopy
}
# In Zsh, 'noglob' turns off globing.
# (e.g, "noglob echo *" outputs "*")
alias rg='noglob rg'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Add autocompletion for docker
fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit && compinit -i

source ~/.xsh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
echo end
