<%@ page  import="java.sql.*, ubq.util.*, ubq.base.*, ubq.appFramework.*" %>

<%
int worklistConfigRID = request.getAttribute("worklistConfigRID") == null ? 0 : (Integer) request.getAttribute("worklistConfigRID");
 String worklistName = request.getAttribute("worklistName") == null ? "" : String.valueOf(request.getAttribute("worklistName"));
  //added by subhransu, to show worklist item in popup/openInset
 int worklistViewMode = 0;
 if(null != request.getAttribute("worklistViewMode")){
     worklistViewMode = Integer.valueOf(request.getAttribute("worklistViewMode").toString());
 }

 response.setContentType("text/html");

 boolean isDelayedTasks = "1".equals(request.getParameter("isDelayedTasks"));
%>


<div>
    <table width="100%" cellpadding="0" cellspacing="0" border="0">

        <tr height="<%=isDelayedTasks ? "1px":"30px"%>" class="<%=isDelayedTasks ? "hidden":"hidden"%>">
            <td colspan="100%">
                &nbsp;
                <%
                boolean isManaged = false;
                int isTrackDelayed = 0;
                if("1".equals(request.getParameter("isManaged"))) {
                    isManaged = true;
                }
                 if("1".equals(request.getParameter("hidTrackDelays"))) {
                    isTrackDelayed = 1;
                }
                %>
                <input type="hidden" name="isManaged" id="isManaged" value="<%= isManaged ? 1 : 0%>">
                <input type="hidden" name="hidTrackDelays" id="hidTrackDelays" value="<%= isTrackDelayed %>">
            </td>
        </tr>
        
<%
  String[] header = (String[]) request.getAttribute("worklistTaskHeader");

%>
<tr height="30px" class="wellHeader" style="visibility: hidden;display: none;">
        <td valign="middle" width="80%">
        Search by: 
       <select name="boSearchBy" id="boSearchBy">
         <%
  for(int i = 0; (header != null && i < header.length); i++) {
      
%>
         <option value="<%= i+1%>"><%= header[i]%></option>
<%
      } //i+1 for working fileters in work list
%>
       </select>
       &nbsp;
       <input type="text" name="boSearchString" id="boSearchString" value="" 
        onkeypress="if(baGetKeyCode(event) == 13) appFramework.searchTask();">&nbsp;
       <input type="button" name="boSearchBtn" id="boSearchBtn" value="Go" onclick="appFramework.searchTask();">&nbsp;
      </td>
      <td align="right" style="padding-right: 5px" width="20%">
          <input type="button" id="exportBtn" name="exportBtn" value="Export" title="Export worklist"
                 onclick="boWorklist.exportWorklist()" >
      </td>
    </tr>

        <%
        URequestContext ctxt = (URequestContext) request.getAttribute("ctxt");
        int isSnoozable = ctxt.getAttribute("isSnoozable") == null ? 0 : (Integer) ctxt.getAttribute("isSnoozable");
        ResultSet rs = (ResultSet) ctxt.getAttribute("worklistTasks");
        if(rs != null && rs.first()) { 
        %>
        
        <tr>
            <td colspan="100%">

                <input type="hidden" name="onWorklistLoad" value="initSortingOnTable('worklistTaskTbl')" >
                <input type="hidden" name="worklistConfigRID" id="worklistConfigRID" value="<%= worklistConfigRID %>" >
                <input type="hidden" name="worklistName" id="worklistName" value="<%= worklistName %>" >

                <table width="100%" border="0" cellpadding="0" cellspacing="0" class="boxShape" id="worklistTaskTbl" >
                    <tr class="specialRow">
                      <th>&nbsp;</th>
                        <%
                        java.sql.Timestamp now = UDate_Old.currentTimestamp();
                        
                        String worklistRID = (String) request.getParameter("worklistRID");
                        String worklistType = (String) request.getAttribute("worklistType");
                        String worklistBOWorkContext = (String) request.getAttribute("worklistBOWorkContext");
                        header = (String[]) request.getAttribute("worklistTaskHeader");
                        String[] contentFields = (String[]) request.getAttribute("worklistTaskFields");
                        
                        for(int i = 0; i < header.length; i++) {
                        %>
                        <th align="left"><%= (i == 0 ? "&nbsp;" : "") + header[i] %></th>
                        <%
                        }
                        %>
                        <td width="1%">&nbsp;</td>
                    </tr>
                    <%
                    int timerFlag = 0;
                    int rowNum = 1;
                    String timerColourSpec = "background-color: #FBC64A;";
                    boolean writeFromResultset = "RESULT_SET".equals((String) request.getAttribute("worklistContentSource"));
                    
                    String taskCommandURL = request.getParameter("taskCommandURL");
                    
                    if(taskCommandURL == null)
                        taskCommandURL = "";
                    
                    if(rs != null) {
                        rs.beforeFirst();
                        while(rs.next()) {
                            int wliRID = rs.getInt("wli_rid");
                            int boRID = rs.getInt("wli_bo_rid");
                            String boCode = rs.getString("bo_code");

                            String worklistFeatureCode = rs.getString("feature_code");

                            String actualClass = rowNum % 2 == 0 ? "evenRow" : "oddRow";
                            
                            java.sql.Timestamp timer1 = rs.getTimestamp("wli_timer1_expiry");
                            java.sql.Timestamp timer2 = rs.getTimestamp("wli_timer2_expiry");
                            java.sql.Timestamp stoppedTimerTime = rs.getTimestamp("wli_timer_stopped_time");
                            
                            String bgColourSpec = "";
                            timerFlag = rs.getInt("wli_timer_flag");
                            
                            if(timer2 != null && now.compareTo(timer2) > 0)
                            bgColourSpec = UConfig.getParameterValue(ctxt, "LEVEL2_ALERT_STYLE", "background-color:red;font-weight: bold;"); //#ED9894;");
                            else if(timer1 != null && now.compareTo(timer1) > 0)
                            bgColourSpec = UConfig.getParameterValue(ctxt, "LEVEL1_ALERT_STYLE", "background-color:orange;"); //#F5D19A;");
                            if(timerFlag == 1) { 
                            if(stoppedTimerTime != null && timer2 != null && stoppedTimerTime.compareTo(timer2) > 0) {
                            bgColourSpec = UConfig.getParameterValue(ctxt, "LEVEL2_ALERT_STYLE", "background-color:red;font-weight: bold;"); //#ED9894;"); 
                            } else if(stoppedTimerTime != null && timer1 != null && stoppedTimerTime.compareTo(timer1) > 0 ) {
                            bgColourSpec = UConfig.getParameterValue(ctxt, "LEVEL1_ALERT_STYLE", "background-color:orange;"); //#F5D19A;");
                            } else if(stoppedTimerTime != null && timer1 != null && timer1.compareTo(stoppedTimerTime) >= 0) {
                            bgColourSpec = ""; 
                            }
                         }

			    String taskArgs = rs.getString("wli_task_args");
                    %>
                    <tr class="<%= actualClass%> <%=isDelayedTasks ? "" :"cursorPoint"%>" id="worklistRowItem<%= boRID %>"
                        style="cursor: pointer;<%= (timerFlag == 1 && isTrackDelayed == 1) ? timerColourSpec : bgColourSpec%>"
                        <%
                        if(isManaged) {
                        %>
                        onclick="boWorklist.openWorklistTask(this, event, '<%= taskArgs%>');">
                        <%
                        } else {
                                
                                ResultSet rsUnmanagedCommand = (ResultSet) ctxt.getAttribute("rsUnmanagedCommand");
                                if(rsUnmanagedCommand != null && rsUnmanagedCommand.first()) {
                                    taskCommandURL = rsUnmanagedCommand.getString("wl_command_url");
                                }
                                
                                String onClickHandler = "boWorklist.openUnmanagedWorklistTask(this, '" +
                                        taskCommandURL + "', event, '" + taskArgs +"')";
                          if(!isDelayedTasks) {
                        %>                        
                        onclick="<%= onClickHandler%>" >
                        <%
                          }
                        }
			%>
<%
  String highPriorityClass = UConfig.getParameterValue(ctxt, "HIGH_PRIORITY_TASK_STYLE", 
                                                       "color:red;font-weight:bold;font-size:125%");
%>
			<td style="<%= rs.getInt("wli_priority") == BOWorklistManager.HIGH_PRIORITY ? "background-color:white;" : ""%>">
                          <span style="<%= highPriorityClass%>">
                             <%= rs.getInt("wli_priority") == BOWorklistManager.HIGH_PRIORITY ? "&nbsp;!" : ""%>
                          </span>
                        </td>

			<%
                            
                            int contentLength = 0;
                            if (writeFromResultset) {
                                if (null != contentFields) {
                                    contentLength = contentFields.length;
                                }
                                for(int i = 0; i < contentLength; i++) {
                        %>
                        <td height="25px" ><%= (i == 0 ? "&nbsp;" : "") + UString.blankIfNull(rs.getString(contentFields[i])) %></td>
                        <%
                                }
                            } else {
                                String boDescriptorStr = rs.getString("wli_descriptor");
                                String[] boDescriptor = null;
                                if (null != boDescriptorStr) {
                                    boDescriptor = (String[]) boDescriptorStr.split("&");
                                    contentLength = boDescriptor.length;
                                }
                                for (int i = 0; i < contentLength; i++) {
                        %>
                        <td height="25px" ><%= (i == 0) ? ("&nbsp;" + boDescriptor[i]) : boDescriptor[i] %></td>
                        <%
                                }
                            }
                            
                            for(int i = 0; i < header.length-contentLength; i++) {
                        %>
                        <td>&nbsp;</td>
                        <%
                            }
                        %>
                        <td>
                            <input type="hidden" name="wliRID" value="<%= wliRID %>">
                            <input type="hidden" name="boRID" value="<%= boRID%>">
                            <input type="hidden" name="boCode" value="<%= boCode%>">
                            <input type="hidden" name="worklistType" value="<%= worklistType%>">
                            <input type="hidden" name="worklistBOWorkContext" value="<%= worklistBOWorkContext %>">
                            <input type="hidden" name="taskCommandURL" value="<%= taskCommandURL%>">
                            <input type="hidden" name="worklistRowRID" value="<%= worklistRID%>">
                            <input type="hidden" name="timerFlag" value="<%= timerFlag%>">
                            <input type="hidden" name="timerColourSpec" value="<%= timerColourSpec%>">
                            <input type="hidden" name="bgColourSpec" value="<%= bgColourSpec%>">
                            <input type="hidden" name="isSnoozable" value="<%= isSnoozable %>" >
                            <input type="hidden" name="worklistFeatureCode" value="<%= worklistFeatureCode %>">
<!--                            //added by subhransu, to show worklist item in popup:1/openInset:0-->
                            <input type="hidden" name="worklistViewMode" value="<%= worklistViewMode %>">

                            <%
                            if (UUserManager.hasPrivilege(ctxt, "DISCARD_WORKLIST_ROW_ITEM")) {
                            %>

                            <input type="button" id="" name="" value="X" title="Click to discard worklist row item"
                                   class="deleteGrayButton" 
                                   onclick="boWorklist.discardWorklistRowItem(this, event, <%= wliRID %>)" > 
                            
                            <% } %>
                        </td>
                    </tr>
                    <%
                    rowNum++;
                        }
                    }
                    %>
                </table>
            </td>
        </tr>
        
        <% 
        }
        %>
        
    </table>
</div>
