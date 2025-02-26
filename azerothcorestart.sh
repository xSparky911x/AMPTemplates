#!/bin/bash
echo -e "AzerothCore integration for Cubecoders AMP Generic Module\n      by xSparky911x\n\nStarting AzerothCore WotLK (Docker)..."

command="server start"

while true; do
    case $command in
        'server shutdown'* )  
            docker compose down
            echo "AzerothCore stopped. You can now exit this terminal."
            exit 0 
            ;;

        'server stop' )  
            docker compose down
            echo "AzerothCore stopped."
            ;;

        'server start' )  
            docker compose down
            docker compose up -d --build
            echo "WORLD: World initialized"
            ;;

        'console' )  
            echo "WARNING: AMP cannot stop the server while attached. Use 'server shutdown' or 'server stop' to properly shut it down."
            echo "Attaching to worldserver... (Press Ctrl+P + Ctrl+Q to detach safely)"
            docker attach worldserver
            echo "Disconnected from Worldserver."
            ;;

        'help' )  
            echo -e "AzerothCore integration for Cubecoders AMP Generic Module\n"
            echo "Terminal commands for AzerothCore:"
            echo "  server start   - Stops currently running containers and starts them."
            echo "  server stop    - Stops the running Docker containers."
            echo "  server shutdown - Stops the containers and closes this terminal."
            echo "  console        - Attaches to the worldserver console."
            echo "                   !! IMPORTANT: While connected, AMP cannot stop the server! Use 'server exit' manually."
            echo "  exit           - Closes this terminal without stopping containers."
            ;;

        'exit' )  
            exit 0 
            ;;

        * )  
            echo "Invalid command: '$command'. Type 'help' for available commands."
            ;;

    esac

    echo "Waiting for command... (Type 'help' for a list of commands)"
    read command
done
