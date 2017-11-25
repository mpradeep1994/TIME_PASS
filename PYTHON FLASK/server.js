 // include the http module
var http = require('http');
var soap = require('soap');
var url = 'http://localhost:8080/SOA_WebService/payments_service?wsdl';
var args = {name: 'value'};
 
 
  soap.createClient(url, function(err, client) {
      client.getPaymentID(args, function(err, result) {
          console.log(result);
      });
  });