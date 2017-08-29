source "pats_engine.bash"

################
# Tests go here
################
test_name "sensu is installed"
test_runner rpm -q sensu

test_name "sensu-client is running"
test_runner systemctl is-active sensu-client

test_name "sensu-client starts on boot"
test_runner systemctl is-enabled sensu-client

#############################################
# Cleanup steps that you don't need to touch
#############################################
if [ "${COMPACT_OUTPUT}" -eq 1 ]; then
    echo
fi

if [ "${ERRORS}" -ne 0 ]; then
    exit 1
fi
