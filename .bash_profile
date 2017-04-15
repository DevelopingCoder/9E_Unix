#######################################################################
#                                                                     #
#   Bash_login file                                                   #
#                                                                     #
#   commands to perform from the bash shell at login time             #
#   (sourced from .bash_profile)                                      #
#                                                                     #
#######################################################################

# Set the Class MASTER variable and source the class master version of .cshrc

[[ -z ${USER} ]] && export USER=${LOGNAME}

[[ -z ${MASTER} ]] && export MASTER=${USER%[a-z][a-z]}
[[ -z ${MASTERDIR} ]] && export MASTERDIR=$(eval echo ~${MASTER})

# Set up class wide settings
for file in ${MASTERDIR}/adm/bashrc.d/* ; do [[ -x ${file} ]] && . "${file}"; done

[[ ! -e ${MASTERDIR}/grading/register/${USER} ]] && /share/b/grading/bin/register

# Set up local settings
for file in ${HOME}/bashrc.d/* ; do [[ -x ${file} ]] && . "${file}"; done
