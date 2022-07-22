 <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.util.*" import="ubq.base.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<script>
 
function Window_onload() {
<%            
     if(request.getAttribute("errorMessage") != null) {
%>
     window.parent.handleFailure("Error: " + "<%= request.getAttribute("errorMessage")%>");
<%
    } else if(request.getAttribute("infoMessage") != null) {
%>
     window.parent.handleFailure("<%= request.getAttribute("infoMessage")%>");
<%
    } else if(request.getAttribute("warningMessage") != null) {
%>
     window.parent.handleSuccess("<%= request.getAttribute("warningMessage")%>");
 <% } else if(request.getAttribute("reloadPage") !=  null) {
         
  %>
    window.parent.handleSuccessReload("<%= request.getAttribute("reloadPage")%>","<%= request.getAttribute("url")%>");    
<%
    } else {
       String successMessage = (String)request.getAttribute("successMessage");
       if (successMessage == null)
          successMessage = "success"; 
%>
     window.parent.handleSuccess("<%= successMessage %>");
 
<%            
     }
%>
}

</script>
</head>

<body onLoad="Window_onload()">

</body>
</html>
