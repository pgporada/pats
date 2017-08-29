source "pats_engine.bash"

################
# Tests go here
################
test_name "Ensure rabbitmq is installed"
test_runner rpm -q rabbitmq-server

test_name "SELinux boolean nis_enabled is set to true"
test_runner getsebool nis_enabled

test_name "Ensure rabbitmq starts on boot"
test_runner systemctl is-enabled rabbitmq-server

test_name "Ensure rabbitmq is running"
test_runner systemctl is-active rabbitmq-server

test_name "rabbitmqctl is on the PATH and is executable"
test_runner sudo rabbitmqctl status

test_name "/etc/rabbitmq/rabbitmq.config exists and is not empty"
test_runner [ -s /etc/rabbitmq/rabbitmq.config ]

test_name "rabbitmqadmin bash completion is in place"
test_runner [ -s /etc/bash_completion.d/rabbitmqadmin ]

test_name "rabbitmqadmin version matches rabbitmq-server rpm version"
test_runner "[[ $(rpm -q rabbitmq-server | awk -F'-' '{print $3}') =~ $(rabbitmqadmin --version | awk '{print $2}') ]]"

test_name "User exists: 'admin'"
test_runner "rabbitmqctl list_users | grep '^admin'"

test_name "User exists: 'sensu'"
test_runner "rabbitmqctl list_users | grep '^sensu'"

test_name "User doesn't exist: 'guest'"
test_runner "! rabbitmqctl list_users | grep '^guest'"

test_name "Vhost exists: '/'"
test_runner "rabbitmqctl list_vhosts | grep '^/$'"

test_name "Vhost exists: '/sensu'"
test_runner "rabbitmqctl list_vhosts | grep '^/sensu$'"

test_name "sensu user can authenticate to rabbitmq - requires rabbitmq 3.6.x"
test_runner "rabbitmqctl authenticate_user sensu secret | grep '^Success'"

#############################################
# Cleanup steps that you don't need to touch
#############################################
if [ "${COMPACT_OUTPUT}" -eq 1 ]; then
    echo
fi

if [ "${ERRORS}" -ne 0 ]; then
    exit 1
fi
