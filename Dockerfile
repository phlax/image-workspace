FROM gpt4/bazel

ENV DEBIAN_FRONTEND=noninteractive

ARG APT_PKGS="\
    byobu \
    emacs-goodies-el \
    emacs-nox"

USER root

RUN echo "deb http://deb.debian.org/debian bullseye-backports main contrib non-free" >> /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -t bullseye-backports --no-install-recommends -y -qq $APT_PKGS

USER $USERNAME
