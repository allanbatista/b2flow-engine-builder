#!/usr/bin/env bash
set -e

echo "--------------------------------------------------"
echo "                   ENVIRONMENTS                   "
echo "--------------------------------------------------"
export B2FLOW__SOURCE_FILE=source.zip
export B2FLOW__SOURCE_PATH=$(pwd)/source
export B2FLOW__IMAGE_NAME="gcr.io/${B2FLOW__GOOGLE__PROJECT_ID}/${B2FLOW__IMAGE__NAME}:${B2FLOW__IMAGE__TAG}"
env | grep B2FLOW

echo "--------------------------------------------------"
echo "                START DOCKER DAEMON               "
echo "--------------------------------------------------"
/usr/local/bin/dockerd-entrypoint.sh &
DOCKER_PID=$!
echo "DOCKER_PID=${DOCKER_PID}"
sleep 10 # wait docker process to be running. i know this is ungly.
docker ps

echo "--------------------------------------------------"
echo "                 REGISTRY LOGIN                   "
echo "--------------------------------------------------"
echo $B2FLOW__REGISTRY__GCP__KEYFILE | base64 -d > registry-auth.json
cat registry-auth.json | docker login -u _json_key --password-stdin https://gcr.io

echo "--------------------------------------------------"
echo "               DOWNLOAD SOURCE CODE               "
echo "--------------------------------------------------"
python3 -m b2flow_builder.download

echo "--------------------------------------------------"
echo "                 UNZIP SOURCE CODE                "
echo "--------------------------------------------------"
unzip -o $B2FLOW__SOURCE_FILE -d $B2FLOW__SOURCE_PATH

echo "--------------------------------------------------"
echo "                  BUILDING IMAGE                  "
echo "--------------------------------------------------"
cd $B2FLOW__SOURCE_PATH/$B2FLOW__DAG__JOB__NAME; docker build -t $B2FLOW__IMAGE_NAME .

echo "--------------------------------------------------"
echo "                    SUBMIT IMAGE                  "
echo "--------------------------------------------------"
docker push $B2FLOW__IMAGE_NAME

echo "--------------------------------------------------"
echo "                  KILL DOCKER PID                 "
echo "--------------------------------------------------"
kill -9 $DOCKER_PID 2>/dev/null

exit 0