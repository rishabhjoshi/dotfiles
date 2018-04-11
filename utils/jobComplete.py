
# Author : Rishabh Joshi
# Insti  : IISc, Bangalore


from flask import Flask, request
import json, re, os

app = Flask(__name__)

@app.route('/jobComplete', methods = ['GET', 'POST'])
def jobComp():
    if request.method == 'POST':
        message = request.data
        os.system('say ' + message)
    else:
        return 'Error! in signal server'


if __name__ == "__main__":
    print "Server Running"
    app.run(host= '0.0.0.0', port = 9999)
