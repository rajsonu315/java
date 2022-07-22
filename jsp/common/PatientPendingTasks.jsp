<%@ page  import="java.sql.*, ubq.util.*, ubq.base.*, ubq.appFramework.*" %>


<div>
  <table width="100%" cellpadding="0" cellspacing="0" border="0">

<%
  ResultSet rs = (ResultSet) request.getAttribute("rsPatientPendingTasks");

  rs.beforeFirst();

  while(rs.next()) {

    int worklistRID = rs.getInt("wli_worklist_rid");
    int wliRID = rs.getInt("wli_rid");
    int boRID = rs.getInt("wli_bo_rid");
    String boCode = rs.getString("bo_code");
    String worklistFeatureCode = ""; //rs.getString("feature_code");
    String taskArgs = rs.getString("wli_task_args");
%>

    <tr onclick="boWorklist.popupWorklistTask(this, event, '<%= taskArgs%>');">
      <td><%= rs.getString("wl_name")%></td>
      <td>
        <input type="hidden" name="wliRID" value="<%= wliRID %>">
        <input type="hidden" name="boRID" value="<%= boRID%>">
        <input type="hidden" name="boCode" value="<%= boCode%>">
        <input type="hidden" name="worklistRowRID" value="<%= worklistRID%>">
        <input type="hidden" name="worklistFeatureCode" value="<%= worklistFeatureCode %>" >
      </td>
    </tr>
<%
  }
%>

  </table>
</div>
