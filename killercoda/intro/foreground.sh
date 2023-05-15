# Hold tight while we fetch our installer script.
curl -sSLO "https://raw.githubusercontent.com/roobre/xk6-disruptor-demo/main/killercoda/install.sh" && chmod +x install.sh
#
# We'll now install the xk6-disruptor binary for you.
#
./install.sh xk6-disruptor
#
# Next, let's install the Sock Shop demo application.
#
./install.sh sock-shop
#
# Now let's create an ingress for that demo application.
#
./install.sh sock-shop-ingress
#
# Finally, we'll export the path for the kubeconfig file
#
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
#
# ===================================================================================
# Everything is set! Kubernetes is working hard to get the demo application ready.
# This can take several minutes. Hold tight. 
# Check the instructions panel on the left to see how to check the deployment status.
# ===================================================================================
