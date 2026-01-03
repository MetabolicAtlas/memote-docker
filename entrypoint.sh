#!/usr/bin/env sh
set -eu

LICENSE_DIR="${HOME}/.gurobi"
LICENSE_FILE="${LICENSE_DIR}/gurobi.lic"

# Single entrypoint variable: GUROBI_LICENSE (raw text or base64).
if [ -n "${GUROBI_LICENSE:-}" ]; then
    mkdir -p "${LICENSE_DIR}"
    printf "%s" "${GUROBI_LICENSE}" > "${LICENSE_FILE}"
    export GRB_LICENSE_FILE="${LICENSE_FILE}"
fi

# Pick solver based on whether a license is available; default to GLPK.
if [ -n "${GRB_LICENSE_FILE:-}" ] && [ -r "${GRB_LICENSE_FILE}" ]; then
    export COBRA_SOLVER="${COBRA_SOLVER:-gurobi}"
else
    export COBRA_SOLVER="${COBRA_SOLVER:-glpk}"
fi

exec "$@"
