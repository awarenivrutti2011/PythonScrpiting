
import subprocess
import sys

process = sys.argv[1]


output = subprocess.getoutput(f"pgrep -f {process}")

if output:
    print(f"process '{process}'is running")
else:
    print(f"process '{process}'is not running")

