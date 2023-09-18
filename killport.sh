killport() {
    local force=0

    while getopts ":f" opt; do
        case $opt in
            f)
                force=1
                ;;
            \?)
                echo "Invalid option: -$OPTARG" >&2
                return 1
                ;;
        esac
    done
    shift $((OPTIND - 1))

    if [ -z "$1" ]; then
        echo "Please specify a port"
        return 1
    fi

    pid=$(lsof -t -i:$1)

    if [ -z "$pid" ]; then
        echo "No process is using port $1"
        return 1
    fi

    if [ "$force" -eq "1" ]; then
        kill -9 $pid
        echo "Force killed process $pid on port $1"
    else
        kill -15 $pid
        echo "Killed process $pid on port $1"
    fi
}

