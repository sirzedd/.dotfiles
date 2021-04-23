echo start

source ~/.zsh_functions_aws

# export JAVA_HOME=$(/Users/user/.sdkman/candidates/java/current)

export MYSQL_HOST=127.0.0.1
export MYSQL_USER=local 
export MYSQL_PASSWD=local

# export M2_HOME=/Users/user/.sdkman/candidates/maven/current
export SIR_DEV=/Users/user/

export PATH=$HOME/bin:/usr/local/bin:/usr/local/opt/python/libexec/bin:$SIR_DEV/bin:$MAVEN_HOME/bin:$SDKMAN_HOME/bin:$PATH



# Path to your oh-my-zsh installation.
export ZSH="/Users/user/.oh-my-zsh"


alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'


alias tf='docker run --rm -it --name terraform -v $(pwd):/workspace -w /workspace hashicorp/terraform:0.12.29 $@'

# https://developer.apple.com/forums/thread/79056
# ~/files/dev/tools/telnet
alias telnet="docker run -it tools /usr/bin/telnet"

function reload() {
	source ~/.zshrc
}

function gw() {
    ./gradlew $@
}

function dcdn-removeall() {
  docker-compose down --rmi=all -v
}

# function terraform() {
#     docker run --rm -it --name terraform -v $(pwd):/workspace -w /workspace hashicorp/terraform:0.12.29 terraform $@
# }

function ap() {
  if [[ $@ == *"-p"* ]]; then
    MY_INPUT=$(</dev/stdin)
    echo $MY_INPUT > /tmp/atom-project-tmp.diff
    groovy ~/bin/atom-project.groovy -f /tmp/atom-project-tmp.diff
  else
    groovy ~/bin/atom-project.groovy $@
  fi
}

function training_db_tunnel() {
  ssh -N -L 3307:myyesgo-training.cj80xk4fiykk.us-east-2.rds.amazonaws.com:3306 jhendricks@3.14.159.195
}

function cbc_db_tunnel() {
    ssh -i ~/.ssh/id_rsa jhendricks@3.14.159.195 -L 9090:credit-bureau.cj80xk4fiykk.us-east-2.rds.amazonaws.com:5432
}


local knownhosts
knownhosts=( ${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[0-9]*}%%\ *}%%,*} )
zstyle ':completion:*:(ssh|scp|sftp):*' hosts $knownhosts


# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster2"

DEFAULT_USER="user"
# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

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
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git mvn gradle brew npm history node spring docker docker-compose aws jfrog)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!! 
# export SDKMAN_DIR="/home/USER/.sdkman" [[ -s "/home/USER/.sdkman/bin/sdkman-init.sh" ]] && source "/home/USER/.sdkman/bin/sdkman-init.sh"
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/user/.sdkman"
[[ -s "/Users/user/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/user/.sdkman/bin/sdkman-init.sh"

echo loaded
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"


autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform
