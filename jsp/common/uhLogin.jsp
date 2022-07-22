<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<HTML>
<HEAD>
<TITLE>Sales Force Automation Login</TITLE>
<SCRIPT LANGUAGE="JavaScript" SRC="js/base/UbqValidations.js"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<!-- Importing the required CSS files -->
<link href="styles/UbqColors.css" rel="stylesheet" type="text/css">
<link href="styles/UbqStyles.css" rel="stylesheet" type="text/css">

<style>

.textbody {
  color:#FFFFFF;
}
.textbody1{
  color:#FFFFFF;
  font-size:50px;
}

.textbody1s{
  color:#FFFFFF;
  font-size:20px;
}

.submitbutton {
  height: 2em;
  width: 6em;
  font-family: Arial;
  font-size: medium;
  font-weight: bold;
}

.textboxbackground{
  background-color:#FFFFFF;
  width:200px;
  height:25px;
  font-size:20px;
  font-weight:bold;
}

</style>
</HEAD>

<script language="Javascript">

function wclose() {
  window.opener = null;
  self.close();
}

function setfocusUserName() {
  document.login_form.userName.focus();
}

function validate(uname) {
  if(isEmpty(uname)) {
    alert('User name must have a value');

    setfocusUserName();
    
    return false;
  }

  return true;
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

<body class="bannerBackgroundColor" onLoad="setfocusUserName()">

  <p>

<FORM name="login_form" id="login_form" METHOD="POST" action="Login" onSubmit="return validate(this.userName.value);">

    <!-- When the user enters his UserName and Password combination the request FORM will be handled
        in Servlet class using a doPost method -->
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
    
  <tr height="30">
    <td><p>&nbsp;</p></td>
  </tr>

    <tr>
      <td height="150"  ><div align="center"><img src="images/title.bmp" width="200" height="134"></div></td>
      <td width="335">
        <font face="Arial" class="textbody1"><b><%= request.getAttribute("productTitle")%></b></font><br><br>
        <font face="Arial" class="textbody1s"><b>&nbsp;Version <%= request.getAttribute("productVersion")%></b></font>
      </td>
      <td>&nbsp;</td>
    </tr>

    <tr height="150" ><td><p>&nbsp;</p></td></tr>

    <tr height="100" >
      <td><p>&nbsp;</p></td>
      <td><p>&nbsp;</p></td>

      <td><p><% if (request.getAttribute("error")!=null) {%> 
               <font color="yellow" face="Arial, Helvetica, sans-serif"  size="+2"> 
                 Login failed!
               </font>
	     <% } %>
      </p></td>
    </tr>
					  
    <tr>
      <td>&nbsp;</td>
      <td align="right">
	<font  face="Arial, Helvetica, sans-serif"  size="+2" class="textbody"> <strong>User name</strong>:</font>
      </td>
      <td>
	<INPUT CLASS="textboxbackground" TYPE="text" NAME="userName" id="userName">
      </td>
    </tr>

    <tr>
      <td colspan=3>&nbsp;</td>
    </tr>
	
    <tr>
      <td>&nbsp;</td>
      <td align="right">
        <font  face="Arial, Helvetica, sans-serif"  size="+2" class="textbody"><strong>Password</strong>:</font>
      </td>
      <td>
	<INPUT CLASS="textboxbackground" TYPE="password" NAME="password" id="password">
      </td>
    </tr>

    <tr>
      <td colspan=3><br></td>
    </tr>
					  
    <tr>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
      <td>
        <b><INPUT TYPE="Submit" class="submitbutton" VALUE="Sign In"></b>
	<b>&nbsp;<INPUT TYPE="button" class="submitbutton" VALUE=" Exit " onClick="wclose()" ></b>
      </td>  
    </tr>
 </table> 

</FORM> 

</body>   

</HTML>
