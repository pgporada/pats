#!/bin/bash
# AUTHOR:
#       Phil Porada - philporada@gmail.com
# LICENSE: GPLv3
# HOW:
#       This file is sourced by each test_*.bash file
#       You can check the return code of each test_*.bash file to automate
#
######################################

USE_COLOR=0
GRN=""
RED=""
RST=""
YEL=""
DEBUG_OUTPUT=0
COMPACT_OUTPUT=0
ERRORS=0

usage() {
    echo -e "
USAGE:

    ./"$(basename ${0})" [-c] [-d] [-h] [-t]

    -c | Color output, defaults to uncolored
    -d | Show output from the commands you're testing, defaults to off
    -h | Show this help menu
    -t | Output in compact format. Example:  ..F....FFF.


LICENSE:
    GNU GPLv3

AUTHOR:
    Phil Porada
"
}

# Checks return values and outputs pass/fail
checker() {
    local RETVAL=${1}
    shift
    if [ "${RETVAL}" -eq 0 ] && [ "${COMPACT_OUTPUT}" -eq 0 ]; then
        CHECKER="${GRN}ok${RST}"
    elif [ "${RETVAL}" -eq 0 ] && [ "${COMPACT_OUTPUT}" -eq 1 ]; then
        CHECKER="${GRN}.${RST}"
    elif [ "${RETVAL}" -ne 0 ] && [ "${COMPACT_OUTPUT}" -eq 0 ]; then
        CHECKER="${RED}not ok${RST}"
    else
        CHECKER="${RED}F${RST}"
    fi

    if [ "${RETVAL}" -ne 0 ]; then
        ERRORS=$((ERRORS + 1))
    fi
}

# Prepares part of the output string
test_name() {
    local TEST_NAME="${@}"
    shift
    if [ "${DEBUG_OUTPUT}" -eq 1 ]; then
        OUTPUT="${YEL}DEBUG${RST} - ${TEST_NAME}"
    else
        OUTPUT="${TEST_NAME}"
    fi
}

# Runs the specified commands to retrieve a return value
# Finishes building the output string
test_runner() {
    local TEST_SCRIPT="${@}"
    shift

    if [ "${DEBUG_OUTPUT}" -eq 0 ]; then
        eval "${TEST_SCRIPT}" > /dev/null 2>&1
    else
        eval "${TEST_SCRIPT}"
    fi

    checker $?

    if [ "${DEBUG_OUTPUT}" -eq 0 ] && [ "${COMPACT_OUTPUT}" -eq 0 ]; then
        echo "${CHECKER} - ${OUTPUT}"
    elif [ "${DEBUG_OUTPUT}" -eq 1 ] && [ "${COMPACT_OUTPUT}" -eq 0 ]; then
        echo "${CHECKER} - ${OUTPUT}"
    elif [ "${DEBUG_OUTPUT}" -eq 0 ] && [ "${COMPACT_OUTPUT}" -eq 1 ]; then
        echo -n "${CHECKER}"
    else
        echo "${CHECKER} - ${OUTPUT}"
    fi
}

while getopts ":cdht" opt; do
  case $opt in
    c)  USE_COLOR=1
        GRN="$(tput setaf 2)"
        RED="$(tput setaf 1)"
        YEL="$(tput setaf 3)"
        RST="$(tput sgr0)"
        ;;
    d)  DEBUG_OUTPUT=1;;
    h)  usage
        exit 0
        ;;
    t)  COMPACT_OUTPUT=1;;
    \?) echo "Invalid option: -$OPTARG" >&2
        exit 1
        ;;
  esac
done
