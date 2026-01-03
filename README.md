# memote – the genome-scale metabolic model test suite

Easily run the memote command line tools from a docker container. You can find the main documentation on [readthedocs](https://memote.readthedocs.io/).

## Usage

The container exposes the memote command line tool. If you run the container without any arguments you will see the base help message.

```bash
docker run ghcr.io/metabolicatlas/memote-docker:0.13
```

For now, the best way to have memote interact with files is to mount a local directory into the container. The only hurdle is that you may have to afterwards change the permissions of the output file to your own user.

```bash
docker run -v ~/local/path/to/models/directory:/opt ghcr.io/metabolicatlas/memote-docker:0.13 memote run /opt/my-model.xml
```

## Using Gurobi (optional)

The image bundles `gurobipy`; if a Gurobi license is provided the container switches to Gurobi, otherwise it falls back to GLPK.

- Set a single env var `GUROBI_LICENSE` with the license content. The entrypoint writes it to `~/.gurobi/gurobi.lic` and sets `COBRA_SOLVER=gurobi`.
- If `GUROBI_LICENSE` is unset, `COBRA_SOLVER` defaults to `glpk` and the existing behaviour is unchanged.

GitHub Actions example (license stored as a secret, raw or base64):

```yaml
- name: Run memote with Gurobi
  env:
    GUROBI_LICENSE: ${{ secrets.GUROBI_LICENSE }}
  run: |
    docker run -e GUROBI_LICENSE="$GUROBI_LICENSE" \
      ghcr.io/metabolicatlas/memote-docker:0.13 \
      memote run /opt/my-model.xml
```
