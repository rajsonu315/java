<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<HTML>
    <% String projPath = request.getContextPath();%>
    <HEAD>
        <TITLE>Set Password Page</TITLE>
        <SCRIPT LANGUAGE="JavaScript" SRC="js/base/UbqValidations.js"></SCRIPT>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
        <link href="<%= projPath%>/style/UbqApp.css" rel="stylesheet" type="text/css">
       <!-- <link href="<%= projPath%>/style/UbqStyleSheet.css" rel="stylesheet" type="text/css">-->
    </HEAD>
    <script language="Javascript">

        function wclose() {
            window.opener=null;
            self.close();
            window.parent.close();
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
    <!--<body  onLoad="setfocusPassword()" background="images/title.bmp">  -->
    <body  onLoad="setfocusPassword()">

        <p>

        <FORM name="setPasswordForm" id="setPasswordForm" METHOD="POST" action="SetPassword" onSubmit="return validate();">
            <div align="center"   style="width:100%;height:100%;overflow: hidden">
                <img src='<%= projPath%>/images/title.bmp'
                     style='background-repeat: no-repeat;' alt='Log in Page' />
            </div>
            <div style="width:100%;height:100%;position:absolute;z-index:0;left:0;top:0;">
                <table width="100%" height="100%" border="0" cellpadding="3" cellspacing="0">

                    <tr>

                        <td width="380"> <font face="Arial" class="textbody1"></font></td>
                        <td>&nbsp;</td>
                    </tr>

                    <tr height="455" ><td><p>&nbsp;</p></td></tr>

                    <tr height="70" >

                        <td colspan="100%" align="right">
                            <p>
                                <font face="Arial" color="RED" style="font-size:15px; font-weight:bold; ">
<!--                                <font color="red" face="Arial, Helvetica, sans-serif" size="+1">-->
                                    No password has been set for this account.<br>Please enter a password to use the system.
                                </font>
                            </p>
                        </td>
                    </tr>
                    <tr height="40" ><td><p>&nbsp;</p></td></tr>
                    <tr>
                        <td width="70%">&nbsp;</td>
                        <td width="30%" >
                            <div style="width:300px;padding:5px;" class="shadow">
                                <table width="100%" cellpadding="2" cellspacing="0" border="0" bgcolor="white">
                                    <tr class="activityBackgroundColor">
                                        <td colspan="4" align="center" class="activityHeader"><b>Set Password </b></td>
                                    </tr>
                                    <tr>
                                        <td align="right" width="55%"> User name  </td>
                                        <td width="7%">&nbsp;</td>
                                        <td width="15%" align="center">
                                            <INPUT  TYPE="text" NAME="userName" id="userName" value="<%= request.getAttribute("userName")%>" readonly>
                                        </td>
                                        <td width="23%"></td>
                                    </tr>

                                    <tr>

                                        <td align="right"> Password  </td>
                                        <td >&nbsp;</td>
                                        <td align="center">
                                            <INPUT  TYPE="password" NAME="password" id="password">
                                        </td>
                                        <td ></td>
                                    </tr>

                                    <tr>
                                        <td align="right"> Confirm  password  </td>
                                        <td >&nbsp;</td>
                                        <td align="center"> <INPUT  TYPE="password" NAME="confirmPassword" id="confirmPassword"> </td>
                                        <td ></td>
                                    </tr>

                                    <tr>
                                        <td colspan="3" align="right">
                                            <b><INPUT TYPE="Submit"  class="loginButton" VALUE=" OK " ></b>
                                            <b>&nbsp;<INPUT TYPE="button"  class="loginButton" VALUE="Exit" onClick="wclose()" ></b>
                                        </td>
                                    </tr>
                                    <tr ><td colspan="4"><p>&nbsp;</p></td></tr>

                                </table>
                            </div>
                        </td>
                    </tr>


                </table>
            </div>
        </FORM>
    </body>
</HTML>
