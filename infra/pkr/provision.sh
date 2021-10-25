#!/bin/bash

function Docker {
  echo "Installing Docker"
  curl -sL get.docker.com | sh
  sudo usermod -aG docker $USER
}

function Kubectl {
  echo "Installing Kubectl"
  curl -sLO "https://storage.googleapis.com/kubernetes-release/release/$(curl -sL https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
  chmod +x ./kubectl
  sudo mv ./kubectl /usr/local/bin/kubectl
  echo 'source <(kubectl completion bash)' >>~/.bashrc
  echo 'alias k=kubectl' >>~/.bashrc
  echo 'complete -F __start_kubectl k' >>~/.bashrc
}

function K3D {
  echo "Installing K3D"
  curl -sL https://raw.githubusercontent.com/rancher/k3d/main/install.sh | bash
}

function Helm {
  echo "Installing Helm"
  curl -sL https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
}

function LinuxTools {
  echo "Installing basic GNU/Linux Tools for k8s labs"
  sudo -E sh -c DEBIAN_FRONTEND=noninteractive apt update -qq >/dev/null
  sudo -E sh -c DEBIAN_FRONTEND=noninteractive apt install -y -qq curl jq make unzip zip vim git >/dev/null
}

function Okteto {
  echo "Installing Okteto"
  curl -sSfL https://get.okteto.com | sh
}

function Krew {
  echo "Installing Krew"

  (
    set -x; cd "$(mktemp -d)" &&
    OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
    ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
    KREW="krew-${OS}_${ARCH}" &&
    curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
    tar zxvf "${KREW}.tar.gz" &&
    ./"${KREW}" install krew
  )

  echo 'export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"' >> .bashrc

  export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
  kubectl krew update
  kubectl krew install get-all change-ns ingress-nginx janitor doctor ns pod-dive pod-inspect pod-lens pod-logs pod-shell podevents service-tree sick-pods view-secret
}

function Tekton {
  echo "Installing tekton cli"
  sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3EFE0E0A2F2F60AA
  echo "deb http://ppa.launchpad.net/tektoncd/cli/ubuntu focal main" | sudo tee /etc/apt/sources.list.d/tektoncd-ubuntu-cli.list
  sudo -E sh -c DEBIAN_FRONTEND=noninteractive apt update -qq
  sudo -E sh -c DEBIAN_FRONTEND=noninteractive apt install -y -qq tektoncd-cli
}

function Operators {
  echo "Installing Operator Framework"
  brew install operator-sdk
  operator-sdk olm install
}

function Required {
  LinuxTools
  Docker
  Kubectl
  Helm
  Krew
  K3D
  Okteto
  Tekton
}

function Install {
  Required
  # Operators
}

Install
