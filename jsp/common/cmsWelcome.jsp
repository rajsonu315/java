<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" 
import="ubq.util.*" import="java.util.*" import="ubq.base.*" errorPage="" %>
<%@page pageEncoding="UTF-8"%>

<% String projPath = request.getContextPath(); %>
<div>
    <!--script language="javascript">
        function hideDiv(){
        var targetDiv = document.getElementById('alertDiv') ;
        targetDiv.style.visibility = 'hidden' ;
        targetDiv.style.display = 'none' ;
        }
</script-->
    <input type="hidden" name="onLoadFunction" value="portalHomeInit()">
    <input type="hidden" name="jsFile" value="<%= projPath%>/js/base/xmlHelper.js">
    <input type="hidden" name="jsFile" value="<%= projPath%>/js/base/ValidateFunction.js">
    
    
    <form name="cmsWelcomeForm" method="GET" >
        <table border="0" cellpadding="0" cellspacing="0" width="100%" id="skeletonTable">
            <tr class="wellHeader" ><td height="30px" colspan="100%" ></td></tr>
            <tr> 
                <td colspan="4" style="padding-left:10px;" class="boxShape">
                    <table width="100%" border="0" cellpadding="2" cellspacing="2"> 
                        
                        <tr>
                            <td colspan="2">
                                To set any command as the default that must be initiated after login, 
                                click on the round button on the left of the command name. To change the default,
                                click on the new default command.
                                <br><br>
                            </td>
                        </tr>
                        
                        <tr>
                            <td width="50%" valign="top"> 
                                <table align="left" border="0" width="100%" >
                                    
                                    <%
                                    int tempParentRID = -5;
                                    int rootParentRID = 0;
                                    String rootParentDesc = "";
                                    Vector cmdsVect = (Vector) request.getAttribute("accessibleCommands");
                                    
				    // Load the Frequently Used Feature (FUF) Vector
	                            Vector fufVect = (Vector) request.getAttribute("frequentlyUsedCommands");

                                    // Construct a Hash table so that we can check quickly if an accessible command 
                                    // is frequently used
                                    HashMap fufHM = new HashMap();

                                    if(fufVect != null) {
                                      for(int i = 0; i < fufVect.size(); i++) {
                                        UFeature f = (UFeature) fufVect.elementAt(i);
                                        fufHM.put(new Integer(f.featRID), f);
                                      }
                                    }
                                    
                                    String primaryFeatCmd = (request.getAttribute("primaryFeatCmd") == null)? "" :
                                        (String) request.getAttribute("primaryFeatCmd");
                                    
                                    int count = 0, vLength = 0;
                                    
                                    if(cmdsVect != null){
                                        
                                        for(int i = 0; i < cmdsVect.size(); i++) {
                                            UFeature f = (UFeature) cmdsVect.elementAt(i);
                                            rootParentRID = f.rootParentRID;
                                            if(rootParentRID == 0) {
                                                continue;
                                            }
                                            
                                            rootParentDesc = f.rootParentDesc;
                                            String link_url_1 = f.featCommand;
                                            
                                            if(link_url_1 != null && !link_url_1.equals("")) {
                                    %>
                                    
                                    
                                    
                                    <% if (rootParentRID != tempParentRID) {
                                       
                                    %>
                                    
                                    <%if (tempParentRID != -5) {%>
                                    <tr>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <%}
                                        tempParentRID = rootParentRID;
                                    %>
                                    <tr>
                                        <th height="20" align="left" class="specialRow">
                                            &nbsp;<%= rootParentDesc.toUpperCase() %>
                                        </th>
                                    </tr>
                                    <%
                                    }
                                    %>
                                    <tr>
                                        
                                        <th height="20" align="left" >&nbsp;&nbsp;&nbsp;   
                                            <% if("L".equalsIgnoreCase(f.featGroup)){%>
                                            <input type="radio" name="radio" value="0" title="Operation not allowed here" disabled> 
                                                
                                                <a href="#" onclick="window.open('<%=f.featCommand%>', '_blank', 'toolbar=yes,location=no,directories=no, status=yes,menubar=yes,scrollbars=yes,resizable=yes, copyhistory=no,fullscreen=no,titlebar=yes');" class="menuLink" ><%= f.featName%></a>
                                            
                                            <%} else {%>
                                            
                                            &nbsp;<input type="checkbox" 
				    <%

                                      boolean isFrequentlyUsed = fufHM.get(new Integer(f.featRID)) != null;

                                      if(isFrequentlyUsed) {
                                    %>
                                                   title="Click to remove from frequently used commands list" onclick="userProfile.removeFromFrequentlyUsedCommands(this, <%= f.featRID%>)" checked>
                                    <%
                                      } else {
                                    %>
                                                   title="Click to add to frequently used commands list" onclick="userProfile.addToFrequentlyUsedCommands(this, <%= f.featRID%>)">
                                    <%
                                      }
                                    %>
                                            
                                            <input type="radio" name="changeDefaultFeature" value="<%= f.featRID%>" 
                                                   onclick="setDefaultFeature('<%= f.featRID%>')" 
                                                   <% if(primaryFeatCmd.equals(f.featCommand)){%> checked <%}%> title="Set this as my initial page">
                                            
                                            &nbsp;<a  href="#" onclick="desktop.loadPage('<%= f.featCommand %>', '<%= f.featName %>')" class="menuLink" ><%= f.featName%></a>
                                            <%}%>
                                        </th>
                                    </tr>
                                    
                                    <tr><td valign="top" >
                                            <table width="100%" cellpadding="0" cellspacing="0"><tr><td width="12%"  ></td><td><%= f.featHelp%></td></tr></table>
                                            
                                    </td></tr>
                                    <%
                                    vLength = 8;
                                    if(cmdsVect != null && cmdsVect.size() > vLength){
                                        vLength = (cmdsVect.size() / 2) - 2;
                                    }
                                    if(count == vLength) {
                                    %>
                                </table>
                            </td>
                            <td valign="top" width="50%">  <table border="0" width="100%" cellpadding="0" cellspacing="0">
                                    
                                    <%
                                    }
                                    count ++ ;
                                            }
                                        }
                                    }
                                    %>
                                </table>
                            </td>
                            <td>&nbsp; </td>
                        </tr>
                    </table>
                    
                </td>
            </tr>                                                                                           
            <tr>
                <td width="17%"  valign="top" height="30" onclick="hideDiv();">
                <div id="controlDiv"> </div></td>
                <td width="100%" height="70"  valign="top" onclick="hideDiv();">
                    
                    <div id="workingDiv" >
                        <p></p>
                        <div id="myDiv" height="100px" width="100px">
                        </div>
                    </div>
                </td>
                <td>          
                    <div id="alertDiv" style="visibility:hidden; display:none; width:300px; height:200px;" class="centered"
                         onclick="highLightFirstRow();">
                        <% //@include file="GenericProductListDiv.jsp"%>
                    </div>
                </td>
            </tr>
            
            
            
            
          
        </table>
    </form>
    
</div>
