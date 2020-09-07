FROM opensuse/leap:15.2

ARG USER
ARG UID
ARG GID

RUN zypper -n ar -f http://download.suse.de/ibs/SUSE:/CA/openSUSE_Leap_15.2/SUSE:CA.repo \
  && zypper -n ar -Gf http://download.suse.de/ibs/Devel:/CAPS:/Registry:/2.0/standard/Devel:CAPS:Registry:2.0.repo

RUN zypper -n in \
      ca-certificates-suse \
      curl \
      docker \
      gzip \
      helm \
      jq \
      kubernetes-client \
      make \
      nodejs12 \
      openssh \
      python3-robotframework \
      unzip \
      wget

RUN wget https://releases.hashicorp.com/terraform/0.12.25/terraform_0.12.25_linux_amd64.zip \
  && unzip terraform_0.12.25_linux_amd64.zip \
  && mv terraform /usr/local/bin/ \
  && rm terraform_0.12.25_linux_amd64.zip

RUN useradd -r -g ${GID} -d /github/home -m -l -c "runner default user" -u ${UID} ${USER}

USER ${UID}:${GID}

ENTRYPOINT ["/bin/bash"]
CMD []

