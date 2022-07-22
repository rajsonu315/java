<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" errorPage="" %>
<%@page pageEncoding="UTF-8"%>
<%--
The taglib directive below imports the JSTL library. If you uncomment it,
you must also add the JSTL library to the project. The Add Library... action
on Libraries node in Projects view can be used to add the JSTL 1.1 library.
--%>
<%--
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
--%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<%
    String project = request.getContextPath();
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
	<link href="<%=project%>/styles/uOutReach.css" rel="stylesheet" type="text/css">
    </head>

<SCRIPT LANGUAGE="JavaScript" SRC="<%=project%>/js/base/UbqValidations.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="<%=project%>/js/base/xmlHelper.js"></SCRIPT>

<script language="javascript">

function selectComboItem(targetCombo, targetItem){
	for(var i =0; i < targetCombo.options.length; i++){
		if(targetCombo.options[i].text == targetItem){
			targetCombo.options[i].selected = true ;   
                        targetCombo.options[i].value = targetItem;
			return ;
		}
	}
}    

    
function entityTypeOnchange(selectBox){
var i = selectBox.selectedIndex;
selectBox.options[i].value = selectBox.options[i].text;
}

function loadEntityMaster(selectBox) {
   document.entityMasterForm.entityCode.value = "";
   document.entityMasterForm.entityType.text = "";
  
  var i = selectBox.selectedIndex;

  entityMasterForm.entity.value = selectBox.options[i].text;  
  var valArray = selectBox.options[i].value.split("~"); 
  entityMasterForm.entityRID.value = selectBox.options[i].value;  
  
  if(selectBox.options[i].value == 0){ 
  document.entityMasterForm.entity.value = "" ;
  document.entityMasterForm.entityType.value = 0;
  document.entityMasterForm.entityCode.value = "";   
  }
  else{
  selectComboItem(document.entityMasterForm.entityType,valArray[1]);
  document.entityMasterForm.entityCode.value = valArray[2];   
  entityMasterForm.entityRID.value = valArray[0];
  } 
  var isActive = entityMasterForm.entityValid[i].value;

  entityMasterForm.isActive.checked = (isActive == 1) ? true : false;
}

function clearForm(prompt) {

  var ans = true;

  if(prompt)
    ans = confirm("Do you really want to clear the form?");

  if(ans) {
    entityMasterForm.reset();
    entityMasterForm.entityRID.value = "0";
    entityMasterForm.entity.value = "";
  }
}

function handleSuccess(msg) {
  clearForm(false);

  var url = "<%=project%>/UMasterServlet";
//  xmlLoadElementValues(url + "?command=loadEntityMaster", document.getElementById('returnEntitySelection'));

  entityMasterForm.method = "get";
  entityMasterForm.command.value = "loadEntityMaster";
  entityMasterForm.action = url + "?command=loadEntityMaster";
  entityMasterForm.target = "_self";
  entityMasterForm.submit();

}

function handleFailure(msg) {

  alert(msg);
}

function formValidate() {
   
  if(isEmpty(entityMasterForm.entity.value)) {
    
    alert("Please enter factory ");

   entityMasterForm.entity.focus();
    return false;
  }
   if(isEmpty(entityMasterForm.entityCode.value)) {
    
    alert("Please enter factory Code");

   entityMasterForm.entityCode.focus();
    return false;
  }
   
   var i = document.entityMasterForm.entityType.selectedIndex;      
   if(document.entityMasterForm.entityType.options[i].value == 0) {    
    alert("Please select factory Type");
    entityMasterForm.entityType.focus();
    return false;
  }
  
  return true;

}
	
</script>

<style type="text/css">

.header {	
  font-family: verdana;
  font-weight: bold;
  font-size: 14px;
  color:#FFFFFF;
}

.myLabel {
  font-family: verdana; 
  font-size: 12px; 
}

#entryResponseFrame      { position: absolute; visibility: hidden }

</style>

<body bgcolor="CFCFD5">

<form name="entityMasterForm" id="entityMasterForm" method="post" action="<%=project%>/UMasterServlet" target="entryResponseFrame" onSubmit="return formValidate();">
  
    
<input type="hidden" name="command" id="command" value="saveEntity">
<input type="hidden" name="entityRID" id="entityRID" id="entityRID">

<table bgcolor="CFCFD5" height="650" width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr height="18" width="100%" bgcolor="#4A4A4C">
    <td align="center"><span class="header"><strong>Factory Master</strong></span></td>
  </tr>

  <tr>
    <td valign="top" >
      <table border="0" cellpadding="0" cellspacing="0" bgcolor="CFCFD5">

        <tr>
          <td colspan="2" class="myLabel">
            &nbsp;To make changes to an existing Entity, select the Entity from the options below, make changes, <br>
            &nbsp;and then click on the "Save" button.<br><br>
          </td>
        </tr>

	<tr>
          <td colspan="2" class="myLabel">
            &nbsp;Select Factory
	  </td>
	</tr>

	<tr>
	  <td colspan="2" class="myLabel">
              &nbsp;<select style="width:200px" name="returnEntitySelection" id="returnEntitySelection" onChange="loadEntityMaster(this)">
                <option value="0">&nbsp;</option>
<%
   
    ResultSet rs = (ResultSet) request.getAttribute("entities");

    if(rs != null) {

        while(rs.next()) {            
%>
               <option value="<%= rs.getInt("ent_rid") + "~" + rs.getString("ent_Type") + "~" + rs.getString("ent_code")%> ">
                   <%= rs.getString("ent_name")%>
                </option>
<%

      }
    }
%>
              </select> 
          </td>
        </tr>

	<tr>
	  <td colspan="2" class="myLabel">
<%
    rs = (ResultSet) request.getAttribute("entities");
    
    if(rs != null) {

	rs.beforeFirst();
%>
            <input type="hidden" name="entityValid" value="0">
<%
        while(rs.next()) {
%>
            <input type="hidden" name="entityValid" value="<%= rs.getInt("ent_registered")%>">
           
            
<%
        }
    }
      
%>
          </td>
        </tr>
<% rs.close();%>
        <tr>
          <td colspan="2"><hr /></td>
        </tr>

        <tr>
          <td colspan="2" class="myLabel">
            &nbsp;To add a new Factory , enter data and click on the "Save" button.<br><br>
          </td>
        </tr>

        <tr>
          <td class="myLabel">&nbsp;Factory</td>
          <td class="myLabel"><input type="text" size="25" maxlength="25" name="entity" id="entity"></td>
        </tr>

	<tr><td colspan="2">&nbsp;</tr>
        
        <tr>
          <td class="myLabel">&nbsp;Factory Code</td>
          <td class="myLabel"><input type="text" size="12" maxlength="12" name="entityCode" id="entityCode"></td>
        </tr>
        
        <tr><td colspan="2">&nbsp;</tr>
        
       
      <tr>
        <td class="myLabel">&nbsp;Factory Type</td>
	  <td colspan="2" class="myLabel">
              <select style="width:200px" name="entityType" id="entityType" onchange="entityTypeOnchange(this)">
                <option value="0">&nbsp;</option>  
                <option value="1">F</option>
<%
   
  /*   ResultSet rst = (ResultSet) request.getAttribute("entityTypes");

    if(rst != null) {    
        while(rst.next()) {          */  
%>   
       <!--   <option value="<%/*=rst.getString("ent_rid")*/%>">
                   <%/*= rst.getString("ent_Type")*/%>
             </option>-->
<%

  /*    }
    }*/
%>             
                <!--<option value="0">&nbsp;</option>
                 <option value="1">F</option>
                <option value="0">D</option>
                 <option value="0">C</option>       -->
                 
              </select> 
          </td>
        </tr>      
     
         
       
         <tr><td colspan="2">&nbsp;</tr>
         <tr> <td colspan="2" class="myLabel"><input type="checkbox" name="isActive" id="isActive" checked = true>Is Active</td>
        </tr>

        <tr>
          <td colspan="2" width="100%"><hr /></td>
        </tr>

        <tr>
          <td colspan="2" align="center">
            <input type="submit" value="Save" name="save" id="save"> &nbsp;
            <input type="button" value="Clear" name="cancel" id="cancel" onClick="clearForm(true)">
          </td>
        </tr>
    </td>
  </tr>
</table>

<iframe id=entryResponseFrame name=entryResponseFrame src=""></iframe>

</form>

</body>

</html>
