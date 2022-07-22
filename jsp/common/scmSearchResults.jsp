<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8" language="java" import="java.sql.*" import="java.util.*" import="java.text.*" errorPage="" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
        <link href="<%=(String)request.getContextPath()%>/style/dqiColors.css" rel="stylesheet" type="text/css">
        <link href="<%=(String)request.getContextPath()%>/style/dqiStyles.css" rel="stylesheet" type="text/css">
        <link href="<%=(String)request.getContextPath()%>/style/outReach.css" rel="stylesheet" type="text/css">
    </head>
	
	<script language="javascript">
	function cancel_click()
	{
  		window.close();
	}
	
	function ok_click(){
		var selected_value ;
		var selectedIndex = document.search_results_form.results_list.selectedIndex;
		if(selectedIndex >= 0) {
			selected_value = (document.search_results_form.results_list.options[selectedIndex].value);
		} else {
			alert("Please select an SKU or click on the Cancel button");
			return;
		}
		var result_array = selected_value.split("~") ;
		var assoc_array = new Array() ;
		assoc_array["dd_index"] = result_array[0] ;
		assoc_array["dd_abbrv"] = result_array[1] ;
		assoc_array["dd_value"] = result_array[2] ;
		assoc_array["dd_parent_index"] = result_array[3] ;
		assoc_array["dd_valid"] = result_array[4] ;
                
		window.returnValue = assoc_array; //selected_value.split("~");
		window.close() ;
	}
        
    function initializePage(){
      window.dialogWidth="540px";
      window.dialogHeight="520px";
      window.dialogLeft=250;
      window.dialogTop=100;
    }
    
    function checkKeyStroke() {
      var keycode = window.event.keyCode;
      if (keycode == 13) 
        ok_click() ;
    }
    </script>
    <body onload="initializePage()">
	        <form name="search_results_form" id="search_results_form" method="post" action="">
            <table width="100%"  border="0" cellspacing="5" cellpadding="5">
                <tr>
                    <td>
                    <div align="center">
                        <select name="results_list" id="results_list" size="25" style="width:497px" onKeyPress="checkKeyStroke()">
                            <%if (request.getAttribute("supTypeRs") != null) {
                    ResultSet rs = (ResultSet)request.getAttribute("supTypeRs") ;
                    while(rs.next()){
                        String valueStr = rs.getString("dd_index") + "~" + rs.getString("dd_abbrv") + "~" + rs.getString("dd_value") + "~" + rs.getString("dd_parent_index") + "~" + rs.getString("dd_valid");%>
                           <!-- rs.getString("dd_index") + "  " + rs.getString("dd_abbrv") + "  " +  -->
                            <option value="<%= valueStr%>"> <%=  rs.getString("dd_value")%></option>
                            <% }
                            }%>
                            </select>
                    </div></td>
                </tr>
                <tr>
                    <td>
                    <div align="center">
                        <input type="button" name="okBtn" id="okBtn" value="  OK  " onClick="ok_click()"> 
                        &nbsp; &nbsp;
                        <input type="button" name="cancelBtn" id="cancelBtn" value="Cancel" onClick="cancel_click()">
                    </div></td>
                </tr>
            </table>
        </form>
    </body>
</html>
