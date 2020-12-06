def get_value(inp_obj, inp_key):
    '''
    Function to get the value of the key fron a nested object, if present.
    If the key is not present it returns None
    '''
    key_list = inp_key.replace('/', '').replace(' ', '')
    try:
        for key in key_list:
            if key in inp_obj.keys():
                #Iterate over the "value", till key exists in the object.
                inp_obj = inp_obj[key]
                continue
            else:
                #Key does not exist and hence return None.
                return None
        #Value was found sucessfully, return the "value" of the object for the provided key.
        return inp_obj
    except AttributeError:
        return None


#get_value({"a":{"b":{"c":"d"}}}, "a")
#get_value({"a":{"b":{"c":"d"}}}, "a/b")
#get_value({"a":{"b":{"c":"d"}}}, "a/b/c")
#get_value({"a":{"b":{"c":"d"}}}, "a/b /c")
#get_value({"a":{"b":{"c":"d"}}}, "a/b/c/")
#get_value({"a":{"b":{"c":"d"}}}, "a/b%/c/")
#get_value({"a":{"b":{"c":"d"}}}, "a/b{/c/")
#get_value({"a":{"b":{"c":"d"}}}, "a/b.key()/c/")
#get_value({"x":{"y":{"z":"a"}}}, "x/y/z")
#get_value({"x":{"y":{"z":"a"}}}, "x/y/z/s")
#get_value({"x":{"y":{"y":"a"}}}, "x/y/z")
#get_value({"x":{"y":{"y":"a"}}}, "x/y/z/s")
