#!/bin/bash

mkdir -p /code/py
mkdir -p /code/py/notebooks
mkdir -p /code/scripts

mv /tmp/scripts/* /code/scripts/ 2>/dev/null

chmod +x /code/scripts/*