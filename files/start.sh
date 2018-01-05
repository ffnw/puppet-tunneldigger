#!/bin/bash
cd /srv/tunneldigger && \
/srv/env_tunneldigger/bin/python -m tunneldigger_broker.main "/etc/tunneldigger/$1/broker.cfg"
