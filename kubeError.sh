#!/bin/bash

Pod_details="kubectl get pod -n prod | grep -E'crashlookback|imagepullbackooff'| awk '{print $1}'"

if [-z $P_details ]; then


	echo"everthing is fine "
else
	echo"abnrmal more investigating "
	TEMP_FILE=$(mktemp)

	for pod in $Pod_details
	
	do
		echo"----------describe $pod "
		kubectl describe pod $pod >> $TEMP_FILE 


		echo"...............logs..............."
		kubectl get logs $pod  >> $TEMP_FILE

		mail -x 'alert from K8s' support@com < $TEMP_FILE

		#clean up temp file
		rm -f $TEMP_FILE
	done
fi
