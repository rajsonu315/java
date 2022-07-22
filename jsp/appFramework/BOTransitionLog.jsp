<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.ResultSet ,ubq.util.UDate_Old, ubq.appFramework.BOState"%>

<%
ResultSet rs = (ResultSet) request.getAttribute("transitionLog");
//ResultSet rsEscalationLog = (ResultSet) request.getAttribute("escalationLog");
%>

<div id="transitionLogDiv">
    
<table id="transitionLogTable" cellpadding="2" cellspacing="0" width="100%" border="0">
    <%
        if(rs != null && rs.first()) {
            rs.beforeFirst();
        %>
        <tr><td colspan="5"> </td> </tr>
        <tr class="specialRow">
            <td align="left">From state </td>
            <td align="left">To state </td>
            <td align="left">User </td>
            <td align="left">Date / Time </td>
            <td title="Close"><a class="clickMe" onclick="appFramework.hideHistory()">X</a></td>
        </tr>
            
        <%
            while(rs.next()) {
        %>
        <tr>
            <td><%=rs.getString("from_state")%> </td>
            <td><%=rs.getString("to_state")%> </td>
            <td><%=rs.getString("user_full_name")%> </td>
            <td colspan="2"><%=UDate_Old.dbToDisplayDatetime(rs.getString("updated_time"))%>

            </td>
        </tr>
        <%
            }
        %>
        
        <%
        }
        %>
        
<%--    <%
        if(rsEscalationLog != null && rsEscalationLog.first()) {
            rsEscalationLog.beforeFirst();
        %>
        <tr><td colspan="5"> </td> </tr>
        <tr class="specialRow">
            <td align="left" colspan="2">Escalation </td>
            <td align="left" colspan="3">Date / Time </td>
        </tr>

        <%
            while(rsEscalationLog.next()) {
        %>
        <tr>
            <td colspan="2"><%=rsEscalationLog.getString("to_state")%> </td>
            <td colspan="3"><%=UDate_Old.dbToDisplayDatetime(rsEscalationLog.getString("updated_time"))%>
            </td>
        </tr>
        <%
            }
        %>

        <%
        }
        %>--%>
    
</table>
    
    
     
</div>