#!/bin/bash

cd /code/py/notebooks
jupyter notebook --port=9999 --notebook-dir='/code/py/notebooks' --ip=0.0.0.0 --no-browser --allow-root --NotebookApp.token='115b86c498e3293a889f45f2b11f208c133d692f5bd69a81'
#jupyterhub --ip 0.0.0.0 --port 9999 -f /etc/jupyter/jupyterhub_config.py
