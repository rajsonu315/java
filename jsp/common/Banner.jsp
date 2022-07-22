<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*, ubq.util.*" errorPage="" %>
<%@page pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%
%>
<script language="javascript">
         
         function closeEPR() {
           
            self.close();
        }
               
        
</script>
<input type="hidden" name="dirtyBit" id="dirtyBit" value="0">

<table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
        
       <td width="25%" valign="middle" align="left">
            <img src="<%=(String) request.getContextPath()%>/images/Banner_Prod_MIS.png">
        </td>
<!--        <td width="20%"><b> CRITICAL INCIDENT REPORT</b></td>-->
       <td width="30%" valign="middle" align="center">
            <h3><%= (String) session.getAttribute("userEntityName")%></h3>
        </td>
        
        <td valign="top" align="right" width="25%">
            <b>Welcome <%= session.getAttribute("userName")%></b>
            <br>
            Date: <%= ubq.util.UDate.nowDisplayString()%>
            <br><br>
            <a href="<%=(String) request.getContextPath()%>/Logout">Sign Out</a>
            &nbsp; 
            <%--<a href="javascript:closeEPR()" id="windowCloseLabel">Exit</a>--%>
        </td>
    </tr>

</table>
