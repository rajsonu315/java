<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8" language="java" import="java.sql.*" import="java.util.*" import="java.text.*" errorPage="" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <% String projPath = request.getContextPath();%>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
        <link href="<%= projPath%>/style/UbqApp.css" rel="stylesheet" type="text/css">
        <script type="text/javascript" language="javascript" src="<%=projPath%>/js/assetUtlization/AWList.js"></script>
    </head>

    <body onload="awList.initializePage()">
        <form name="searchAWListform" id="searchAWListform" method="post" action="">
            <table width="100%"  border="0" cellspacing="5" cellpadding="5">
                <tr>
                    <td>
                        <div align="center" style="overflow:auto; height:400px; width:100%; background-color:#FFFFFF;">
                            <select name="results_list" id="results_list" size="25" style="width:497px;height: 400px"  onKeyPress="awList.checkKeyStroke()" ondblclick="awList.okClick()">
                                <%
                                            if (request.getAttribute("awRS") != null) {
                                                ResultSet rs = (ResultSet) request.getAttribute("awRS");
                                                rs.beforeFirst();
                                                while (rs.next()) {
                                                    String valueStr = rs.getString("ent_rid");
                                                //System.out.println(valueStr);
%>
                                <option value="<%= valueStr%>" >
                                    <%= rs.getString("ent_code") + " - " + rs.getString("ent_name")%>
                                </option>
                                <% }
                                        }%>
                            </select>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div align="right">
                            <input type="button" name="okBtn" id="okBtn" value="  OK  " onclick="awList.okClick()" class="buttonSize">
                            &nbsp; &nbsp;
                            <input type="button" name="cancelBtn" id="cancelBtn"  value="Cancel" onclick="awList.cancelClick()" class="buttonSize">
                        </div></td>
                </tr>
            </table>
        </form>
    </body>
</html>



