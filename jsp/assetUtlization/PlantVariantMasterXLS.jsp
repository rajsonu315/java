<%-- 
    Document   : PlantVariantMasterXLS
    Created on : Dec 17, 2013, 5:47:55 PM
    Author     : Pushpanjali
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="application/vnd.ms-excel; charset=iso-8859-1" pageEncoding="windows-1252"%>

<%
    String project = request.getContextPath();
    ResultSet variantMasterRS = (ResultSet) request.getAttribute("variantMasterRS");
%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="<%= project %>/style/UbqApp.css" rel="stylesheet" type="text/css">
    </head>
    <body>
        <table width="1005" cellpadding="0" cellspacing="0" border="0">
            <tr class="specialRow">
                <td>Variant Code</td>
                <td>Variant Name</td>
                <td>Brand Code</td>
                <td>Brand Name</td>
            </tr>

            <%
                if(null != variantMasterRS && variantMasterRS.next()) {
                    variantMasterRS.beforeFirst();
                    while(variantMasterRS.next()) {

            %>
            <tr>
                <td><%= variantMasterRS.getString("var_code")%></td>
                <td><%= variantMasterRS.getString("var_name")%></td>
                <td><%= variantMasterRS.getString("brand_code")%></td>
                <td><%= variantMasterRS.getString("brand_name")%></td>
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
