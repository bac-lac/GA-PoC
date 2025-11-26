import boto3

print('Loading function')

def lambda_handler(event, context):
    ec2 = boto3.client('ec2')
    if event['detail']['eventName'] == 'CreateNetworkInterface':
        # Get the network interface ID from the event
        network_interface_id  = event['detail']['responseElements']['networkInterface']['networkInterfaceId']
        print("network_interface_id = " + network_interface_id)

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
    else:
        raise Exception('Exception in lambda_handler, event=', event)
