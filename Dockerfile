FROM texlive/texlive:latest

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /container_workspace/src

RUN tlmgr update --self && tlmgr install \
    latexmk \
    texliveonfly \
    && apt-get update && apt-get install -y \
    python3-pygments \
    && rm -rf /var/lib/apt/lists/*

RUN echo '#!/bin/bash\n\
tlmgr install "$@"' > /usr/local/bin/install-tex-packages && \
    chmod +x /usr/local/bin/install-tex-packages

CMD ["tail", "-f", "/dev/null"]