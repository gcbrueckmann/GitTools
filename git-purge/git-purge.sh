#!/usr/bin/env bash

set -e

fail() {
    echo "$@" >&2
    exit 1
}

USAGE="\
usage: $0 [-f]
       $0 -l
       $0 -h"

usage() {
	fail "${USAGE}"
}

help() {
	echo "${USAGE}"
  echo
  echo "Delete local branches when their remote tracking branches have gone."
  echo
  echo "  -f Allow deleting branches irrespective of their merged status."
  echo "  -l List branches eligible for purging, but do not purge them."
  echo "  -h Show this help."
  exit 0
}

LIST_ONLY=0
FORCE_DELETE=0

while getopts ':flh' opt; do
  case $opt in
    f)
      FORCE_DELETE=1
      ;;
    l)
      LIST_ONLY=1
      ;;
    h)
      help
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      usage
      ;;
    *)
      echo "Option -$OPTARG requires an argument." >&2
      usage
      ;;
  esac
done

shift $((OPTIND-1))

git fetch -p || fail "Could not fetch before purging."

CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)

for BRANCH in `git branch -vv | grep ': gone]' | awk '{print $1}'`; do
  if [ "${LIST_ONLY}" -eq 1 ]; then
    echo "${BRANCH}"
  else
    if [ "${BRANCH}" -eq "${CURRENT_BRANCH}" ]; then
      echo "${BRANCH} needs purging, but cannot be deleted while it is the current branch."
    else
      DELETE_OPTIONS="d"
      if [ "${FORCE_DELETE}" -eq 1 ]; then
        DELETE_OPTIONS="${DELETE_OPTIONS}f"
      fi
      git branch "-${DELETE_OPTIONS}" -- "${BRANCH}" || fail "Could not delete ${BRANCH}"
    fi
  fi
done
