<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@page pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%
    String project = request.getContextPath();
%>
<input type="hidden" name="dirtyBit" id="dirtyBit" value="0">
  <table width="100%" border="0" cellpadding="0" cellspacing="0">
      
      <tr style="height:80px"><td width="100%" align="left">
              <img src="<%=project%>/images/outReach_big.png">
          </td></tr>
      <tr>
<!--          <td align="left" width="35"><img src="images/topleft.gif" width="35" height=50></td> -->
        
        <td align="left"  height=100>
           <img src="<%=project%>/images/outreach.png">
        </td>
      </tr>
  </table>
  <table width=100% border="0" cellpadding="0" cellspacing="0">
  <tr>
    <!-- <td width="35"> <img src="images/navleft.gif" width=35 height=33></td> -->
    <td colspan=2 background="images/navbg.gif" class="heading" height=33>
    </td>
    <!-- <td width="14"> <img src="images/navright.gif" width=14 height=33></td> -->
  </tr>
</table>