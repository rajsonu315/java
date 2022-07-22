<%-- 
    Document   : AssetReconciliationDetailsReport
    Created on : Apr 11, 2013, 12:56:50 PM
    Author     : ubqtech035
--%>


<%@page contentType="text/html" pageEncoding="windows-1252" import="java.sql.*" import="java.util.*" import="ubq.assetUtlization.*"  import="java.text.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<%
            String reportName = (String) request.getAttribute("reportName");
            String reportType = (String) request.getAttribute("reportType");
            String currDate = (String) request.getAttribute("sysDate");
            String selectedFromDate = (String) request.getAttribute("selectedFromDate");
            String selectedToDate = (String) request.getAttribute("selectedToDate");
            String targetScreen = (String) request.getAttribute("targetScreen");
            ResultSet rs = (ResultSet) request.getAttribute("rsReconciliation");
            ResultSet allowedFuelRS = (ResultSet) request.getAttribute("allowedFuelRS");
            HashMap usedFuelDetailsMap = request.getAttribute("usedFuelDetailsMap") != null
                        ? (HashMap) request.getAttribute("usedFuelDetailsMap") : new HashMap();
            int reportLevel = (Integer) request.getAttribute("reportLevel");
            DecimalFormat fmt = new DecimalFormat("####0.00");
            if ("Excel".equals(targetScreen)) {
                response.setHeader("Content-Disposition", "attachment; filename=\"" + reportName + ".xls\"");
            }

            int border = 0;
            if ("Excel".equals(targetScreen)) {
                border = 1;
            }else{
                border = 0;
            }


%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
    </head>

    <body  style="font-size: smaller;" >
        <div style="overflow: auto; width: 1400px ;font-family:Arial;font-size: 13px" id="assetReconciliationTableDiv">

            <table width="100%" border="0" cellpadding="2" cellspacing="1" >
                <tr>
                    <td  align="left"><b> Line Reconciliation Report </b></td>
                </tr>
                <tr>
                    <td  align="left"><b> <%=reportType%> </b></td>
                </tr>
                            <tr>
            <td  align="left"> <b>Date :</b> <%=currDate%></td>
        </tr>
                <tr>
                    <td  align="left">&nbsp;</td>
                </tr>
                <tr>
                    <td><b>Report for the Period  </b><%=selectedFromDate%> to <%=selectedToDate%></td>
                </tr>
                <tr>
                    <td width="100%" >
                      
                        <table width="100%" border="<%= border%>" cellpadding="2" cellspacing="1" style="background-color:gray" id="assetUtilizationTable">
                                <tr style="background-color:#cccccc;" valign="top">

                                    <td width="10%">Date/Period</td>
                                    <td width="10%">Plant Name</td>
                                    <td width="6%">Line</td>
                                    <td width="16">Variety</td>
                                    <td width="6%" align="right">Total Available Time</td>
                                    <td width="8%" align="right">Downtime (Hrs.)</td>
                                    <td width="6%" align="right">Effective (Hrs.)</td>
                                    <td width="9%" align="right">Theoretical Prod.</td>
                                    <td width="7%" align="right">Actual Prod.</td>
                                    <td width="8%" align="right">Calculated Prod.</td>
                                    <td width="9%" align="right">Difference in Prod.</td>
                                    <td width="8%" align="right">Difference(Hrs.)</td>
                                    <td width="8%" align="right">Power (KWH)</td>
                                    <td width="8%" align="right">Labour (Mandays)</td>
                                    <td width="8%" align="right">Fuel (HSD Ltr)</td>
                                    <%
                                    String uom = "", fuelName = "",fuelHeader = "",key= "";

                                    while (allowedFuelRS != null && allowedFuelRS.next()) {

                                        fuelName = allowedFuelRS.getString("fuel_name");
                                        uom = allowedFuelRS.getString("uom");
                                        fuelHeader = fuelName +" ("+uom+")";
                                    %>
                                    <td width="10%" align="right"><%= fuelHeader%></td>
                                    <%
                                    }
                                    %>

                                </tr>
                                <%   if (rs != null) {
                                                rs.beforeFirst();
                                            }

                                            if (rs != null && rs.next() == false) {
                                %>
                                <tr  style="background-color: white">
                                    <td colspan="12"><span class="userInfo">No record found </span></td>
                                </tr>

                                <%}%>
                                <%

                                            float total_time = 0;
                                            float avail_time = 0;
                                            float down_time = 0;
                                            float theoritical_prod = 0;
                                            float actul_prod = 0;
                                            float effective_time = 0;
                                            float calculated_prod = 0;
                                            float differenece_prod = 0;
                                            float differenece_hr = 0;
                                            int headerRid = 0;
                                            int lineRid = 0;
                                            int fuelRid = 0;
                                            float usedQty = 0;


                                            if (rs != null && rs.first()) {
                                                rs.beforeFirst();
                                                int i = 0;
                                                while (rs.next()) {
                                                    total_time = rs.getFloat("total_time");
                                                    avail_time = rs.getFloat("avilable_time");
                                                    down_time = rs.getFloat("down_time");
                                                    theoritical_prod = rs.getFloat("theoritical_prod");
                                                    actul_prod = rs.getFloat("actul_prod");
                                                    effective_time = avail_time - down_time;
                                                    calculated_prod = (theoritical_prod / total_time) * (effective_time);
                                                    differenece_prod = calculated_prod - actul_prod;
                                                    if(theoritical_prod != 0){
                                                        differenece_hr = (differenece_prod) / (theoritical_prod / total_time);
                                                    }else{
                                                        differenece_hr = 0;
                                                    }
                                                    headerRid = Integer.parseInt(rs.getString("headerRid"));
                                                    lineRid = Integer.parseInt(rs.getString("lineRid"));
                                %>
                                <tr  valign="top"  style="background-color: white">
                                    <td width="10%">&nbsp;<%=rs.getString("pluDate")%></td>
                                    <td width="10%"><%=rs.getString("plant_name")%></td>
                                    <td width="6%"><%=rs.getString("line_name")%></td>
                                    <td width="16%"><%=rs.getString("variant_names")%></td>
                                    <td width="6%" align="right"><%=fmt.format(avail_time)%></td>
                                    <td width="8%" align="right"><%=fmt.format(down_time)%></td>
                                    <td width="6%" align="right"><%=fmt.format(effective_time)%></td>
                                    <td width="9%" align="right"><%=fmt.format(theoritical_prod)%></td>
                                    <td width="7%" align="right"><%=fmt.format(actul_prod)%></td>
                                    <td width="8%" align="right"><%=fmt.format(calculated_prod)%></td>
                                    <td width="9%" align="right"><%=fmt.format(differenece_prod)%></td>
                                    <td width="8%" align="right"><%=fmt.format(differenece_hr)%></td>
                                    <td width="8%" align="right"><%=fmt.format(rs.getFloat("lineTotalPower"))%></td>
                                    <td width="8%" align="right"><%=fmt.format(rs.getFloat("lineTotalLabour"))%></td>
                                    <td width="8%" align="right"><%=fmt.format(rs.getFloat("lineTotalFuel"))%></td>

                                    <%
                                    allowedFuelRS.beforeFirst();
                                    while (allowedFuelRS != null && allowedFuelRS.next()) {
                                        fuelRid = Integer.parseInt(allowedFuelRS.getString("fuel_rid"));
                                        key = headerRid + "~" + lineRid + "~" + fuelRid;
                                        usedQty = usedFuelDetailsMap.get(key) != null ? Float.valueOf(usedFuelDetailsMap.get(key).toString()) : 0;
                                    %>
                                    <td width="10%" align="right"><%= fmt.format(usedQty)%></td>
                                    <%
                                    }
                                    %>

                                </tr>
                                <%
                                                    i++;
                                                }
                                            }
                                %>

                            </table>
                    </td>
                </tr>
            </table>

        </div>
    </body>
</html>