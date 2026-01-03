#!/usr/bin/env sh
set -eu

LICENSE_DIR="${HOME}/.gurobi"
LICENSE_FILE="${LICENSE_DIR}/gurobi.lic"

# Accept a base64-encoded license (preferred) or raw text as fallback.
if [ -n "${GUROBI_LICENSE_B64:-}" ]; then
    mkdir -p "${LICENSE_DIR}"
    python - "$GUROBI_LICENSE_B64" "$LICENSE_FILE" <<'PY'
import base64, binascii, sys
data, dest = sys.argv[1], sys.argv[2]
# Add padding if omitted (len must be a multiple of 4).
pad = (-len(data)) % 4
if pad:
    data += "=" * pad
with open(dest, "wb") as fh:
    fh.write(base64.b64decode(data))
PY
    export GRB_LICENSE_FILE="${LICENSE_FILE}"
elif [ -n "${GUROBI_LICENSE:-}" ]; then
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
