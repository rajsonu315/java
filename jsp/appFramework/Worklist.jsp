<%@ page contentType="text/html" import="java.sql.*, ubq.util.*, ubq.base.*" %>


<div>

<%
  URequestContext ctxt = (URequestContext) request.getAttribute("ctxt");

  ResultSet rs = (ResultSet) ctxt.getAttribute("worklistTasks");

  if(rs != null) {

    while(rs.next()) {
%>
      rs.getString("wli_descriptor");
<%
    }
  }
%>
</div>