#!/bin/sh
awk '{ print $2 }' \
  | sort \
  | uniq -c \
  | awk '{ printf "%d %s\n", ($1 * length($2)), $2 }' \
  | sort -rn \
  | head
