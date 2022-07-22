<%-- 
    Document   : ProductTypeDetails
    Created on : Dec 12, 2012, 4:45:29 PM
    Author     : saurabh
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" import="java.util.*"
         import="java.text.*" import="java.lang.*" errorPage="" import="ubq.util.*" %>
<div id="productTypeDetails">
    <%
                String projPath = request.getParameter("projPath");
    %>
    <%--<input type="hidden" name="jsFile" value="<%= projPath%>/js/audit/ProdTypeManagement.js">
    <input type="hidden" name="onLoadFunction" value="prodTypeManagement.formInit()">
    <input type="hidden" name="successHandler" value="prodTypeManagement.handleSuccess">
    <input type="hidden" name="failureHandler" value="prodTypeManagement.handleFailure">--%>
    <%

                String command = "insert";
                ResultSet prodTypeRS = (ResultSet) request.getAttribute("prodTypeRS");
                ResultSet brandRS = (ResultSet) request.getAttribute("brandRS");
                ResultSet prodVarietyRS = (ResultSet) request.getAttribute("prodVarietyRS");

                ResultSet rs = (ResultSet) request.getAttribute("detailsRS");

                String code = "";
                String desc = "";
                int prodType = 0;
                int brand = 0;
                int variety = 0;

                int childDDIndex = 0;
                int childDDTypeIndex = 0;
                int parentDDIndex = 0;
                int parentDDTypeIndex = 0;
                short isActive = 1;

                String disableTypeSelection = "";
                String disableProdType = "";
                String disableBrand = "";
                String disableVariety = "";
                String checkedStatus = "checked";

                if (rs != null && rs.next()) {
                    rs.beforeFirst();
                    command = "update";
                    while (rs.next()) {
                        code = rs.getString("dd_abbrv");
                        desc = rs.getString("dd_value");
                        childDDIndex = rs.getInt("childIndex");
                        childDDTypeIndex = rs.getInt("childType");
                        parentDDIndex = rs.getInt("parentIndex");
                        parentDDTypeIndex = rs.getInt("parentType");
                        isActive = rs.getShort("dd_valid");
                        checkedStatus = isActive == 1 ? "checked" : "";
                    }
                    disableTypeSelection = "disabled";
                }


                if (parentDDTypeIndex == DataDictionaryManager.PRODUCT_TYPE) {
                    prodType = parentDDIndex;
                    disableProdType = "disabled";
                } else if (parentDDTypeIndex == DataDictionaryManager.BRAND) {
                    brand = parentDDIndex;
                    disableBrand = "disabled";
                }


    %>
    <input type="hidden" name="action" id="action" value="<%=command%>">
    <input type="hidden" name="prodType" id="prodType" value="<%= prodType%>">
    <input type="hidden" name="brand" id="brand" value="<%= brand%>">
    <input type="hidden" name="variety" id="variety" value="<%= variety%>">


    <input type="hidden" name="child" id="child" value="<%= childDDIndex%>">
    <input type="hidden" name="parent" id="parent" value="<%= parentDDIndex%>">






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
                                        <td>Select Type</td>
                                        <td valign="top">
                                            <select name="typeSel" id="typeSel" class="selectheight" tabindex="1" style="width:136px"
                                                    onchange="prodTypeManagement.showHideParentCombo(this.value)" <%= disableTypeSelection%>>
                                                <option value="0"></option>
                                                <option value="100" <%if(childDDTypeIndex == 100){%> selected <%}%>>Product Type</option>
                                                <option value="200" <%if(childDDTypeIndex == 200){%> selected <%}%>>Brand</option>
                                                <option value="300" <%if(childDDTypeIndex == 300){%> selected <%}%>>Variant</option>
                                            </select>
                                            <span class="userInfo">*</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Code</td>
                                        <td>
                                            <input type="text" name="code" id="code" value="<%= code%>"
                                                   maxlength="20" style="width:134px;" onkeypress="restrictInput(this,keybCodeNumber,event);">
                                            <%--<span class="helpText">*</span>--%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Desc
                                        </td>
                                        <td>
                                            <input type="text" name="desc" id="desc" value="<%= desc%>" maxlength="20" style="width:136px;">
                                            <span class="userInfo">*</span>
                                        </td>
                                    </tr>
                                    <tr id="productTypeTr">
                                        <td>
                                            Product Type
                                        </td>
                                        <td>
                                            <select class="selectheight" id="prodTypeSel" name="prodTypeSel" style="width:138px;" 
                                                    <%= disableProdType%> onchange="prodTypeManagement.setParentIndex(this.value)">
                                                <option value="0"></option>
                                                <%
                                                            if (prodTypeRS != null && prodTypeRS.first()) {
                                                                prodTypeRS.beforeFirst();

                                                                while (prodTypeRS.next()) {
                                                %>
                                                <option value="<%=prodTypeRS.getInt("dd_index")%>" <%if (prodTypeRS.getInt("dd_index") == prodType) {%>selected <%}%>>
                                                    <%=prodTypeRS.getString("dd_value")%>
                                                </option>
                                                <%
                                                                }
                                                            }
                                                %>
                                            </select>
                                            <span class="userInfo">*</span>
                                        </td>
                                    </tr>
                                    <tr id="brandTr" class="hidden">
                                        <td>
                                            Brand
                                        </td>
                                        <td>
                                            <select class="selectheight" id="brandSel" name="brandSel" style="width:136px;"
                                                    <%= disableBrand%> onchange="prodTypeManagement.setParentIndex(this.value)">
                                                <option value="0"></option>
                                                <%
                                                            if (brandRS != null && brandRS.first()) {
                                                                brandRS.beforeFirst();

                                                                while (brandRS.next()) {
                                                %>
                                                <option value="<%=brandRS.getInt("dd_index")%>" <%if (brandRS.getInt("dd_index") == brand) {%>selected <%}%>>
                                                    <%=brandRS.getString("dd_value")%>
                                                </option>
                                                <%
                                                                }
                                                            }
                                                %>
                                            </select>
                                            <span class="userInfo">*</span>
                                        </td>
                                    </tr>
                                    <tr id="varietyTr" class="hidden">
                                        <td>
                                            Variety
                                        </td>
                                        <td>
                                            <select class="selectheight" id="prodTVarietySel" name="prodTVarietySel" style="width:136px;" <%= disableVariety%>>
                                                <option value="0"></option>
                                                <%
                                                            if (prodVarietyRS != null && prodVarietyRS.first()) {
                                                                prodVarietyRS.beforeFirst();

                                                                while (prodVarietyRS.next()) {
                                                %>
                                                <option value="<%=prodVarietyRS.getInt("dd_index")%>" <%if (prodVarietyRS.getInt("dd_index") == variety) {%>selected <%}%>>
                                                    <%=prodVarietyRS.getString("dd_value")%>
                                                </option>
                                                <%
                                                                }
                                                            }
                                                %>
                                            </select>
                                            <span class="userInfo">*</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <label for="isActive"> Is Active </label>
                                            <input type="hidden" name="isActiveStatus" id="isActiveStatus" value="<%=isActive%>">
                                            <input type="checkbox" name="isActive" id="isActive" <%=checkedStatus%> onclick="prodTypeManagement.setStatus(this.checked)">
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
