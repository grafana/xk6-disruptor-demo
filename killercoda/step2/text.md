## Baseline test


We have prepared a simple script for you to try this out, `test-front-end.js`. Let's download it now:

```
curl -LO https://raw.githubusercontent.com/grafana/xk6-disruptor-demo/main/scripts/test-front-end.js
```{{exec}}

Feel free to take a peek at the `test-front-end.js` in the `Editor` tab!

After that, let's use k6 to perform a baseline test of our applicaton:

```
xk6-disruptor run --env SVC_URL=localhost/front-end ./test-front-end.js
```{{exec}}

We expect the output of the test to look like this:

```
        /\      |‾‾| /‾‾/   /‾‾/   
   /\  /  \     |  |/  /   /  /    
  /  \/    \    |     (   /   ‾‾\  
 /          \   |  |\  \ |  (‾)  |
/ __________ \  |__| \__\ \_____/ .io

execution: local
script: scripts/test-front-end.js
output: -

scenarios: (100.00%) 2 scenarios, 101 max VUs, 10m30s max duration (incl. graceful stop):
* inject: 1 iterations shared among 1 VUs (maxDuration: 10m0s, exec: injectFaults, gracefulStop: 30s)
* load: 20.00 iterations/s for 1m0s (maxVUs: 5-100, exec: requestProduct, gracefulStop: 30s)


running (01m00.0s), 000/006 VUs, 1202 complete and 0 interrupted iterations
inject ✓ [======================================] 1 VUs        00m00.0s/10m0s  1/1 shared iters
load   ✓ [======================================] 000/005 VUs  1m0s            20.00 iters/s

     ✓ No errors

     checks.........................: 100.00% ✓ 1201      ✗ 0   
     data_received..................: 691 kB  12 kB/s
     data_sent......................: 165 kB  2.7 kB/s
     http_req_blocked...............: avg=17.06µs min=6.07µs  med=9.82µs   max=1.08ms   p(90)=13.52µs  p(95)=15.07µs 
     http_req_connecting............: avg=4.44µs  min=0s      med=0s       max=485.07µs p(90)=0s       p(95)=0s      
     http_req_duration..............: avg=9.37ms  min=5.34ms  med=8.13ms   max=221.39ms p(90)=10.38ms  p(95)=11.29ms 
       { expected_response:true }...: avg=9.37ms  min=5.34ms  med=8.13ms   max=221.39ms p(90)=10.38ms  p(95)=11.29ms 
     http_req_failed................: 0.00%   ✓ 0         ✗ 1201
     http_req_receiving.............: avg=468µs   min=73.98µs med=391.43µs max=46.01ms  p(90)=662.87µs p(95)=786.08µs
     http_req_sending...............: avg=53.04µs min=29.5µs  med=49.57µs  max=189.28µs p(90)=69.32µs  p(95)=75.64µs 
     http_req_tls_handshaking.......: avg=0s      min=0s      med=0s       max=0s       p(90)=0s       p(95)=0s      
     http_req_waiting...............: avg=8.85ms  min=5.19ms  med=7.66ms   max=220.09ms p(90)=9.71ms   p(95)=10.69ms 
     http_reqs......................: 1201    20.011126/s
     iteration_duration.............: avg=9.86ms  min=48.58µs med=8.62ms   max=222.21ms p(90)=10.89ms  p(95)=11.97ms 
     iterations.....................: 1202    20.027788/s
     vus............................: 5       min=5       max=5 
     vus_max........................: 6       min=6       max=6 ```
