#!/bin/sh

function weather {
  local update_interval=$((60 * 15))
  local current_time=$(date "+%s")
  local previous_update="$([ -f /tmp/wttr ] && head -1 /tmp/wttr || echo 0)"
  local delta=$(($current_time - $previous_update))

  if [ -z "$previous_update" ] || [ $delta -ge $update_interval ]; then
    local value=$(curl -s "wttr.in?u&format=%c%t" | sed "s/ +//g")

    echo "$current_time" > /tmp/wttr
    echo "$value" >> /tmp/wttr
  else
    local value="$(tail -r -1 /tmp/wttr)\n"
  fi

  if [[ $value =~ [0-9]+ ]]; then
    local temp=${BASH_REMATCH[0]}
  fi

  if (($temp >= 85)); then
    local color="red"
  elif (($temp <= 65)); then
    local color="blue"
  else
    local color="yellow"
  fi

  printf "#[fg=$color]$value"
}

function utc {
  local value=$(date -u +'%H:%M')

  printf "#[fg=green]$value UTC "
}

function est {
  local value=$(TZ="America/NewYork" date +'%H:%M')

  printf "#[fg=green]$value EST "
}

function brt {
  local value=$(TZ="America/Bahia" date +'%H:%M')

  printf "#[fg=green]$value BRT "
}

function status {
  utc
  weather
}

status
