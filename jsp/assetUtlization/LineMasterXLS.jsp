<%-- 
    Document   : LineMasterXLS
    Created on : Dec 17, 2013, 3:44:28 PM
    Author     : Pushpanjali
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="application/vnd.ms-excel; charset=iso-8859-1" pageEncoding="windows-1252"%>


<%
    String project = request.getContextPath();
    ResultSet lineMasterRS = (ResultSet) request.getAttribute("lineMasterRS");
%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="<%= project %>/style/UbqApp.css" rel="stylesheet" type="text/css">
    </head>
    <body>
        <table width="1005" cellpadding="0" cellspacing="0" border="0">
            <tr class="specialRow">
                <td>Plant Name</td>
                <td>Plant Code</td>
                <td>Line Code</td>
                <td>Line Name</td>
                <td>Line Specification</td>
                <td>Line Description</td>
            </tr>

            <%
                if(null != lineMasterRS && lineMasterRS.next()) {
                    lineMasterRS.beforeFirst();
                    while(lineMasterRS.next()) {

            %>
            <tr>
                <td><%= lineMasterRS.getString("ent_name")%></td>
                <td><%= lineMasterRS.getString("ent_code")%></td>
                <td><%= lineMasterRS.getString("pml_code")%></td>
                <td><%= lineMasterRS.getString("pml_name")%></td>
                <td><%= lineMasterRS.getString("pml_specification")%></td>
                <td><%= lineMasterRS.getString("pml_description")%></td>
            </tr>

            <%
                    }
                } else {
            %>

            <tr>
                <td colspan="6">No record found</td>
            </tr>
            <%
                }
            %>
        </table>
    </body>
</html>
