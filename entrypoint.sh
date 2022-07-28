#!/bin/bash



mkdir "/root/.ssh"
echo "$SSH_PRIVATE_KEY" > "/root/.ssh/id_rsa"
chmod 400  "/root/.ssh/id_rsa"

command="curl -s -o /dev/null -w "%{response_code}" localhost:$SERVICE_PORT/actuator/health"

status=1
count=0

echo "Start inspcting service health in 10 secs..."
sleep 3;

while [ $count -le 6 ]
do
    echo "Attempt to check service status...($count)"

    echo "::debug::$command"

    commandStdout=$(sshpass ssh -v -o StrictHostKeyChecking=no -p $PORT $USERNAME@$HOST "$command")

    if [ $commandStdout -eq '200' ]; then
        status=0
        break
    else
        ((count=count+1))
    fi
    sleep 5;
done

echo "::set-output name=command_execution_stdout::$status"

exit 0
