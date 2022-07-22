<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
    String project = request.getContextPath();
%>
<html>
<head>
<title>Other Activities</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<!-- Importing the required CSS files -->
<link href="<%=project%>/style/UbqColors.css" rel="stylesheet" type="text/css">
<link href="<%=project%>/style/UbqStyles.css" rel="stylesheet" type="text/css">

<script>
</script>


<style type="text/css">
<!--
body {
	margin-left: 2px;
	margin-top: 2px;
	margin-right: 4px;
	margin-bottom: 4px;
}
-->
</style></head>
<!-- Body of the Page Starts -->
<body class="workAreaBackgroundColor">
<!-- Creating a table -->
<table width="100%" height="272"  border="0" cellspacing="0">
    <tr class="tableHeaderColor">
     <th height="20" scope="col"><span class="tableHeader">Other Activities</span></th>
    </tr>
    <tr class="tableBodyColor">
     <td><p> &nbsp;<a href="#" class="tableElementHeader">View Daily Summary</a></p></td>
	</tr>
	<tr class="tableBodyColor"><td><p>&nbsp;</p></td></tr>
	<tr class="tableBodyColor"><td><p>&nbsp;<a href="<%=project%>/jsp/billing/uBill.jsp" target="_parent" class="tableElementHeader">Bill Patients </a></p></td></tr>
	<tr class="tableBodyColor"><td><p>&nbsp;</p></td></tr>
    <tr class="tableBodyColor"><td> <p>&nbsp;<a href="<%=project%>/jsp/order/order.jsp" target="_parent" class="tableElementHeader">Order</a></p></td></tr>
	<tr class="tableBodyColor"><td><p>&nbsp;</p></td></tr>
    <tr class="tableBodyColor"><td><p>&nbsp;</p></td></tr>
    <tr class="tableBodyColor"><td><p>&nbsp;<a href="<%=project%>/UMasterServlet?command=loadAccessibleCommands" target="body" class="tableElementHeader">Back to Start screen</a></p></td></tr>
</table>
</body>
<!-- Body Ends -->
</html>
