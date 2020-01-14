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
uri = os.environ['B2FLOW__STORAGE__URI'].strip()

if uri.startswith("https"):
    _domain, _bucket_name, path = uri.replace("https://", "").split("/", 2)
    bucket.download_file(path, 'source.zip')

elif "s3" in uri or "gs" in uri:
    _bucket_name, path = uri.replace("s3://", "").replace("gs://", "").split("/", 1)
    bucket.download_file(path, "source.zip")

else:
    bucket.download_file(uri, "source.zip")
