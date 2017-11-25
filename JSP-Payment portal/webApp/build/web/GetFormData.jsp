<%-- 
    Document   : GetFormData.jsp
    Created on : Nov 1, 2017, 5:15:29 PM
    Author     : admin
--%>


<%@page import="java.util.Date" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="/WEB-INF/tlds/custtag" prefix="custtag" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Credit Card Validation</title>
    <style> 
    input[type=text],input[type=password] {
        width: 100%;
        box-sizing: border-box;
        border: 2px solid #ccc;
        border-radius: 4px;
        font-size: 16px;
        background-color: white;
        background-position: 10px 10px; 
        background-repeat: no-repeat;
        padding: 12px 20px 12px 40px;
    }
    input[type=button], input[type=submit], input[type=reset] {
    background-color: #4CAF50;
    border: none;
    color: white;
    padding: 16px 32px;
    text-decoration: none;
    margin: 4px 2px;
    cursor: pointer;

}

    
    </style>    
     <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    </head>
    
    <% 
        Date date = new Date();
       
    %>
    
    <body>
        
        
    <div class="jumbotron text-center">
      <h1>Welcome to Payment Gateway!!</h1> 
      <p><h3> Please Enter Your Credit Card Details </h3></p> 
    </div>
    <center>
        <custag:
       
        <custtag:custtag id ='id1' value= 'red'> Current Date and Time is displayed from Custom Tag:   </custtag:custtag>
<h3> <p> ${param.message}</p></h3>        
        <form action="validateFormDate.jsp" method="POST" name = "myForm" >
            <table style="border-collapse:separate; border-spacing:1em;">
            <tbody>
                <tr><td>Credit Card Number : </td>
                    <td><input type="text" name="creditcardnumber" value="" placeholder="16 Digit Card Number" pattern="[0-9]+" maxlength="16" required/></td>
                </tr> <tr><td></td></tr>
                <tr><td>Credit Card Type </td>          
                    <td>
                        <select name="ctype" style=" width: 350px; height: 32px;">
                        <option value="MASTER CARD">MASTER CARD</option>
                        <option value="VISA">VISA</option>
                        <option value="DISCOVER CARD">DISCOVER CARD</option>
                        </select>
                     </td>          
                </tr>
                <tr><td>PIN : </td>
                    <td><input type="password" name="pin" value="" placeholder="Enter a 4 digit pin" pattern="[0-9][0-9][0-9][0-9]" maxlength="4" required/></td>
                </tr>
                <tr><td>Amount required : </td>
                    <td><input type="text" name="amount_req" value="" placeholder="Enter a Valid number" pattern="[0-9]+" required></td>
                </tr>
                <tr><td> Expiration date : </td>
                    <td><input type="text" name="expdate" placeholder="MMYY" class="masked" pattern="[0-1][0-2][1-5][0-9]" data-valid-example="0518" required/></td>
                </tr>
                <tr>
                    <td></td><td><input type="submit" name="ValidateFormDate" value="validate" required/></td>
                </tr>
                 <tr>
                    <td></td>
                </tr>
                
            </tbody>
        </table>
      
      </form>
      </center>
    </body>
</html>
