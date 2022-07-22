<%@page contentType="text/html" import=" ubq.util.UDate_Old"%>
<%@page pageEncoding="UTF-8"%>

<% String projPath = request.getContextPath(); %>

<div>
    <input type="hidden" name="jsFile" value="<%= projPath%>/js/appFramework/UserTasks.js">
    <form name="userTasksForm" action="<%= projPath %>/UserTasksServlet" method="post" target="entryResponseFrame" >
        <input type="hidden" name="command" id="command" value="" >
        
        <table width="100%" cellpadding="4" cellspacing="0" border="0" class="whiteBG" >
            <tr class="wellHeader" >
                <td height="30px" colspan="100%" ></td>
            </tr>
            <tr class="specialRow" >
                <td colspan="100%" >
                     New Task
                </td>
            </tr>
            <tr>
                <%-- <td>Task</td>
                <td>
                    <input type="text" id="taskNameFld" name="taskNameFld" size="15" maxlength="100" value="">
                </td> --%>
                <td width="5%" valign="top" >
                    Details
                </td>
                <td>
                    <textarea id="taskDescArea" name="taskDescArea" rows="3" cols="60"></textarea>  
                </td>
                <td align="left"  valign="top" onkeypress="editKeyBoard(event, this, keybDateChar)" autocomplete="off">
                    Date  &nbsp;<input type="text"  name="taskDateFld" id="taskDateFld" size="10" maxlength="50" value="<%=UDate_Old.nowDisplayString()%>">
                    &nbsp;<input type="button" class="smallBtn" value="...." name="dateBtn" id="dateBtn" onclick="newPopupCalender('taskDateFld', 'dateBtn', this)">
                </td>
                <td onkeypress="editKeyBoard(event, this, keybTime)" autocomplete="off" valign="top">
                    Time  &nbsp;<input type="text" size="5" id="taskTimeFld" name="taskTimeFld" maxlength="5" value="<%=  UDate_Old.currentTime().toString().substring(0, 5) %>" >
                </td>
                <%-- </tr>
            <tr>--%>
            </tr>
            
            <tr>
                <td  width="10%" align="left" colspan="2">
                    <input type="checkbox" id="notifyMe" name="notifyMe" value="0">&nbsp;Remind me at
                    <input type="text"  name="dateFld" id="dateFld" size="10" maxlength="50" value="<%= UDate_Old.nowDisplayString() %>">
                    <input type="text" size="5" id="remindtimeFld" name="remindtimeFld" maxlength="5" value="<%=  UDate_Old.currentTime().toString().substring(0, 5) %>" >
                </td>
                
                <td align="right" style="padding-right:5px" colspan="100%">
                    <input type="button" id="saveTask" name="saveTask" value="Save" onclick="userTasks.saveTasks()">
                    <input type="button" id="cancel" name="cancel" value="Cancel" onclick="userTasks.cancel(this)">
                </td>
            </tr>
        </table>
    </form>
    
</div>
