# -*- coding: utf-8 -*-
# MinIO Python Library for Amazon S3 Compatible Cloud Storage,
# (C) 2015 MinIO, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

from minio import Minio

minio_endpoint = "d4n-statsl-storage-minio.dev.officialstatistics.org"  # Replace with your Minio server endpoint
access_key = "plpc6DX3O6UATAdT"  # Replace with your Minio access key
secret_key = "5TWkzL4e3ZO8ZVkFjl3vwozsN2GGuvb4"  # Replace with your Minio secret key

client = Minio(
    minio_endpoint,
    access_key,
    secret_key,
    secure=False
)

if client.bucket_exists("raw"):
    print("my-bucket exists")
else:
    print("my-bucket does not exist")

