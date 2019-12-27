#!/bin/bash
set -e
echo "--------------------------------------------------"
echo "                START DOCKER DAEMON               "
echo "--------------------------------------------------"
sh /usr/local/bin/dockerd-entrypoint.sh &

echo "--------------------------------------------------"
echo "                   ENVIRONMENTS                   "
echo "--------------------------------------------------"
echo $B2FLOW__REGISTRY__GCP__KEYFILE | base64 -d > registry-auth.json
cat registry-auth.json | docker login -u _json_key --password-stdin https://gcr.io

echo "--------------------------------------------------"
echo "                   ENVIRONMENTS                   "
echo "--------------------------------------------------"
export B2FLOW__SOURCE_FILE=source.zip
export B2FLOW__SOURCE_PATH=$(pwd)/source
export B2FLOW__IMAGE_NAME="gcr.io/${B2FLOW__GOOGLE__PROJECT_ID}/${B2FLOW__TEAM__NAME}_${B2FLOW__PROJECT__NAME}_${B2FLOW__DAG__NAME}_${B2FLOW__DAG__JOB__NAME}:${B2FLOW__DAG__VERSION}"
env | grep B2FLOW


echo "--------------------------------------------------"
echo "               DOWNLOAD SOURCE CODE               "
echo "--------------------------------------------------"
python3 -m b2flow_builder.download; ls -lh $B2FLOW__SOURCE_FILE

echo "--------------------------------------------------"
echo "                 UNZIP SOURCE CODE                "
echo "--------------------------------------------------"
mkdir -p $B2FLOW__SOURCE_PATH; cp $B2FLOW__SOURCE_FILE $B2FLOW__SOURCE_PATH; cd $B2FLOW__SOURCE_PATH
unzip $B2FLOW__SOURCE_FILE; ls -lhR

echo "--------------------------------------------------"
echo "                  BUILDING IMAGE                  "
echo "--------------------------------------------------"
cd $B2FLOW__SOURCE_PATH/$B2FLOW__DAG__JOB__NAME; docker build -t $B2FLOW__IMAGE_NAME .

echo "--------------------------------------------------"
echo "                    SUBMIT IMAGE                  "
echo "--------------------------------------------------"
docker push $B2FLOW__IMAGE_NAME
