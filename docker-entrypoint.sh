#!/usr/bin/env bash

isCommand() {
  for cmd in \
    "about" \
    "archive" \
    "auto-scripts" \
    "browse" \
    "check-platform-reqs" \
    "clear-cache" \
    "clearcache" \
    "config" \
    "create-project" \
    "depends" \
    "diagnose" \
    "dump-autoload" \
    "dump-env" \
    "dumpautoload" \
    "exec" \
    "fix-recipes" \
    "global" \
    "help" \
    "home" \
    "i" \
    "info" \
    "init" \
    "install" \
    "licenses" \
    "list" \
    "outdated" \
    "prohibits" \
    "remove" \
    "require" \
    "run" \
    "run-script" \
    "search" \
    "self-update" \
    "selfupdate" \
    "show" \
    "status" \
    "suggests" \
    "sync-recipes" \
    "u" \
    "unpack" \
    "update" \
    "upgrade" \
    "validate" \
    "why" \
    "why-not" \
    "symfony:dump-env" \
    "symfony:generate-id" \
    "symfony:sync-recipes" \
    "symfony:unpack"
  do
    if [ -z "${cmd#"$1"}" ]; then
      return 0
    fi
  done

  return 1
}

# check if the first argument passed in looks like a flag
if [ "$(printf %c "$1")" = '-' ]; then
  set -- /tini -- composer "$@"
# check if the first argument passed in is composer
elif [ "$1" = 'composer' ]; then
  set -- /tini -- "$@"
# check if the first argument passed in matches a known command
elif isCommand "$1"; then
  set -- /tini -- composer "$@"
fi

exec "$@"
