<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.util.*" 
    import="ubq.base.*" errorPage="" %>
<%@page pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<% 
 String project = (String) request.getContextPath();
%>
<table width=100% border="0" cellpadding="2" cellspacing="0">
  <tr>
   
    <td colspan=2  background="<%=project%>/images/navbg.gif" class="heading">
      <input type="text" name="currentActivity" id="currentActivity" size="60" class="heading" readonly>
    </td>

    <td class="heading" background="<%=project%>/images/navbg.gif" >
      <label name="dateLabel" id="dateLabel">Today</label>
    </td>
   
    <td background="<%=project%>/images/navbg.gif" width="430" align="right" height="33" class="heading">
      
<% 
  if (request.getAttribute("accessibleCommands") != null){

      Vector accessibleCmds = (Vector) request.getAttribute("accessibleCommands") ;

      for(int i = 0; i < accessibleCmds.size(); i++) {
        UFeature f = (UFeature) accessibleCmds.elementAt(i); 
        if (i > 0)
{ %>
        |
 <%       
        }    
%>
      
          <a  href="<%=f.featCommand%>" class="generalLink"><%= f.featName%></a>
                
<%
      }
 }
%>  &nbsp;
                    
    </td>   
   
  </tr>
</table>
