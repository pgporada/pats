source "pats_engine.bash"

################
# Tests go here
################
test_name "nginx is installed"
test_runner rpm -q nginx

test_name "nginx is running"
test_runner systemctl is-active nginx

test_name "nginx starts on boot"
test_runner systemctl is-enabled nginx

#############################################
# Cleanup steps that you don't need to touch
#############################################
if [ "${COMPACT_OUTPUT}" -eq 1 ]; then
    echo
fi

if [ "${ERRORS}" -ne 0 ]; then
    exit 1
fi
