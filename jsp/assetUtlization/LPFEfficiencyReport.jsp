<%-- 
    Document   : LPFEfficiencyReport
    Created on : Jan 23, 2014, 11:40:00 AM
    Author     : Sudip
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="windows-1252"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<%
            String reportName = (String) request.getAttribute("reportName");
            String reportType = (String) request.getAttribute("reportType");
            String currDate = (String) request.getAttribute("sysDate");
            String selectedFromDate = (String) request.getAttribute("selectedFromDate");
            String selectedToDate = (String) request.getAttribute("selectedToDate");
            String targetScreen = (String) request.getAttribute("targetScreen");
            ResultSet LPFEfficiencyRS = (ResultSet) request.getAttribute("LPFEfficiencyRS");
            ResultSet allowedFuelRS = (ResultSet) request.getAttribute("allowedFuelRS");
            HashMap usedFuelDetailsMap = request.getAttribute("usedFuelDetailsMap") != null
                        ? (HashMap) request.getAttribute("usedFuelDetailsMap") : new HashMap();
            
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
    <body style="font-size: smaller;">
        <div style="overflow: auto; width: 1400px ;font-family:Arial;font-size: 13px" id="LPFEfficiencyTableDiv">
            <table width="100%" border="0" cellpadding="2" cellspacing="1" >
                <tr>
                    <td  align="left"><b> LPF Efficiency Report </b></td>
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
                    <td width="100%">
                        <table width="100%" border="<%= border%>" cellpadding="2" cellspacing="1" style="background-color:gray" id="LPFEfficiencyTable">
                            <tr style="background-color:#cccccc;" valign="top">
                                <td width="10%">Date</td>
                                <td width="18%">Plant Name</td>
                                <td width="15%">Line</td>
                                <td width="25%">Variety</td>
                                <td width="10%" align="right">Actual Prod. (Ton)</td>
                       <%--         <td width="10%" align="right">Difference in Prod.</td>
                                <td width="10%" align="right">Difference (Hrs)</td> --%>
                                <td width="10%" align="right">Labour (Mandays)</td>
                                <td width="10%" align="right">Power (Kwh)</td>
                                <td width="10%" align="right">Fuel (HSD Ltr)</td>
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
                                <td width="12%" align="right">Labour Actual (MD/Ton)</td>
                                <td width="12%" align="right">Power Actual (Kwh/Ton)</td>
                                <td width="12%" align="right">Fuel Actual (HSD Ltr/Ton)</td>
                                <td width="10%" align="right">Labour Std. (MD/Ton)</td>
                                <td width="10%" align="right">Power Std. (Kwh/Ton)</td>
                                <td width="10%" align="right">Fuel Std. (HSD Ltr/Ton)</td>
                                <td width="10%" align="right">Labour Efficiency (%)</td>
                                <td width="10%" align="right">Power Efficiency (%)</td>
                                <td width="10%" align="right">Fuel Efficiency (%)</td>

                            </tr>

                            <%
                            int pluRid = 0,lineRid = 0,varientindex = 0,fuelRid = 0;
                            float actProd = 0, theoriticalProd = 0, usedQty = 0,stdFuel = 0, stdPower = 0, stdlabour = 0,usedPower =0, usedFuel = 0, usedLabour = 0,
                                    powerEffi = 0,labourEffi = 0,fuelEffi = 0;

                            if (LPFEfficiencyRS != null && LPFEfficiencyRS.next()){
                                LPFEfficiencyRS.beforeFirst();
                                while (LPFEfficiencyRS.next()) {
                                  pluRid = Integer.parseInt(LPFEfficiencyRS.getString("plu_rid"));
                                  lineRid = Integer.parseInt(LPFEfficiencyRS.getString("llf_line_rid"));
                                  varientindex = Integer.parseInt(LPFEfficiencyRS.getString("lvd_variant_index"));

                                  usedPower = LPFEfficiencyRS.getFloat("lvd_power_per_prod_unit");
                                  usedLabour = LPFEfficiencyRS.getFloat("lvd_labour_per_prod_unit");
                                  usedFuel = LPFEfficiencyRS.getFloat("lvd_fuel_per_prod_unit");

                                  stdPower = LPFEfficiencyRS.getFloat("std_power");
                                  stdlabour = LPFEfficiencyRS.getFloat("std_labour");
                                  stdFuel = LPFEfficiencyRS.getFloat("std_fuel");

                                  if (usedPower > 0) {
                                      powerEffi = (stdPower * 100)/usedPower;
                                  } else {
                                      powerEffi = 0;
                                  }
                                  if (usedLabour > 0) {
                                      labourEffi = (stdlabour * 100)/usedLabour;
                                  } else {
                                      labourEffi = 0;
                                  }
                                  if (usedFuel > 0) {
                                      fuelEffi = (stdFuel * 100)/usedFuel;
                                  } else {
                                      fuelEffi = 0;
                                  }
                            %>
                            <tr  valign="top"  style="background-color: white">
                                <td width="10%"><%= LPFEfficiencyRS.getString("pluDate")%></td>
                                <td width="18%"><%= LPFEfficiencyRS.getString("plantName")%></td>
                                <td width="15%"><%= LPFEfficiencyRS.getString("lineName")%></td>
                                <td width="25%"><%= LPFEfficiencyRS.getString("variantName")%></td>
                                <td width="10%" align="right"><%= fmt.format(LPFEfficiencyRS.getFloat("lvd_production"))%></td>
                          <%--      <td width="10%" align="right"></td>
                                <td width="10%" align="right"></td>  --%>
                                <td width="10%" align="right"><%= fmt.format(LPFEfficiencyRS.getFloat("lvd_labour"))%></td>
                                <td width="10%" align="right"><%= fmt.format(LPFEfficiencyRS.getFloat("lvd_power"))%></td>
                                <td width="10%" align="right"><%= fmt.format(LPFEfficiencyRS.getFloat("lvd_fuel"))%></td>

                                <%
                                allowedFuelRS.beforeFirst();
                                    while (allowedFuelRS != null && allowedFuelRS.next()) {
                                        fuelRid = Integer.parseInt(allowedFuelRS.getString("fuel_rid"));
                                        key = pluRid + "~" + lineRid + "~" + varientindex + "~" + fuelRid;
                                        usedQty = usedFuelDetailsMap.get(key) != null ? Float.valueOf(usedFuelDetailsMap.get(key).toString()) : 0;
                                %>
                                <td width="10%" align="right"><%= fmt.format(usedQty)%></td>
                                <%
                                }
                                %>

                                <td width="12%" align="right"><%= fmt.format(usedLabour)%></td>
                                <td width="12%" align="right"><%= fmt.format(usedPower)%></td>
                                <td width="12%" align="right"><%= fmt.format(usedFuel)%></td>
                                <td width="10%" align="right"><%= fmt.format(stdlabour)%></td>
                                <td width="10%" align="right"><%= fmt.format(stdPower)%></td>
                                <td width="10%" align="right"><%= fmt.format(stdFuel)%></td>
                                <td width="10%" align="right"><%= fmt.format(labourEffi)%></td>
                                <td width="10%" align="right"><%= fmt.format(powerEffi)%></td>
                                <td width="10%" align="right"><%= fmt.format(fuelEffi)%></td>
                            </tr>
                            <%
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
