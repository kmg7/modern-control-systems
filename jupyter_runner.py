#!/usr/bin/env python3
"""Jupyter Lab runner with no authentication."""
import sys
from jupyterlab.labapp import main

def run_lab():
    sys.argv.extend([
        '--ServerApp.token=a2d7e7d2-c620-4a2f-9872-ebc48bc35870',
    ])
    main()

if __name__ == '__main__':
    run_lab()
