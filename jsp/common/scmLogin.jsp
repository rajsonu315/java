<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="ubq.base.UServletHelper" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% String projectPath = request.getContextPath();%> 
<html>
<head>
<title>Login Page</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<link href="<%=projectPath%>/style/UbqApp.css" rel="stylesheet" type="text/css">
</head>
<SCRIPT LANGUAGE="JavaScript" SRC="<%=projectPath%>/js/base/UbqValidations.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="<%=projectPath%>/js/base/xmlHelper.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="<%=projectPath%>/js/base/ValidateFunction.js"></SCRIPT>

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
  if(isEmpty(document.getElementById("entCode").value)){
    alert('Entity code must have a value');
    document.getElementById("entCode").focus();
    return false;
  }
  if(isEmpty(uname)) {
    alert('User name must have a value');

    setfocusUserName();
    
    return false;
  }

  document.login_form.logInBtn.disabled = true;
  return true;
}

function getEntityName(obj){
    var entName = xmlGetResultString("<%=projectPath%>" + "/Login?command=getEntityName&entCode=" + obj.value);
    entName = uTrim (entName, 2);
    document.getElementById("entName").value = '';
    if(uscmIsEmpty(entName)){
        alert("Entity not found");
        document.getElementById("entCode").focus();
    }else{
        document.getElementById("entName").value = entName;
    }
}
</script>
<% 
    String disableLogin = ""; 
    String entCodeCookies = UServletHelper.getCookieValue(request,"entCode");
    String entNameCookies = UServletHelper.getCookieValue(request,"entName");
    entCodeCookies = (entCodeCookies == null) ? "" : entCodeCookies;
    entNameCookies = (entNameCookies  == null) ?"" : entNameCookies;
    

%>
    <%-- background="<%=projectPath%>/images/title.bmp" class="bannerBackgroundColor"  --%>
<body onLoad="setfocusUserName()"  >

 


<FORM name="login_form" id="login_form" METHOD="POST" onSubmit="return validate(this.userName.value);">
         <div align="center"   style="width:100%;height:100%;overflow: hidden">
                <img src='<%= projectPath%>/images/title.bmp'
                style='background-repeat: no-repeat;' alt='Log in Page' />
            </div>
            <div style="width:100%;height:100%;position:absolute;z-index:0;left:0;top:0;">
                <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" >
                    <tr height="30" ><td width="50%" ><p>&nbsp;</p></td></tr>
                    <!-- color:GREEN #006600; LIGHT GREEN #D6FE78 GOLDEN #FBFE89 -->
                    <tr>
                        <td height="350" align="right"><div align="right"></div>
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
                                <font color="red" face="Arial, Helvetica, sans-serif"  size="+2"> 
                                    Application version is not compatible with database.
                                </font>
                                <% } %>
                                <% if (request.getAttribute("isDBUpdatedProperly")!= null) {
                                String upgradtionCommentString = (String)request.getAttribute("isDBUpdatedProperly");
                                String upgradtionCommentArr[] = upgradtionCommentString.split("~");
                                String dbVersion = "";
                                if(upgradtionCommentArr[1] != null)
                                dbVersion = upgradtionCommentArr[1];
                                
                                disableLogin = "disabled"; %> 
                                <font color="red" face="Arial, Helvetica, sans-serif"  size="+2"> 
                                    Database version  <%=dbVersion%>  has not been upgraded properly.
                                    Please contact Help Desk.
                                </font>
                                <% } %>
                        </p></td> 
                    </tr>
                    
                    <tr height="110px" >
                        
                        
                        <td colspan="2" align="right"><p><% if (request.getAttribute("error")!=null) {%> 
                                <font color="Red" face="Arial, Helvetica, sans-serif"  size="+2"> 
                                    Login failed!
                                </font>
                                <% } %>
                        </p></td>
                    </tr>
                    <tr <%--valign="top"--%>>
                        <td width="40%" <%--valign="bottom"--%> align="center">
                            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                                <tr valign="top">
                                    <td align="right" width="26%">&nbsp;</td>
                                    
                                    <td align="left" width="74%" valign="top">
                                        <font color="Red" face="Arial, Helvetica, sans-serif"  size="+3">
                                            OutReach POS
                                        </font>
                                        <br>
                                        <b>Version </b>
                                        <font face="Arial" color="RED" style="font-size:15px; font-weight:bold; ">
                                        <%= request.getAttribute("productVersion")%></font> 
                                </td></tr>
                            </table> 
                        </td>
                        <td  width="50%">            
                            <div style="width:400px;padding:5px;" class="shadow">
                                
                                <table width="100%" cellpadding="2" cellspacing="0" border="0"  bgcolor="white">
                                    <tr class="activityBackgroundColor">
                                        <td colspan="4" align="center" class="activityHeader"><b>User Login</b></td>
                                    </tr>
                                    <tr>
                                        <td width="20%">&nbsp;</td>
                                        <td align="left" width="30%">Entity code</td>
                                        
                                        <td width="50%" align="left">
                                            <INPUT  TYPE="text" NAME="entCode" ID="entCode" <%= disableLogin %> VALUE="<%=entCodeCookies %>"
                                                    AUTOCOMPLETE="OFF" ONCHANGE="getEntityName(this)">
                                        </td>
                                        
                                    </tr>
                                    <tr>
                                        <td width="20%">&nbsp;</td>
                                        <td align="left" width="30%" >Entity name </td>
                                        
                                        <td align="left" width="50%">
                                            <INPUT class="readOnlyLogin" TYPE="text" NAME="entName" id="entName" tabindex="10"  VALUE="<%=entNameCookies %>" READONLY  SIZE="37" MAXLENGTH="100">
                                        </td>
                                        
                                    </tr>
                                    <tr>
                                        
                                    <td colspan="3"><hr></td></tr>
                                    <tr>
                                        
                                        <td width="20%">&nbsp;</td>
                                        <td align="left" width="30%">User  name</td>
                                        
                                        <td align="left" width="50%">
                                            <INPUT  TYPE="text" NAME="userName" id="userName" <%= disableLogin %> AUTOCOMPLETE="OFF">
                                        </td>
                                    </tr>
                                    
                                    <tr>
                                        <td width="20%">&nbsp;</td>
                                        <td align="left" width="30%">Password</td>
                                        
                                        <td align="left" width="50%">
                                            <INPUT  TYPE="password" NAME="password" <%= disableLogin %> id="password" >
                                        </td>
                                    </tr>
                                    
                                    <tr>
                                        <td colspan="3"></td>
                                        
                                    </tr>
                                    
                                    <tr>
                                        <td align="center" colspan="3"> &nbsp;
                                            <b><INPUT TYPE="Submit" name="logInBtn" id="logInBtn" class="loginButton" VALUE="Log In" <%= disableLogin %>></b>
                                            <b>&nbsp;<INPUT name="exitButton" id="exitButton" TYPE="button" class="loginButton" VALUE="Exit" onClick="wclose()" ></b>
                                        </td>  
                                        
                                    </tr> 
                                    <tr>
                                        <td colspan="3"><br></td>
                                        
                                    </tr>
                                    
                                </table>    
                            </div> 
                            
                        </td>
                    </tr>
                    
                    <!--<tr height="20" >
      <td><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <font face="Arial" style="font-size:15px; font-weight:bold; color:#000000; "><b>&nbsp;Version </b></font><font face="Arial" color="RED" style="font-size:15px; font-weight:bold; "> <%= request.getAttribute("productVersion")%></b></font> </td>       
      <td colspan=2><br></td>
    </tr>-->
                    
                </table>
                
            </div>
</FORM> 
</body> 

</html>
