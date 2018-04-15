
pr_error() {
    echo "ERR: " "$@" >&2
}

pr_info() {
    echo "INFO: " "$@" >&2
}

die() {
    echo "FATAL: " "$@" >&2
    exit 1
}
