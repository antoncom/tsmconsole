#!/bin/sh

INITFILE=/etc/init.d/tsmconsole
SERVICE_PID_FILE=/var/run/tsmconsole.pid
APP=$0

usage() {
    echo "Usage: $APP [ COMMAND [ OPTIONS ] ]"
    echo "Without any command Tsmconsole will be run in the foreground mode"
    echo
    echo "Commands are:"
    echo "    start|stop|restart|reload     controlling the daemon"
    doexit
}
callinit() {
    [ -x $INITFILE ] || {
        echo "No init file '$INITFILE'"
        return
    }
    exec $INITFILE $1
    RETVAL=$?
}
run() {
    exec /usr/bin/lua /usr/lib/lua/tsmconsole/app.lua
    RETVAL=$?
}

doexit() {
    exit $RETVAL
}

[ -n "$INCLUDE_ONLY" ] && return

CMD="$1"
[ -z $CMD ] && {
    run
    doexit
}
shift
# See how we were called.
case "$CMD" in
    start|stop|restart|reload)
        callinit $CMD
        ;;
    *)
        RETVAL=1
        usage $0
        ;;
esac

doexit
