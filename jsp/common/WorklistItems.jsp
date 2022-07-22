<%@page import="java.sql.*,ubq.util.*,java.util.*,ubq.base.*"%>
<div id="worklistItemsDiv">
    <%
                String ACTIONABLE = "1";
                String FOLLOWUP = "2";
                String FYI = "3";
    %>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr valign="top">
            <td>
                
                <table width="100%" id="worklistTable" tabindex=-1 cellpadding="3" cellspacing="0" > 
                    <%
                    URequestContext ctxt = (URequestContext) request.getAttribute("ctxt");
                    String selectedWorklistRIDStr = ctxt.getParameter("selectedWorklistRID") == null?"0"
                            :ctxt.getParameter("selectedWorklistRID").toString();
                    int selectedWorklistRID = Integer.parseInt(selectedWorklistRIDStr);
                    int hidTrackDelays = 0;
                    Vector wv = (Vector) request.getAttribute("worklistSummary");
                    boolean showAll = request.getParameter("showAll") != null;
                                String prevWorklistType = "0", worklistType = "0", wlTypeName = "", backgroundColor = "";
                    
                    if(wv != null) {
                        
                        int taskCount = 0;
                        
                        boolean isManaged = false;
                        String taskCommandURL = null;
                        
                        for(int i = 0; i < wv.size(); i++) {
                            
                            String[] a = (String[]) wv.get(i);
                                        worklistType = a[11];

                                        if (!worklistType.equals(prevWorklistType)) {
                                            if (ACTIONABLE.equals(worklistType)) {
                                                wlTypeName = "Pending Actions";
                                                backgroundColor = "#FF9090";
                                            } else if (FOLLOWUP.equals(worklistType)) {
                                                wlTypeName = "Followup";
                                                backgroundColor = "wheat";
                                            } else if (FYI.equals(worklistType)) {
                                                wlTypeName = "FYI";
                                                backgroundColor = "thistle";
                                            }

                                            prevWorklistType = worklistType;
                                            if (taskCount > 0) {
                    %>

                </table>
                </div>
                </fieldset>
            </td>
        </tr>
        <%                                                                    }
        %>
        <tr >
            <td >
                <fieldset style="background-color: <%= backgroundColor%>">
                    <legend><b><%= wlTypeName%></b></legend>
                    <div >
                        <table width="100%" cellpadding="2" cellspacing="0" border="0" >

                            <%
                                                        }
                            
                            if(!"0".equals(a[2])) {
                                taskCount++;
                            } else if(!showAll) {
                                continue;
                            }
                            
                    /*
                    String bgColourSpec = "";
 
                    if("2".equals(a[6]))
                    bgColourSpec = UConfig.getParameterValue(ctxt, "LEVEL2_ALERT_STYLE", "background-color:red;font-weight: bold;");
                    else if("1".equals(a[6]))
                    bgColourSpec = UConfig.getParameterValue(ctxt, "LEVEL1_ALERT_STYLE", "background-color:orange;");
                     */
                            
			    isManaged = "1".equals(a[7]);
                            taskCommandURL = a[8];

			    String displayStyle = a[9];
                    
                    %>
                            <tr itemRow=true class="<%= (a[0].equals(selectedWorklistRID + "")) ? "selectedWorklistItem" : backgroundColor%>">
<%
                            if(displayStyle != null && !"".equals(displayStyle)) {
%>
	              style="<%= displayStyle%>"
<%
                            }
%>
		      

                        <td height="25px" title="<%= a[1] %> as on <%= a[5] %>"  >
                            
                            <a href="#" onclick="boWorklist.loadWorklistItem(dynTableRow(this));" >
                                <input type="hidden" id="worklistRID" name="worklistRID" value="<%= a[0]%>">
				<input type="hidden" id="worklistType" name="worklistType" value="<%= a[11] %>">
                                <input type="hidden" id="worklistCommand" name="worklistCommand" value="<%= a[3]%>">
                                <input type="hidden" id="isManaged" name="isManaged" value="<%= isManaged ? 1 : 0%>">
                                <input type="hidden" id="taskCommandURL" name="taskCommandURL" value="<%= taskCommandURL%>">
                                <input type="hidden" id="worklistName" name="worklistName" value="<%= a[1]%>">
                                <input type="hidden" id="worklistCount" name="worklistCount" value="<%= a[2]%>">
<!--                                //added by subhransu, to show worklist item in popup:1/openInset:0-->
                                <input type="hidden" id="worklistViewMode" name="worklistViewMode" value="<%= a[12]%>">
                                <% if("1".equals(a[4])){ %>
                                <input type="hidden" id="isDateSpecific" name="isDateSpecific" value="1">
                                <% } %>
                                
                                <%
                                if(!"0".equals(a[2])) {
                                %>
                                <span id="wItemName" name="wItemName" ><%= a[1] %></span>
                                <span id="itemCount" name="itemCount" ><%= " (" + a[2] + ") "%></span>
                                <%
                                } else if(showAll) {
                                %>
                                <span id="wItemName" name="wItemName"><%= a[1]%></span><span id="itemCount" name="itemCount"></span>
                                <%
                                }
                                %>
                            </a>
                        </td>
                        <td width="8%">
                           
                            <%
                            if("1".equals(a[6])) {
                                hidTrackDelays = 1;
                            %>
                            <img src="images/Clock_gif_small_orange.png"/>
                            <%
                            } else if("2".equals(a[6])) {
                                 hidTrackDelays = 1;
                            %>
                            <img src="images/Clock_gif_small.gif"/>
                            <%
                            } else {
                                hidTrackDelays = 0;
                            %>
                            &nbsp;
                            <%
                            }
                            %>
                            <input type="hidden" id="wliTrackDelays" name="wliTrackDelays" value="<%= hidTrackDelays%>">  
                        </td>
                       
                    </tr>
                    <%
                    
                        }
                                                    if (taskCount > 0) {
                            %>
                        </table>
                    </div>
                </fieldset>
            </td>
        </tr>
        <%                                                    }
                        
                        if(taskCount == 0 && !showAll) {
                    %>
                    <tr >
                        <td height="20px" >&nbsp;No pending tasks</td>
                    </tr>
        <%                                            }
                    } else if (!showAll) {
                    %>
                    <tr >
                        <td height="20px" >&nbsp;No pending tasks</td>
                    </tr>
        <%                                }
                    %>
                </table>
            </td>
        </tr>
    </table>
</div>
