#!/bin/bash
source /srv/tunneldigger/env_tunneldigger/bin/activate && \
/srv/tunneldigger/env_tunneldigger/bin/python /srv/tunneldigger/tunneldigger/broker/broker.py "/etc/tunneldigger/$1/broker.cfg"

