<%--
    Document   : PartyFilter
    Author     : @@saurabh
--%>
<%@ page language="java" import="java.sql.*" import="java.util.*" import="java.text.*" errorPage="" %>

<div id="">

    <%
                String Path = request.getContextPath();
                String loadInActiveCustomer = (String) request.getParameter("loadInActiveCustomer");
                String isMandatoryField = (String) request.getParameter("isMandatoryFieldReq");
                String comboWidth = (String) request.getParameter("comboWidth");                

                boolean mandatoryField = false;
                if ("true".equalsIgnoreCase(isMandatoryField) && isMandatoryField != null) {
                    mandatoryField = true;
                }

                String searchType = request.getParameter("searchType");
    %>  
    <input type="hidden" name="isMandatoryFieldReq" id="isMandatoryFieldReq" value="<%=mandatoryField%>">
    <input type="hidden" name="comboboxWidth" id="comboboxWidth" value="<%=comboWidth%>">
    <input type="hidden" name ="loadInActiveCustomerHidden" id="loadInActiveCustomerHidden" value="<%= loadInActiveCustomer%>">
    <%--<input type="hidden" name="jsFile" value="<%= Path%>/js/audit/PartyFilter.js">--%>

    <table  height="100%" border="0" cellspacing="0" cellpadding="0" >
        <%
                    if ("entity".equals(searchType)) {
        %>
        <tr>
            <td valign="top">
                <select name="entityType" id="entityType" class="selectheight" tabindex="1" <%if (comboWidth != null) {%> style="<%=comboWidth%>" <%} else {%> style="width:175px" <%}%>>
                    <option value=""></option>
                    <%--<option value="DEP">Depot</option>--%>
                    <option value="FAC">Factory</option>
                    <%--<option value="SUP">Supplier</option>--%>
                </select>
                <%if (mandatoryField) {%> <span class="userInfo">*</span> <%}%>
            </td>
        </tr>
        <%
                    }
                    if ("prodType".equals(searchType)) {
        %>
        <tr>
            <td valign="top">
                <select name="searchBy" id="searchBy" class="selectheight" tabindex="1"
                        <%if (comboWidth != null) {%> style="<%=comboWidth%>" <%} else {%> style="width:175px" <%}%>>
                    <option value="0"></option>
                    <option value="100">Product Type</option>
                    <option value="200">Brand</option>
                    <option value="300">Variant</option>
                </select>
                <%if (mandatoryField) {%> <span class="userInfo">*</span> <%}%>
            </td>
        </tr>
        <%
                    }
        %>
    </table>
</div>
