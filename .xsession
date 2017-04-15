[[ -z ${USER} ]] && export USER=${LOGNAME}

[[ -z ${MASTER} ]] && export MASTER=${USER%[a-z][a-z]}
[[ -z ${MASTERDIR} ]] && export MASTERDIR=$(eval echo ~${MASTER})

[[ -e ${MASTERDIR}/adm/class.xsession ]] && . ${MASTERDIR}/adm/class.xsession
