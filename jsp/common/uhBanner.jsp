<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>

<style type="text/css">

.style1 {
  font-family: verdana;
  font-size: 16px;
  color: #FFFFFF;
}
.style2 {
  font-family: verdana;
  font-weight: bold;
  font-size: 18px;
  color: #FFFFFF;
}
</style>

<head>
<title>Banner</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<link href="styles/UbqColors.css" rel="stylesheet" type="text/css">
<link href="styles/UbqStyles.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE="JavaScript" SRC="js/base/xmlHelper.js"></SCRIPT> 
</head>

<%
    String project = request.getContextPath();
    ResultSet rsUnit =  (ResultSet) session.getAttribute("unitRS"); 
%>

<script>

function checkTransition(anchor) {

  var ans;

  if(form1.dirtyBit.value == '1') {
    ans = confirm("Selected action will discard any entered data. Continue?");

    if(ans) {
      form1.dirtyBit.value = '0';
      return true;
    } else {
      window.event.returnValue = false;
      return false;
    }
  }
}

function setUnitValue(cmb, selIndex)
{
    var unitRID = cmb.options[selIndex].value;
    var unitName = cmb.options[selIndex].text;
    var url = "<%=project%>/UUnitServlet?command=setUnit&unitRID=" + unitRID + "&unitName="+unitName; 
    
    xmlPostSync(url);
    
    try {
      window.parent.body.activityFrame.setUnit(unitRID) ;
    } catch (e) { 
      // do nothing 
    }
}

</script>

<!-- Body of Banner JSP Starts -->
<body class="bannerBackgroundColor">

<form name="form1" id="form1" method="post" action="">

<input type="hidden" name="dirtyBit" id="dirtyBit" value="0">

  <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#9B638E">
    <tr>
      <td width="10%" height="55"><div align="center"><img src="<%=project%>/images/small-logo.jpg" width="54" height="33"></div></td>
      <td width="30%"><span class="style1" style="font-weight: bold;">&nbsp;Ubq Health</span></td>
      <td width="30%"><span class="style1"><%= session.getAttribute("userEntityName") %><br>
                                           (<%= session.getAttribute("userName") %>)</span></td>
     <%
       if (rsUnit != null && rsUnit.first())
       {
           rsUnit.beforeFirst();
           rsUnit.last();
           int rowCount = rsUnit.getRow();
           rsUnit.beforeFirst();
           if ( rowCount > 1)
           {    
               out.println("<td width=\"30%\" align=\"left\"><span class=\"style1\">Unit ");
               out.println("<select name=cmbUnit id=cmbUnit onchange=\"setUnitValue(this, selectedIndex)\" style='width:150px'>" );
               while (rsUnit.next()) { 

                   out.println("<option value=" + rsUnit.getInt("unit_rid") + ">" + rsUnit.getString("unit_name") +"</option>");
                }
                out.println("</select>");
                out.println("</span></td>");
           }
           else if ( rowCount == 1 )
           {
            rsUnit.first();
            out.println("<td width=\"30%\" align=\"left\"><span class=\"style1\">Unit ");
            out.println("<input type=text name=cmbUnit id=cmbUnit style='width:150px' value=" + rsUnit.getString("unit_name") + " readOnly >" );   
           }
           rsUnit.first();
           session.setAttribute("unitRID", new Integer(rsUnit.getInt("unit_rid")));
           session.setAttribute("unitName", rsUnit.getString("unit_name"));
           
               
       }
     %>   
                                      
     <!-- <td width="30%" align="left"><span class="style1">Unit <= session.getAttribute("unitRS")%> </span></td> -->
      <td width="15%" align="center" ><a href="<%=project%>/UMasterServlet?command=loadAccessibleCommands" 
	target="body" onClick="checkTransition(this)"><span class="style2">Menu</span>&nbsp;</a>&nbsp;&nbsp;</td>

      <td align="center" ><a href="<%=project%>/Logout" target="_top" onClick="checkTransition(this)">
	<span class="style2">Logout</span>&nbsp;</a>&nbsp;</td>

</body> 
<!-- Body of JSP Ends -->
</html>
