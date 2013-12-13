#!/bin/sh
awk '{ print $2 }' \
  | sort \
  | uniq -c \
  | awk '{ printf "%d|%s: %d times\n", ($1 * length($2)), $2, $1 }' \
  | sort -rn \
  | cut -d '|' -f 2- \
  | head -n "${1-10}"
