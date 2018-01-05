#!/bin/bash
virtualenv env_tunneldigger
source env_tunneldigger/bin/activate
cd tunneldigger/broker
python setup.py install
