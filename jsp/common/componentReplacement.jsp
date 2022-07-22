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
    
    window.parent.Failure("Error: " + "<%= request.getAttribute("errorMessage")%>");     
 
<%            
     } else if(request.getAttribute("reloadComponentFun" ) !=  null) {         
         
 %>
    window.parent.scmSalesBrowserFilterForm.command.value = "<%=(String)request.getAttribute("commandVal")%>";
    window.parent.<%= request.getAttribute("reloadComponentFun")%>();
 <%            
     } else if (request.getAttribute("success") != null){
 %>
    window.parent.handleSuccess("<%= request.getAttribute("success")%>");
 <%            
     } 
 %>
}

</script>
</head>

<body onLoad="Window_onload()">

</body>
</html>
