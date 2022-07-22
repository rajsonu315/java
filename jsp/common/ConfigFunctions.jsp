<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Document Flow Configuration</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">

.header {	
  font-family: verdana;
  font-weight: bold;
  font-size: 14px;
  color:#FFFFFF;
}

.tableBody {	
  font-family: Arial;
  font-weight: bold;
  font-size: 14px;
  color:#FFFFFF;
}

.txtbox {
  border : 1px solid #0C5C8F;
  font-family: verdana;
  font-size: 11px;
  font-style: normal;
  color: #333333;
  text-align:right;
}

.readonlyTxtBox {
  border : 1px solid #0C5C8F;
  font-family: verdana;
  font-size: 11px;
  font-style: normal;
  color: #333333;
  text-align:left;
  background-color:#CCCCCC
  readonly
}

.button {
  font-family: verdana;
  font-size: 11px;
  color: #FFFFFF;
  background-color: #0B4A73;
  border : none;
}

.label {
  font-family: verdana; 
  font-size: 12px; 
}

a {
  text-decoration: none;
}

#entryResponseFrame      { position: absolute; visibility: hidden }

</style>

<%
    String project = request.getContextPath();
%>


<script>

function setNewSelection(selection){
    selectedElem = document.getElementById(selection.id);
    highlightSelection(selectedElem);
 
}

var currSelection ;

function highlightSelection(elem) {
    
    
    if(currSelection != null) {
     
      elem.style.background = currSelection.savedBackground;
      currSelection.style.background = currSelection.savedBackground;
    } 
      elem.savedBackground = elem.style.background;
      elem.style.background = "#FD9A00";
      
     
      elem.style.background = "#FD9A00";
      currSelection = elem;
}    
    
</script>

</head>

<body bgcolor="888996" style="margin-left:0px;margin-right:0px;margin-bottom:0px;margin-top:0px;">

<table bgcolor="CFCFD5" height="650" width="100%"  border="0" cellspacing="0" cellpadding="0">

  <tr>
    <td valign="top">
      <table bgcolor="CFCFD5" width="100%" border="0" cellspacing="0" cellpadding="0">

        <tr height="35" bgcolor="#4A4A4C">
          <td align="center" ><span class="header"><strong>Config Functions</strong></span></td>
        </tr>

        <tr>
          <td class="label">

          <br>

          <strong>&nbsp;User and Role Management</strong><br><br>
          &nbsp;&nbsp;<a id="roles" style="text-decoration:none;color:#000000;" href="<%=project%>/UMasterServlet?command=loadRoleMaster" target="ConfigWorkspaceFrame" onclick="setNewSelection(this)">Roles</a><br>
          &nbsp;&nbsp;<a id="user" style="text-decoration:none;color:#000000;" href="<%=project%>/UMasterServlet?command=loadUserMaster" target="ConfigWorkspaceFrame" onclick="setNewSelection(this)">User</a><br>          
          <br>

          <strong>&nbsp;AWs</strong><br><br>
          &nbsp;&nbsp;<a id="factory" style="text-decoration:none;color:#000000;" href="<%=project%>/UMasterServlet?command=loadEntityMaster" target="ConfigWorkspaceFrame" onclick="setNewSelection(this)">Factory</a><br>
          <br>
	
          <strong>&nbsp;System</strong><br><br>

          &nbsp;&nbsp;<a id="reconfig" style="text-decoration:none;color:#000000;" href="<%=project%>/UMasterServlet?command=reconfigureLogging" target="entryResponseFrame" onclick="setNewSelection(this)">Reconfigure Logging</a><br>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>

<iframe id=entryResponseFrame name=entryResponseFrame src=""></iframe>

</body>

</html>
