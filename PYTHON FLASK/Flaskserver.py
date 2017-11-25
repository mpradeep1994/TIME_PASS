from flask import Flask,session
from zeep import Client
import json
from flask import jsonify, render_template, request

app = Flask(__name__)
app.secret_key = 'A0Zr98j/3yX R~XHH!jmN]LWX/,?RT'
 
@app.route("/payments_service")
def payments_service():
	client = Client('http://localhost:8080/SOA_WebService/payments_service?wsdl')
	result = client.service.getPaymentID()
	return str(result)
"""
def setcookie(name,phone):
   resp = make_response(render_template(...))
   resp.set_cookie('name', name)
   resp.set_cookie('phone', phone)
   return resp
"""
@app.route("/pay")
def pay():
	name = request.args.get('email')
 	phone = request.args.get('password')
	client = Client('http://localhost:8080/SOA_WebService/customers_service?wsdl')
	result = client.service.getCustomerDetails(name,phone)
	session['name'] = str(name)
	session['phone'] = str(phone)
	if result != []:
		return result
		#return render_template('loginsuccess.html',result=result)
 	else:
		return render_template('loginfail.html')


@app.route("/customer_details")
def customer_details():
	name = session['name']
 	phone =  session['phone']
	client = Client('http://localhost:8080/SOA_WebService/customers_service?wsdl')
	result = client.service.getCustomerDetails(name,phone)
	return jsonify(result)


@app.route("/heo")
def hello1():
    return "World!"

@app.route("/")
def hello():
    return render_template('login.html')


if __name__ == "__main__":
    app.run()