# xk6-disruptor interactive demo

```
          /\      |‾‾| /‾‾/   /‾‾/
     /\  /  \     |  |/  /   /  /
    /  \/    \    |     (   /   ‾‾\
   /          \   |  |\  \ |  (‾)  |
  / __________ \  |__| \__\ \_____/ .io
```

Thanks for trying out xk6-disruptor! We're setting up the `xk6-disruptor` tool and a demo application for you. Hold tight while get everything ready!

During this interactive demo, we will:

1. Install the microservice-powered [sock shop](https://github.com/microservices-demo/microservices-demo) demo application.
2. Make a simple test to understand how the demo application works.
3. Perform a baseline test against the demo application.
4. Inject a fault on a backend service and observe how the frontend service behaves.

Step one is being taking care of on the right panel as you read this. After the deployment has been initiated successfully, you can check the deployment progress by running:

```
kubectl get pods --all-namespaces
```{{exec}}

All pods ready? Click `Start` to move on to the next step.
