<%-- 
    Document   : FuelConsumptionDetails
    Created on : Jan 17, 2014, 6:51:55 PM
    Author     : Sudip
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="windows-1252"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">


<div>
  <fieldset>
   <table id="fuelDetailsTable" width="100%" cellpadding="0" cellspacing="0" border="0">
        <tr class="header" valign="top" style="height: 20px">
            <td width ="40%" align="left">Fuel</td>
            <td width="20%" align="right"> Qty</td>
            <td width="20%"align="center">UOM</td>
            <td width="20%" align="right">HSD Eqv (Ltr)</td>
            <td></td>
        </tr>
        <%
       // ResultSet fuelDetailsRS = (ResultSet) request.getAttribute("fuelDetailsRS");
        int fuelRid = 0;
        String fuelDesc = "";
        int fuelUom = 0;
        float HSDMult = 0;
        float usedQty = 0;
        float HsdUsedQty = 0;
        String uomName = "";


        String fuelDetailsString = (String) request.getAttribute("fuelDetailsString") == null ? request.getParameter("fuelDetailsString") : (String) request.getAttribute("fuelDetailsString");
        String fuelDetailsArray[] = fuelDetailsString.split(",");
        for (int i= 0;i<fuelDetailsArray.length ; i++) {
           if (!"".equals(fuelDetailsArray[i])) {
           String fuelarray[] = fuelDetailsArray[i].split("@");
    //    if (fuelDetailsRS != null) {
    //        while (fuelDetailsRS.next()) {
    //         fuelRid = fuelDetailsRS.getInt("fuel_rid");
    //         fuelName =fuelDetailsRS.getString("fuel_name");
    //         fuelUom = fuelDetailsRS.getInt("fuel_uom_index");
    //         HSDMult = fuelDetailsRS.getDouble("fuel_hsd_eqv");
    //         usedQty = fuelDetailsRS.getDouble("dfu_fuel_qty");
    //         HsdUsedQty = fuelDetailsRS.getDouble("dfu_eqv_hsd_qty");
            fuelRid = Integer.parseInt(fuelarray[0]);
            fuelDesc = String.valueOf(fuelarray[1]);
            fuelUom = Integer.parseInt(fuelarray[2]);
            usedQty = Float.parseFloat(fuelarray[3]);
            HSDMult = Float.parseFloat(fuelarray[4]);
            HsdUsedQty = Float.parseFloat(fuelarray[5]);
            uomName = String.valueOf(fuelarray[6]);
        %>
        <tr style="height: 20px;background-color: #D3DEB3" class="<%= fuelRid == 0 ? "hidden" : ""%>">
        <input type="hidden" name="fuelRID" id="fuelRID" value="<%= fuelRid%>">
        <input type="hidden" name="fuelUomIndex" id="fuelUomIndex" value="<%= fuelUom%>">
        <input type="hidden" name="HSDMultiplier" id="HSDMultiplier" value="<%= HSDMult%>">

            <td width="40%" align="left">
                <input type="hidden" name="fuelName" id="fuelName" value="<%= fuelDesc%>"><span><%= fuelDesc%></span>
            </td>
            <td width="20%" align="right">
                <input type="text" name="fuelusedQty" id="fuelusedQty" style="text-align: right" size="10" maxlength="6" value="<%= usedQty%>" onkeypress="restrictInput(this,keybDecimal,event)" onchange="assetUtilization.calculateFuelHsdQty(this)">
            </td>
            <td width="20%" align="center">
                <input type="hidden" name="fueluom" id="fueluom" value="<%= uomName%>" ><span><%= uomName%></span>
            </td>
            <td width="20%" align="right">
                <input type="text" name="fuelHSDQty" id="fuelHSDQty" readonly style="text-align: right;background-color: lightgray;" size="10" maxlength="6" value="<%= HsdUsedQty%>" onkeypress="restrictInput(this,keybDecimal,event)">
            </td>
            <td></td>
        </tr>
        <%
        }
        }
           // } }
        %>
    </table>
 </fieldset>

    <table width="100%" cellpadding="0" cellspacing="0" border="0">
        <tr>
            <td colspan="3" align="right">
                <input type="button" id="confirm" name="confirm" value="OK" onclick="assetUtilization.saveFuelDetails();">
                <input type="button" id="cancel" name="cancel" value="Cancel" onclick="assetUtilization.closeFuelDetails()">
            </td>
        </tr>
    </table>
</div>