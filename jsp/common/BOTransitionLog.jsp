<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.ResultSet ,ubq.util.UDate_Old, ubq.appFramework.BOState"%>

<%
ResultSet rs = (ResultSet) request.getAttribute("transitionLog");
%>

<div id="transitionLogDiv">
    
<table id="transitionLogTable" cellpadding="2" cellspacing="0" width="100%" border="0">
    <%
        if(rs != null && rs.first()) {
            rs.beforeFirst();
        %>
        <tr><td> </td> </tr>
        <tr class="specialRow">
            <th align="left">From state </th>
            <th align="left">To state </th>
            <th align="left">User </th>
            <th align="left">Date / Time </th>
            <th title="Close"><a class="clickMe" onclick="appFramework.hideHistory()">X</a></th>
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
    
</table>
    
    
     
</div>