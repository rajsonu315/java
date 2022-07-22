<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.ResultSet" import="java.text.*" %>
<%@ page import="ubq.base.*" errorPage="" pageEncoding="UTF-8"%>

<div id="workingDiv">
    <%
    ResultSet rsWorklistItems = (ResultSet)request.getAttribute("rsWorklistItems");
    String projPath = request.getContextPath();
    String printFlag = "false";
    if(request.getAttribute("printFlag") != null) {
        printFlag = (String)request.getAttribute("printFlag");
    }
    %>
    <form method="post" name="worklistTimeDelayDetails" > 
        
        <input type="hidden" name="command" value="modifyWorklistDetails" >
        <div id="timeDelayDiv">
            <input type="hidden" name="jsFile" value="<%= projPath %>/js/appFramework/DelayedTasks.js">
            
            <table border="0" cellpadding="3" cellspacing="0" width="100%" class="boxShape" id="timeDelayDetailsTable">
                
                <tr height="30px;" class="wellHeader">
                    <td colspan="100%"> &nbsp; </td>
                </tr>
                <tr class="specialRow" valign="top">
                    <td  colspan="4" width=""> <b> Worklist Timer Master </b> </td>
                </tr><br/>
                <tr class="wellHeader">
                    <td  style="padding-left:8px"> <b> Worklist Name </b> </td>
                    <td> <b> Track Delay </b>  </td>
                    <td> <b> Time Delay 1 (mins) </b> </td>
                    <td> <b> Time Delay 2 (mins) </b> </td>
                    
                </tr><br/>
                <% if(rsWorklistItems != null && rsWorklistItems.first()){
        rsWorklistItems.beforeFirst();
        while(rsWorklistItems.next()) { %>
                <tr align="left">
                    <td  style="padding-left:8px">
                        <input type="hidden" id="worklisRID" name="worklisRID" value="<%= rsWorklistItems.getInt("wl_rid")%>">
                        <input type="hidden" id="isModified"  name="isModified" value="0">
                        <%--       <input type="text" name="worklistName" id="worklistName" size="45" value="<%= rsWorklistItems.getString("wl_name")%>" onkeypress="editKeyBoard(event, this, keybName)" onchange="delayedTasks.modifyWorklistDetails(this,event)"> --%>
                        <label style="width:40px"> <%= rsWorklistItems.getString("wl_name")%> </label>
                    </td>
                    <%     if(rsWorklistItems.getInt("wl_track_delays") == 0) {
                    %>
                    <td>
                        <%--    <a id="delete" href="javascript:"onclick="delayedTasks.modifyWorklistDetails(this,event)" title='Delete time delay'>
                            <span class="userInfo" style="cursor: pointer;"> X </span>  
                        </a> --%>
                        <% if(!(printFlag.equals("true"))) { %>
                        <input type="checkbox" title="Is worklist track delay requires"  name="isTimeDelayExists" id="isTimeDelayExists" value="0" unchecked onclick="delayedTasks.modifyWorklistDetails(this,event)">
                        <%} else {%>
                        <input type="checkbox" name="isTimeDelayExists" id="isTimeDelayExists" value="0" unchecked disabled>
                            <%}%>
                        </td>
                    <% } else { %>
                    <td>
                        <% if(!(printFlag.equals("true"))) { %>
                        <input type="checkbox" title="Is worklist track delay requires"  name="isTimeDelayExists" id="isTimeDelayExists" value="1" checked onclick="delayedTasks.modifyWorklistDetails(this,event)">
                        <%} else {%>
                        <input type="checkbox" name="isTimeDelayExists" id="isTimeDelayExists" value="1" checked disabled >
                            <%}%>
                        </td>
                    <% } %>
                    <td>
                        <% if(!(printFlag.equals("true"))) { %>
                        <input class="numberTextBox" type="text" maxlength="5" size="5" name="timeDelay1" id="timeDelay1" align="right" value="<%=rsWorklistItems.getString("wl_time_delay_1")%>" onkeypress="editKeyBoard(event, this,keybNumber)"  onchange="delayedTasks.modifyWorklistDetails(this,event)">
                        <%} else {%>
                        <input class="numberTextBox" type="text" maxlength="5" size="5" name="timeDelay1" id="timeDelay1" align="right" value="<%=rsWorklistItems.getString("wl_time_delay_1")%>" readonly>
                            <%}%>
                        </td>
                    <td>
                        <% if(!(printFlag.equals("true"))) { %>
                        <input class="numberTextBox" type="text" maxlength="5" size="5" name="timeDelay2" id="timeDelay2" align="right" value="<%=rsWorklistItems.getString("wl_time_delay_2")%>" onkeypress="editKeyBoard(event, this,keybNumber)"  onchange="delayedTasks.modifyWorklistDetails(this,event)">
                        <%} else {%>
                        <input class="numberTextBox" type="text" maxlength="5" size="5" name="timeDelay2" id="timeDelay2" align="right" value="<%=rsWorklistItems.getString("wl_time_delay_2")%>" readonly>
                            <%}%>
                        </td>
                </tr>
                <% }
                }%> <br/><br/>
                <% if(!(printFlag.equals("true"))) { %>
                <tr class="">
                    <td align="right" colspan="4" style="padding-right:8px;padding-bottom:12px">
                        <input type="button" id="printBtn" name="printBtn" value="Print" onclick="delayedTasks.printWorklistTimeDelays(this,event)">
                        &nbsp;
                        <input type="button" id="saveBtn" name="saveBtn" value="Save" onclick="delayedTasks.saveWorklistDetails(this,event)">
                        &nbsp;
                        <input type="reset" name="clearBtn" id="clearBtn" value="Clear">
                    </td><br/>
                    
                </tr>
                <% } %>
            </table>
        </div>
    </form>
</div>