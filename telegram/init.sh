#! /bin/sh

telegram-notify () {
  message=${1-Default message}
  if [[ -z $TELEGRAM_CHAT_ID ]]
  then
    echo "TELEGRAM_CHAT_ID variable not set"
  else
    if [[ -z $TELEGRAM_BOT_TOKEN ]]
    then
      echo "TELEGRAM_BOT_TOKEN variable not set"
    else
      curl -X POST  -H 'Content-Type: application/json' -d '{"chat_id": "'$TELEGRAM_CHAT_ID'", "text": "'$message'"}'  https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage
    fi
  fi
}
telegram-notify-every () {
  message=$1
  delay=$2
  while true; do
    telegram-notify $message
    sleep $delay
  done
}

telegram-notify-every-eval () {
  eval_message=${1:-Default Message}
  delay=${2:-10}
  while true; do
    telegram-notify "`eval $eval_message`"
    echo ""
    echo "Wait ${delay} seconds..."
    sleep $delay
  done
}
