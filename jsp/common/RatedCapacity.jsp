<%-- 
    Document   : RatedCapacity
    Created on : Apr 11, 2013, 3:53:01 PM
    Author     : ubqtech037
--%>

<%@page contentType="text/html" pageEncoding="windows-1252" import="java.util.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%
            String projPath = request.getContextPath();
            int entRid = request.getAttribute("entRid") != null && !"".equals(request.getAttribute("entRid").toString())
                    ? Integer.parseInt(request.getAttribute("entRid").toString()) : 0;
            int lineNos = request.getAttribute("lineNos") != null
                    && !"".equals(request.getAttribute("lineNos").toString())
                    ? Integer.parseInt(request.getAttribute("lineNos").toString()) : 0;
            int variantElemsLen = request.getAttribute("variantElemsLen") != null
                    && !"".equals(request.getAttribute("variantElemsLen").toString())
                    ? Integer.parseInt(request.getAttribute("variantElemsLen").toString()) : 0;
            String variantIndexes = request.getAttribute("variantIndexes") != null
                    ? request.getAttribute("variantIndexes").toString() : "";
            Map variantIndexValueMap = request.getAttribute("variantIndexValueMap") != null
                    ? (HashMap) request.getAttribute("variantIndexValueMap") : null;
            Map savedRatedCapacityMap = request.getAttribute("savedRatedCapacityMap") != null
                    ? (HashMap) request.getAttribute("savedRatedCapacityMap") : null;
            String variantsSplit[] = null;
            if (!"".equals(variantIndexes)) {
                variantsSplit = variantIndexes.split(",");
            }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="<%= projPath%>/style/UbqApp.css" rel="stylesheet" type="text/css">
        <script language="Javascript" type="text/Javascript" src="<%= projPath%>/js/base/RestrictInputFunction.js"></script>
        <script language="Javascript" type="text/Javascript" src="<%= projPath%>/js/base/UValidations.js"></script>
        <script language="Javascript" type="text/Javascript" src="<%= projPath%>/js/base/DynamicTableTemplate.js"></script>
        <script language="Javascript" type="text/Javascript" src="<%= projPath%>/js/assetUtlization/AWProfile.js"></script>      
    </head>
    <body class="bodyBackground" onload="awProfile.ratedCapacityInit(); awProfile.initializePage()">
        <div style="width:550px">
            <%-- <fieldset> --%>
                <table width="100%" cellpadding="0" cellspacing="1" border="0" id="ratedCapTab">
                    <tr class="specialRow">
                        <td width="5%" align="center">
                            Line No
                        </td>
                        <td width="12%" align="center">
                            Variant
                        </td>
                        <td width="5%" align="center">
                            Capacity
                             (ton)
                        </td>
                         <td width="5%" align="center">
                              Power
                            (Kwh/Ton)
                        </td>
                         <td width="5%" align="center">
                            Fuel HSD
                            (Ltr/Ton)
                        </td>
                         <td width="5%" align="center">
                               Labour
                            (Mandays/Ton)
                        </td>
                    </tr>
                    <%
                                String variantIndex = null;
                                String variantValue = "";
                                String capacityValue = "";
                                double capacity = 0, power = 0, labour = 0, fuel = 0;
                                int lineRid = 0;
                                
                                for (int loop = 1; loop <= lineNos; loop++) {
                                    for (int i = 0; i <= variantElemsLen - 1; i++) {
                                        capacity = 0;
                                        power = 0;
                                        labour = 0;
                                        fuel = 0;
                                        lineRid = 0;
                                        variantIndex = variantsSplit[i];
                                        variantValue = variantIndexValueMap != null && variantIndexValueMap.containsKey(variantIndex)
                                                ? variantIndexValueMap.get(variantIndex).toString() : "";
                                        capacityValue = savedRatedCapacityMap != null && savedRatedCapacityMap.containsKey(loop + "~" + variantIndex)
                                                ? savedRatedCapacityMap.get(loop + "~" + variantIndex).toString() : "";
                                
                                        if (!"".equals(capacityValue)) {
                                            capacity = Double.parseDouble(capacityValue.split("~")[0]);
                                            lineRid = Integer.parseInt(capacityValue.split("~")[1]);
                                            power = Double.parseDouble(capacityValue.split("~")[2]);
                                            fuel = Double.parseDouble(capacityValue.split("~")[3]);
                                            labour = Double.parseDouble(capacityValue.split("~")[4]);
                                        }


                    %>
                    <tr>
                        <td>
                            Line <%= loop%>
                        </td>
                        <td>
                            <input type="hidden" name="variantIndexHidden" id="variantIndexHidden" value="<%= variantIndex%>">
                            <input type="hidden" name="lineNoHidden" id="lineNoHidden" value="<%= loop%>">
                            <input type="hidden" name="lineRidHidden" id="lineRidHidden" value="<%= lineRid%>">
                            <%= variantValue%>
                        </td>
                        <td>
                            <input type="text" style="text-align: right; width: 80px; " name="capacity" id="capacity" value="<%= capacity%>" onkeypress="restrictInput(this,keybNumber,event)">                                                  
                        </td>                                                                 
                        <td>
                            <input type="text" style="text-align: right; width: 80px;" name="power" id="power" value="<%= power%>" onkeypress="restrictInput(this,keybNumber,event)">
                        </td>
                        <td>
                            <input type="text" style="text-align: right; width: 80px;" name="fuel" id="fuel" value="<%= fuel%>" onkeypress="restrictInput(this,keybNumber,event)">
                        </td>
                        <td>
                            <input type="text" style="text-align: right; width: 80px;" name="labour" id="labour" value="<%= labour%>" onkeypress="restrictInput(this,keybNumber,event)">
                        </td>
                    </tr>                     
                    <%
                                    }
                                }
                    %>
                    <tr>
                        <td colspan="6" align="right">
                            <input type="button" name="okBtn" id="okBtn" value=" OK " onclick="awProfile.okClick()">
                        </td>
                    </tr>
                </table>
                    <%-- </fieldset> --%>
        </div>
    </body>
</html>