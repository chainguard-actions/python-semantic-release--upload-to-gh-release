#!/bin/bash

set -e

# See https://github.com/actions/runner-images/issues/6775#issuecomment-1409268124
# and https://github.com/actions/runner-images/issues/6775#issuecomment-1410270956
git config --system --add safe.directory "*"

# Change to configured directory
cd "${INPUT_DIRECTORY}"

# Make Token available as a correctly-named environment variables
export GH_TOKEN="${INPUT_GITHUB_TOKEN}"

# Build command as an array to avoid eval and shell injection
CMD=("$PSR_VENV_BIN/semantic-release")

# Add root options as individual words (word-split intentional for option flags)
if [ -n "${INPUT_ROOT_OPTIONS}" ]; then
  read -ra ROOT_OPTS <<< "${INPUT_ROOT_OPTIONS}"
  CMD+=("${ROOT_OPTS[@]}")
fi

CMD+=("publish")

# Add publish arguments as necessary
if [ -n "${INPUT_TAG}" ]; then
  CMD+=("--tag" "${INPUT_TAG}")
fi

# Print and run the command safely without eval
printf '%s\n' "> ${CMD[*]}"
"${CMD[@]}"
