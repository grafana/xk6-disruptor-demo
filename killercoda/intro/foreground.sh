# Hold tight while we fetch our installer script.
curl -sSLO "https://raw.githubusercontent.com/roobre/xk6-disruptor-demo/main/killercoda/install.sh" && chmod +x install.sh
#
# We'll now install the xk6-disruptor binary for you.
#
./install.sh xk6_disruptor
#
# Next, let's install the Sock Shop demo application.
#
./install.sh socks_shop
#
# Now let's create an ingress for that demo application.
#
./install.sh socks_shop_ingress

# ===================================================================================
# Everything set! Kubernetes is working hard to get the demo application ready.
# Check the instructions panel on the left to see how to check the deployment status.
# ===================================================================================
