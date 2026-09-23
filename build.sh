#!/usr/bin/env bash
# Render Native Build Script (alternative to Docker)
# Exit immediately if a command exits with a non-zero status
set -e

echo "Starting backend build..."
cd backend
mvn clean package -DskipTests -B
echo "Backend build finished successfully!"
