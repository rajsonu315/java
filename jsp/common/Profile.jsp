<%--
    Document   : Profile
    Author     : @@Saurabh
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" import="java.util.*"
         import="java.text.*" import="java.lang.*" errorPage="" %>
<div id="entityDetails">
    <%
                String projPath = request.getContextPath();
                boolean isProfileEditable = false;
                if (null != request.getParameter("isProfileEditable")) {
                    isProfileEditable = Boolean.parseBoolean(request.getParameter("isProfileEditable"));
                } else {
                    isProfileEditable = request.getAttribute("isProfileEditable") != null
                            ? Boolean.parseBoolean(request.getAttribute("isProfileEditable").toString()) : false;
                }
    %>
    <input type="hidden" name="jsFile" value="<%= projPath%>/js/audit/AWProfile.js">

    <% if (isProfileEditable) {%>
    <input type="hidden" name="onLoadFunction" value="awProfile.formInit()">
    <%}%>
    <input type="hidden" name="successHandler" value="awProfile.handleSuccess">
    <input type="hidden" name="failureHandler" value="awProfile.handleFailure">
    <%
                SimpleDateFormat fmt = new SimpleDateFormat("dd/MM/yyyy");
                int awRID = 0;
                String awCode = "";
                String awName = "";
                String awAddress1 = "";
                String awAddress2 = "";
                String awPhone = "";
                String mobileNo = "";
                String emailId = "";
                String entType = "";
                String entPin = "";
                int region = 0;
                int awEntityRID = 0;
                int isActive = 1;
                int mfgCatProdIndex = 0;
                String awcityname = "";
                String awstatename = "";


                int noOfShifts = 0;
                int shiftDuration = 0;
                int noOfLines = 0;
                int lineIsActive = 1;
                String lineCheckedStatus = "checked";

                boolean isCodeEditable = false;
                boolean canChangeEntityType = true;
                String command = "";


                String checkedStatus = "checked";
                ResultSet regRS = (ResultSet) request.getAttribute("regRS");
                ResultSet variantRS = (ResultSet) request.getAttribute("variantRS");
                ResultSet rs = (ResultSet) request.getAttribute("profileList");
                if (rs != null) {

                    rs.beforeFirst();
                    while (rs.next()) {
                        isCodeEditable = true;
                        canChangeEntityType = false;
                        awCode = rs.getString("ent_code") != null ? rs.getString("ent_code") : "";
                        awName = rs.getString("ent_name") != null ? rs.getString("ent_name") : "";
                        awAddress1 = rs.getString("ent_address1") != null ? rs.getString("ent_address1") : "";
                        awAddress2 = rs.getString("ent_address2") != null ? rs.getString("ent_address2") : "";
                        awEntityRID = rs.getInt("ent_rid");
                        awPhone = rs.getString("ent_phone") != null ? rs.getString("ent_phone") : "";
                        isActive = rs.getInt("ent_registered");
                        awcityname = rs.getString("ent_city") != null ? rs.getString("ent_city") : "";
                        awstatename = rs.getString("ent_state") != null ? rs.getString("ent_state") : "";
                        region = rs.getInt("ent_region_index");
                        mfgCatProdIndex = rs.getInt("ent_mfg_prod_cat_index");
                        entPin = rs.getString("ent_pin_code") != null ? rs.getString("ent_pin_code") : "";
                        checkedStatus = isActive == 1 ? "checked" : "";

                        // extra parameters need to show along with the profile informations                        

                        if (rs.getString("ent_mobile") != null) {
                            mobileNo = rs.getString("ent_mobile");
                        }


                        if (rs.getString("ent_mail") != null) {
                            emailId = rs.getString("ent_mail");
                        }

                        if (rs.getString("ent_type") != null) {
                            entType = rs.getString("ent_type");
                        }
                    }

                }

                if (!isCodeEditable) {
                    command = "insert";
                }
                String disableEntityStatus = "";

                boolean isManageProfile = false;
                if (null != request.getParameter("isManageProfile")) {
                    isManageProfile = Boolean.parseBoolean(request.getParameter("isManageProfile"));
                }

                if (isManageProfile) {
                    disableEntityStatus = "disabled";
                }

                //ResultSet plantShiftDetailsRS = (ResultSet) request.getAttribute("plantShiftDetails");
                ResultSet plantLineDetailsRS = (ResultSet) request.getAttribute("plantLineDetails");
                ResultSet plantCapacityDetailsRS = (ResultSet) request.getAttribute("plantCapacityDetails");
                ResultSet plantVariantDetailsRS = (ResultSet) request.getAttribute("plantVariantDetails");

               /* if (plantShiftDetailsRS != null && plantShiftDetailsRS.first()) {
                    noOfShifts = plantShiftDetailsRS.getInt("psd_no_of_shifts");
                    shiftDuration = plantShiftDetailsRS.getInt("psd_shift_time");
                }*/

                if (plantLineDetailsRS != null && plantLineDetailsRS.last()) {
                    noOfLines = plantLineDetailsRS.getRow();
                }

                String capacityDet = "";
                if (plantCapacityDetailsRS != null && plantCapacityDetailsRS.first()) {
                    plantCapacityDetailsRS.beforeFirst();
                    int capacityLineRid = 0, variantIndex = 0;
                    double capacityVal = 0, powerVal = 0, fuelVal = 0, labourVal = 0;
                    while (plantCapacityDetailsRS.next()) {
                        capacityLineRid = plantCapacityDetailsRS.getInt("rcd_line_rid");
                        variantIndex = plantCapacityDetailsRS.getInt("rcd_variant_index");
                        capacityVal = plantCapacityDetailsRS.getDouble("rcd_rated_capacity");
                        powerVal = plantCapacityDetailsRS.getDouble("rcd_std_power");
                        fuelVal = plantCapacityDetailsRS.getDouble("rcd_std_fuel_hsd");
                        labourVal = plantCapacityDetailsRS.getDouble("rcd_std_labour");
                        capacityDet += capacityLineRid + "~" + variantIndex + "~" + capacityVal + "~" + powerVal + "~" + fuelVal + "~" + labourVal + "," ;
                    }
                    if (!"".equals(capacityDet)) {
                        capacityDet = capacityDet.substring(0, capacityDet.length() - 1);
                    }
                }


    %>
    <input type="hidden" name="action" id="action" value="<%=command%>">
    <input type="hidden" name="awrid" id="awrid" value="<%=awRID%>">
    <input type="hidden" id="awEntityRID" name="awEntityRID" value="<%=awEntityRID%>">
    <input type="hidden" id="fuelDetString" name="fuelDetString" value="0~0~0,">

    <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" >
        <tr>
            <td valign="top" width="100%">
                <table width="100%" border="0" cellpadding="0" cellspacing="0" >
                    <tr valign="top">

                        <td>
                            <fieldset>
                                <legend><b>Profile Details</b></legend>
                                <table width="100%" border="0" cellpadding="2" cellspacing="0">
                                    <tr>
                                        <td >Entity Type</td>
                                        <td>
                                            <select class="selectheight" id="entType" name="entType" style="width:138px;" <%= canChangeEntityType ? "" : "disabled"%> onchange="awProfile.showHideSKUType(this.value)">
                                                <option value="FAC" <%if ("FAC".equals(entType)) {%>selected <%}%>>Factory</option>
                                                <%--<option value="DEP" <%if ("DEP".equals(entType)) {%>selected <%}%>>Depot</option>
                                                <option value="SUP" <%if ("SUP".equals(entType)) {%>selected <%}%>>Supplier</option>--%>
                                            </select>
                                            <span class="userInfo">*</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Code
                                        </td>
                                        <td><input name="code" id="code" type="text" maxlength="20" style="width:134px;" value="<%=awCode%>" <%= !isCodeEditable ? "" : "readonly"%> <%= isProfileEditable ? "" : "disabled"%> onkeypress="restrictInput(this,keybSplChars,event);">
                                            <span class="userInfo">*</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td >Region</td>
                                        <td>
                                            <select class="selectheight" id="region" name="region" style="width:138px;">
                                                <%
                                                            if (regRS != null && regRS.first()) {
                                                                regRS.beforeFirst();

                                                                while (regRS.next()) {
                                                %>
                                                <option value="<%=regRS.getInt("ent_rid")%>" <%if (regRS.getInt("ent_rid") == region) {%>selected <%}%>>
                                                    <%=regRS.getString("ent_name")%>
                                                </option>
                                                <%
                                                                }
                                                            }
                                                %>
                                            </select>
                                            <span class="userInfo">*</span>
                                        </td>
                                    </tr>
                                    <tr id="prodTypeTR" valign="top">
                                        <td >Variant</td>
                                        <td >
                                            <%
                                                        if (plantVariantDetailsRS != null && plantVariantDetailsRS.first()) {
                                                            plantVariantDetailsRS.beforeFirst();
                                                            int curVariantIndex = 0;
                                            %>
                                            <table width="100%" cellpadding="0" cellspacing="0" border="0" id="variantTab">
                                                <%
                                                                                                            while (plantVariantDetailsRS.next()) {
                                                                                                                curVariantIndex = plantVariantDetailsRS.getInt("pmv_variant_index");
                                                %>

                                                <tr valign="bottom">
                                                    <td id="variantCol" valign="bottom">
                                                        <select class="selectheight" id="prodType" name="prodType" style="width:350px;">
                                                            <option value="0"></option>
                                                            <%
                                                                                                                                                                            if (variantRS != null && variantRS.first()) {
                                                                                                                                                                                variantRS.beforeFirst();
                                                                                                                                                                                while (variantRS.next()) {
                                                            %>
                                                            <option value="<%=variantRS.getInt("dd_index")%>" <%if (variantRS.getInt("dd_index") == curVariantIndex) {%>selected <%}%>>
                                                                <%= variantRS.getString("dd_value") +  (variantRS.getString("dd_abbrv") != null && !"".equals(variantRS.getString("dd_abbrv")) ? " - " + variantRS.getString("dd_abbrv") : "") + " (" + variantRS.getString("parent_dd_value") + ")"%>
                                                            </option>
                                                            <%
                                                                                                                                                                                }
                                                                                                                                                                            }
                                                            %>
                                                        </select>
                                                        <span class="userInfo">*</span>
                                                        &nbsp;&nbsp;&nbsp;
                                                        <%
                                                                                                                                                                        if (plantVariantDetailsRS.isLast()) {
                                                        %>
                                                        <img alt="Add" src="<%= projPath%>/images/add.png" title="Add a new Variant"
                                                             onmouseover="this.style.cursor = 'pointer'" onmouseout="this.style.cursor = 'default'" onclick="awProfile.addVariant(this)"/>
                                                        <%
                                                                                                                                                                                                                                } else {
                                                        %>
                                                        <img alt="Delete" src="<%= projPath%>/images/delete.gif" title="Delete this Variant"
                                                             onmouseover="this.style.cursor = 'pointer'" onmouseout="this.style.cursor = 'default'" onclick="awProfile.deleteVariant(this)"/>
                                                        <%                                                                                                                        }
                                                        %>
                                                    </td>
                                                </tr>


                                                <%                                                            }
                                                %>
                                            </table>
                                            <%
                                                                                                    } else {

                                            %>
                                            <table width="100%" cellpadding="0" cellspacing="0" border="0" id="variantTab">
                                                <tr valign="bottom">
                                                    <td id="variantCol" valign="bottom">
                                                        <select class="selectheight" id="prodType" name="prodType" style="width:350px;">
                                                            <option value="0"></option>
                                                            <%
                                                                                                                        if (variantRS != null && variantRS.first()) {
                                                                                                                            variantRS.beforeFirst();

                                                                                                                            while (variantRS.next()) {
                                                            %>
                                                            <option value="<%=variantRS.getInt("dd_index")%>">
                                                                <%= variantRS.getString("dd_value") +  (variantRS.getString("dd_abbrv") != null && !"".equals(variantRS.getString("dd_abbrv")) ? " - " + variantRS.getString("dd_abbrv") : "") + " (" + variantRS.getString("parent_dd_value") + ")"%>
                                                            </option>
                                                            <%
                                                                                                                            }
                                                                                                                        }
                                                            %>
                                                        </select>
                                                        <span class="userInfo">*</span>
                                                        &nbsp;&nbsp;&nbsp;
                                                        <img alt="Add" src="<%= projPath%>/images/add.png" title="Add a new Variant"
                                                             onmouseover="this.style.cursor = 'pointer'" onmouseout="this.style.cursor = 'default'" onclick="awProfile.addVariant(this)"/>
                                                    </td>
                                                </tr>
                                            </table>
                                            <%
                                                        }
                                            %>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td >Name </td>
                                        <td>
                                            <input name="name" id="name" maxlength="100" size = "70" type="text" value="<%=awName%>" <%= isProfileEditable ? "" : "disabled"%> onkeypress="restrictInput(this,keybSplChars,event);">
                                            <span class="userInfo">*</span>
                                        </td>
                                    </tr>  


                                    <tr>
                                        <td >Address 1 </td>

                                        <td> <input name="address1" maxlength="255" id="address1" type="text"  size="70" value="<%=awAddress1%>" <%= isProfileEditable ? "" : "disabled"%> >
                                            <span class="userInfo">*</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td >Address 2 </td>

                                        <td> <input name="address2" maxlength="255" id="address2" type="text" size="70" value="<%=awAddress2%>" <%= isProfileEditable ? "" : "disabled"%> >
                                            <%--<span class="userInfo">*</span>--%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td >Pin No </td>
                                        <td>
                                            <input type="text" name="pinNo" id="pinNo" maxlength="100"  size="70" value="<%=entPin%>" <%= isProfileEditable ? "" : "disabled"%>>
                                            <%--<span class="userInfo">*</span>--%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td >City Name </td>
                                        <td><input type="text" name="aw_city_name" id="aw_city_name" maxlength="100"  size="70" value="<%=awcityname%>" <%= isProfileEditable ? "" : "disabled"%> >
                                    </tr>
                                    <tr>
                                        <td >State Name </td>
                                        <td><input type="text" name="aw_state_name" id="aw_state_name" maxlength="100" size="70" value="<%=awstatename%>" <%= isProfileEditable ? "" : "disabled"%> ></td>
                                    </tr>

                                    <tr>
                                        <td >Phone No </td>
                                        <td><input style="text-align: left" type="text" name="phone" id="phone" maxlength="15" value="<%=awPhone%>" <%= isProfileEditable ? "" : "disabled"%> onkeypress="return restrictInput(this, keybPhoneNumber, event);"></td>
                                    </tr>
                                    <tr>
                                        <td >Mobile No </td>
                                        <td><input type="text" name="mobileNo" id="mobileNo" maxlength="15" value="<%=mobileNo%>" <%= isProfileEditable ? "" : "disabled"%> onkeypress="return restrictInput(this, keybPhoneNumber, event);"></td>
                                    </tr>
                                    <tr>
                                        <td >Email-Id </td>
                                        <td><input type="text" name="emailId" id="emailId" maxlength="100" value="<%=emailId%>" <%= isProfileEditable ? "" : "disabled"%> ></td>
                                    </tr>

<!--                                    <tr>
                                        <td>
                                            No. of Shifts
                                        </td>
                                        <td>
                                            <input style="text-align: right" type="text" name="shifts" id="shifts" value="<//%= noOfShifts%>" size="6" <%= isProfileEditable ? "" : "disabled"%>  onkeypress="restrictInput(this,keybNumber);">
                                            <span class="userInfo">*</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Shift Duration
                                        </td>
                                        <td>
                                            <input style="text-align: right" type="text" name="shiftDuration" id="shiftDuration" value="<//%= shiftDuration%>" size="6" <%= isProfileEditable ? "" : "disabled"%>  onkeypress="restrictInput(this,keybNumber);">
                                            <span class="helpText">(hrs.)</span>
                                            <span class="userInfo">*</span>
                                        </td>
                                    </tr>-->
                                    <tr>
                                        <td>
                                            No. of Lines
                                        </td>
                                        <td>
                                            <input style="text-align: right" type="text" name="lines" id="lines" value="<%= noOfLines%>" size="6" <%= noOfLines > 0 ? "readOnly" : ""%>  onkeypress="restrictInput(this,keybNumber);" onchange="awProfile.addOrDeleteLines(this)">
                                            <span class="userInfo">*</span>
                                            &nbsp;&nbsp;&nbsp;
                                            <a id="ratedCapacityLink" href="#" onclick="awProfile.showRatedCapacity(this)"
                                               onmouseover="this.style.cursor = 'pointer', this.style.textDecoration = 'underline'" onmouseout="this.style.cursor = 'default', this.style.textDecoration = ''">
                                                Enter Rated Capacity
                                            </a>
                                            <input type="hidden" name="ratedCapacityDet" id="ratedCapacityDet" value="<%= capacityDet%>">
                                             &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            <a id="fuelsAllowedLink" href="#" onclick="awProfile.showFuelDetails(this)"
                                               onmouseover="this.style.cursor = 'pointer', this.style.textDecoration = 'underline'" onmouseout="this.style.cursor = 'default', this.style.textDecoration = ''">
                                                Fuels Allowed
                                            </a>
                                        </td>
                                    </tr>
                                    <tr id="lineDescTabRow">
                                        <td></td>
                                        <td >
                                            <div id="lineDescDiv" <%if (plantLineDetailsRS == null || !plantLineDetailsRS.first()) {%>style="display: none"<%}%>>
                                                <table cellpadding="2" cellspacing="2" border="0" style="" id="lineDescTab">
                                                    <tr class="specialRow">
                                                        <%if (plantLineDetailsRS != null && plantLineDetailsRS.first()) {%>
                                                        <td>

                                                        </td>
                                                        <%}%>
                                                        <td>
                                                            Name
                                                        </td>
                                                        <td>
                                                            Specification
                                                        </td>
                                                        <td>
                                                            Description
                                                        </td>
                                                        <td>
                                                            Is Active
                                                        </td>
                                                    </tr>
                                                    <%
                                                                if (plantLineDetailsRS != null && plantLineDetailsRS.first()) {
                                                                    plantLineDetailsRS.beforeFirst();
                                                                    String name = "", spec = "", desc = "";
                                                                    int rid = 0, lineNo = 0;
                                                                    while (plantLineDetailsRS.next()) {
                                                                        rid = plantLineDetailsRS.getInt("pml_rid");
                                                                        name = plantLineDetailsRS.getString("pml_name");
                                                                        spec = plantLineDetailsRS.getString("pml_specification");
                                                                        desc = plantLineDetailsRS.getString("pml_description");
                                                                        lineIsActive = plantLineDetailsRS.getInt("pml_is_active");
                                                                        lineNo = plantLineDetailsRS.getInt("pml_line_no");
                                                                        lineCheckedStatus = lineIsActive == 1 ? "checked" : "";
                                                    %>
                                                    <tr id="lineRows">
                                                        <%
                                                           if (plantLineDetailsRS.isLast()) {
                                                        %>
                                                        <td>
                                                            <img alt="Add" src="<%= projPath%>/images/add.png" title="Add another Line"
                                                                 onmouseover="this.style.cursor = 'pointer'" onmouseout="this.style.cursor = 'default'" onclick="awProfile.addNewPlantLine(this)"/>
                                                        </td>

                                                        <%
                                                                                                                                                                                        } else {
                                                        %>
                                                        <td>

                                                        </td>
                                                        <% }
                                                        %>
                                                        <td align="right">

                                                            <input type="text" id="lineNameText" name="lineNameText" value="<%= name%>" size="10">
                                                            <input type="hidden" name="lineNo" id="lineNo" value="<%= lineNo%>">
                                                            <input type="hidden" name="lineRid" id="lineRid" value="<%= rid%>">
                                                        </td>
                                                        <td>
                                                            <input type="text" size="35" name="specs" id="specs" value="<%= spec%>">
                                                        </td>
                                                        <td>
                                                            <input type="text" size="35" name="desc" id="desc" value="<%= desc%>">
                                                        </td>
                                                        <td>
                                                            <input type="checkbox" name="lineIsActive" id="lineIsActive" <%= lineCheckedStatus%> onclick="awProfile.setLineStatus(this)">
                                                            <input type="hidden" name="lineIsActiveHidden" id="lineIsActiveHidden" value="<%= lineIsActive%>">
                                                        </td>
                                                    </tr>
                                                    <%}
                                                    } else {
                                                    %>
                                                    <tr id="lineRows">
                                                        <td align="right">
                                                            <input type="text" id="lineNameText" name="lineNameText" value="Line 1" size="10">
                                                            <input type="hidden" name="lineNo" id="lineNo" value="1">
                                                            <input type="hidden" name="lineRid" id="lineRid" value="0">
                                                        </td>
                                                        <td>
                                                            <input type="text" size="35" name="specs" id="specs" value="">
                                                        </td>
                                                        <td>
                                                            <input type="text" size="35" name="desc" id="desc" value="">
                                                        </td>
                                                        <td>
                                                            <input type="checkbox" name="lineIsActive" id="lineIsActive" <%= lineCheckedStatus%> onclick="awProfile.setLineStatus(this)">
                                                            <input type="hidden" name="lineIsActiveHidden" id="lineIsActiveHidden" value="<%= lineIsActive%>">
                                                        </td>
                                                    </tr>
                                                    <%
                                                        }
                                                    %>
                                                </table>
                                            </div>
                                        </td>
                                    </tr>

                                    <%--Shiv, it will not allow to see isActive checkbox to entity itself --%>
                                    <%
                                                if (!isManageProfile) {
                                    %>
                                    <tr>
                                        <td colspan="2"> Is Active
                                            <input type="hidden" name="isActiveStatus" id="isActiveStatus" value="<%=isActive%>">
                                            <input type="checkbox" name="isActive" id="isActive" <%=checkedStatus%> onclick="awProfile.setStatus(this)" <%= disableEntityStatus%>>
                                        </td>
                                    </tr>
                                    <%}%>
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