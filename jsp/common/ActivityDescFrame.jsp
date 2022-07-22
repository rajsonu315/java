<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" 
import="java.util.*" import="ubq.util.*" import="ubq.base.*" errorPage="" %>
<%@page pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
 <% String prjName = request.getContextPath(); %>
<html>
 <!--<link href="<//%= prjName %>/style/UbqColors.css" rel="stylesheet" type="text/css">
     <link href="<//%= prjName %>/style/UbqStyles.css" rel="stylesheet" type="text/css"> -->
     <link href="<%= prjName %>/style/UbqApp.css" rel="stylesheet" type="text/css">
    <!-- <link href="<//%= prjName %>/style/UbqStyleSheet.css" rel="stylesheet" type="text/css">
     <link href="<//%= prjName %>/style/StockStyles.css" rel="stylesheet" type="text/css">
     <link href="<//%= prjName %>/style/outReach.css" rel="stylesheet" type="text/css"> -->
     
<%
    String dateStr = ubq.util.UDate.nowDisplayString();
%>

 <form id="activityForm" action="" method="post" >
<table width=100% border="0" height="100%" cellpadding="0" cellspacing="0" style="position:absolute;top:0px;">
 <input type="hidden" id = "searchingFor" name ="searchingFor">
  <tr>
   
    <td   class="heading" background="<%= prjName %>/images/navbg.gif">
      <input type="text" name="currentActivity" id="currentActivity" size="30" class="heading" readonly>
    </td>
    <td class="heading"  align="right"  background="<%= prjName %>/images/navbg.gif">
        <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" >
            <tr>
                <td background="<%= prjName %>/images/navbg.gif" height="33" >
                    <%
                        Vector v = (Vector) request.getAttribute("accessibleCommands");


                        if(v != null){

                            for(int i = 0; i < v.size(); i++) {

                                UFeature f = (UFeature) v.elementAt(i);

                                String cmd_name = f.featName;
                                String link_url = f.featCommand;
                                String cmd_help = f.featHelp;

                                if(link_url != null && !link_url.equals("")) {
                        %>   

                    <a href="<%= f.featCommand%>" class="generalLink" target="_top" ><%= f.featName%></a> 

                    <% if ( i < v.size() - 1)
                    { %>   
                                         |
                    <%}%>

                    <%
                    }
                                }
                            }
                            %>
                    &nbsp;
                </td>

            </tr>
        </table>                        
       </td>   
  </tr>
      
</table></form>
<html>
