# memote – the genome-scale metabolic model test suite

Easily run the memote command line tools from a Docker container. You can find the main documentation on [readthedocs](https://memote.readthedocs.io/).
If you use this Docker image, please cite the corresponding Zenodo DOI: [placeholder]. For the original software, please cite Memote.

## Usage

The container exposes the memote command line tool. If you run the container without any arguments you will see the base help message.

```bash
docker run ghcr.io/metabolicatlas/memote-docker:0.13
```

For now, the best way to have memote interact with files is to mount a local directory into the container. The only hurdle is that you may have to afterwards change the permissions of the output file to your own user.

```bash
docker run -v ~/local/path/to/models/directory:/opt ghcr.io/metabolicatlas/memote-docker:0.13 memote run /opt/my-model.xml
```
## New functionality

The following functionality has been added when comparing to the original repository:
- Memote v0.13 (versus v0.12)
- Python v3.9 (versus v3.6)
- addition of `scipy` and `yamllint`
- Zenodo DOIs
- Gurobi support
