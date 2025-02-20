#!/bin/bash
export PATH="/usr/bin:/usr/local/bin:$PATH"

# Log file location
LOG_FILE="/home/amp/amp_debug.log"

echo "Script started at $(date)" >> $LOG_FILE

echo "Current PATH: $PATH" >> $LOG_FILE
printenv >> $LOG_FILE

DOCKER_CMD="$(which docker)"
DOCKER_COMPOSE_CMD="$(which docker-compose)"

if [[ -z "$DOCKER_CMD" ]]; then
    echo "Error: Docker not found. Make sure Docker is installed and accessible." >> $LOG_FILE
    exit 1
fi

if [[ -z "$DOCKER_COMPOSE_CMD" ]]; then
    echo "Error: Docker Compose not found. Make sure Docker Compose is installed." >> $LOG_FILE
    exit 1
fi

echo -e "AzerothCore integration for Cubecoders AMP Generic Module\n      by xSparky911x\n\nStarting AzerothCore WotLK (Docker)..." >> $LOG_FILE

command="server start"

while true; do
    case $command in
        'server shutdown'* )  
            $DOCKER_COMPOSE_CMD down
            echo "AzerothCore stopped. You can now exit this terminal." >> $LOG_FILE
            exit 0 
            ;;

        'server stop' )  
            $DOCKER_COMPOSE_CMD down
            echo "AzerothCore stopped." >> $LOG_FILE
            ;;

        'server start' )  
            $DOCKER_COMPOSE_CMD down
            $DOCKER_COMPOSE_CMD up -d --build
            echo "WORLD: World initialized" >> $LOG_FILE
            ;;

        'console' )  
            echo "WARNING: AMP cannot stop the server while attached. Use 'server shutdown' or 'server stop' to properly shut it down." >> $LOG_FILE
            echo "Attaching to worldserver... (Press Ctrl+P + Ctrl+Q to detach safely)" >> $LOG_FILE
            $DOCKER_CMD attach worldserver
            echo "Disconnected from Worldserver." >> $LOG_FILE
            ;;

        'help' )  
            echo -e "AzerothCore integration for Cubecoders AMP Generic Module\n" >> $LOG_FILE
            echo "Terminal commands for AzerothCore:" >> $LOG_FILE
            echo "  server start   - Stops currently running containers and starts them." >> $LOG_FILE
            echo "  server stop    - Stops the running Docker containers." >> $LOG_FILE
            echo "  server shutdown - Stops the containers and closes this terminal." >> $LOG_FILE
            echo "  console        - Attaches to the worldserver console." >> $LOG_FILE
            echo "                   !! IMPORTANT: While connected, AMP cannot stop the server! Use 'server exit' manually." >> $LOG_FILE
            echo "  exit           - Closes this terminal without stopping containers." >> $LOG_FILE
            ;;

        'exit' )  
            exit 0 
            ;;

        * )  
            echo "Invalid command: '$command'. Type 'help' for available commands." >> $LOG_FILE
            ;;

    esac

    echo "Waiting for command... (Type 'help' for a list of commands)" >> $LOG_FILE
    read command
done
