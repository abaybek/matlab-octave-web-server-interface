#! /bin/bash

# exit if a command fails
set -e

octave --eval="web_server('start')" --persist
