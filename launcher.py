"""
bs2 Launcher Script (bs2/launcher.py)
Author: Peak AI
Tenant: Default
Created: 2019-01-22
Template Version: 1

This script is included to ensure compatibility with SageMaker deployment requirements.
"""

import subprocess

subprocess.call(["orion-service", "run", "-s", "api.py", "-f", "predict", "-v", "sagemaker"])

