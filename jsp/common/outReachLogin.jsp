<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
    String project = request.getContextPath();
%>
<html>
<head>
<title>Login Page</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">


<link href="<%=project%>/style/dqiColors.css" rel="stylesheet" type="text/css">
<link href="<%=project%>/style/dqiStyles.css" rel="stylesheet" type="text/css">
</head>
<SCRIPT LANGUAGE="JavaScript" SRC="<%=project%>/js/base/UbqValidations.js"></SCRIPT>
<script language="Javascript">

function wclose() {
  
  window.opener=null;
  self.close();
  window.parent.close();
} 

function setfocusUserName() {
  if (!document.login_form.userName.disabled) 
  document.login_form.userName.focus();
  else
      document.login_form.exitButton.focus();
}

function validate(uname) {
  if(isEmpty(uname)) {
    alert('User name must have a value');

    setfocusUserName();
    
    return false;
  }

  return true;
}

</script>
<% String disableLogin = ""; %>
<body class="bannerBackgroundColor" onLoad="setfocusUserName()" background="<%=project%>/images/title.bmp" >  

<p>

<FORM name="login_form" id="login_form" METHOD="POST" onSubmit="return validate(this.userName.value);">

<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
    <tr height="30" ><td width="60%" ><p>&nbsp;</p></td></tr>
    <!-- color:GREEN #006600; LIGHT GREEN #D6FE78 GOLDEN #FBFE89 -->
    <tr>
      <td height="380" align="right"><div align="right"></div>
      </td>
       <!--<td width="335" style=" font-family:'Bradley Hand ITC'; font-size:120px; font-weight:bold; color:#FFFFFF; "> alliance -->
     <!--  <td width="335">
        <font face="Bradley Hand ITC" style="font-size:120px; font-weight:bold; color:#D6FE78; "><b><%= request.getAttribute("productTitle")%></b></font>
        <font face="Arial" style="font-size:20px; font-weight:bold; color:#D6FE78; "><b>&nbsp;Version <%= request.getAttribute("productVersion")%></b></font>
      </td>  -->
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>

    <tr height="50" > 
        <td><p><% if (request.getAttribute("isVersioncompatible")!= null) {
                disableLogin = "disabled"; %> 
               <font color="red" face="Arial, Helvetica, sans-serif"  size="+3"> 
                 Application version is not compatible with database
               </font>
	     <% } %>
        </p></td> 
      </tr>

    <tr height="100" >
      <td><p>&nbsp;</p></td>
      <td><p>&nbsp;</p></td>

      <td><p><% if (request.getAttribute("error")!=null) {%> 
               <font color="Red" face="Arial, Helvetica, sans-serif"  size="+3"> 
                 Login failed!
               </font>
	     <% } %>
      </p></td>
    </tr>
					  
    <tr>
      <td>&nbsp;</td>
      <td align="right" >
      <font face="Arial" style="font-size:x-large; font-weight:bold; color:#000000; ">
	User name:
      </font>  
      </td>
      <td>
        <INPUT class="textBox" TYPE="text" NAME="userName" <%= disableLogin %>>
      </td>
    </tr>

    <tr>
      <td colspan=3>&nbsp;</td>
    </tr>
	
    <tr>
      <td>&nbsp;</td>
      <td align="right">
       <font face="Arial" style="font-size:x-large; font-weight:bold; color:#000000; "> Password:</font>
      </td>
      <td>
	<INPUT class="textBox" TYPE="password" NAME="password" <%= disableLogin %> >
      </td>
    </tr>

    <tr>
      
      <td colspan=3><br></td>
    </tr>
					  
    <tr>
      <td>&nbsp;</td>  
      <td>&nbsp;</td>
      <td>
        <b><INPUT TYPE="Submit" class="button" VALUE="Log In" <%= disableLogin %>></b>
	<b>&nbsp;<INPUT name="exitButton" id="exitButton" TYPE="button" class="button" VALUE="Exit" onClick="wclose()" ></b>
      </td>  
    </tr>
     <tr height="35" valign="CENTER">
      <td  >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <font face="Arial" style="font-size:15px; font-weight:bold; color:#000000; "><b>&nbsp;Version </b></font><font face="Arial" color="RED" style="font-size:15px; font-weight:bold; "> <%= request.getAttribute("productVersion")%></b></font> </td>       
      <td colspan=2><br></td>
    </tr>

</table>
</FORM> 
</body> 

</html>
