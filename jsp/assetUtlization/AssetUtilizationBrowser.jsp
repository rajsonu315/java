<%-- 
    Document   : AssetUtilizationBrowser
    Created on : Apr 11, 2013, 4:04:37 PM
    Author     : ubqtech018
--%>

<%@page contentType="text/html" pageEncoding="windows-1252"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<%
            String projectPath = request.getContextPath();
%>
<div>
    <input type="hidden" name="jsFile" id="jsFile" value="<%= projectPath%>/js/assetUtlization/AssetUtilization.js">
    <table width="100%" cellpadding="0" cellspacing="0">
        <tr>
            <td width="100%">
                <fieldset>
                    <table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <tr>
                            <td  width="100%" colspan="4">
                                <font color="blue" style="">
                                    Select filter criteria
                                </font>
                            </td>
                        <tr>
                            <td width="100%" colspan="4">
                                <%@ include file="../common/EntityFilter.jsp"%>
                            </td>
                        <tr>
                        </tr>
                        <tr>
                            <td width="8%" > From Date
                            </td>
                            <td width="20%">
                                <input type="text" name="fromDate" id="fromDate" size="10" value="">
                                <input type="button" name="from_date_button" id="from_date_button" value="..." onclick="newPopupCalender('fromDate','from_date_button');">
                            <td width="5%"> To Date
                            </td>
                            <td>
                                <input type="text" name="toDate" id="toDate" size="10" value="">
                                <input type="button" name="to_date_button" id="to_date_button" value="..." onclick="newPopupCalender('toDate','to_date_button');">
                            </td>
                        </tr>
                        <tr>
                            <td width="100%" colspan="4" align="right" style="padding-right: 20px">
                                <input type="button" name="viewLineUtil" id="viewLineUtil" value="  View  " onclick="assetUtilization.showUtilizationEntries(this)">
                            </td>
                        </tr>
                    </table>
                </fieldset>
            </td>
        </tr>
        <tr>
            <td width="100%">
                <table width="100%" border="0">
                    <tr class="specialRow" valign="top">
                        <td width="15%">
                            Production date
                        </td>
                        <td width="20%">
                            Plant Name
                        </td>
                        <td width="20%">
                            No of Lines
                        </td>
                        <td width="45%">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td width="100%" colspan="4">
                            <div id="detailDiv" style="width: 97%;height: 300px;overflow: auto">
                            </div>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</div>