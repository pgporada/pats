source "pats_engine.bash"

################
# Tests go here
################
test_name "Can echo"
test_runner echo 123

test_name "apt was found"
test_runner which apt

#############################################
# Cleanup steps that you don't need to touch
#############################################
if [ "${COMPACT_OUTPUT}" -eq 1 ]; then
    echo
fi

if [ "${ERRORS}" -ne 0 ]; then
    exit 1
fi
