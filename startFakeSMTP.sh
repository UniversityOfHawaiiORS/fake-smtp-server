BASEDIR=`dirname $0`

CLEAR=$1

JAR_FILE=`find ${BASEDIR} -name fake-smtp-server-1.2.2.jar`

mkdir -p ${BASEDIR}/log

# Configure for Java 11
if [ -f ${BASEDIR}/java.config ]
then
    source ${BASEDIR}/java.config
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
