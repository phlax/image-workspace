FROM gpt4/bazel

ENV DEBIAN_FRONTEND=noninteractive

ARG APT_PKGS="\
    bash-completion \
    byobu \
    emacs-goodies-el \
    emacs-nox \
    gosu \
    sudo"

USER root

RUN apt-get update \
    && apt-get install -t bullseye-backports --no-install-recommends -y -qq $APT_PKGS

ADD ./entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
