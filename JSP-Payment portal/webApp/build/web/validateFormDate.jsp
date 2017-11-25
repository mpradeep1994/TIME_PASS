<%-- 
    Document   : validateFormDate.jsp
    Created on : Nov 10, 2017, 7:03:54 AM
    Author     : pradeep
--%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date" %>
<%@page import="java.net.URLEncoder" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Welcome to the BANK </title>
    </head>
    <body>
        <h2>Validation is performed on the card:  </h2>
       
        
    <%!
        
        
    public boolean validatenumner(String ccnumber ) 
    {
        
        int sum=0;
        for (int j = ccnumber.length() - 2 ; j >= 0 ; j = j-2 ) 
        {
            int temp = (Character.getNumericValue(ccnumber.charAt(j))) * 2;
            if ( temp > 9 ){
                temp = temp%10 + 1;
            }
        sum =sum+temp+(Character.getNumericValue(ccnumber.charAt(j+1)));   
        }

        if ((sum % 10) == 0){
          return false;
        }
    return true;
    }
    
%>

        
        <%
            try {
            
            String validation = "";
            String expdate = request.getParameter("expdate");
            String amnt = request.getParameter("amount_req");
            String creditcardnumber=request.getParameter("creditcardnumber");
            int cnumlength = String.valueOf(creditcardnumber).length();
            String ctype = request.getParameter("ctype");
            String pin = request.getParameter("pin");
            String month=expdate.substring(0,2);
            String year=expdate.substring(2,4);
            
           //setting up session objects
            session.setAttribute("CreditCardNumber", creditcardnumber);
            session.setAttribute("CreditCardType",ctype);
            session.setAttribute("Pin", pin);
            session.setAttribute("Amount", amnt);
            session.setAttribute("month", month);
            session.setAttribute("year",year);
           
            
            //Amount validation
            boolean Flag = new Boolean(false);
            if(!amnt.equalsIgnoreCase("")){
                if (Integer.parseInt(amnt) > 500 || Integer.parseInt(amnt) < 0) {
                    validation=" Amount is Invalid. Amount should be less than 500$ <br/>";
                    Flag = true;
                } 
            }
            else{ 
                validation=" Amount is Invalid. Amount should be less than 500$ <br/>";
                Flag = true;
            }
            
            //pin validation  
            if(!pin.equalsIgnoreCase("")){
       
            if (pin.charAt(0) == pin.charAt(1) && pin.charAt(0) == pin.charAt(2) && pin.charAt(0) == pin.charAt(3)) {
                validation=validation.concat(" Invalid PIN details. Pin cannot have same number for all digits<br/>");
                Flag = true;
            }
            }else{
                validation=validation.concat(" Invalid PIN Number. Pin cannot be empty <br/>");
                Flag = true;
            }
            
            //date validation
            SimpleDateFormat df = new SimpleDateFormat("MMyy");
            Date exp_date = df.parse(expdate);
            Date Cur_date = new Date();
            if (Cur_date.after(exp_date)) {
                validation=validation.concat("Date needs to be in Future.<br/>");
                Flag=true;
            }
            // MASTERCARD
            if (cnumlength != 0 || cnumlength <= 16) {
                if (ctype.equalsIgnoreCase("MASTER CARD")) {
                    int start = Integer.parseInt(creditcardnumber.substring(0, 2));
                        if (start >= 10 && start <= 99) {
                            boolean mod = validatenumner(creditcardnumber);
                            
                            if (mod) {
                                Flag=true;
                                validation=validation.concat( "This is a Invalid Card Number number should begin with 22-55... eg: 2720992400837400");
                            }    
                        }
                        else{
                         validation=validation.concat( "This is a Invalid  Card Number number should begin with  22-55...");
                        }
                }
                else if (ctype.equalsIgnoreCase("VISA")){
                int start = Integer.parseInt(creditcardnumber.substring(0, 2));
                        if (start >= 10 && start <= 99){
                            boolean mod = validatenumner(creditcardnumber);
                            if (mod) {
                                Flag=true;
                                validation=validation.concat( "This is a Invalid  Card Number number should begin with 13-19...");
                            }    
                        }
                        else{
                         validation=validation.concat( "This is a Invalid  Card Number number should begin with 13-19...");
                        }
                }
                
                else if (ctype.equalsIgnoreCase("DISCOVER CARD")){
                int start = Integer.parseInt(creditcardnumber.substring(0, 2));
                        if (start >= 10 && start <= 99) {
                            boolean mod = validatenumner(creditcardnumber);
                            if (mod) {
                                Flag=true;
                                validation=validation.concat( "This is a Invalid  CARD Number number should begin with 55-65... eg: 6011094933968353");
                            }    
                        }
                        else{
                         validation=validation.concat( "This is a Invalid  CARD number should begin with 55-65...eg:6011094933968353");
                        }
                }
            }
            else {
                validation=validation.concat("Enter All Numbers of Your Credit Card");
            }
            
            
            if(Flag == true){  
                //out.println(validation);    
                response.sendRedirect("./GetFormData.jsp?message=" + URLEncoder.encode(validation, "UTF-8"));
                //RequestDispatcher requestDispatcher = request.getRequestDispatcher("./GetFormData.jsp?message=" + URLEncoder.encode(validation, "UTF-8"));
                //requestDispatcher.forward(request, response);
            }
            else{
                out.println(validation); 
                response.sendRedirect("./ProcessCreditRequest.jsp");
                //requestDispatcher = request.getRequestDispatcher("ProcessCreditRequest.jsp");
               //requestDispatcher.forward(request, response);
           }
            
            }
            catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </body>
</html>
