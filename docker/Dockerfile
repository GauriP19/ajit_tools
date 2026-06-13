FROM ubuntu:22.04

ARG HOST_UID=1000
ARG HOST_GID=1000
ARG HOST_USER=ajit

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC
ENV AJIT_HOME=/workspace/ajit_tools

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    autoconf \
    automake \
    bash \
    bison \
    build-essential \
    bzip2 \
    ca-certificates \
    curl \
    flex \
    gawk \
    git \
    gperf \
    help2man \
    libbz2-dev \
    libffi-dev \
    libftdi1-dev \
    libusb-1.0-0-dev \
    liblzma-dev \
    libncurses-dev \
    libncursesw5-dev \
    libreadline-dev \
    libsqlite3-dev \
    libssl-dev \
    libtool \
    libtool-bin \
    make \
    meson \
    nano \
    ninja-build \
    patch \
    python3 \
    python3-dev \
    python3-pip \
    python3-venv \
    rsync \
    sudo \
    tar \
    texinfo \
    tk-dev \
    unzip \
    usbutils \
    vim-tiny \
    wget \
    xz-utils \
    zlib1g-dev \
  && rm -rf /var/lib/apt/lists/*

RUN ln -sf /usr/bin/python3 /usr/local/bin/python

RUN groupadd --gid "${HOST_GID}" "${HOST_USER}" \
  && useradd --uid "${HOST_UID}" --gid "${HOST_GID}" --create-home --shell /bin/bash "${HOST_USER}" \
  && printf '%s ALL=(ALL) NOPASSWD:ALL\n' "${HOST_USER}" > "/etc/sudoers.d/${HOST_USER}" \
  && chmod 0440 "/etc/sudoers.d/${HOST_USER}" \
  && mkdir -p /workspace \
  && chown "${HOST_UID}:${HOST_GID}" /workspace

USER ${HOST_USER}
WORKDIR /workspace/ajit_tools

CMD ["/bin/bash"]
