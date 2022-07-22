<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" 
 import="java.text.*" import="java.util.*" import="ubq.base.*" errorPage="" %>
<div>
    <% String prjName = request.getContextPath(); %>

    
   <input type="hidden" name="cssFile" value="<%= prjName %>/style/UbqColors.css">
   <input type="hidden" name="cssFile" value="<%= prjName %>/style/UbqStyles.css">
   <input type="hidden" name="cssFile" value="<%= prjName %>/style/UbqApp.css">
   <input type="hidden" name="cssFile" value="<%= prjName %>/style/cmsStyles.css">
   <input type="hidden" name=jsFile value="<%= prjName %>/base/outReachWelcome.js">
   
        <form name="cmsWelcomeForm" id="cmsWelcomeForm" method="GET" >
<!--        <table border="0" cellpadding="0" cellspacing="0" width="100%" id="skeletonTable" height="590px">-->
         <table border="0" cellpadding="0" cellspacing="0" width="100%" id="skeletonTable" height="395px">
            <tr valign="top">
                <td>
                <div style="height:350px;">
                    <table align="left" border="0" cellpadding="3" cellspacing="1">
        
                        <%
                            Vector cmdsVect = (Vector) request.getAttribute("accessibleCommands");
                            
                            
                            if(cmdsVect != null){
                            
                            for(int i = 0; i < cmdsVect.size(); i++) {
                            
                            UFeature f = (UFeature) cmdsVect.elementAt(i);
                            
                            String link_url_1 = f.featCommand;
                            
                            if(link_url_1 != null && !link_url_1.equals("")) {
                            %>
                            
                            <% if (i > 0)
                            {
                            %>
                            
                            <%}%>

                            <tr valign="top">

                                <th  align="left">   
                                    <% if("L".equalsIgnoreCase(f.featGroup)){%>
                                    <%--  Modified by saurabh....19.09.2011   --%>
                                    <a href="#" style="text-decoration: none; color: #000000;"  onmouseover="javascript:this.style.cursor = 'auto'"<%--class="menuLink"--%> <%--onclick="javascript:window.open('<%=f.featCommand%>','Dashboard','toolbar=no,location=no,directories=no,status=no,menubar=yes,scrollbars=yes,resizable=yes,copyhistory=no,fullscreen=no,titlebar=yes')"--%>>
                                        <%= f.featName%></a>
                                 <%}else{%>
                                 <a  href="#" style="text-decoration: none; color: #000000;" onmouseover="javascript:this.style.cursor = 'auto'" <%--onclick="desktop.loadPage('<%= f.featCommand %>', '<%= f.featName %>')"--%> <%--class="menuLink"--%>  ><%= f.featName%></a>
                                 <%}%>
                                
                            </th>
                        </tr>
                        
                        <tr>
                            <td width="20%">
                                
                            </td>     
                       <td>
                            &nbsp;&nbsp;&nbsp;<%= f.featHelp%>
                        </td></tr>
                        <%
                            }
                            }
                            }
                        %>
                    </table>
                </div>
                
                
                </td></tr>
                </table>
        </form>
    </div>

