from flask import Flask, Response, request
import os.path,subprocess
from subprocess import STDOUT,PIPE
import json

app = Flask(__name__, static_url_path='/static')

@app.route("/")
def hello():
    return "hello"

@app.route("/compile/", methods = ['POST'])
def hello4():
    data = request.get_json()["Code"]
    f = open("exp", "w")
    for line in data:
        f.write(line)
    f.close()
    proc = subprocess.Popen(["sh", "./script.sh"], stdout=PIPE, stderr=PIPE)
    stdout,stderr = proc.communicate()
    return stdout

def shutdown_server():
    func = request.environ.get('werkzeug.server.shutdown')
    if func is None:
        raise RuntimeError('Not running with the Werkzeug Server')
    func()

@app.route('/shutdown/', methods=['POST'])
def shutdown():
    shutdown_server()
    return 'Server shutting down...'

if __name__ == "__main__":
	app.run(host= '0.0.0.0', port=8000)