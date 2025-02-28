BASEDIR=`dirname $0`

CLEAR=$1

JAR_FILE="${BASEDIR}/build/libs/fake-smtp-server-2.4.1.jar"

mkdir -p ${BASEDIR}/log

# Configure for Java 21
if [ -f ${BASEDIR}/app_config/java.config ]
then
    source ${BASEDIR}/app_config/java.config
fi

if [ -f ${BASEDIR}/running.pid ]
then
    echo "running.pid found so stopping first"
    ${BASEDIR}/stopFakeSMTP.sh
fi

if [ "${CLEAR}" == "clear" ]
then
    rm DB/testmails.db.*    
fi

java -Dspring.config.location=${BASEDIR}/app_config/application.properties -jar ${JAR_FILE} &> ${BASEDIR}/log/fake-smtp.log &
pid=$!
echo $pid > ${BASEDIR}/running.pid
