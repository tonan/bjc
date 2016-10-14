#!/bin/sh
export API_TOKEN=$(curl -X POST https://localhost/api/login -k -s -d '{"userid": "workstation-1", "password": "workstation!"}')
curl -X POST "https://localhost/api/owners/admin/compliance/ssl-benchmark/tar" -k -H "Authorization: Bearer $API_TOKEN" --data-binary "@/home/ubuntu/ssl-benchmark.tar.gz"
