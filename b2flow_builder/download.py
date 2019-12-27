import os

from b2flow_builder.storage import Storage

storage = Storage(
    storage_type=os.environ['B2FLOW__STORAGE__TYPE'],
    access_key_id=os.environ['B2FLOW__STORAGE__S3__ACCESS_KEY_ID'],
    secret_access_key=os.environ['B2FLOW__STORAGE__S3__SECRET_KEY_ID'],
    region_name=os.environ['B2FLOW__STORAGE__S3__REGION']
)

bucket_name = os.environ['B2FLOW__STORAGE__S3__BUCKET']
bucket = storage.client.Bucket(bucket_name)
bucket.download_file(os.environ['B2FLOW__STORAGE__URI'].replace(f"s3://{bucket_name}/", ""), "source.zip")