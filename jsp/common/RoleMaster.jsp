<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.text.*" import="java.util.*" import="ubq.base.*" errorPage="" %>
<%@ page pageEncoding="UTF-8"%>

<% String prjName = request.getContextPath();%>


<div style="width:100%;" name="workingDiv" id="workingDiv">

    <form name="roleMasterForm" id="roleMasterForm" method="post" action="<%=(String) request.getContextPath()%>/UMasterServlet"
          target="entryResponseFrame" onSubmit="return roleMaster.formValidateRole();" onKeyPress="setDirtyBit();">
        <input type="hidden" name="jsFile" value="<%= prjName%>/js/base/conConfig.js">
        <input type="hidden" name="jsFile" value="<%= prjName%>/js/base/RoleMaster.js">
        <input type="hidden" name="onLoadFunction" value="roleMaster.formInitRole()">
        <input type="hidden" name="successHandler" value="roleMaster.handleSuccess">
        <input type="hidden" name="failureHandler" value="roleMaster.handleFailure">
        <input type="hidden" name="reloadSuccessHandler" value="roleMaster.handleSuccessReload">

        <table width="100%" cellpadding="0" cellspacing="0" border="0">
            <tr>
                <td  ><span id="commonErrorMsg" class="userInfo"></span></td>
                <td width="5%" align="right">
                    <img src="images/Info.jpg" style="cursor:hand;" title="Info" onclick="showInfoDiv('Create/modify the Roles details.  \'*\' indicates mandatory fields.',event);">
                </td>
            </tr>
        </table>
        <table width="100%" border="0" cellspacing="2" cellpadding="0" >
            <!--            <tr>
                            <td>
                <table width="100%">
                        <tr>
                            <td width="99%"><label class="lineHeading">&nbsp </label></td>
                             <td width="1%" align="right">
                                <span class="infoButton" title="Information"
                                  onclick="showInfoDiv('Create/modfiy the Roles details. \'*\' indicates mandatory fields.',event);">&nbsp;i&nbsp;</span>
                            </td>
                        </tr>
                    </table>
                                   </td>
                        </tr>-->
            <tr> <td colspan="100%">
                      <fieldset>
                    <div style="width:100%; height:100%; overflow:auto;" >

                        <input type="hidden" name="command" id="command" value="saveRoleWithMesaage">

                        <%
                                    int roleRID = 0;
                                    String strRoleName = "";
                                    boolean isActive = true;

                                    ResultSet rs = (ResultSet) request.getAttribute("roleDetail");

                                    if (rs != null) {

                                        rs.next();

                                        roleRID = rs.getInt("role_rid");
                                        strRoleName = rs.getString("role_name");
                                        isActive = rs.getInt("role_valid") == 1;
                                    }
                        %>

                        <input type="hidden" name="roleRID" id="roleRID" value="<%= roleRID%>">

                        <table border="0" cellpadding="1" cellspacing="1" width="100%">

                            <tr>
                                <td colspan="2" class="smallLabel" height="20px">
                                    To add a new Role, enter data and click on the "Save" button.

                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" class="smallLabel" height="20px">
                                    To make changes to an existing Role, select a Role below, make changes,
                                    and then click on the "Save" button.
                                </td>
                            </tr>

                            <tr>
                                <td class="label" colspan="2" height="30px">
                                    Select Role

                                    <select style="width:200px" name="roleSelection" id="select" onChange="roleMaster.loadRole(this.value)">
                                        <option value="0">&nbsp;</option>
                                        <%
                                                    ResultSet rolesRS = (ResultSet) request.getAttribute("roles");

                                                    if (rolesRS != null) {

                                                        while (rolesRS.next()) {
                                                            if (rolesRS.getInt("role_rid") > 0) {
                                        %>
                                        <option value="<%= rolesRS.getInt("role_rid")%>"><%= rolesRS.getString("role_name")%></option>
                                        <%
                                                            }
                                                        }
                                                    }
                                        %>
                                    </select>
                                </td>
                            </tr>

                            <tr>
                            </tr>

                            <tr>
                                <td colspan="2"><hr ></td>
                            </tr>

                            <tr>
                                <td class="label" colspan="2">Role name&nbsp;&nbsp;

                                    <input type="text" name="roleName" id="roleName" value="<%= strRoleName%>" size="30" maxlength="80">
                                    <label name="roleNameMsg" id="roleNameMsg" class="userInfo"> *</label>
                                    <br>  <br>
                                </td>
                            </tr>

                            <tr>
                                <td class="label">Feature List</td>
                                <td class="label">Accessible Features</td>
                            </tr>

                            <tr>
                                <td class="boxShape" width="50%">
                                    <div style="overflow:auto; height:150px; valign:top">
                                        <table name="productFeatureTbl" id="productFeatureTbl" cellpadding="0">
                                            <%
                                                        ResultSet rs1 = (ResultSet) request.getAttribute("productFeatures");

                                                        if (rs1 != null) {

                                                            while (rs1.next()) {
                                                                //if(rs1.getInt("feature_group") == 0) {
%>
                                            <tr>
                                                <td class="smallLabel">

                                                    <input type="checkbox" name="productFeature" id="productFeature" value="<%= rs1.getInt("feature_rid")%>"><%= rs1.getString("feature_name")%>
                                                    <input type="hidden" name="productFeatureName" id="productFeatureName" value="<%= rs1.getString("feature_name")%>">
                                                </td>
                                            </tr>
                                            <%
                                                                                    //}

                                                                                }
                                            %>
                                        </table>
                                    </div>
                                </td>
                                <td class="boxShape" width="50%">
                                    <div style="overflow:auto; height:150px; valign:top">
                                        <table name="assignedFeatureTbl" id="assignedFeatureTbl" cellpadding="0" >
                                            <%
                                                                                ResultSet rs2 = (ResultSet) request.getAttribute("assignedFeatures");

                                                                                if (rs2 != null) {

                                                                                    while (rs2.next()) {
                                                                                        //if(rs2.getString("feature_group") == 0) {
%>
                                            <tr>
                                                <td class="smallLabel">
                                                    <input type="checkbox" name="assignedFeatureChk" id="assignedFeatureChk">
                                                    <input type="hidden" name="assignedFeature" id="assignedFeature" value="<%= rs2.getInt("feature_rid")%>">
                                                    <input type="text" name="assignedFeatureName" id="assignedFeatureName" style="border:0px;" readonly value="<%= rs2.getString("feature_name")%>">
                                                </td>
                                            </tr>
                                            <%
                                                                    //}
                                                                }
                                                            }
                                                        }
                                            %>

                                            <td class="smallLabel">
                                                <input type="checkbox" name="assignedFeatureChk" id="assignedFeatureChk">
                                                <input type="hidden" name="assignedFeature" id="assignedFeature" value="">
                                                <input type="text" name="assignedFeatureName" id="assignedFeatureName" value="" readonly style="border:0px;" >
                                            </td>

                                        </table>
                                    </div>
                                </td>
                            </tr>

                            <tr>
                                <td align="center">
                                    <input type="button" name="addFeatureBtn" id="addFeatureBtn" value="Add Selected" onClick="roleMaster.addFeatures()">
                                </td>
                                <td align="center">
                                    <input type="button" name="removeFeatureBtn" id="removeFeatureBtn" value="Remove Selected" onClick="roleMaster.removeFeatures()">
                                </td>

                            </tr>

                            <tr>
                                <td colspan="2" class="label"><input type="checkbox" name="isActive" <%= isActive ? "checked" : ""%> > &nbsp;Is Active</td>
                            </tr>

                            <tr>
                                <td colspan="2" width="100%"><hr /></td>
                            </tr>

                            <tr>
                                <td colspan="2" align="right">
                                    <input type="submit" value="Save" id= "saveBtn" name="saveBtn"> &nbsp;
                                    <input type="button" value="Clear" id="clearBtn" name="clearBtn" onClick="roleMaster.clearFormRole(true)">
                                </td>
                            </tr>

                        </table>
                    </div>
                              </fieldset>
                </td>
            </tr>
        </table>
        <iframe id=entryResponseFrame name=entryResponseFrame src="" width="0px" height="0px"></iframe>

    </form>
</div>

