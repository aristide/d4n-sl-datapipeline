from minio import Minio
from minio.error import ResponseError
from minio.commonconfig import CopySource


# Set your Minio server credentials
minio_endpoint = "d4n-statsl-storage-minio.dev.officialstatistics.org"  # Replace with your Minio server endpoint
access_key = "plpc6DX3O6UATAdT"  # Replace with your Minio access key
secret_key = "5TWkzL4e3ZO8ZVkFjl3vwozsN2GGuvb4"  # Replace with your Minio secret key

# Initialize Minio client
minio_client = Minio(minio_endpoint, access_key=access_key, secret_key=secret_key, secure=False)

# Define your raw and anonymized buckets
raw_bucket_name = "raw"
anonymized_bucket_name = "anonymized"

# List all objects in the raw bucket
try:
    objects = minio_client.list_objects(raw_bucket_name)
    for obj in objects:
        # Copy each object from the raw bucket to the anonymized bucket
        source_object = obj.object_name
        dest_object = obj.object_name  # You can modify the destination object name if needed
        minio_client.copy_object(anonymized_bucket_name, dest_object, f'/{raw_bucket_name}/{source_object}')
        print(f"Copying {source_object} to {dest_object}")
except ResponseError as err:
    print(f"Minio error: {err}")

# Copy a single file from raw bucket to anonymed bucket
file_name="name" 
result = minio_client.copy_object(
    anonymized_bucket_name,
    file_name,
    CopySource(raw_bucket_name, file_name),
)
