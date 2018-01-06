#!/bin/sh
### BEGIN INIT INFO
# Provides:
# Required-Start:    $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Saves or loads VBox's shared folders
# Description:       Saves or loads VBox's shared folders
### END INIT INFO

set -e
set -x

# https://raw.githubusercontent.com/fhd/init-script-template/master/template

dir=""
cmd=""
user=""

name=`basename $0`

DUMP_FILE=/var/local/shared-saver-dump
KERNEL_PASSPHRASE=root
#KERNEL_PASSPHRASE=khack-kexec

LOGFILE="/home/vagrant/shared-saver-log-$(date '+%Y-%m-%d-%H-%M-%S')"
log() {
  echo "$@" >>"$LOGFILE"
}

save_file() {
  log 'saving mounts'
  mount | perl -ne 'print "$1\t$2\tvboxsf\tdefaults\t0\t0$/" if /^([\w\/]+) on (.+) type vboxsf \(.+\)$/' | tee "$DUMP_FILE"
}

is_magic() {
  !(grep -q "BOOT_IMAGE" /proc/cmdline)
}

force_load_file() {
  if [ -f "$DUMP_FILE" ]; then
    mount -T "$DUMP_FILE" -a
  else
    log 'file not found, skipping'
  fi
}

load_file() {
  log 'loading mounts, before checking'
  if is_magic; then
   force_load_file 
  fi
}

case "$1" in
    start)
    # TODO do we need to handle /var/lock/subsys? https://unix.stackexchange.com/a/114277
    # TODO read state if we have the magic passphrase in kernel CLI
    load_file
    ;;
    stop)
    # TODO dump state to file
    save_file
    ;;
    status)
    # We're never running
    echo "This is useless"
    ;;
    *)
    echo "Usage: $0 {start|stop|status}"
    exit 1
    ;;
esac

exit 0
