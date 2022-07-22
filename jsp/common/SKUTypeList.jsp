<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8" language="java" import="java.sql.*" import="java.util.*" import="java.text.*" errorPage="" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <% String projPath = request.getContextPath();%>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
        <link href="<%= projPath%>/style/UbqApp.css" rel="stylesheet" type="text/css">
        <script type="text/javascript" language="javascript" src="<%=projPath%>/js/assetUtlization/SKUList.js"></script>
    </head>

    <body onload="skuList.initializePage()">
        <form name="searchSKUListform" id="searchSKUListform" method="post" action="">
            <table width="100%"  border="0" cellspacing="5" cellpadding="5">
                <tr>
                    <td>
                        <div align="center" style="overflow:auto; height:400px; width:100%; background-color:#FFFFFF;">
                            <select name="results_list" id="results_list" size="25" style="width:497px;height: 400px"  onKeyPress="skuList.checkKeyStroke()" ondblclick="skuList.okClick()">
                                <%
                                            if (request.getAttribute("listRS") != null) {
                                                ResultSet rs = (ResultSet) request.getAttribute("listRS");
                                                rs.beforeFirst();
                                                String valueStr = "";
                                                while (rs.next()) {
                                                    valueStr = rs.getString("dd_index");
                                %>
                                <option value="<%= valueStr%>" >
                                    <%= rs.getString("dd_value") + (rs.getString("dd_abbrv") != null
                                    && !"".equals(rs.getString("dd_abbrv")) ? " (" + rs.getString("dd_abbrv") + ")" : "")%>
                                </option>
                                <% }
                                        }%>
                            </select>
                        </div></td>
                </tr>
                <tr>
                    <td>
                        <div align="right">
                            <input type="button" name="okBtn" id="okBtn" value="  OK  " onclick="skuList.okClick()" class="buttonSize">
                            &nbsp; &nbsp;
                            <input type="button" name="cancelBtn" id="cancelBtn"  value="Cancel" onclick="skuList.cancelClick()" class="buttonSize">
                        </div></td>
                </tr>
            </table>
        </form>
    </body>
</html>



