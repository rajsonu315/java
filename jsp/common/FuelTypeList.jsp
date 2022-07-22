<%-- 
    Document   : FuelList
    Created on : 20 Jan, 2014, 11:03:35 AM
    Author     : ubqtech037
--%>


<%@page import="java.sql.ResultSet"%>
<html>
    <% String projPath = request.getContextPath(); %>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
        <link href="<%= projPath%>/style/UbqApp.css" rel="stylesheet" type="text/css">
        <script type="text/javascript" language="javascript" src="<%=projPath%>/js/assetUtlization/FuelList.js"></script>
    </head>

    <body onload="fuelList.initializePage()">

        <form name="searchFuelListForm" id="searchFuelListForm" method="POST" action="">

            <table width="100%" border="0" cellspacing="5" cellpadding="5">
            <tr>
                <td>
                    <div align="center" style="overflow:auto; height:400px; width:100%; background-color:#FFFFFF;">
                        <select name="results_list" id="results_list" size="25" style="width:497px;height: 400px"  onKeyPress="fuelList.checkKeyStroke()" ondblclick="fuelList.okClick()">
                        <%
                           
                               ResultSet rs = (ResultSet) request.getAttribute("listRS");
                               rs.beforeFirst();
                               String valueStr="";
                               while(rs!= null && rs.next()){
                                    valueStr = rs.getString("fuel_rid")+'~'+ rs.getString("fuel_code")+'~'+rs.getString("fuel_name")+'~'+rs.getInt("fuel_uom_index")+'~'+rs.getDouble("fuel_hsd_eqv")+'~'+rs.getInt("fuel_is_valid");
                        %>
                        <option value = "<%=valueStr%>" >
                            <%= rs.getString("fuel_name") %>

                        </option>

                        <%   }   %>

                        </select>

                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div align="left">
                        <input type="button" name="okBtn" id="okBtn" value=" OK " onClick ="fuelList.okClick()" class = "buttonSize">
                        &nbsp; &nbsp;
                        <input type="button" name="cancelBtn" id="cancelBtn" value=" Cancel " onClick ="fuelList.cancelClick()" class = "buttonSize">

                    </div>

                </td>
            </tr>


            </table>

        </form>
    </body>
</html>
