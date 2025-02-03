#!/bin/bash

ADMIN_PASSWORD=$1

# Check if Nexus API is reachable
echo "Checking Nexus API availability..."
until curl -s -o /dev/null -w "%{http_code}" -u admin:$ADMIN_PASSWORD http://localhost:8081/service/rest/v1/security/users | grep 200; do
  echo "Waiting for Nexus API..."
  sleep 5
done

# Create new user
echo "Creating new user..."
curl -u admin:$ADMIN_PASSWORD -X POST 'http://localhost:8081/service/rest/v1/security/users' \
-H 'Content-Type: application/json' \
-d '{
  "userId": "newuser",
  "firstName": "New",
  "lastName": "User",
  "emailAddress": "newuser@example.com",
  "password": "newuserpassword",
  "status": "active",
  "roles": ["nx-admin"]
}'

echo "User created successfully!"
