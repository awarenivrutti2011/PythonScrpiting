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
 
#!/bin/bash
 
NAMESPACE=monitoring
 
Pod_details=$(kubectl get pods -n $NAMESPACE | grep -Ei 'CrashLoopBackOff|ImagePullBackOff' | awk '{print $1}')
 
if [ -z "$Pod_details" ]; then

    echo "Everything is fine"

else

    echo "Abnormal pods found, investigating..."
 
    TEMP_FILE=$(mktemp)
 
    for pod in $Pod_details

    do

        echo "========== DESCRIBE POD: $pod ==========" >> $TEMP_FILE

        kubectl describe pod $pod -n $NAMESPACE >> $TEMP_FILE
 
        echo "========== LOGS POD: $pod ==========" >> $TEMP_FILE

        kubectl logs $pod -n $NAMESPACE >> $TEMP_FILE

    done
 
    mail -s "K8s Alert: Pod Failure Detected" support@company.com < $TEMP_FILE
 
    rm -f $TEMP_FILE

fi

 
/tmp/tmp
 
