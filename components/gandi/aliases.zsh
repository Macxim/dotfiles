#!/bin/zsh

export GPAAS_HOST="dc0.gpaas.net"
export GPAAS_SFTP_HOST="sftp.$GPAAS_HOST"
export GPAAS_SSH_HOST="console.$GPAAS_HOST"
export GPAAS_GIT_HOST="git.$GPAAS_HOST"
export GPAAS_GIT_URL="git+ssh://$MY_GPAAS_USER@$MY_GPAAS_GIT/"
#GPAAS_SFTP="$GPAAS_SFTP_HOST"
alias gpaas_ssh="ssh $1@$GPAAS_SSH_HOST"
