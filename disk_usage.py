

import subprocess


disk_usage = subprocess.getoutput(" df -h / |sort -rh |awk 'NR==2 { print $5 }'|sed 's/%//'")
disk_usage=int(disk_usage)


if disk_usage > 20:
    print("disk usage high:" , disk_usage ,"%" )
else:
    print("cool disk is normal")

    
