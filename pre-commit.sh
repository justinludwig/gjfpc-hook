#!/bin/sh -e
format_cmd="$(dirname $(realpath "$0"))/format.sh"

# skip if NO_VERIFY env var set
if [ "$NO_VERIFY" ]; then
    echo 'google-java-format skipped' 1>&2
    exit 0
fi

# list all added/copied/modified/renamed java files
git diff -z --staged --name-only --diff-filter=ACMR | grep -z '.java$' |
    # run google-java-format on each file and re-stage any new changes
    xargs -0 -I % echo "$format_cmd -i '%'; git add -f '%'" | sh
