<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.util.*" import="ubq.base.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <title>Production Management and Information System</title>
        <meta http-equiv="content-type" content="text/html; charset=iso-8859-1">
        <meta name="keywords" content="keywords here">
        <meta name="description" content="description here">
        <meta name="author" content="myfreetemplates.com">
        <meta name="robots" content="index, follow"> <!-- (robot commands: all, none, index, no index, follow, no follow) -->
        <meta name="revisit-after" content="30 days">
        <meta name="distribution" content="global">
        <meta name="rating" content="general">
        <meta name="content-language" content="english">


    </head>
    <%
                String project = request.getContextPath();
    %>
    <link href="<%=(String) request.getContextPath()%>/style/UbqApp.css" rel="stylesheet" type="text/css">

    <SCRIPT LANGUAGE="JavaScript" SRC="<%=(String) request.getContextPath()%>/js/base/UbqValidations.js"></SCRIPT>
    <SCRIPT LANGUAGE="JavaScript" SRC="<%=(String) request.getContextPath()%>/js/base/ValidateFunction.js"></SCRIPT>
    <SCRIPT LANGUAGE="JavaScript" SRC="<%=(String) request.getContextPath()%>/js/base/CalendarPopup.js"></SCRIPT>
    <SCRIPT LANGUAGE="JavaScript" SRC="<%=(String) request.getContextPath()%>/js/base/DynamicTableTemplate.js"></SCRIPT>
    <SCRIPT LANGUAGE="JavaScript" SRC="<%=(String) request.getContextPath()%>/js/base/xmlHelper.js"></SCRIPT>

    <script language="Javascript">

        function wclose() {
            window.opener=null;
            top.window.close();
        }
       

        function setfocusUserName() {
            if (!document.login_form.userName.disabled)
                document.login_form.userName.focus();
            else
                document.login_form.exitButton.focus();
        }

        //With alert error msg
        function validate(uname) {
            if(isEmpty(uname)) {
                alert('Enter user name');
                setfocusUserName();
                return false;
            }
            if(document.getElementById("password").value == "" ) {
                alert("Password Cannot be blank");
                return false;
            } else {
                if((document.getElementById("password").value).length < 3) {
                    alert("Password should have a minimum of characters");
                    return false;
                }
            }
            document.getElementById("command").value = "";
            document.login_form.target="_self";
            return true;
        }

        //With inline error msg.
        function submitForm() {
            uname = document.getElementById("userName").value;
            document.getElementById("errorMsg").value = "";
            if(isEmpty(uname)) {
                document.getElementById("errorMsg").value = "Enter username.";
                setfocusUserName();
                return false;
            }
            else if(document.getElementById("password").value == "" ) {
                document.getElementById("errorMsg").value = "Enter password.";
                return false;
            }
            document.getElementById("command").value = "";
            document.login_form.target="_self";
            document.login_form.submit();
        }
        
        function formReset() {
            document.login_form.reset();
        }

    </script>


    <body  onLoad="setfocusUserName();">
        <form name="login_form" id="login_form" METHOD="POST" onSubmit="return submitForm();" TARGET="_self" >
            <div align="center"   style="width:100%;height:100%;overflow: hidden">
                <img src='<%= project%>/images/ProdMIS_Login.jpg'
                     style='background-repeat: no-repeat;' alt='Log in Page' />
            </div>
            <div align="center" style="width:100%;height:100%;position:absolute;z-index:0;left:0;top:0;">
                <input type="hidden" id="command" name="command">

                <table  width="100%" border="0" cellpadding=0 cellspacing=0>
                    <tr>
                        <td height="350" align="right"><div align="right"></div>
                        </td>
                        <td>&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr valign="bottom">
                        <td valign="top"  width="58%">
                        </td>
                        
                        <td valign="bottom" width="32%">
                            <br>

                            <table border="0" cellpadding="0" cellspacing="0" width="81%" height="150">

                                <tr>
                                    <td class="heading" height="20px" align="left">&nbsp;<input type="text" size="28" class="heading" readonly value="User Login" align="left"></td>
                                </tr>

                                <tr>
                                    <td class="bodyBackground"  align="left" >
                                        <table width="100%" class="lhsMenuTable shadow"  height="150" border="0" cellpadding="0" cellspacing="0" id="userTable">
                                            <tr>
                                                <td><br>
                                                    &nbsp;User Name&nbsp; </td>
                                                <td>
                                                    <br><input type="text" name="userName" id="userName" size="20" tabindex="1" maxlength="20" >
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <br>
                                                    &nbsp;Password &nbsp;
                                                </td>
                                                <td>
                                                    <br><input type="password"  name="password" tabindex="2" size="20" id="password" >
                                                </td>
                                            </tr>
                                            <tr>

                                                <%
                                                            boolean entityBasedLogin = "yes".equals((String) request.getAttribute("entityBasedLogin"));
                                                            if (entityBasedLogin) {
                                                %>

                                                <td ><br>
                                                    &nbsp;Stockist &nbsp; </td>
                                                <td><br>
                                                    <input type="hidden" name="entityFromInput" id="entityFromInput" value="1" >
                                                    <select name="entity" id="entity" style="width:175px;">
                                                        <%
                                                                                            ResultSet rs = (ResultSet) request.getAttribute("entityList");

                                                                                            while (rs != null && rs.next()) {
                                                        %>
                                                        <option value="<%=rs.getInt("ent_rid")%>" ><%=rs.getString("ent_name")%></option>
                                                        <%

                                                                                            }
                                                        %>

                                                    </select>

                                                    <%
                                                                }
                                                    %>
                                                </td>
                                            </tr>

                                            <tr><td>&nbsp;</td></tr>

                                            <tr>
                                                <td class="userInfo" >&nbsp;&nbsp;

                                                    <% String errorDisplayMsg = null;
                                                                if (request.getAttribute("error") != null) {
                                                                    errorDisplayMsg = "Login failed.";

                                                                } else {
                                                                    errorDisplayMsg = "";
                                                                }
                                                    %>
                                                    <br>&nbsp;&nbsp;
                                                    <input type="text"  size="20" id="errorMsg" name="errorMsg" value="<%=errorDisplayMsg%>" class="userInfo readOnly commonbg" readonly  >
                                                </td>
                                                <td align="right">
                                                    <input type="submit" name="login" id="login" tabindex="3"  value=" Login "  <%--class="smallBtn"--%> size="30"
                                                           style="font-family: Arial, Helvetica, sans-serif;<%--font-size: x-small;--%>font-weight: bold;">
                                                    <input type="button" name="exit" id="exit"  value="  Exit  " onclick="wclose();" tabindex="4"  >
                                                    &nbsp;&nbsp;&nbsp;
                                                </td>
                                            </tr>
                                            <tr><td>&nbsp;</td></tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td width="10%"></td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <iframe style="visibility:hidden" name="myIframe" id="myIframe" height="0" width="0"> </iframe>
        </form>
    </body>
</html>

