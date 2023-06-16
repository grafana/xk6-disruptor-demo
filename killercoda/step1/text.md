## Application overview

The sock shop application we just deployed looks like this:

![Architecture diagram](https://raw.githubusercontent.com/grafana/xk6-disruptor-demo/main/demos/socks-shop/images/socks-shop.png)

Let's check if we can access the `Catalogue` service through the `Front-end` service:

```
curl -v localhost/catalogue/3395a43e-2d88-40de-b95f-e00e1502085b | jq
```{{exec}}

You should see something like:

```json
{
  "id": "3395a43e-2d88-40de-b95f-e00e1502085b",
  "name": "Colourful",
  "description": "proident occaecat irure et excepteur labore minim nisi amet irure",
  "imageUrl": [
    "/catalogue/images/colourful_socks.jpg",
    "/catalogue/images/colourful_socks.jpg"
  ],
  "price": 18,
  "count": 438,
  "tag": [
    "brown",
    "blue"
  ]
}
```

Did that work? If so, let's click `Next` and start testing.

### If you didn't get the expected response

The sock-shop demo application may still be deploying. Try running

```
kubectl get pods -n sock-shop
```{{exec}}

And ensure all pods are `Running` and fully `Ready`.

Still stuck? You may have hit a bug in our demo environment! Please let us know what happened by [opening an issue](https://github.com/grafana/xk6-disruptor-demo/issues).
