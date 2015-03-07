import boto
import boto.ec2
import time
import os
BASE_DIR = os.path.dirname(__file__)


total_time = 3
region_zone = 'us-west-1b'
price = 0.8012
instance_type = 'c3.2xlarge'
key_name = 'key2'
with open(os.path.join(BASE_DIR, 'use_sotrage_for_docker_cloud_config.txt')) as fh:
    user_data = fh.read()

conn = boto.ec2.connect_to_region(region_zone[:-1])

requests = conn.request_spot_instances(
    instance_type=instance_type,
    price=price,
    image_id='ami-24b5ad61',
    key_name=key_name,
    security_groups=['EpiQuest slave'],
    user_data=user_data,
    placement=region_zone,
    instance_profile_name='EpiQuest_pipeline',
)
request_id = requests[0].id

# Wait for spot instance price is accepted.
while True:
    time.sleep(10)
    instance_id = conn.get_all_spot_instance_requests(request_ids=[request_id])[0].instance_id
    if instance_id:
        break
print "instance id:", instance_id

## wait for instance running
instance = conn.get_all_instances([instance_id])[0].instances[0]
time.sleep(3)
while instance.update()!="running":
    time.sleep(1)
    total_time += 1

    if total_time>60:
        raise Exception("The instance is still not running yet!")

## Auto add linux username to tags.
tags = {
    'Name': 'docker test',
    'launched by': 'hchung',
}
print "%s is running" %(instance.id)
