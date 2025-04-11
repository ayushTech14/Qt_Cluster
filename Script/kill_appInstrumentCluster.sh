#!/bin/sh

while true; do
    
    sleep 10
    
    # Kill and restart the process
    PID=$(ps -A | grep appInstrumentCluster | awk '{print $1}')
    if [ ! -z "$PID" ]; then
        echo "Killing process appInstrumentCluster with PID $PID..."
        kill -9 $PID
        echo "Process killed."
    else
        echo "appInstrumentCluster process not found."
    fi

    # Restart the appInstrumentCluster process
    echo "Restarting appInstrumentCluster..."
    /usr/appInstrumentCluster &

    echo "Restart complete."
done

