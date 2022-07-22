<%@page contentType="text/html" import="ubq.base.URequestContext" import="ubq.util.UDate_Old, ubq.util.*, java.sql.*" %>
<%@page pageEncoding="UTF-8"%>

<% String projPath = request.getContextPath(); %>
<div id="viewUserTaskDiv">
    <input type="hidden" name="jsFile" value="<%= projPath%>/js/appFramework/UserTasks.js">
    <form name="userTasksForm" action="<%= projPath %>/UserTasksServlet" method="post" target="entryResponseFrame" >
        <input type="hidden" name="command" id="command" value="" >
        <table  border="0" cellpadding="0" cellspacing="0"  class="whiteBG" width="100%">
            <% ResultSet rsViewUserTasks = (ResultSet)request.getAttribute("rsViewUserTasks");
            String taskDate = "",taskDesc = "", taskName = "", taskTime = "";
            int taskToNotify = 0, taskRID = 0;
            if(rsViewUserTasks != null && rsViewUserTasks.first()) {
                taskRID = rsViewUserTasks.getInt("ut_rid");
               // taskDate =  rsViewUserTasks.getString("ut_createed_dateTime").substring(0,10);
                taskDate =  UDate_Old.dbToDisplay(rsViewUserTasks.getString("ut_createed_dateTime"));
                taskDesc = rsViewUserTasks.getString("ut_task_desc");
                // taskName =  rsViewUserTasks.getString("ut_task_name");
                taskToNotify = rsViewUserTasks.getInt("ut_is_to_notify");
                taskTime = rsViewUserTasks.getString("ut_createed_dateTime").substring(11,16);
            }
            //taskDesc = (taskDesc.length() > 30 ? taskDesc.substring(0, 10) + "... " : taskDesc);
            
            %>
            <tr class="whiteBG">
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td align="left" style="padding-left:8px" width="40%" onkeypress="editKeyBoard(event, this, keybDateChar)" autocomplete="off">
                    Date:&nbsp;<%= taskDate %>&nbsp; Time: <%= taskTime %>
                </td>
            </tr>
            <br/>
            <tr>
                <td>
                    &nbsp;&nbsp;Description : 
                    <%= taskDesc %>
                </td>
            </tr>
            
            <tr>
                <td align="right" style="padding-right:5px;padding-bottom:4px" colspan="100%">
                    <input type="button" id="done" name="done" value="Done" onclick="userTasks.taskDone(<%= taskRID %>)">
                    <input type="button" id="cancel" name="cancel" value="Cancel" onclick="userTasks.cancelInset(this)">
                </td>
            </tr>
        </table>
    </form>
</div>
