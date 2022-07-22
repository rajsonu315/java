<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <title>Select Product</title>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
        <link href="<%=request.getContextPath()%>/style/dqiColors.css" rel="stylesheet" type="text/css">
        <link href="<%=request.getContextPath()%>/style/dqiStyles.css" rel="stylesheet" type="text/css">
        <link href="<%=request.getContextPath()%>/style/outReach.css" rel="stylesheet" type="text/css">
        
        <style>
            .selectedRow 
            { 
            background-color:#0066CC;
            font-family:Arial, Helvetica, sans-serif;
            font-size: small;
            color: #FFFFFF;
            }
            .deSelectedRow { 
            background-color:#FFFFFF;
            font-family:Arial, Helvetica, sans-serif;
            font-size: small;
            color: #000000;
            }   
            .lightBlue{
            background-color: #ECECFF;
            }
        </style>
        <SCRIPT LANGUAGE="JavaScript" SRC="<%=request.getContextPath()%>/js/base/DynamicTableTemplate.js"></SCRIPT>
        <SCRIPT LANGUAGE="JavaScript" SRC="<%=request.getContextPath()%>/js/base/ValidateFunction.js"></SCRIPT>
        <script>

            var selectedRow = null;
            function product_ok_click()
            {
            var selected_value ;

            /* var selectedIndex = document.product_search.select.selectedIndex;

            if(selectedIndex >= 0) {
            selected_value = (document.product_search.select.options[selectedIndex].value);

            } else {

            alert("Please select an SKU or click on the Cancel button");
            return;
            }
            */
            var selected_value = document.product_search.selValue.value;  
            var selectArray = selected_value.split("~");
            var returnArray = new Array();

            //returnArray['prodctCode'] = selectArray[0];
            //returnArray['productRid'] = selectArray[1];
            //returnArray['expiryDuration'] = selectArray[2];
            //returnArray['pieceWt'] = selectArray[3];
            //returnArray['productName'] = selectArray[4];
            //returnArray['purchasePercent'] = selectArray[5];
            //returnArray['salesPercent'] = selectArray[6];
            //returnArray['totbookqty'] = selectArray[7];
            //returnArray['cbbSize'] = selectArray[8];
            //returnArray['cbbvolume'] = selectArray[9];
	
            returnArray[0] = selectArray[0];
            returnArray[1] = selectArray[1];
            returnArray[2] = selectArray[2];
            returnArray[3] = selectArray[3];
            returnArray[4] = selectArray[4];
            returnArray[5] = selectArray[5];
            returnArray[6] = selectArray[6];
            returnArray[7] = selectArray[7];
            returnArray[8] = selectArray[8];
            returnArray[9] = selectArray[9];

            window.returnValue = returnArray;
            window.close();

            }



            function tabNavigate (field, evt) {
    
            var keyCode = evt.keyCode ;
            var currRow = dynTableRow(field);
            // arrow down - move to next row
            if (keyCode == 40)
            {
            var nextHndlr = currRow.nextSibling;
            if(nextHndlr != null)
            toggleSelection(nextHndlr); 
            }
            // arrow up - move to previous row
            else if (keyCode == 38)
            {
            var prevHndlr = currRow.previousSibling;
            if(prevHndlr != null)
            toggleSelection(prevHndlr); 
            }
            }
            function toggleSelection (rowHndlr)
            {
            if (selectedRow != null)
            {
            selectedRow.className = "deSelectedRow";
            dynTableGetNodeInRow(selectedRow, 'prod_code').className = "deSelectedRow";
            }    
            rowHndlr.className="selectedRow";
            document.product_search.selValue.value = dynTableGetNodeInRow(rowHndlr,'valueStr').value;
            dynTableGetNodeInRow(rowHndlr, 'prod_code').className = "selectedRow";
            dynTableGetNodeInRow(rowHndlr, 'prod_code').focus();
            selectedRow = rowHndlr;
            }
    
            function product_cancel_click()
            {
            window.close();
            }

            function highLightFirstRow()
            {
            // Get the table body
            var tbl = document.getElementById("listTable");
            var tby = tbl.getElementsByTagName("TBODY");
            if(tby.length == 0)
            return null;
            tby = tby[tby.length - 1];
            rows = tby.getElementsByTagName("TR");
            var firstRow = rows[0];
            if (firstRow == null )
            {
            document.product_search.ok.disabled=true;
            return;
            }  
            toggleSelection(firstRow);
 
            }

        </script>
    </head>
    <body class="lightBlue" style="width:497px; height:300px" onload="highLightFirstRow();">

        <form action="<%=request.getContextPath()%>/SearchProductServlet" method="post" name="product_search" id="product_search" target="_self" onsubmit="product_ok_click(); return false;">
            <table width="100%" height="100%"  border="0" align="center" cellpadding="0" cellspacing="0" >
                <input type="hidden" name="selValue" id="selValue" value="">
                <tr heigth="40" >
                    <td height="33" width="18%">Code</td>
                    <td >Product Name</td>   
                </tr>  
                <tr>
                    <td colspan="2" align="top" >
                        <div style="overflow:auto; height:400px; width:100%; background-color:#FFFFFF;"> 
                            <table id="listTable" width="90%" border="0" cellpadding="0" cellspacing="0"  >
            
                                <%
                                    ResultSet rs = (ResultSet) request.getAttribute("rsProduct");
                                    String stockinfo = request.getParameter("loadStockInfo");
                                    // moved to    (stockinfo.equals("true")) flow
                                    //+ "~" +  rs.getString("pr_mrp_pkt") + "~" +  rs.getString("pr_unit_pp_per_cbb")

                                    if(rs != null) {
                                        while(rs.next()) {
                                            String  valueStr =rs.getString("prod_custom_code") + "~" + rs.getString("prod_rid") +  "~" +  rs.getString("prod_expiry_duration")  + "~" +  rs.getString("prod_piece_weight" ) + "~" +
                                                    rs.getString("prod_name") + "~" + rs.getString("tax_purchase_percent") + "~" + rs.getString("tax_sales_percent");

                                            if(stockinfo.equals("true")){
                                                valueStr= valueStr + "~" + rs.getString("totbookqty") + "~" + rs.getString("stk_cbb_size") + "~" +
                                                        rs.getString("prod_cbb_volume");
                                            }else{
                                                valueStr= valueStr + "~ ~ ~";
                                            }

                                %>

                                <tr onclick="toggleSelection(this);" ondblclick="product_ok_click();">
                                    <input type="hidden" name="valueStr" id="valueStr" value="<%=valueStr %>" > 
                                    <td width="15%" onkeydown="tabNavigate(this, event)">
                                    <input tabindex="-1" type="text" size="6" maxlength ="0" style="border:0" name="prod_code" id="prod_code" value="<%= rs.getString("prod_code")%>" onkeydown="tabNavigate(this, event)" ></td>
                                    <td width="60%" onkeydown="tabNavigate(this, event)" ><%= rs.getString("prod_name")%></td>  
                                </tr> 

                                <%   }	
                                        }

                                %>
                            </table> 
                        </div>
                        <!-- </select> -->
                    </td>
                </tr>
                <tr>
        
                    <td colspan="2" align="right"><input class="button"type="submit" name="ok" id="ok" value="  OK  " onClick="product_ok_click()" tabindex="1">
                    <input class="button" type="button" name="submit2" id="submit2" value="Cancel" onClick="product_cancel_click()" tabindex="2"></td>
                </tr>
            </table>
  
        </form>
    </body>
</html>
