#!/bin/bash
set -ue
set -o pipefail

# err MAGENTA
log_err() {
    printf "\033[38;5;201m[error] %s\033[0m\n" "$1" >&2
}

# err CYAN
log_info() {
    printf "\033[38;5;84m[info] %s\033[0m\n" "$1" >&2
}

cmd() {
    cmd="$1"

    printf "\033[38;5;84m  %% %s\033[0m\n" "${cmd}" >&2
    eval "${cmd}"
}

# check args
if [ $# -ne 2 ]; then
    log_err "Usage: $0 <toplevel> <path>"
    log_err "  argc = $#"
    for arg in "$@"; do
        log_err "  arg = ${arg}"
    done

    exit 1
fi

toplevel="$1"
path="$2"
smdir="$toplevel/$path"

log_info "bump ${path}..."

# check submodule branch (must be main)
smbranch=$(cmd "git -C ${smdir} rev-parse --abbrev-ref HEAD")
log_info "  branch: '${smbranch}'"
if [[ "${smbranch}" != "main" ]]; then
    log_err "Submodule branch must be main"
    exit 1
fi

# Compare local and remote main branch
git fetch origin main >/dev/null 2>&1

l_commit=$(cmd "git -C ${smdir} rev-parse HEAD")
r_commit=$(cmd "git -C ${smdir} rev-parse origin/main")
log_info "   local commit: ${l_commit}"
log_info "  remote commit: ${r_commit}"

if [ "$l_commit" = "$r_commit" ]; then
    exit 0
elif git merge-base --is-ancestor "$l_commit" "$r_commit"; then
    log_info "  remote is ahead of local..."
    cmd "git -C ${smdir} pull origin main"
else
    echo "  local is ahead of remote..."
fi

# create bump commit
cmd "git -C ${toplevel} add ${path}"
cmd "git -C ${toplevel} commit -m \":arrow_up: bump ${path}\" --no-verify"
exit 0
