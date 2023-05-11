Let's inject some faults in the `Catalogue` service:

![Fault injection diagram](https://raw.githubusercontent.com/grafana/xk6-disruptor-demo/main/images/test.png)

We will now run the same test as before, but with fault injection enabled. To do so, run the following command:


```
xk6-disruptor run --env SVC_URL=localhost/front-end --env INJECT_FAULTS=1 ./test-front-end.js
```{{exec}}

This time, we expect the test to fail:

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


running (01m05.3s), 000/006 VUs, 1201 complete and 0 interrupted iterations
inject ✓ [======================================] 1 VUs        01m05.3s/10m0s  1/1 shared itersaverage
load   ✓ [======================================] 000/005 VUs  1m0s            20.00 iters/s

     ✗ No errors
      ↳  89% — ✓ 1073 / ✗ 127

✗ checks.........................: 89.41% ✓ 1073      ✗ 127
data_received..................: 664 kB 10 kB/s
data_sent......................: 164 kB 2.5 kB/s
http_req_blocked...............: avg=18.04µs  min=5.95µs  med=10.28µs  max=892.64µs p(90)=13.84µs  p(95)=17.08µs
http_req_connecting............: avg=4.77µs   min=0s      med=0s       max=699.49µs p(90)=0s       p(95)=0s      
http_req_duration..............: avg=101.43ms min=5.78ms  med=109.45ms max=125.46ms p(90)=112.72ms p(95)=113.67ms
{ expected_response:true }...: avg=101.43ms min=5.78ms  med=109.45ms max=125.46ms p(90)=112.72ms p(95)=113.67ms
http_req_failed................: 0.00%  ✓ 0         ✗ 1200
http_req_receiving.............: avg=482.26µs min=80.69µs med=392.02µs max=13.55ms  p(90)=741.59µs p(95)=878.89µs
http_req_sending...............: avg=55.72µs  min=28.08µs med=50.63µs  max=972.47µs p(90)=70.38µs  p(95)=82.15µs
http_req_tls_handshaking.......: avg=0s       min=0s      med=0s       max=0s       p(90)=0s       p(95)=0s      
http_req_waiting...............: avg=100.9ms  min=5.52ms  med=109.02ms max=125.12ms p(90)=112.12ms p(95)=112.82ms
http_reqs......................: 1200   18.376378/s
iteration_duration.............: avg=156.23ms min=6.25ms  med=109.94ms max=1m5s     p(90)=113.3ms  p(95)=114.35ms
iterations.....................: 1201   18.391692/s
vus............................: 1      min=1       max=6
vus_max........................: 6      min=6       max=6

ERRO[0062] some thresholds have failed
```
