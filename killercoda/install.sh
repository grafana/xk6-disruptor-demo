#!/usr/bin/env bash

set -eo pipefail

function error() {
  echo "⚠️ Error $*"
  echo "Something went wrong! Please let us know what happened by opening an issue in https://github.com/grafana/xk6-disruptor-demo/issues"
  exit 1
}

function xk6-disruptor() {
  # TODO: Set up renovate to upgrade these.
  XK6_DISRUPTOR_REPO=${XK6_DISRUPTOR_REPO:-grafana/xk6-disruptor}
  XK6_DISRUPTOR_VERSION=${XK6_DISRUPTOR_VERSION:-v0.3.1}
  XK6_DISRUPTOR_URL=${XK6_DISRUPTOR_URL:-https://github.com/$XK6_DISRUPTOR_REPO/releases/download/$XK6_DISRUPTOR_VERSION/xk6-disruptor-$XK6_DISRUPTOR_VERSION-linux-amd64.tar.gz}
  XK6_DISRUPTOR_INSTALL_PATH=${XK6_DISRUPTOR_INSTALL_PATH:-/usr/local/bin}
  echo "Downloading xk6-disruptor $XK6_DISRUPTOR_VERSION"
  curl -sSL "$XK6_DISRUPTOR_URL" |
    tar -xzC "$XK6_DISRUPTOR_INSTALL_PATH"

  mv "$XK6_DISRUPTOR_INSTALL_PATH/xk6-disruptor-linux-amd64" "$XK6_DISRUPTOR_INSTALL_PATH/xk6-disruptor"

  echo "xk6-disruptor $XK6_DISRUPTOR_VERSION installed to $XK6_DISRUPTOR_INSTALL_PATH"

  echo "Symlinking k3s kubeconfig to default path"
  mkdir -p ~/.kube
  ln -s /etc/rancher/k3s/k3s.yaml ~/.kube/config
}

function sock-shop() {
  # TODO: Set up renovate to upgrade these.
  SOCKS_SHOP_VERSION=${SOCKS_SHOP_VERSION:-master} # Latest tag (0.0.12) yields 404 for the combined manifest.
  SOCKS_SHOP_URL=${SOCKS_SHOP_URL:-https://raw.githubusercontent.com/microservices-demo/microservices-demo/$SOCKS_SHOP_VERSION/deploy/kubernetes/complete-demo.yaml}

  echo "Starting deployment of socks-shop demo application..."
  kubectl apply -f "$SOCKS_SHOP_URL" &>/dev/null \
    || error "deploying socks shop application"

  echo "Deployment completed!"
}

function sock-shop-ingress() {
  echo "Configuring ingress for socks-shop demo application..."

  kubectl apply -f "https://raw.githubusercontent.com/grafana/xk6-disruptor-demo/main/killercoda/manifests/front-end-ingress-traefik.yaml" &>/dev/null \
    || error "creating traefik ingress"

  echo "Ingress configured."
}

case $1 in
"xk6-disruptor")
  xk6-disruptor
  ;;
"sock-shop")
  sock-shop
  ;;
"sock-shop-ingress")
  sock-shop-ingress
  ;;
*)
  echo "Unknown installable $1" >&2
  exit 1
esac
