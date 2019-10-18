from urllib import request, parse
data = parse.urlencode({"data":"rishabh"}).encode()
req =  request.Request("http://192.168.43.100:8000/compile", data = data) # this will make the method "POST"
resp = request.urlopen(req)
print(resp)