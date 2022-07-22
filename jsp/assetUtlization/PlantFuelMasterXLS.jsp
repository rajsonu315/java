<%-- 
    Document   : PlantFuelMasterXLS
    Created on : Jan 27, 2014, 7:22:32 PM
    Author     : Sudip
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="application/vnd.ms-excel; charset=iso-8859-1" pageEncoding="windows-1252"%>

<%
    String project = request.getContextPath();
    ResultSet fuelMasterRS = (ResultSet) request.getAttribute("fuelMasterRS");
    DecimalFormat fmt = new DecimalFormat("####0.00");
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="<%= project %>/style/UbqApp.css" rel="stylesheet" type="text/css">
    </head>
    <body>
        <table width="1005" cellpadding="0" cellspacing="1" border="0">
            <tr class="specialRow">
                <td>Fuel Code</td>
                <td>Fuel Name</td>
                <td>Uom Code</td>
                <td>Uom Name</td>
                <td align="right">HSD Eqv.</td>
                <td>Is Active</td>
            </tr>

            <%
            if (fuelMasterRS != null && fuelMasterRS.next()) {
                fuelMasterRS.beforeFirst();
                while (fuelMasterRS.next()) {
            %>
            <tr>
                <td><%= fuelMasterRS.getString("fuel_code")%></td>
                <td><%= fuelMasterRS.getString("fuel_name")%></td>
                <td><%= fuelMasterRS.getString("uomCode")%></td>
                <td><%= fuelMasterRS.getString("uom")%></td>
                <td align="right"><%= fmt.format(fuelMasterRS.getFloat("fuel_hsd_eqv"))%></td>
                <td><%= fuelMasterRS.getInt("fuel_is_valid") == 1 ? "YES" : "NO"%></td>
            </tr>
            <%
            }
            } else {
            %>
            <tr>
                <td>NO record found</td>
            </tr>
            <%
            }
            %>
        </table>
    </body>
</html>
