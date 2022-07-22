<%-- 
    Document   : AssetUtilizationBrowserDetails
    Created on : Apr 11, 2013, 4:04:52 PM
    Author     : ubqtech018
--%>

<%@page import="ubq.util.UDate"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="windows-1252"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%
 ResultSet rs = (ResultSet)request.getAttribute("rsAssetUtils");
%>
<div style="width: 100%">
    <table width="100%" cellpadding="0" cellspacing="1" border="0">
        <%if(null != rs && rs.next()){
            rs.beforeFirst();
            while(rs.next()){
        %>
        <tr style="height: 20px">
            <td width="15%">
                <input type="hidden" name="headerRID" id="headerRID" value="<%= rs.getInt("plu_rid")%>">
                <input type="hidden" name="plantRID" id="plantRID" value="<%= rs.getInt("plu_plant_rid")%>">
                <a id="entName" href="javascript:" onclick="assetUtilization.showAssetUtilizationDetails(this)">
                    <b><%= UDate.dbToDisplay(rs.getString("plu_date"))%></b>
                </a>
           </td>
           
            <td width="20%"> &nbsp;&nbsp;
                    <%= rs.getString("ent_name")%>
            </td>
            <td width="20%">
               &nbsp;&nbsp; <%= rs.getString("no_of_lines")%>
            </td>
            <td width="45%">
               &nbsp;
           </td>
        </tr>
        <%}}else{%>
        <tr>
            <td width="100%" colspan="4">
                No record found
            </td>
        </tr>
        <%}%>
    </table>

</div>
