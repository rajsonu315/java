<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*, ubq.util.*" errorPage="" %>
<%@page pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
   <% String prjName = request.getContextPath(); %>
<html>
<head>
<link href="<%= prjName %>/style/UbqColors.css" rel="stylesheet" type="text/css">
     <link href="<%= prjName %>/style/UbqStyles.css" rel="stylesheet" type="text/css">
     <link href="<%= prjName %>/style/UbqApp.css" rel="stylesheet" type="text/css">
     <link href="<%= prjName %>/style/UbqStyleSheet.css" rel="stylesheet" type="text/css">
     <link href="<%= prjName %>/style/StockStyles.css" rel="stylesheet" type="text/css">
     <link href="<%= prjName %>/style/outReach.css" rel="stylesheet" type="text/css">
 </head>    
<script language="javascript">
         
         function closeEPR() {
           
            top.window.opener='x';
            top.window.close();


        }
               
        
    </script>
    
<input type="hidden" name="dirtyBit" id="dirtyBit" value="0">
  

<table width="98%" border="0" cellpadding="0" cellspacing="0">
  <tr>
   
        <td >
            <img src="<%= prjName %>/images/outReach_big.PNG">
        </td>
   
    <td >

      <table border="0" cellpadding="2" cellspacing="0">
        <tr>
          <td><p>Welcome <%= session.getAttribute("userName")%></p></td>
        </tr>
        <tr>
          <td><a href="<%= prjName %>/Logout" target="_top">Sign Out</a> 
           &nbsp; 
           <a href="javascript:closeEPR()" id="windowCloseLabel">Exit</a>
          </td>
         
             
        </tr>
      </table>
    </td>
    
  </tr>
</table>
</html>
