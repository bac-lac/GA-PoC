import boto3
import json

def lambda_handler(event, context):
    try:
        ec2 = boto3.client('ec2')
        if event['detail']['eventName'] == 'CreateNetworkInterface':
            # Get the network interface ID from the event
            network_interface_id  = event['detail']['responseElements']['networkInterface']['networkInterfaceId']

            # Define tags
            tags = [
                {'Key': 'SSC_CBRID', 'Value': '21YK'}
            ]

            # Apply tags
            ec2.create_tags(
                Resources=[network_interface_id],
                Tags=tags
            )

            return {
                'statusCode': 200,
                'body': "Tag created for network_interface_id: " + network_interface_id
            }
    except:
        return {
            'statusCode': 500,
            'body': "Exception in lambda_handler, event=" + json.dumps(event)
        }