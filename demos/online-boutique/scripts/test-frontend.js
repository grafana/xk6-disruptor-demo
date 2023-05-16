import http from 'k6/http';
import { check } from 'k6';
import { ServiceDisruptor } from 'k6/x/disruptor'

export const options = {
    thresholds: {
        checks: ['rate>0.99'],
    },
    scenarios: {
        load: {
            executor: 'constant-arrival-rate',
            rate:   20,
            preAllocatedVUs: 5,
            maxVUs: 100,
            exec: 'requestProduct',
            startTime: '0s',
            duration: '30s',
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
    const res = http.get(`http://${__ENV.SVC_URL}/product/OLJCESPC7Z`);
    check(res, {
        'No errors': (res) => res.status === 200,
    });
}

export function injectFaults(data) {
    if (__ENV.INJECT_FAULTS != "1") {
        return
    }

    const fault = {
        port: 3550,
        errorRate: 0.1,
        statusCode: 10,
    };

    const svcDisruptor = new ServiceDisruptor('productcatalogservice', 'boutique');
    svcDisruptor.injectGrpcFaults(fault, "30s");
}
