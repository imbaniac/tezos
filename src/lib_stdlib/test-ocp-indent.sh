#!/bin/bash

tmp_dir="$(mktemp -d -t tezos_build.XXXXXXXXXX)"
failed=no
if [ "$1" = "fix" ]; then
    fix=yes
    shift 1
fi

files="$@"
if [ -z "$files" ]; then
files=` find \( -name _build -or \
                -name .git -or \
                -wholename ./src/environment/v1.ml -or \
                -name registerer.ml \) -prune -or \
                \( -name \*.ml -or -name \*.mli \) -print`
fi

for f in $files ; do
  ff=$(basename $f)
  ocp-indent $f > $tmp_dir/$ff
  diff -U 3 $f $tmp_dir/$ff
  if [ $? -ne 0 ]; then
    if [ "$fix" = "yes" ]; then
      echo "Fix indentation $f"
      cp $tmp_dir/$ff $f
    else
      failed=yes
    fi
  fi
  rm -f $tmp_dir/$ff $tmp_dir/$ff.diff
done

if [ $failed = "yes" ]; then
    exit 2
fi
