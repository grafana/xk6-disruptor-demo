# xk6-disruptor-demo

The purpose of this repository is to offer a step-by-step guide for running [xk6-disruptor](https://github.com/grafana/xk6-disruptor) in a local development environment using demo applications.

## Interactive demos

You can also try this demos on an interactive environment on [Killercoda](https://killercoda.com). We'll take care of setting up Kubernetes and the demo applications for you so you can focus on learning the basics of `xk6-disruptor`.

If you prefer to run the demo entirely on your local machine, you can find instructions on how to proceed below.

## Before you start

This tutorial assumes that you are familiar with Kubernetes concepts such as [deploying applications](https://kubernetes.io/docs/concepts/workloads/) and exposing them using [services](https://kubernetes.io/docs/concepts/services-networking/service/).

Even when will provide all the required commands in this tutorial, it would also be convenient if you have some familiarity with using [kubectl](https://kubernetes.io/docs/reference/kubectl/) for managing applications in Kubernetes.

> :warning: The demo has been tested on Linux and Windows 11 - using a [Windows Terminal](https://apps.microsoft.com/store/detail/windows-terminal/9N0DX20HK701). It might not work with other OS.

## The case studies

### Socks Shop (HTTP fault injection demo)

The [Socks-shop application](https://github.com/microservices-demo/microservices-demo) implements a fully functional e-Commerce site that allows users to register, browse the catalog, and buy items. It follows a polyglot microservices-based architecture shown in the figure below. Each microservice has its own API that can be accessed directly using its corresponding Kubernetes service. The front-end service works as a backend for the web interface but also exposes the APIs of other services, working as a kind of API gateway.

You can try this demo on an interactive environment on [Killercoda](https://killercoda.com/grafana-xk6-disruptor/scenario/killercoda). 

See [Socks Shop demo](demos/socks-shop/README.md) for detailed instructions for installing this application and testing HTTP fault injection in this application

### Online boutique (gRPC fault injection)

[Online Boutique](https://github.com/GoogleCloudPlatform/microservices-demo) is a cloud-first microservices demo application. The application is a web-based e-commerce app where users can browse items, add them to the cart, and purchase them. Online Boutique consists of an 11-tier microservices application.

See [Online Boutique demo](demos/online-boutique/README.md) for instructions for installing this application and testing gRPC fault injection in this application.

## Installing xk6-disruptor

xk6-disruptor is a k6 extension. To use it in a k6 test script, it is necessary to use a custom build of k6 that includes it. You can get the binaries for different platforms from the [xk6-disruptor github repository](https://github.com/grafana/xk6-disruptor/releases). Refer to the [Installation Guide](https://k6.io/docs/javascript-api/xk6-disruptor/get-started/installation/) for more information.

> The rest of this tutorial assumes `xk6-disruptor` binary is available in the system path. In other words, you can invoke it just by typing `xk6-disruptor`. If this is not the case, you will have to modify the commands in this tutorial accordingly.

## Setup test environment

For this demo, we will be using a local Kubernetes cluster deployed using [Kind](https://kind.sigs.k8s.io/). Kind is a tool to run local Kubernetes clusters using Docker containers to emulate nodes.

For the setup, you will also need the `kubectl` tool.

### Install kubectl

Follow [official documentation](https://kubernetes.io/docs/tasks/tools/#kubectl) depending on your operating system.

### Install kind

Follow the [official documentation](https://kind.sigs.k8s.io/docs/user/quick-start/#installation) depending on your operating system.

## Create cluster

Create a local cluster with a name `demo` using the config file provided at `manifests\kind-config.yaml`. The resulting cluster will be configured to use the host port `38080` to access the ingress controller (see setup ingress below).

```shell
kind create cluster --name demo --config setup/kind-config.yaml
```

Output:

```shell
Creating cluster "demo" ...
 ✓ Ensuring node image (kindest/node:v1.24.0) 🖼
 ✓ Preparing nodes 📦  
 ✓ Writing configuration 📜 
 ✓ Starting control-plane 🕹️ 
 ✓ Installing CNI 🔌 
 ✓ Installing StorageClass 💾 
Set kubectl context to "kind-demo"
You can now use your cluster with:

kubectl cluster-info --context kind-demo

Thanks for using kind! 😊
```

> If you get an error message with the reason `Bind for 0.0.0.0:38080 failed: port is already allocated`, it means this port is already in use by another application. You can change the ports used by the cluster editing the [port mapping section](https://kind.sigs.k8s.io/docs/user/configuration/#extra-port-mappings) in the `manifests/kind-config.yaml` file. Remember the port used as you will need it later for accessing the application.

### Setup a service ingress

We will install the nginx ingress controller to expose services to the host machine:

```shell
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml
```

Output (some omitted for brevity):

```shell
namespace/ingress-nginx created
serviceaccount/ingress-nginx created
serviceaccount/ingress-nginx-admission created
...
```

### Set access to the cluster

The xk6-disruptor needs to interact with the Kubernetes cluster on which the application is running. To do so, you must have the credentials to access the cluster in a [kubeconfig file](https://kubernetes.io/docs/tasks/access-application-cluster/configure-access-multiple-clusters/).

Use the following command to set this configuration:

```shell
kind export kubeconfig --name demo
```

Output:

```shell
Set kubectl context to "kind-demo"
```

## Next steps

See [Socks Shop demo](demos/socks-shop/README.md) for detailed instructions for installing this application and testing HTTP fault injection in this application

See [Online Boutique demo](demos/online-boutique/README.md) for instructions for installing this application and testing gRPC fault injection in this application.

Learn more [about k6 and load testing](https://github.com/grafana/k6-learn).
