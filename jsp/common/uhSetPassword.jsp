<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<HTML>
<HEAD>
<TITLE>Login Page</TITLE>
<SCRIPT LANGUAGE="JavaScript" SRC="UbqValidations.js"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="UbqStyleSheet.css" rel="stylesheet" type="text/css">
</HEAD>
<link href="<%=(String)request.getContextPath()%>/style/UbqApp.css" rel="stylesheet" type="text/css">

<SCRIPT LANGUAGE="JavaScript" SRC="<%=(String)request.getContextPath()%>/js/base/UbqValidations.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="<%=(String)request.getContextPath()%>/js/base/ValidateFunction.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="<%=(String)request.getContextPath()%>/js/base/CalendarPopup.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="<%=(String)request.getContextPath()%>/js/base/DynamicTableTemplate.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="<%=(String)request.getContextPath()%>/js/base/xmlHelper.js"></SCRIPT>
<script language="Javascript">

function wclose() {
  window.opener=null;
  self.close();
}

function setfocusPassword() {
  document.setPasswordForm.password.focus();
}

function validate() {

  pw = document.setPasswordForm.password.value

  if(isEmpty(pw)) {
    alert('Please enter a password.');
    setfocusPassword();
    return false;
  }

  cpw = document.setPasswordForm.confirmPassword.value

  if(isEmpty(cpw)) {
    alert('Please confirm the password.');
    document.setPasswordForm.confirmPassword.focus();
    return false;
  }

  if(pw != cpw) {
    alert('Passwords do not match. Please try again.');

    document.setPasswordForm.password.value = ""
    document.setPasswordForm.confirmPassword.value = ""

    setfocusPassword();

    return false;
  }
  return true;
}

</script>
<body class="indexbackground" onLoad="setfocusPassword()">
<%
    String project = request.getContextPath();
%>

<p>

<FORM name="setPasswordForm" id="setPasswordForm" METHOD="POST" action="SetPassword" TARGET="_self" onSubmit="return validate();">
<div align="center"   style="width:100%;height:100%;overflow: hidden">
                <img src='<%= project%>/images/QMSLogin.jpg'
                     style='background-repeat: no-repeat;' alt='Log in Page' />
            </div>
<div align="center" style="width:100%;height:100%;position:absolute;z-index:0;left:0;top:0;">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
                        <td height="350" align="right"><div align="right"></div>
                        </td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
     </tr>

   <tr valign="bottom">
                        <td valign="top"  width="60%">
                        </td>


        <td valign="bottom" width="30%">
            <br>
            <table border="0" cellpadding="0" cellspacing="0" width="81%" height="150">
                <tr>
                    <td class="heading" height="20px" align="left"> <input type="text" size="28" class="heading" readonly value="User Login" align="left"></td>
                </tr>
                <tr>
                    <td class="commonbg"  align="left" >
                        <table width="100%"  height="150" border="0" cellpadding="0" cellspacing="0" id="userTable">
                            <tr>
                                <td><br>
                                &nbsp;User Name&nbsp; </td>
                                <td>
                                    <INPUT TYPE="text" NAME="userName" id="userName" value="<%= request.getAttribute("userName") %>" readonly>
                                    <!--<br><input type="text" name="userName" id="userName" size="20"   maxlength="10"> -->
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <br>
                                    &nbsp;Password &nbsp;
                                </td>
                                <td>
                                    <br><input type="password"  name="password" size="20" id="password" >
                                </td>
                            </tr>
                            <tr>
                              <td>
                                  <br>
                                  &nbsp;Confirm Password &nbsp;
                              </td>
                              <td>
                                <INPUT TYPE="password" NAME="confirmPassword" id="confirmPassword">
                              </td>
                            </tr>

                            <tr><td>&nbsp;</td></tr>

                            <tr>
                                <td class="userInfo" >&nbsp;&nbsp;

                                    <% String errorDisplayMsg = null;
                                    if (request.getAttribute("error")!=null) {
                                    errorDisplayMsg = "Login failed.";

                                    } else {
                                    errorDisplayMsg = "";
                                    }
                                    %>
                                    <br>&nbsp;&nbsp;
                                    <input type="text"  size="20" id="errorMsg" name="errorMsg" value="<%=errorDisplayMsg%>" class="userInfo readOnly commonbg" readonly  >
                                    </td>
                                <td>
                                    <input type="submit" name="login" id="login"  value=" Login "  class="smallBtn">
                                <input type="button" name="exit" id="exit"  value="  Exit  " onclick="wclose();"  class="smallBtn">
                                </td>
                            </tr>
                            <tr><td>&nbsp;</td></tr>
                        </table>
                    </td>
                </tr>
                <tr height="60">
                    <td colspan="2" align="left"><p><font color="red"><i>
                         &nbsp;No password has been set for this account.<br>&nbsp;Please enter a password to use the system.
                         </i></font>
                  </p></td>
                </tr>
            </table>
<!-- /////////////////////////////////////////////////////////////
            <table>
                <tr height="100" >
                  <td><p>&nbsp;</p></td>
                  <td colspan="2" align="center"><p><font color="yellow" face="Arial, Helvetica, sans-serif"  size="+1">
                         No password has been set for this account.<br>Please enter a password to use the system.
                         </font>
                  </p></td>
                </tr>
                <tr>
                  <td>&nbsp;</td>
                  <td align="right">
                    <font  face="Arial, Helvetica, sans-serif"  size="+2" class="textbody"> <strong>User name</strong>:</font>
                  </td>
                  <td>
                    <INPUT CLASS="textboxbackground" TYPE="text" NAME="userName" value="<%= request.getAttribute("userName") %>" readonly>
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
                    <INPUT CLASS="textboxbackground" TYPE="password" NAME="password">
                  </td>
                </tr>

                <tr>
                  <td colspan=3>&nbsp;</td>
                </tr>

                <tr>
                  <td>&nbsp;</td>
                  <td align="right">
                    <font  face="Arial, Helvetica, sans-serif"  size="+2" class="textbody"><strong>Confirm Password</strong>:</font>
                  </td>
                  <td>
                    <INPUT CLASS="textboxbackground" TYPE="password" NAME="confirmPassword">
                  </td>
                </tr>

                <tr>
                  <td colspan=3><br></td>
                </tr>

                <tr>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>
                    <b><INPUT TYPE="Submit"  class="submitbutton" VALUE=" OK "></b>
                    <b>&nbsp;<INPUT TYPE="button"  class="submitbutton" VALUE="Exit" onClick="wclose()" ></b>
                  </td>
                </tr>
            </table> -->
        </td>
  <td width="10%"></td>
    </tr>
</table>
</div>
<iframe style="visibility:hidden" name="myIframe" id="myIframe" height="0" width="0"> </iframe>
</FORM>
</body>
</HTML>
