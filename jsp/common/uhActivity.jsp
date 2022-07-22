<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
  String project = request.getContextPath();
  String activityName = request.getParameter("activityName");
%>

<script>

function setActivityName(name) {
  var elem = document.getElementById('activityName');

  if(elem == null)
    alert('Could not find activityName label');
  else
    elem.innerHTML = name;
}
</script>
<head>

<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="<%=project%>/styles/UbqColors.css" rel="stylesheet" type="text/css">
<link href="<%=project%>/styles/UbqStyles.css" rel="stylesheet" type="text/css">
</head>
<body class="activityBackgroundColor">
<span class="activityHeader"><label name="activityName" id="activityName"><%= activityName%></label></span>

</body>
</html>
