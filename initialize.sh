#!/bin/bash

mkdir -p /code/py
mkdir -p /code/py/notebooks
mkdir -p /code/scripts

mv /tmp/scripts/* /code/scripts/ 2>/dev/null
mv /tmp/tessdata/* /usr/share/tesseract-ocr/4.00/tessdata 2>/dev/null

chmod +x /code/scripts/*