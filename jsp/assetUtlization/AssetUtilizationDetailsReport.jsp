<%-- 
    Document   : AssetUtilizationDetailsReport
    Created on : Apr 9, 2013, 11:14:09 AM
    Author     : ubqtech035
--%>

<%@page contentType="text/html" pageEncoding="windows-1252" import="java.sql.*" import="java.util.*" import="ubq.assetUtlization.*"  import="java.text.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<%
            int timeParamCount=0,efficiencyParamCount=0,lostTimeParamCount=0;
            String reportName = (String) request.getAttribute("reportName");
            String reportType = (String) request.getAttribute("reportType");
            String currDate = (String) request.getAttribute("sysDate");
            String selectedFromDate = (String) request.getAttribute("selectedFromDate");
            String selectedToDate = (String) request.getAttribute("selectedToDate");
            String targetScreen = (String) request.getAttribute("targetScreen");
            int lostOfTime = (Integer)request.getAttribute("lostOfTime");
            ResultSet rsTimeParam  = (ResultSet)request.getAttribute("rsTimeParam");
            ResultSet rsEfficiencyParam  = (ResultSet)request.getAttribute("rsEfficiencyParam");
            ResultSet rslostTimeParam  = (ResultSet)request.getAttribute("rslostTimeParam");
            if (null != rsTimeParam) {
                             rsTimeParam.last();
                             timeParamCount = rsTimeParam.getRow();
                             rsTimeParam.beforeFirst();
                         }
            if (rsEfficiencyParam != null) {
                             rsEfficiencyParam.last();
                             efficiencyParamCount = rsEfficiencyParam.getRow();
                             rsEfficiencyParam.beforeFirst();
                         }
            if (1 == lostOfTime) {
                             if (rslostTimeParam != null) {
                                 rslostTimeParam.last();
                                 lostTimeParamCount = rslostTimeParam.getRow();
                                 rslostTimeParam.beforeFirst();
                             }
                         }

            List AssetUtilizationCalcList =(List) request.getAttribute("AssetUtilizationCalcList");
            DecimalFormat fmt = new DecimalFormat("####0.00");
            if ("Excel".equals(targetScreen)) {
                response.setHeader("Content-Disposition", "attachment; filename=\"" + reportName + ".xls\"");
            }
            int border = 0;



%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
    </head>

    <script language="javascript">
        function setWidth(){
            var noOfColumn = document.getElementById('assetUtilizationTable').rows[1].cells.length;
            document.getElementById("assetUtilizationTableDiv").style.width = (noOfColumn*120)+"px";
        }
    </script>
    <body onload="setWidth()" style="font-size: smaller;" >
    <div style="overflow: auto; font-family:Arial;font-size: 13px" id="assetUtilizationTableDiv">

        <table width="100%" border="0" cellpadding="2" cellspacing="1" >
         <tr>
            <td  align="left"><b>Line Utilization Report  </b></td>
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
                <% if ("Excel".equals(targetScreen)) {
                        border = 1;
                    }else{
                        border = 0;
                    }
                %>
                 <table width="100%" border="<%= border%>" cellpadding="2" cellspacing="1" style="background-color:gray" id="assetUtilizationTable">
                    <tr style="background-color:#cccccc;" valign="top">
                        <td colspan="3">&nbsp;</td>
                        <td colspan="<%=timeParamCount%>" align="center">Time Details</td>
                        <td colspan="<%=efficiencyParamCount%>" align="center">Efficiency Details</td>
                         <%if(0!=lostOfTime){%>
                        <td colspan="<%=lostTimeParamCount * 2%>" align="center">Time Loss Details</td>
                         <%}%>
                    </tr>
                    <tr style="background-color:#cccccc;" valign="top">

                        <td >Plant Name</td>
                        <td >Line</td>
                        <td >Date/Period</td>
                     <% if (rsTimeParam != null && rsTimeParam.next()) {
                                    rsTimeParam.beforeFirst();
                                    while (rsTimeParam.next()) {
                                        

                     %>
                        <td align="right"><%= rsTimeParam.getString("pep_name")%></td>
                    <%
                                    }
                     }
                    %>

                    <% if(rsEfficiencyParam != null && rsEfficiencyParam.next()) {
                                    rsEfficiencyParam.beforeFirst();
                                    while (rsEfficiencyParam.next()) {

                     %>
                        <td align="right"><%= rsEfficiencyParam.getString("pep_name")%></td>
                    <%
                                    }
                     }
                    %>
                    <%
                    if (0!=lostOfTime) {
                        if (rslostTimeParam != null && rslostTimeParam.next()) {
                            rslostTimeParam.beforeFirst();
                            while (rslostTimeParam.next()) {
                         %>
                            <td align="right"><%= rslostTimeParam.getString("ltp_name")%></td>
                            <td align="right"><%= "Reason for " + rslostTimeParam.getString("ltp_name")%></td>
                        <%
                            }
                        }
                    }
                    %>
                     </tr>
                     <%if (AssetUtilizationCalcList.size() > 0) {
                      for (int i = 0; AssetUtilizationCalcList != null && i < AssetUtilizationCalcList.size(); i++) {
                                       AssetUtilizationCalc AssetUtilizationObj = (AssetUtilizationCalc) AssetUtilizationCalcList.get(i); 
                      
                       %>
                     <tr style="background-color:white">
                            <td><%=AssetUtilizationObj.plantName%></td>
                            <td><%=AssetUtilizationObj.lineName%></td>
                            <td><%=AssetUtilizationObj.date%></td>
                            <td align="right"><%=fmt.format(AssetUtilizationObj.totalTime)%></td>
                            <td align="right"><%=fmt.format(AssetUtilizationObj.totalAvailTime)%></td>
                            <td align="right"><%=fmt.format(AssetUtilizationObj.usedTime)%></td>
                             <td align="right"><%=fmt.format(AssetUtilizationObj.operationalTime)%></td>
                             <td align="right"><%=fmt.format(AssetUtilizationObj.productionTime)%></td>
                             <td align="right"><%=fmt.format(AssetUtilizationObj.effectiveTime)%></td>
                             <td align="right"><%=fmt.format(AssetUtilizationObj.assetAvl)%></td>
                             <td align="right"><%=fmt.format(AssetUtilizationObj.assetUtlz)%></td>
                             <td align="right"><%=fmt.format(AssetUtilizationObj.operationUtlz)%></td>
                             <td align="right"><%=fmt.format(AssetUtilizationObj.productionUtlz)%></td>
                             <td align="right"><%=fmt.format(AssetUtilizationObj.OEE)%></td>
                             <td align="right"><%=fmt.format(AssetUtilizationObj.operationEff)%></td>
                             <td align="right"><%=fmt.format(AssetUtilizationObj.productionEff)%></td>
                             <td align="right"><%=fmt.format(AssetUtilizationObj.lineEff)%></td>
                             <%
                                if(0!=lostOfTime){%>
                             <td align="right"><%=fmt.format(AssetUtilizationObj.noPlan)%></td>
                             <td align="right"><%=AssetUtilizationObj.noPlan_Reason%></td>
                             <td align="right"><%=fmt.format(AssetUtilizationObj.nonAvlRM)%></td>
                             <td align="right"><%=AssetUtilizationObj.nonAvlRM_Reason%></td>
                             <td align="right"><%=fmt.format(AssetUtilizationObj.nonAvlPM)%></td>
                             <td align="right"><%=AssetUtilizationObj.nonAvlPM_Reason%></td>
                             <td align="right"><%=fmt.format(AssetUtilizationObj.noStorage)%></td>
                             <td align="right"><%=AssetUtilizationObj.noStorage_Reason%></td>
                             <td align="right"><%=fmt.format(AssetUtilizationObj.manShortage)%></td>
                             <td align="right"><%=AssetUtilizationObj.manShortage_Reason%></td>
                             <td align="right"><%=fmt.format(AssetUtilizationObj.changeClean)%></td>
                             <td align="right"><%=AssetUtilizationObj.changeClean_Reason%></td>
                             <td align="right"><%=fmt.format(AssetUtilizationObj.powerFail)%></td>
                             <td align="right"><%=AssetUtilizationObj.powerFail_Reason%></td>
                             <td align="right"><%=fmt.format(AssetUtilizationObj.utilProb)%></td>
                             <td align="right"><%=AssetUtilizationObj.utilProb_Reason%></td>
                             <td align="right"><%=fmt.format(AssetUtilizationObj.breakDown)%></td>
                             <td align="right"><%=AssetUtilizationObj.breakDown_Reason%></td>
                             <td align="right"><%=fmt.format(AssetUtilizationObj.processBreakDown)%></td>
                             <td align="right"><%=AssetUtilizationObj.processBreakDown_Reason%></td>
                             <td align="right"><%=fmt.format(AssetUtilizationObj.elecBreakDown)%></td>
                             <td align="right"><%=AssetUtilizationObj.elecBreakDown_Reason%></td>
                             <td align="right"><%=fmt.format(AssetUtilizationObj.ovenBreakDown)%></td>
                             <td align="right"><%=AssetUtilizationObj.ovenBreakDown_Reason%></td>
                             <td align="right"><%=fmt.format(AssetUtilizationObj.machineBreakDown)%></td>
                             <td align="right"><%=AssetUtilizationObj.machineBreakDown_Reason%></td>
                             <td align="right"><%=fmt.format(AssetUtilizationObj.trialsQaOtherLoss)%></td>
                             <td align="right"><%=AssetUtilizationObj.trialsQaOtherLoss_Reason%></td>
                             <td align="right"><%=fmt.format(AssetUtilizationObj.totalStop)%></td>
                             <td align="right"><%=AssetUtilizationObj.totalStop_Reason%></td>
                            <%}%>
                     </tr>
                     <%}}else {
                       int colspan = 3+timeParamCount+efficiencyParamCount;
                       if(0!=lostOfTime){
                       colspan =colspan+lostTimeParamCount;
                       }
                       %>
                     <tr>
                         <td colspan="<%=colspan%>"style="background-color:white">
                            <span class="userInfo">No record found </span>
                         </td>
                     </tr>
                     <%}%>
                </table>
            </td>
        </tr>
    </table>

</div>
    </body>
</html>