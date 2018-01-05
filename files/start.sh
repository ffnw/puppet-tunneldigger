#!/bin/bash
cd /srv/tunneldigger && \
/srv/tunneldigger/env_tunneldigger/bin/python -m tunneldigger_broker.main "/etc/tunneldigger/$1/broker.cfg"
