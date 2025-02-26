#!/bin/bash
set -euo pipefail

# Define environment variables
ClusterName="clustername"
RegionName="ap-south-1"
FluentBitHttpPort="2020"
FluentBitReadFromHead="Off"

# Determine Fluent Bit log reading mode
if [[ ${FluentBitReadFromHead} == "On" ]]; then
    FluentBitReadFromTail="Off"
else
    FluentBitReadFromTail="On"
fi

# Determine HTTP Server status based on whether a port is specified
if [[ -z ${FluentBitHttpPort} ]]; then
    FluentBitHttpServer="Off"
else
    FluentBitHttpServer="On"
fi

# Define the manifest URL
ManifestUrl="https://raw.githubusercontent.com/aws-samples/amazon-cloudwatch-container-insights/latest/k8s-deployment-manifest-templates/deployment-mode/daemonset/container-insights-monitoring/quickstart/cwagent-fluent-bit-quickstart.yaml"

# Download and configure the Kubernetes manifest
echo "Downloading and configuring the Kubernetes manifest..."
ModifiedManifest=$(curl -sSfL ${ManifestUrl} | sed "s/{{cluster_name}}/${ClusterName}/;s/{{region_name}}/${RegionName}/;s/{{http_server_toggle}}/\"${FluentBitHttpServer}\"/;s/{{http_server_port}}/\"${FluentBitHttpPort}\"/;s/{{read_from_head}}/\"${FluentBitReadFromHead}\"/;s/{{read_from_tail}}/\"${FluentBitReadFromTail}\"/")

if [[ -z "$ModifiedManifest" ]]; then
    echo "Failed to download or modify the manifest."
    exit 1
fi

# Apply the Kubernetes manifest
echo "Applying the Kubernetes manifest..."
echo "${ModifiedManifest}" | kubectl apply -f -

echo "Deployment completed successfully."
