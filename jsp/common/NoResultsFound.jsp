<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8" language="java" import="java.sql.*" import="java.util.*" import="java.text.*" errorPage="" %>

<html>
<head>
<title>Search Results</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/uSCM/style/dqiColors.css" rel="stylesheet" type="text/css">
<link href="/uSCM/style/dqiStyles.css" rel="stylesheet" type="text/css">

<style type="text/css">
<!--
body {
	margin-left: 4px;
	margin-top: 6px;
	margin-right: 6px;
	margin-bottom: 4px;
}
-->
</style>
</head>

<body bgcolor="#888996">
<form name="form1" id="form1" method="post" action="">
<div align="center">
<table width="100%" height="450" border="0" cellpadding="0" cellspacing="0" bgcolor="#B2B2B2">
 <tr valign="center">
   <td><div align="center">
     <table width="80%"  border="0" cellspacing="5" cellpadding="5" class="tableBodyColor">
         <tr>
           <td class="smallLabel"><p> <strong><%= request.getParameter("searchTxt")%> </strong> - did not match any entries in the database. <br>
               <br>
Suggestions: </p>
             <ul>
               <li>Make sure the word is spelled correctly. </li>
               <li>Try more specific keywords. </li>
             </ul></td>
         </tr>
         <tr>
           <td align="center">
             <input name="closeBtn" type="button" id="closeBtn" value=" Close " onClick="window.close()" >           </td>
         </tr>
        </table>
   </div></td> 
 </tr>
</table>
</div>
</form>
</body>
</html>
