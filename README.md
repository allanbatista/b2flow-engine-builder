# b2flow-engine-builder

This project is responsible to build jobs before run.

## Executing Local


**build images**

```
docker-compose build
```

**configure**

update envvars with your credentials and configurations in docker-compose-example.yml

```
B2FLOW__DAG__NAME=x-dag1
B2FLOW__DAG__VERSION=1
B2FLOW__DAG__JOB__NAME=job1
B2FLOW__TEAM__NAME=x-team
B2FLOW__PROJECT__NAME=x-project
B2FLOW__GOOGLE__PROJECT_ID=eco-league-244218
B2FLOW__STORAGE__TYPE='gcs'
B2FLOW__STORAGE__S3__ACCESS_KEY_ID='key_id'
B2FLOW__STORAGE__S3__SECRET_KEY_ID='secret_id'
B2FLOW__STORAGE__S3__REGION='us-west1'
B2FLOW__STORAGE__S3__BUCKET='bucket-name'
B2FLOW__STORAGE__URI='s3://bucket-name/dags/source.zip'
B2FLOW__REGISTRY__GCP__KEYFILE='Service Account Encoded base64'
```

**run**

```
docker-compose up
```