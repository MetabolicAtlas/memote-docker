# memote – the genome-scale metabolic model test suite

Easily run the memote command line tools from a docker container. You can find the main documentation on [readthedocs](https://memote.readthedocs.io/).

## Usage

The container exposes the memote command line tool. If you run the container without any arguments you will see the base help message.

```bash
docker run ghcr.io/metabolicatlas/memote-docker
```

For now, the best way to have memote interact with files is to mount a local directory into the container. The only hurdle is that you may have to afterwards change the permissions of the output file to your own user.

```bash
docker run -v ~/local/path/to/models/directory:/opt ghcr.io/metabolicatlas/memote-docker memote run /opt/my-model.xml
```
