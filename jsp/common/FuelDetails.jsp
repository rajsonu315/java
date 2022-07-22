<%-- 
    Document   : FuelDetails
    Created on : 17 Jan, 2014, 1:46:09 PM
    Author     : ubqtech037
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" import="java.util.*"
         import="java.text.*" import="java.lang.*" errorPage="" import="ubq.util.*" %>

<div id="fuelDetails">
  
    <input type="hidden" name="isFuelactive" id="isFuelactive" value="1">
    <input type="hidden" name="fuelRid" id="fuelRid" value="0">
    <input type="hidden" name="uomIndex" id="uomIndex" value="0">
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" >
        <tr>
            <td valign="top" width="100%">
                <table width="100%" border="0" cellpadding="0" cellspacing="0" >
                    <tr valign="top">
                        <td>
                            <fieldset>
                                <%--<legend><b>Profile Details</b></legend>--%>
                                <table width="50%" border="0" cellpadding="2" cellspacing="0">
                                    
                                    <tr>
                                        <td>Code</td>
                                        <td valign="top">
                                            <input type="text" name="fuelCode" id="fuelCode"
                                                   maxlength="20" style="width:134px;" onkeypress="restrictInput(this,keybCodeNumber,event)">

                                       
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Name</td>
                                        <td>
                                            <input type="text" name="fuelName" id="fuelName"
                                                   maxlength="20" style="width:134px;" onkeypress="">
                                           
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>UOM</td>
                                        <td>
                                            <select name="typeSel" id="typeSel" class="selectheight" tabindex="1" style="width:140px"
                                                    onchange="fuelTypeManagment.setUomIndex();">
                                               <option value="0"></option>
                                                <%
                                                ResultSet fuelUomRS = (ResultSet) request.getAttribute("fuelUomRS");
                                                while (fuelUomRS != null && fuelUomRS.next()) {
                                                %>
                                                <option value="<%= fuelUomRS.getInt("dd_index")%>"><%= fuelUomRS.getString("dd_value")%></option>
                                                <%
                                                }
                                                %>
                                            </select>
                                           
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>HSD Equivalent</td>
                                        <td>
                                            <input type="text" name="hsd" id="hsd" 
                                                   maxlength="20" style="width:134px;" onkeypress="">
                                           
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <label for="isActive"> Is Active </label>
                                            <% String checkedStatus = "checked";%>
                                            <input type="checkbox" name="isActive" id="isActive"<%=checkedStatus%> onclick="fuelTypeManagment.setIsFuelActive();">

                                        </td>
                                    </tr>
                                </table>
                            </fieldset>

                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
   <iframe name="myIframe" id="myIframe" class="hidden" style="display: none"></iframe>
</div>