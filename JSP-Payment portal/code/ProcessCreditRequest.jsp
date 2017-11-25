<%-- 
    Document   : ProcessCreditRequest.jsp
    Created on : Nov 2, 2017, 4:26:35 PM
    Author     : admin
--%>

<%@page import="java.io.PrintWriter"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Welcome to the Bank</title>
    </head>
<style>
    
#customers {
    font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
    border-collapse: collapse;
    width: 100%;
}

#customers td, #customers th {
    border: 1px solid #ddd;
    padding: 8px;
}

#customers tr:nth-child(even){background-color: #f2f2f2;}

#customers tr:hover {background-color: #ddd;}

</style>
    <body>
        <h1>Welcome Customer!</h1>
        
        <%

            String amount = session.getAttribute("Amount").toString();
            String creditcardnumber=session.getAttribute("CreditCardNumber").toString();
            String ctype = session.getAttribute("CreditCardType").toString();
            String pin = session.getAttribute("Pin").toString();
            String month=session.getAttribute("month").toString();
            String year=session.getAttribute("year").toString();
            out.print("<table id='customers'><tr>");
            out.print("<td>Credit Card number</td><td>" + creditcardnumber);
            out.print("</td></tr><tr><td>Credit Card Type</td><td>" + ctype);
            out.print("</td></tr><tr><td>Month</td><td>" + month);
            out.print("</td></tr><tr><td>Year</td><td>" + year);
            out.print("</td></tr><tr><td>Amount</td><td>" + amount);
            out.print("</td></tr></table>");
            %>
            
    <center> <h1> Payment Successful!!!</h1></center>
    </body>
</html>
