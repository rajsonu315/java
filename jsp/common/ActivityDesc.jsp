<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*"
import="java.util.*" import="ubq.util.*" import="ubq.base.*" errorPage="" %>
<%@page pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<%
    String dateStr = ubq.util.UDate.nowDisplayString();
    //String projectName = request.getContextPath();
%>

 <%--<form id="activityForm" name="activityForm" action="" method="post" >--%>
     
<table width=100% border="0" height="100%" cellpadding="0" cellspacing="0">
 <input type="hidden" id = "searchingFor" name ="searchingFor">
  <tr>
   
    <td   class="heading" background="<%=(String) request.getContextPath()%>/images/navbg.gif">
      <input type="text" name="currentActivity" id="currentActivity" size="43" class="heading" readonly>
    </td>
    
    <td class="heading"  align="left" background="<%=(String) request.getContextPath()%>/images/navbg.gif">
     <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" >
        <tr>
        <td background="<%=(String) request.getContextPath()%>/images/navbg.gif" align="right" height="33" >
 <%
  Vector v = (Vector) request.getAttribute("accessibleCommands"); 
  

  if(v != null){
 
      for(int i = 0; i < v.size(); i++) {

      UFeature f = (UFeature) v.elementAt(i);

      String cmd_name = f.featName;
      String link_url = f.featCommand;
      String cmd_help = f.featHelp;
      String targetURL = null ;

      if(link_url != null && !link_url.equals(""))
      {
          if(link_url.startsWith("http://"))
              targetURL = link_url ;
          else
              targetURL = request.getContextPath() + "/" + link_url ;
        %>   
           <%if("L".equalsIgnoreCase(f.featGroup)){%>
                    <a href="#" class="generalLink" onclick="javascript:window.open('<%= targetURL%>','Dashboard',' top=0, left=0, scrollbars=0, height=768,width=1024,status=yes,resizable=1')">
                <%= f.featName%></a>
                <%}else{%>
                    <a  href="#" onclick="desktop.loadPage('<%= f.featCommand %>', '<%= f.featName %>')" class="generalLink">
                <%= f.featName%></a>
                <%}%>

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
      
</table><%--</form>--%>
