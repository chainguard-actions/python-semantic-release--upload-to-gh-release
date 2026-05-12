# Hardening Report: python-semantic-release--upload-to-gh-release/v9.8.8

> This file was generated automatically by the hardening agent.

**Policy SHA:** `ff50f15e4b79bfbf764dafdfd2579175a6ea9771`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `1`

Action **python-semantic-release--upload-to-gh-release/v9.8.8** was hardened automatically. 0 finding(s) were identified and resolved across 1 iteration(s).

## Iteration Notes

### Iteration 1

**Fixes applied:** suspicious-run-content

**Notes:**

Removed the `explicit_run_cmd` function that used `eval "$cmd"` on a string constructed from attacker-controlled inputs (`INPUT_ROOT_OPTIONS` and `INPUT_TAG`). Replaced with a Bash array-based approach: the command and all its arguments are stored in a `CMD` array, with `INPUT_ROOT_OPTIONS` safely word-split via `read -ra` and `INPUT_TAG` added as a separate quoted element. The command is then executed as `"${CMD[@]}"`, which passes each array element as a distinct argument to the OS — no shell interpretation of metacharacters occurs. This eliminates the shell injection vector while preserving the original functionality.

