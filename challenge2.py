import requests
import json

def get_value(url):
    '''
    Function to get the value from the metadata url depending on the url that was passed.
    '''
    return requests.get(url, headers=query_header).text

#Define some variables and headers
url = "http://169.254.169.254/latest"

token_header = {'X-aws-ec2-metadata-token-ttl-seconds' : '60'}

#Get the token for our requests.
token = requests.put(url + '/api/token', headers=token_header)

query_header = {'X-aws-ec2-metadata-token' : token.text}

#Initial value from the metadata url. Does not cover dynamic values for now.
initial_list = [x for x in get_value(url + '/meta-data/').split('\n') ]
json_dict = {}
temp_obj = ""

for obj in initial_list:
    if obj.endswith('/'):
        #Work remaining here: Make nested json string
        #and try to handle the case where further down the line multiple nested objects can be passed by metadata url.
        temp_obj = obj
        while True:
            obj_value = get_value(url + '/meta-data/' + temp_obj)
            if obj_value.endswith('/'):
                temp_obj += obj_value
                continue
            else:
                json_dict[temp_obj] = obj_value
                break
    else:
        #For the easy case
        obj_value = get_value(url + '/meta-data/' + obj)
        json_dict[obj] = obj_value
#Convert to json.
print(json.dumps(json_dict))
