#!/bin/bash
set -e

# Start Nexus in the background
bin/nexus run &

# Wait until Nexus is fully up and running
echo "Waiting for Nexus to start..."
until curl -s -o /dev/null -w "%{http_code}" http://localhost:8081/service/rest/v1/status | grep 200; do
  sleep 10
done

echo "Nexus started successfully!"

# Get admin password dynamically
ADMIN_PASSWORD=$(cat /nexus-data/admin.password 2>/dev/null || echo "admin123")

# Run user creation script
/opt/sonatype/create-nexus-users.sh "$ADMIN_PASSWORD"

# Keep Nexus running in foreground
wait
