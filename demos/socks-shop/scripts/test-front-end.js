import http from 'k6/http';
import { check } from 'k6';
import { ServiceDisruptor } from 'k6/x/disruptor'
import { randomItem } from 'https://jslib.k6.io/k6-utils/1.2.0/index.js';

const products = [
 'a0a4f044-b040-410d-8ead-4de0446aec7e',
 '808a2de1-1aaa-4c25-a9b9-6612e8f29a38',
 '510a0d7e-8e83-4193-b483-e27e09ddc34d',
 '03fef6ac-1896-4ce8-bd69-b798f85c6e0b',
 'd3588630-ad8e-49df-bbd7-3167f7efb246',
 '819e1fbf-8b7e-4f6d-811f-693534916a8b',
 'zzz4f044-b040-410d-8ead-4de0446aec7e',
 '3395a43e-2d88-40de-b95f-e00e1502085b',
 '837ab141-399e-4c1f-9abc-bace40296bac',
];

export const options = {
   thresholds: {
       checks: ['rate>0.97'],
    },
    scenarios: {
        load: {
          executor: 'constant-arrival-rate',
          rate:   20,
          preAllocatedVUs: 5,
          maxVUs: 100,
          exec: 'requestProduct',
          startTime: '0s',
          duration: '60s',
        },
        inject: {
          executor: 'shared-iterations',
          iterations: 1,
          vus: 1,
          exec: 'injectFaults',
          startTime: '0s',
        }
    }
}

export function requestProduct() {
   const item = randomItem(products);
   const resp = http.get(`http://${__ENV.SVC_URL}/catalogue/${item}`);
   check(resp.json(), {
       'No errors': (body) => !('error' in body),
   });
   
}

const errorBody = '{"error":"Unexpected error","status_code":500,"status_text":"Internal Server Error"}';
export function injectFaults(data) {
    if (__ENV.INJECT_FAULTS != "1") {
        return
    }

    const fault = {
        averageDelay: '100ms',
        errorRate: 0.1,
        errorCode: 500,
        errorBody: errorBody,
        exclude: '/health',
    };

    const svcDisruptor = new ServiceDisruptor('catalogue', 'sock-shop'); (6)
    svcDisruptor.injectHTTPFaults(fault, '60s');
}
