import requests
import json

#Define some variables and headers
url = "http://169.254.169.254/latest"

token_header = {'X-aws-ec2-metadata-token-ttl-seconds' : '60'}

#Get the token for our requests.
token = requests.put(url + '/api/token', headers=token_header)

query_header = {'X-aws-ec2-metadata-token' : token.text}

def get_value(url):
    '''
    Function to get the value from the metadata url depending on the url that was passed.
    '''
    return requests.get(url, headers=query_header).text

def recursive_values(url, input_dict):
    initial_list = [x for x in get_value(url).split('\n') ]
    for obj in initial_list:
        if obj.endswith('/'):
            key = obj.replace('/', '')
            input_dict[key] = {}
            recursive_values(url + obj , input_dict[key] )
        else:
            #For the easy case
            input_dict[obj] = get_value(url + obj)
    return

json_dict = {}
#Initial value from the metadata url. Does not cover dynamic values for now.
recursive_values(url + '/meta-data/', json_dict)

#Convert to json.
print(json.dumps(json_dict))
