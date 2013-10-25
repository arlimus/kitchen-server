#!/bin/sh

[[ $# -ne 1 && $# -ne 2 ]] && \
  echo "usage: ./setup.sh <host> [<config_suffix>]" && \
  echo "       ./setup.sh 192.168.200.204" && \
  echo "       ./setup.sh 192.168.200.204 ext" && \
  exit 0

SSHHOST="$1"
HOST="$(echo $SSHHOST | sed 's/.*@//')"
echo "setting up for host: ${HOST}"

# get base config files
BASE="example"
SUFFIX=$( [[ -z "$2" ]] && echo "" || echo "_$2" )
NODE_ORG="nodes/example${SUFFIX}.json"
NODE_CONF="nodes/${HOST}.json"
USER_ORG="data_bags/users/example${SUFFIX}.json"

[ ! -f "$NODE_ORG" ] && echo "Can't find file ${NODE_ORG}, aborting." && exit 1
[ ! -f "$USER_ORG" ] && echo "Can't find file ${USER_ORG}, aborting." && exit 1

# get ssh config
SSHKEY_PATH="${HOME}/.ssh/id_rsa.pub"
[ ! -f "$SSHKEY_PATH" ] \
  && echo "Can't find your ssh key in ${SSHKEY_PATH}. continuing without it..." \
  || SSHKEY="$(cat ${SSHKEY_PATH} | tr -d "\n")" \
  && echo "using ssh key from: ${SSHKEY_PATH}"

# create the node configuration
NEW_USER="$(cat "$USER_ORG" | grep '"id"' | grep -o '\"[^"]*\"' | tr -d '"' | tail -n1)"
echo "-- the new user will be: ${NEW_USER}"

sed "s;.*ssh_keys.*;ssh_keys\":[\"${SSHKEY}\"];" -i "$USER_ORG"
echo "++ added ssh key to user ${NEW_USER}"

cp "$NODE_ORG" "${NODE_CONF}"
echo "++ created node configuration in ${NODE_CONF}"

sed 's;.*users.*;"users":["'${NEW_USER}'"],;' -i "${NODE_CONF}"
echo "++ added user ${NEW_USER} to node configuration"

echo "-- starting knife solo"
knife solo bootstrap $SSHHOST

echo ""
echo "done, you can now:"
echo "  ssh ${NEW_USER}@${HOST}"