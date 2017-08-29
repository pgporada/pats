source "pats_engine.bash"

################
# Tests go here
################
test_name "sensu is installed"
test_runner rpm -q sensu

test_name "sensu-server is running"
test_runner systemctl is-active sensu-server

test_name "sensu-server starts on boot"
test_runner systemctl is-enabled sensu-server

test_name "sensu-api is running"
test_runner systemctl is-active sensu-api

test_name "sensu-api starts on boot"
test_runner systemctl is-enabled sensu-api

test_name "redis is installed"
test_runner rpm -q redis

test_name "redis is running"
test_runner systemctl is-active redis

test_name "redis starts on boot"
test_runner systemctl is-enabled redis

#############################################
# Cleanup steps that you don't need to touch
#############################################
if [ "${COMPACT_OUTPUT}" -eq 1 ]; then
    echo
fi

if [ "${ERRORS}" -ne 0 ]; then
    exit 1
fi
