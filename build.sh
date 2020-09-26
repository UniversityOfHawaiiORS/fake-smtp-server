BASEDIR=`dirname $0`

usage()
{
cat << HERE
usage: $0 options

OPTIONS:
        -h show this message
        -c run clean first
HERE
}

# Configure for Java 11
if [ -f ${BASEDIR}/java.config ]
then
    source ${BASEDIR}/java.config
fi

clean=N
while getopts "hc" OPTION
do
        case $OPTION in
                h) usage
                   exit 1
                   ;;
                c)
                   clean=Y
                   ;;
                ?)
                   usage
                   exit 1
                   ;;
       esac
done

if [ ${clean} == "Y" ]
then
    echo "Running clean first"
    ./gradlew clean
fi

echo "Running gradle build"
./gradlew build


