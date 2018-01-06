#!/bin/sh
set -e
set -x

# https://raw.githubusercontent.com/fhd/init-script-template/master/template

DUMP_FILE=/var/local/shared-saver-dump

save_file() {
  echo 'saving'
  mount | perl -ne 'print "$1\t$2\tvboxsf\tdefaults\t0\t0$/" if /^(\S+) on (.+) type vboxsf \(.+\)$/' | tee "$DUMP_FILE"
}

is_magic() {
  !(grep -q "BOOT_IMAGE" /proc/cmdline)
}

force_load_file() {
  if [ -f "$DUMP_FILE" ]; then
    'file found, loading'
    mount -aT "$DUMP_FILE"
  else
    echo 'file not found, skipping'
  fi
}

load_file() {
  echo 'loading mounts, before checking'
  if is_magic; then
   force_load_file 
  fi
}

case "$1" in
    start)
    load_file
    ;;
    stop)
    save_file
    ;;
    *)
    echo "Usage: $0 {start|stop}"
    exit 1
    ;;
esac

exit 0
