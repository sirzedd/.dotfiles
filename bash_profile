export SIR_DEV=/Users/jhendricks/files/dev

export M2_HOME=$SIR_DEV/maven
export JAVA_HOME=$(/usr/libexec/java_home)
source ~/.xsh

export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$M2_HOME/bin:$JAVA_HOME/bin:$PATH

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/jhendricks/.sdkman"
[[ -s "/Users/jhendricks/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/jhendricks/.sdkman/bin/sdkman-init.sh"
