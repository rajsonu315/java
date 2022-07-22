<%-- 
    Document   : PlantLevelLPFReport
    Created on : Feb 19, 2014, 1:20:28 PM
    Author     : ubqtech010
--%>

<%@page import="ubq.util.UDate"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="windows-1252"%>

<%
String reportName = (String) request.getAttribute("reportName");
String targetScreen = (String) request.getAttribute("targetScreen");
String selectedFromDate = (String) request.getAttribute("selectedFromDate");
String selectedToDate = (String) request.getAttribute("selectedToDate");
String currentDate=(String) request.getAttribute("sysDate");
String reportType=(String)request.getAttribute("reportType");
ResultSet plantLevelRS=(ResultSet)request.getAttribute("plantLevelRS");
if("Excel".equals(targetScreen)) {
response.setHeader("Content-Disposition", "attachment; filename=\"" + reportName + ".xls\"");
}
int border=0;
if("Excel".equals(targetScreen)){
    border=1;
    }
else{
    border=0;
    }

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
    </head>
    <body style="font-size:smaller">
        <div style="overflow:auto;width:1400px;font-family:Arial;font-size:13px"id="PlantLevelLPFTableDiv">
             <table width="100%" border="0" cellpadding="2" cellspacing="1">
                 <tr>
                     <td align="left"><b>Plant Level LPF Report</b></td>
                 </tr>
                 <tr>
                     <td align="left"><b><%=reportType%></b></td>
                 </tr>
                 <tr>
                     <td align="left"><b> Date: </b><%=currentDate%></td>
                 </tr>
                 <tr>
                     <td align="left">&nbsp;</td>
                 </tr>
                 <tr>
                     <td align="left"><b>Report for the period</b><%=selectedFromDate%> to <%=selectedToDate%></td>

                 </tr>
                 <tr>
                   <td width="100%">
                  <table border="<%=border%>" width="100%" cellpadding="2" cellspacing="1" style="background-color:grey" id="PlantLevelLPFTableDiv" >
                 <tr style="background-color:#cccccc;" valign="top">
                <td>Date</td>
                <td>Plant Name</td>
                <td>Total Labour (MD)</td>
                <td>Labour On Lines (MD)</td>
                <td>Labour Misc (MD)</td>
                <td>Total Power (Kwh)</td>
                <td>Power On Lines (Kwh)</td>
                <td>Power Misc (Kwh)</td>
                <td>Total Fuel (HSD Ltr)</td>
                <td>Fuel On Lines (HSD Ltr)</td>
                <td>Fuel Misc (HSD Ltr)</td>
          
                </tr>

      

        <% while(plantLevelRS!=null && plantLevelRS.next()) {
        %>
            <tr>
                <td><%=UDate.dbToDisplay(plantLevelRS.getString("plu_date"))%></td>
                 <td><%=plantLevelRS.getString("ent_name")%></td>
                 <td><%=plantLevelRS.getFloat("pll_total_labour")%></td>
                 <td><%=plantLevelRS.getFloat("labour_on_line")%></td>
                 <td><%=plantLevelRS.getFloat("pll_misc_labour")%></td>
                 <td><%=plantLevelRS.getFloat("pll_total_power")%></td>
                 <td><%=plantLevelRS.getFloat("power_on_line")%></td>
                 <td><%=plantLevelRS.getFloat("pll_misc_power")%></td>
                 <td><%=plantLevelRS.getFloat("pll_total_fuel")%></td>
                 <td><%=plantLevelRS.getFloat("fuel_on_line")%></td>
                 <td><%=plantLevelRS.getFloat("pll_misc_fuel")%></td>
            </tr>
        <%
        }
        %>
     </table>
 </td>
 </tr>
 </table>
 </div>
 </body>
</html>
