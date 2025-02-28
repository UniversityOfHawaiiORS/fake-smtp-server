BASEDIR=`dirname $0`
PIDFILE=${BASEDIR}/running.pid

if [ -f ${PIDFILE} ]
then
    read pid < ${PIDFILE}
    kill $pid
    rm ${PIDFILE}
else
    echo running.pid file not found.
fi
