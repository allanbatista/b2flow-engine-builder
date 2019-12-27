import boto3
from botocore.client import Config


class Storage:
    def __init__(self, storage_type, access_key_id, secret_access_key, region_name):
        self.session = boto3.session.Session(aws_access_key_id=access_key_id,
                                             aws_secret_access_key=secret_access_key,
                                             region_name=region_name)

        if storage_type == 'gcs':
            self.client = self.session.resource('s3',
                                                endpoint_url='https://storage.googleapis.com',
                                                config=Config(signature_version='s3v4'))
        else:
            self.client = self.session.resource('s3')
