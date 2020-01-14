import boto3
from botocore.client import Config
from botocore.handlers import set_list_objects_encoding_type_url

boto3.set_stream_logger('')

class Storage:
    def __init__(self, storage_type, access_key_id, secret_access_key, region_name):
        self.session = boto3.session.Session(aws_access_key_id=access_key_id,
                                             aws_secret_access_key=secret_access_key,
                                             region_name=region_name)

        self.session.events.unregister('before-parameter-build.s3.ListObjects', set_list_objects_encoding_type_url)

        if storage_type == 'gcs':
            self.client = self.session.resource('s3',
                                                endpoint_url='https://storage.googleapis.com',
                                                config=Config(signature_version='s3v4'))
        else:
            self.client = self.session.resource('s3')
