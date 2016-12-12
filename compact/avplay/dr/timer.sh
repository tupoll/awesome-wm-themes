#!/usr/local/bin/zsh
for (( i=0; i<1; i--)); do
  sleep 1 &
  printf "  $i \r"
  wait
done

