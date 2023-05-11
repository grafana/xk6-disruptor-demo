#!/usr/bin/env bash

set -eo pipefail

function error() {
  echo "⚠️ Error $*"
  echo "Something went wrong! Please let us know what happened by opening an issue in https://github.com/grafana/xk6-disruptor-demo/issues"
  exit 1
}

function xk6_disruptor() {
  # TODO: Set up renovate to upgrade these.
  XK6_DISRUPTOR_REPO=${XK6_DISRUPTOR_REPO:-grafana/xk6-disruptor}
  XK6_DISRUPTOR_VERSION=${XK6_DISRUPTOR_VERSION:-v0.3.1}
  XK6_DISRUPTOR_URL=${XK6_DISRUPTOR_URL:-https://github.com/grafana/xk6-disruptor/releases/download/$XK6_DISRUPTOR_VERSION/xk6-disruptor-$XK6_DISRUPTOR_VERSION-linux-amd64.tar.gz}
  XK6_DISRUPTOR_INSTALL_PATH=${XK6_DISRUPTOR_INSTALL_PATH:-/usr/local/bin}
  echo "Downloading xk6-disruptor $XK6_DISRUPTOR_VERSION"
  curl -sSL "$XK6_DISRUPTOR_URL" |
    tar -xzC "$XK6_DISRUPTOR_INSTALL_PATH"

  mv "$XK6_DISRUPTOR_INSTALL_PATH/xk6-disruptor-linux-amd64" "$XK6_DISRUPTOR_INSTALL_PATH/xk6-disruptor"

  echo "xk6-disruptor $XK6_DISRUPTOR_VERSION installed to $XK6_DISRUPTOR_INSTALL_PATH"
}

function socks_shop() {
  # TODO: Set up renovate to upgrade these.
  SOCKS_SHOP_VERSION=${SOCKS_SHOP_VERSION:-master} # Latest tag (0.0.12) yields 404 for the combined manifest.
  SOCKS_SHOP_URL=${SOCKS_SHOP_URL:-https://raw.githubusercontent.com/microservices-demo/microservices-demo/$SOCKS_SHOP_VERSION/deploy/kubernetes/complete-demo.yaml}

  echo "Starting deployment of socks-shop demo application..."
  kubectl create namespace sock-shop >/dev/null
  kubectl apply -f "$SOCKS_SHOP_URL" &>/dev/null \
    || error "deploying socks shop application"

  echo "Deployment completed!"
}

function socks_shop_ingress() {
  TRAEFIK_VERSION=${TRAEFIK_VERSION:-v2.10}
  echo "Configuring ingress for socks-shop demo application..."
  #kubectl apply -f "https://raw.githubusercontent.com/traefik/traefik/$TRAEFIK_VERSION/docs/content/reference/dynamic-configuration/kubernetes-crd-definition-v1.yml" &>/dev/null \
  #  || error "applying traefik CRDs"

  # TODO: Change fork URL.
  kubectl apply -f "https://raw.githubusercontent.com/roobre/xk6-disruptor-demo/main/manifests/front-end-ingress-traefik.yaml" &>/dev/null \
    || error "creating traefik ingress"

  echo "Ingress configured."
}

case $1 in
"xk6_disruptor")
  xk6_disruptor
  ;;
"socks_shop")
  socks_shop
  ;;
"socks_shop_ingress")
  socks_shop_ingress
  ;;
esac

