#!/bin/bash
cd /srv/tunneldigger/tunneldigger && \
source /srv/tunneldigger/env_tunneldigger/bin/activate && \
/srv/tunneldigger/env_tunneldigger/bin/python -m broker.main "/etc/tunneldigger/$1/broker.cfg"

