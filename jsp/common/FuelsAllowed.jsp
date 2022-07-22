<%-- 
    Document   : FuelsAllowed
    Created on : 24 Jan, 2014, 1:24:32 PM
    Author     : ubqtech037
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="windows-1252"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%
    String projPath = request.getContextPath();
    ResultSet rs = (ResultSet) request.getAttribute("fuelListRS");
    int entityRid = (Integer) request.getAttribute("entityRid");

%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
         <link href="<%= projPath%>/style/UbqApp.css" rel="stylesheet" type="text/css">
        <script language="Javascript" type="text/Javascript" src="<%= projPath%>/js/assetUtlization/AWProfile.js"></script>
        <script language="Javascript" type="text/Javascript" src="<%= projPath%>/js/base/DynamicTableTemplate.js"></script>
    </head>
    <body class="bodyBackground" onload="awProfile.initFuelAllowed();">
        <div style="width:100px">
            <table width="300%" cellpadding="0" cellspacing="1" border="0" id="allowedFuelTable">
                <tr class="specialRow">
                    <td width="50%">Fuel Name
                        <input type="hidden" name="plantRid" id="plantRid" value="<%= entityRid%>">
                    </td>
                    <td align="right">Is Allowed</td>
                </tr>
                <%
                     if( rs != null && rs.first() ){
                     String fuelName = "";                     
                     int isActive = 0, fuelRID = 0;
                     rs.beforeFirst();

                     while(rs.next()){
                     fuelName = rs.getString("fuel_name");                    
                     isActive = rs.getInt("allowed");
                     fuelRID = rs.getInt("fuel_rid");
                 %>
                 <tr>
                     <td width="50%"><%=fuelName %></td>
                     <td align="right"><input type="checkbox" name="isAllowed" id="isAllowed" <%= isActive == 1 ? "checked" : ""%> onclick="awProfile.updateHiddenField(this)">
                         <input type="hidden" id="hidIsAllowed" name="hidIsAllowed" value="<%= isActive%>">
                         <input type="hidden" id="hidFuelRid" name="hidFuelRid" value="<%= fuelRID%>">
                        
                     </td>
                 </tr>                                  
                  
              <%
                }
            }
              %>                       
              <tr>
                  <td colspan ="4" align="right">
                  <input type="button" name="okBtn" id="okBtn" value="OK" onclick="awProfile.saveFuel()">
                  </td>
              </tr>
            </table>
        </div>        
    </body>
</html>
