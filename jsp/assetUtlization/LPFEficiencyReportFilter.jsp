<%-- 
    Document   : LPFEficiencyReportFilter
    Created on : Jan 22, 2014, 6:44:27 PM
    Author     : Sudip
--%>

<%@ page  language="java" import="java.sql.*, ubq.util.*, java.util.*" import="ubq.base.*" errorPage="" %>
<%
            String project = request.getContextPath();
            String currentdate = (String) request.getAttribute("sysDate");
            //String monthStartDate = (String) request.getAttribute("monthStartDate");
            //String weekStartDate = (String) request.getAttribute("weekStartDate");
            String reportName = (String) request.getAttribute("reportName");
            int noOfYearToDisplay = ((Integer) request.getAttribute("noOfYearToDisplay")).intValue();
         

            Calendar cal = Calendar.getInstance();
            int currentDay = cal.get(Calendar.DAY_OF_MONTH);
            int currentYear = cal.get(Calendar.YEAR);

            int month = cal.get(Calendar.MONTH) + 1;

            String[] months = {"", "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"};

            String[] weeks = {"", "Week1", "Week2", "Week3", "Week4"};
            int selWeek = 0;
            if (currentDay >= 1 && currentDay < 8) {
                selWeek = 1;
            } else if (currentDay >= 8 && currentDay < 15) {
                selWeek = 2;
            } else if (currentDay >= 15 && currentDay < 22) {
                selWeek = 3;
            } else {
                selWeek = 4;
            }
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<div id="workingDiv">
    <input type="hidden" name="jsFile" value="<%= project%>/js/assetUtlization/LPFEficiencyReport.js">
    <form name="lpfEficiencyReportForm" id="lpfEficiencyReportForm" method="post"action="AssetUtilizationServlet" target="entryResponseFrame">
        <input type ="hidden" id="currentDate" name="currentDate" value="<%=currentdate%>">
        <%--        <input type ="hidden" id="monthStartDate" name="monthStartDate" value="<%=monthStartDate%>">
                <input type ="hidden" id="weekStartDate" name="weekStartDate" value="<%=weekStartDate%>">--%>
        <input type ="hidden" id="selectedFromDate" name="selectedFromDate" value="<%=currentdate%>">
        <input type ="hidden" id="selectedToDate" name="selectedToDate" value="<%=currentdate%>">
        <input type ="hidden" id="reportName" name="reportName" value="<%=reportName%>">
        <input type ="hidden" id="targetScreen" name="targetScreen" value="screen">
        <input type ="hidden" id="reportType" name="reportType" value="Daily Report">
        <input type ="hidden" id="reportLevel" name="reportLevel" value="0">
        <input type ="hidden" id="cumulativeDetailDate" name="cumulativeDetailDate" value="">
        <input type="hidden" name="command" id="command" value="showLPFEfficiencyReport">
        <table width="100%" cellpadding="2" cellspacing="0" border="0">

            <tr>
                <td width="100%">
                    <fieldset>
                        <table width="100%" cellpadding="2" cellspacing="1">
                            <tr>
                                <td  width="100%">
                                    <font color="blue" style="">
                                        Select filter criteria
                                    </font>
                                </td>
                            </tr>

                            <tr>
                                <td>
                                    <%@ include file="../common/EntityFilter.jsp"%>
                                </td>
                           </tr>
                            <tr>
                                <td colspan="4">
                                    <table width="100%" cellpadding="2" cellspacing="2" border="0">
                                        <tr style="height: 28px">
                                            <td valign="top" width="15%">
                                                <input type="radio" id="dateRange" name="dateType" value="0" onclick="lpfEficiencyReport.setFilter(0);" checked>
                                                &nbsp; <label for ="dateRange">For date range</label>
                                            </td>
                                            <td valign="top">
                                                <div name = "dateRangeDiv" id = "dateRangeDiv">
                                                    <table width="100%" border="0" cellpadding="0" cellspacing="1">
                                                        <tr valign="top">
                                                            <td>
                                                                From Date &nbsp;&nbsp;
                                                                <input type="text" name="from_Date" id="from_Date" size="10" value="<%=currentdate%>">
                                                                <input type="button" name="from_date_button" id="from_date_button" value="..." onclick="newPopupCalender('from_Date','from_date_button');">
                                                                &nbsp;&nbsp; To Date &nbsp;&nbsp;
                                                                <input type="text" name="to_Date" id="to_Date" size="10" value="<%=currentdate%>">
                                                                <input type="button" name="to_date_button" id="to_date_button" value="..." onclick="newPopupCalender('to_Date','to_date_button');">
                                                            </td>
                                                        </tr>

                                                    </table>

                                                </div>
                                            </td>
                                        </tr>
                                        <tr style="height: 28px">
                                            <td width="15%">
                                                <input type="radio" id="cumulative" name="dateType" value="1" onclick="lpfEficiencyReport.setFilter(1)" >
                                                &nbsp; <label for ="cumulative">Month / Week</label>&nbsp;&nbsp;

                                            </td >
                                            <td width="100%"  valign="top">
                                                <div name = "cumulativeDiv" id ="cumulativeDiv" style="display:none ;visibility: hidden">
                                                    <table width="100%" border="0" cellpadding="0" cellspacing="1">
                                                        <tr>
                                                            <td>
                                                                &nbsp;&nbsp; Year <select id="selectYear" name="selectYear" onchange="lpfEficiencyReport.formDate('selectedFromDate','selectedToDate')" style="width: 80px">
                                                                    <%
                                                                                for (int j = 0; j < noOfYearToDisplay; j++) {
                                                                    %>

                                                                    <option value=<%= currentYear - j%>> <%= currentYear - j%>

                                                                        <%}%>
                                                                </select>
                                                                &nbsp;&nbsp; Month <select id="selectMonth" name="selectMonth"  style="width: 80px" onchange="lpfEficiencyReport.formDate('selectedFromDate','selectedToDate')">

                                                                    <%
                                                                                for (int i = 0; i < months.length; i++) {
                                                                    %>
                                                                    <option value="<%= i%>"  <%= i == month ? "selected" : ""%>> <%= months[i]%>
                                                                        <%
                                                                                    }
                                                                        %>
                                                                </select>
                                                                &nbsp;&nbsp; Week <select id="selectWeek" name="selectWeek"  style="width: 80px" onchange="lpfEficiencyReport.formDate('selectedFromDate','selectedToDate')">

                                                                    <%
                                                                                for (int i = 0; i < weeks.length; i++) {
                                                                    %>
                                                                    <option value="<%= i%>"  <%= i == selWeek ? "selected" : ""%>> <%= weeks[i]%>
                                                                        <%
                                                                                    }
                                                                        %>
                                                                </select>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>


                                    </table>
                                </td>
                            </tr>


                          <%--  <tr>
                                <td colspan="4">
                                    <table width="100%" cellpadding="2" cellspacing="2" border="0">
                                        <tr >
                                                <%if (null != isShowlostOfTime && "YES".equals(isShowlostOfTime)) {%>
                                            <td width="20%">
                                                <input type="checkbox" id="lostOfTime" name="lostOfTime" checked value="1"><label for ="lostOfTime">Show time loss details</label>
                                            </td>
                                             <%}%>
                                            <td >
                                                <div name = "reportLvlDiv" id ="reportLvlDiv" style="display:none ;visibility: hidden">
                                                    <input type="radio" id="detailRepor" name="reportLevelType" checked value="0"><label for ="detailRepor">Day wise break up </label>
                                                    &nbsp;&nbsp;
                                                    <input type="radio" id="summaryReport" name="reportLevelType"  value="1"><label for ="summaryReport">Summary over selected period </label>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr> --%>

                        </table>
                    </fieldset>
                </td>
            </tr>
        </table>
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td  align="right">
                    <input type="button" name="viewButton" id="viewButton" value=" Plant Level LPF" class="buttonSize" onclick="lpfEficiencyReport.openLPFEficiencyReport(2)">&nbsp;
                    <input type="button" name="viewButton" id="viewButton" value=" View " class="buttonSize" onclick="lpfEficiencyReport.openLPFEficiencyReport(0)">&nbsp;
                    <input type="button" name="viewButton" id="viewButton" value=" Excel Export" class="buttonSize" onclick="lpfEficiencyReport.openLPFEficiencyReport(1)">&nbsp;
                    <input type="button" name="clearButton" id="clearButton" value=" Clear " onClick="lpfEficiencyReport.clearForm()" class="buttonSize">
                </td>
            </tr>
        </table>

        <iframe id=entryResponseFrame name=entryResponseFrame src="" style="visibility: hidden; display: none"></iframe>
    </form>
</div>


