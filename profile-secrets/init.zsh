#! /bin/sh

export SECRETS_HOME=$HOME/.profile-secrets
export SECRETS_FILE=$SECRETS_HOME/secrets.sh
ENCRYPTED_SECRETS_FILE=$SECRETS_FILE.asc

_verify_gpg_id_env_var () {
  if [ -z $GPG_ID ] 
  then
    echo "GPG_ID env var must be set"
    return 1
  fi
}
_create_secrets_file () {
  if [ ! -f $SECRETS_FILE ] && [ ! -f $ENCRYPTED_SECRETS_FILE ]
  then
    mkdir -p $SECRETS_HOME
    echo "$SECRETS_FILE will be created"
    cat > $SECRETS_FILE <<EOF
# Secrets env vars goes here
# MY_TOKEN=123
EOF
    return 0
  fi
}

profile-secrets-decrypt (){
  _verify_gpg_id_env_var || return 1
  if [ -f $ENCRYPTED_SECRETS_FILE ]
  then
    gpg -d ${ENCRYPTED_SECRETS_FILE} > ${SECRETS_FILE}
    rm ${ENCRYPTED_SECRETS_FILE}
  else
    echo "Encrypted file does not exist: $ENCRYPTED_SECRETS_FILE"
    return 1
  fi
}

profile-secrets-encrypt () {
  _verify_gpg_id_env_var || return 1

  if [ -f $SECRETS_FILE ]
  then
    gpg -ea -r ${GPG_ID} ${SECRETS_FILE}
    rm ${SECRETS_FILE}
  else
    _create_secrets_file
  fi
}

profile-secrets-source() {
  profile-secrets-decrypt || return 1
  source $SECRETS_FILE
  profile-secrets-encrypt
}
