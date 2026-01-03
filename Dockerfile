FROM python:3.11.14-slim

LABEL org.opencontainers.image.source=https://github.com/metabolicatlas/memote-docker
LABEL version="0.13"
LABEL description="Docker image of opencobra/memote adapted for MetabolicAtlas/standard-GEM-validation"

ENV PYTHONUNBUFFERED=1

ARG USER_=memote
ARG UID=1000
ARG GID=1000

ENV HOME="/home/${USER_}"

RUN groupadd --system --gid "${GID}" "${USER_}" \
    && useradd --system --create-home --home-dir "${HOME}" \
        --uid "${UID}" --gid "${USER_}" "${USER_}" \
    && chown -R "${USER_}:${USER_}" "${HOME}"
    
WORKDIR /opt
COPY requirements.* /opt/

RUN set -eux \
    && apt-get update \
    && apt-get install --yes --no-install-recommends \
        ca-certificates \
        git-core \
        openssl \
        openssh-client \
        procps \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && pip install --upgrade pip \
    && pip install -r requirements.txt \
    && rm -rf /root/.cache/pip

WORKDIR "${HOME}"

# Allow any user ID to run memote in the working directory.
RUN set -eux \
    && chmod o+rx /usr/bin/* /usr/local/bin/* \
    && chmod -R a+rwx "${HOME}"

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

USER "${USER_}"

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["memote", "-h"]
