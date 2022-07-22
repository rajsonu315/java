<%-- 
    Document   : EntityFilter
    Created on : Apr 5, 2013, 6:07:08 PM
    Author     : ubqtech035
--%>

<%@ page  language="java" import="java.sql.*, ubq.util.* , java.util.*" import="java.text.*" import="java.util.HashMap" errorPage="" %>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<div>
    <%
                String projPath = request.getContextPath();
                ResultSet regionRS = (ResultSet) request.getAttribute("regionRS");
                ResultSet cpRS = (ResultSet) request.getAttribute("cpRS");
                int regionRID = (Integer) request.getAttribute("regionRID");
                int cpRID = (Integer) request.getAttribute("cpRID");                           
    %>
    <input type="hidden" name="jsFile" value="<%= projPath%>/js/base/EntityFilter.js">
    <input type="hidden" id="cpRID" name="cpRID" value="<%=cpRID%>">
    <input type="hidden" id="regionRID" name="regionRID" value="<%=regionRID%>">
    <table border="0" width="100%" cellpadding="2" cellspacing="0">
        <tr>
            <td width="8%"> Region</td>
            <td width="20%">
                <select id="regionCombo" name="regionCombo" style="width:150px" <%if (0 != regionRID) {%> disabled<%}%> onchange="entityFilter.setRegion(this)">
                    <option value="0"> All</option>
                    <%while (null != regionRS && regionRS.next()) {%>
                    <option value="<%=regionRS.getInt("ent_rid")%>"  <%if (regionRID == (regionRS.getInt("ent_rid"))) {%>
                            selected = "selected"<%}%>> <%= regionRS.getString("ent_name")%> </option>
                    <%}
                    %>
                </select>

            </td>
            <td width="5%"> CP</td>
            <td>
                <select id="CPCombo" name="CPCombo" style="width:150px" <%if (0 != cpRID) {%> disabled<%}%> onchange="entityFilter.setCP(this)">
                    <option value="0">All</option>
                    <%while (null != cpRS && cpRS.next()) {%>
                    <option value="<%=cpRS.getInt("ent_rid")%>"  <%if (cpRID == (cpRS.getInt("ent_rid"))) {%>
                            selected = "selected"<%}%>> <%= cpRS.getString("ent_name")%> </option>
                    <%}
                    %>
                </select>
            </td>
        </tr>        
    </table>


</div>
