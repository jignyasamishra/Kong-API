import http from 'k6/http';
import { sleep } from 'k6';

export let options = {
    stages: [
        { duration: '2m', target: 20 }, // Simulate ramp up of traffic from 1 to 20 users over 30 seconds.
        { duration: '5m', target: 20 },  // Stay at 20 users for 1 minute
        { duration: '2m', target: 0 },  // Ramp down to 0 users
    ]
};

export default function () {
    http.get('http://localhost:8000/demo');
    sleep(1); // Think time between requests
}
