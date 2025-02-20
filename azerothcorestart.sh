#!/bin/bash
echo $'AzerothCore integration for Cubecoders AMP Generic Module \n      by xSparky911x    \n \n \n Starting AzerothCore Wotlk (docker)...';

command="server start";

while [ true ] ; do

case $command in
'server shutdown'* )  docker compose down && echo "Azerothcore stopped. you can now exit this terminal" && exit 0 ;;

'server stop' )  docker compose down && echo "Azerothcore stopped.";;

'server start' )   docker compose down && docker-compose up -d --build && echo "WORLD: World initialized";;

'console' )  docker attach worldserver && echo "disconnected from Worldserver.";;

'help' )    echo $'AzerothCore integration for Cubecoders AMP Generic Module \n Terminal commands for AzerothCore: \n \n server start -- trys to stop the currently running docker-compse containers and starts them. \n \n server stop  -- stops the docker-compose containers. \n \n server shutdown   -- stops the docker-compose containers if they are runnning and closes this Terminal. \n \n console   -- connects the Terminal to the worldserver. _-=# !! IMPORTANT!!#=-_ while you connected to the worldserver AMP cannot stop the server! you have to manualy stop it using server exit! \n \n  exit  -- closes this terminal, containers are not stopped!  ' ;;

'exit' ) exit 0;;

'kill' )    echo "Wrong command, try again" ;;


* )     echo "Wrong command $command, try again";;
esac
echo "waiting for command... type help to show commanads"
read command ;
done
done
