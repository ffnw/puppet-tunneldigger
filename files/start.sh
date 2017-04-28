#!/bin/bash
cd /srv/tunneldigger/tunneldigger && \
source /srv/tunneldigger/env_tunneldigger/bin/activate && \
/srv/tunneldigger/env_tunneldigger/bin/python /srv/tunneldigger/tunneldigger/broker/l2tp_broker.py "/etc/tunneldigger/$1/broker.cfg"

