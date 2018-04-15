
. $my_prefix/lib/log.sh

if [ -x /opt/eclipse-neon/eclipse/eclipse ]; then
    eclipse_version=neon
elif [ -x /opt/eclipse-luna/eclipse/eclipse ]; then
    eclipse_version=luna
else
    pr_error "Cant find eclipse version (tried neon|luna"
    exit 1
fi

ECLIPSE_PREFIX=/opt/eclipse-${eclipse_version}/eclipse
ECLIPSE_CMD=${ECLIPSE_PREFIX}/eclipse

. $my_prefix/lib/eclipse.sh
. $my_prefix/lib/sigasi.sh
