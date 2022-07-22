<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% String projPath = request.getContextPath(); %>
<html>
    <head>
        <title>Internal Server Error</title>

        <link href="<%= projPath %>/style/UbqApp.css" rel="stylesheet" type="text/css">
  
    </head>
    <SCRIPT LANGUAGE="JavaScript" SRC="js/base/ValidateFunction.js"></SCRIPT>
    <script language="javascript">
        function errorClose(){
            window.opener=null;
            window.close();
            window.parent.close();
        }
        function setFocusClose(){
            document.error_form.closeWindowBtn.focus();
        }
    </script>
    <body onLoad="setFocusClose()" class="loginPageColor">  
       
        <div id="Layer2" class="style1 style2" style="position:absolute; left:50px; top:50px; z-index:2">
            <img src="images/outreach_big.png"> <br>
        </div>
        <p>

        <FORM name="error_form" METHOD="POST" onSubmit="return validate(this.userName.value);">

            <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td height="300" width="600">

                    </td>
                </tr>
                <tr>
                    <td colspan="3" width="100%" height="5px" class="bannerBackgroundColor"></td>
                </tr>

                <tr>
                    <td><p>&nbsp;</p></td>
                    <td><p>&nbsp;</p></td>

                    <td class="errorInfo"><p>
                        You do not have license to use this application.<br><br>
                        Please contact System Administrator.</font>
                    </p><br><br>      
                        <input type="button" name="closeWindowBtn" class="buttonSize" value="Close" onclick="errorClose()">
                    </td>
                </tr>

            </table>
        </FORM> 
    </body> 

</html>
