#!/bin/bash

echo """
This script will remove all Docker tags older than 7 days
from the Docker Hub repository for TerraflaskqlK8s.
Usage: ./docker-clean.sh

Starting...
"""

# Fetch credentials and repository info from secrets/environment variables.
docker_user="${DOCKER_USERNAME}"
docker_repo="${DOCKER_REPO}"   # Set this secret to "yuvalbenar/terraflaskqlk8s"
docker_token="${DOCKER_PASSWORD}"  # Using DOCKER_PASSWORD as the token

sleep 2

echo ""
echo "Fetching current tags in Docker Hub repo and displaying them..."

# Access Docker Hub API to fetch all current tags and format using jq.
tags=$(curl -s -H "Authorization: Bearer $docker_token" \
    "https://hub.docker.com/v2/repositories/$docker_user/$docker_repo/tags/?page_size=100" \
    | jq '[.results[] | {name: .name, created_at: (.tag_last_pushed | split("T")[0])}]')

echo "$tags"
sleep 2

echo ""
echo "Comparing dates and determining outdated tags (older than 7 days)..."

today_minus_week=$(date -d "-7 days" "+%s")
echo ""
echo "Tags created before $(date -d "-7 days") will be deleted."
echo ""

# Iterate over each tag and delete if it's older than 7 days.
echo "$tags" | jq -c '.[]' | while IFS= read -r tag_object; do
    tag=$(echo "$tag_object" | jq -r '.name')
    tag_date_only=$(echo "$tag_object" | jq -r '.created_at')

    echo "Checking tag '$tag' with creation date $tag_date_only"

    if [[ "$(date -d "$tag_date_only" "+%s")" -lt "$today_minus_week" ]]; then
        echo "Removing tag '$tag'..."
        curl -X DELETE -H "Authorization: Bearer $docker_token" \
            "https://hub.docker.com/v2/repositories/$docker_user/$docker_repo/tags/$tag/"
        echo "Tag '$tag' deleted!"
        echo ""
        sleep 1
    else
        echo "Tag '$tag' is not outdated. Keeping it."
        echo ""
        sleep 1
    fi
done

echo "Displaying remaining tags after cleanup:"
remaining_tags=$(curl -s -H "Authorization: Bearer $docker_token" \
    "https://hub.docker.com/v2/repositories/$docker_user/$docker_repo/tags/?page_size=100" \
    | jq '.results[].name')

echo "$remaining_tags"

echo ""
echo "Docker Hub tag cleanup completed. Exiting..."
echo ""
