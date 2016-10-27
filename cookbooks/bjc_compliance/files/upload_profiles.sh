#!/bin/sh
export API_TOKEN=$(curl -X POST https://localhost/api/login -k -s -d '{"userid": "workstation-1", "password": "workstation!"}')

cd /home/ubuntu

for tarprofile in $(ls *.tar.gz); do
  echo "Uploading ${tarprofile}"
  curl -X POST "https://localhost/api/owners/admin/compliance/${tarprofile%%.tar.gz}/tar" -k -H "Authorization: Bearer $API_TOKEN" --data-binary "@${tarprofile}"
done

for zipprofile in $(ls *.zip); do
  echo "Uploading ${zipprofile}"
  curl -X POST "https://localhost/api/owners/admin/compliance/${zipprofile%%.zip}/zip" -k -H "Authorization: Bearer $API_TOKEN" --data-binary "@${zipprofile}"
done
