<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" errorPage="" %>
<%@page pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<% String prjName = request.getContextPath();%>


<div style="width:100%;" id="workingDiv" >
    <form name="userMasterForm" id="userMasterForm" method="post" action="<%= prjName%>/UMasterServlet"
          target="entryResponseFrame" <%--onSubmit="userMaster.formValidateUser();"--%>>
        <input type="hidden" name="command" id="command" value="saveUsersWithMesaage">
        <input type="hidden" name="jsFile" value="<%= prjName%>/js/base/conConfig.js">
        <input type="hidden" name="jsFile" value="<%= prjName%>/js/base/RoleMaster.js">
        <input type="hidden" name="jsFile" value="<%= prjName%>/js/base/UserMaster.js">
        <input type="hidden" name="jsFile" value="<%= prjName%>/js/base/UserAppList.js">
        <input type="hidden" name="onLoadFunction" value="userMaster.formInitUser()">
        <input type="hidden" name="successHandler" value="userMaster.handleSuccess">
        <input type="hidden" name="failureHandler" value="userMaster.handleFailure">
        <input type="hidden" name="reloadSuccessHandler" value="userMaster.handleSuccessReload">

<input type="hidden" name="jsFile" value="<%= prjName%>/js/report/common.js">

        <%
                    int userRID = 0;
                    int userEntityRID = 0;
                    String userFullName = "";
                    String userLoginId = "";
                    String emailId = "";
                    boolean isActive = true;
                    int eRid = ((Integer)request.getAttribute("eRid")).intValue();
                    ResultSet rs = (ResultSet) request.getAttribute("userDetails");

                    if (rs != null) {

                        rs.next();

                        userRID = rs.getInt("user_rid");
                        userEntityRID = rs.getInt("user_entity_rid");
                        userFullName = rs.getString("user_full_name");
                        userLoginId = rs.getString("user_id");
                        if (userLoginId == null || userLoginId.trim().equalsIgnoreCase("null")) {
                            userLoginId = "";
                        }
                        emailId = rs.getString("user_email");
                        if (emailId == null || emailId.equalsIgnoreCase("null")) {
                            emailId = "";
                        }

                        isActive = rs.getInt("user_valid") == 1;
                    }
                    if (userEntityRID == 0) {
                        userEntityRID = Integer.parseInt(session.getAttribute("userEntityRID") + "");
                    }
        %>
        <input type="hidden" name="userEntityRID" id="userEntityRID" value="<%= userEntityRID%>">
        <input type="hidden" name="userRID" id="userRID" value="<%= userRID%>">
        <input type="hidden" name="eRid" name="eRid" value="<%=eRid%>">
        <table width="100%" cellpadding="0" cellspacing="0" border="0">
            <tr>
                <td  ><span id="commonErrorMsg" class="userInfo"></span></td>
                <td width="5%" align="right">
                    <img src="images/Info.jpg" style="cursor:hand;" title="Info" onclick="showInfoDiv('Create/modify the User details.  \'*\' indicates mandatory fields.',event);">
                </td>
            </tr>
        </table>
        <table width="100%" border="0" cellspacing="0" cellpadding="2" >
            <tr>
                <td colspan="100%">
                     <fieldset>




                                <table width="100%" border="0" cellpadding="1" cellspacing="1">

                                    <tr>
                                        <td colspan="2" class="smallLabel" height="20px">
                                            To make changes to an existing User record, search for the User, make changes,
                                            and then click on the "Save" button.
                                        </td>
                                    </tr>

                                    <tr>
                                        <td class="label">
                                            Select Location
                                        </td>

                                        <td class="label">
                                            Select User
                                        </td>
                                    </tr>

                                    <tr>
                                        <td class="label">
                                            <select style="width:200px;" name="entityRID" id="entityRID" onChange="userMaster.loadUsers(this.value)">
                                                <option value="0">&nbsp;</option>
                                                <%
                                                            ResultSet entRS = (ResultSet) request.getAttribute("entities");

                                                            if (entRS != null) {

                                                                while (entRS.next()) {
                                                %>
                                                <option value="<%= entRS.getInt("ent_rid")%>"><%= entRS.getString("ent_name")%></option>
                                                <%
                                                                }
                                                            }
                                                %>
                                            </select>
                                        </td>

                                        <td class="label">
                                            <%
                                                        ResultSet empUsersRS = (ResultSet) request.getAttribute("empUsersRS");
                                                        ResultSet userRS = (ResultSet) request.getAttribute("sysUsers");
                                                        while (empUsersRS != null && empUsersRS.next()) {
                                            %>
                                            <input type="hidden" name="empName" id="empName" value="<%=empUsersRS.getString("user_id")%>">
                                            <%}%>
                                            <select style="width:200px" name="userSelection" id="userSelection" onChange="userMaster.loadUserDetails(this.value)">
                                                <option value="0">&nbsp;</option>
                                                <%
                                                            while (userRS != null && userRS.next()) {
                                                %>
                                                <option value="<%=userRS.getInt("USER_RID")%>"><%=userRS.getString("user_full_name")%>
                                                    <%   }%>
                                            </select>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td colspan="2"><hr /></td>
                                    </tr>

                                    <%
                                                if (userRID == 0) {
                                    %>
                                    <tr valign="top">
                                        <td colspan="2" class="smallLabel"  >
                                            To add a new User, enter data below and click on the "Save" button.

                                        </td>
                                    </tr>
                                    <%                        } else {
                                    %>

<!--                                    <tr>
                                        <td colspan="2" class="smallLabel">
                                            To grant access to an employee,click on search button ("...") and select from the list<br><br>
                                        </td>
                                    </tr>-->
                                    <% }
                                    %>
                                    <tr>
                                        <td width="30%">User name</td>
                                        <td width="70%"><input type="text" name="userName" id="userName" size="30" value="<%= userFullName%>">
                                            <label class="userInfo" id="userFullNameMsg" name="userFullNameMsg">*</label>   </td>
                                    </tr>

                                    <tr>
                                        <td class="label">User Login ID

                                        </td>
                                        <td class="myLabel"> <input type="text" name="userLoginId" id="userLoginId" size="30" value="<%= userLoginId%>"><label  class="userInfo" name="userIdMsg" id="userIdMsg">&nbsp;*</label></td>
                                    </tr>

                                    <tr>
                                        <td class="label">Email ID</td>
                                        <td class="label"> <input type="text" name="userEmailId" id="userEmailId" size="30" value="<%= emailId%>">
                                            <label class="userInfo" name="userEmailIdMsg" id="userEmailIdMsg"></label></td>
                                    </tr>

                                    <tr>
                                        <td colspan="2">
                                            <table width="100%" cellpadding="1" cellspacing="1" border="0">
                                                <tr>
                                                    <td class="tableHeader_black">All Roles</td>
                                                    <td class="tableHeader_black">Assigned Roles <label class="userInfo" id="userRolesMsg">*</label></td>
                                                </tr>
                                                <tr>
                                                    <td class="boxShape" width="50%">
                                                        <div style="overflow:auto; height:120px; valign:top">
                                                            <table name="systemRolesTbl" id="systemRolesTbl" cellpadding="0" cellspacing="0">
                                                                <%
                                                                            ResultSet rs1 = (ResultSet) request.getAttribute("roles");

                                                                            if (rs1 != null) {

                                                                                while (rs1.next()) {

                                                                                    if (rs1.getInt("role_rid") > 0) {
                                                                %>
                                                                <tr>
                                                                    <td class="label">
                                                                        <input type="checkbox" name="role" id="role" value="<%= rs1.getInt("role_rid")%>"><%= rs1.getString("role_name")%>
                                                                        <input type="hidden" name="roleName" id="roleName" value="<%= rs1.getString("role_name")%>">
                                                                    </td>
                                                                </tr>
                                                                <%
                                                                                    }
                                                                                }
                                                                            }
                                                                %>
                                                            </table>
                                                        </div>
                                                    </td>
                                                    <td class="boxShape" width="50%">
                                                        <div style="overflow:auto; height:120px; valign:top">
                                                            <table name="assignedRolesTbl" id="assignedRolesTbl" cellpadding="0" cellspacing="0">
                                                                <%
                                                                            ResultSet rs2 = (ResultSet) request.getAttribute("userRoles");

                                                                            if (rs2 != null) {

                                                                                while (rs2.next()) {
                                                                %>
                                                                <tr>
                                                                    <td class="label">
                                                                        <input type="checkbox" name="assignedRoleChk" id="assignedRoleChk">
                                                                        <input type="hidden" name="assignedRole" id="assignedRole" value="<%= rs2.getInt("role_rid")%>">
                                                                        <input type="text" name="assignedRoleName"  id="assignedRoleName" style="border:0px;" readonly value="<%= rs2.getString("role_name")%>">
                                                                    </td>
                                                                </tr>
                                                                <%
                                                                                }
                                                                            }
                                                                %>
                                                                <tr>
                                                                    <td class="label">
                                                                        <input type="checkbox" name="assignedRoleChk" id="assignedRoleChk">
                                                                        <input type="hidden" name="assignedRole" id="assignedRole" value="">
                                                                        <input type="text" name="assignedRoleName" id="assignedRoleName" readonly value=""  style="border:0px;" >
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">
                                            <input type="button" name="addRoleBtn" id="addRoleBtn" value="Add Selected" onClick="userMaster.addRolesUser()">
                                        </td>
                                        <td align="center">
                                            <input type="button" name="removeRoleBtn" id="removeRoleBtn" value="Remove Selected" onClick="userMaster.removeRoles()">
                                        </td>

                                    </tr>


                                    <%
                                                if (userRID > 0) {
                                    %>
                                    <tr>
                                        <td colspan="2" class="label"><input type="checkbox" name="emptyPassword" id="emptyPassword"> &nbsp;Set empty password</td>
                                    </tr>
                                    <%                            }
                                    %>
                                    <tr>
                                        <td colspan="2" class="label"><input type="checkbox" name="isActive" <%= isActive ? "checked=\"checked\"" : ""%>> &nbsp;Is Active</td>
                                    </tr>

                                    <tr>
                                        <td colspan="2" width="100%"><hr /></td>
                                    </tr>

                                    <tr>
                                        <td colspan="2" align="right">
                                            <%--<input type="submit" value="Save" id="saveBtn" name="saveBtn"> --%>
                                            <input type="button" value="Save" name="save" id="saveBtn" onclick="userMaster.saveUserDetails();">&nbsp;
                                            <input type="button" value="Clear" name="clearBtn" id="clearBtn" onClick="userMaster.clearFormUser(true)">
                                        </td>
                                    </tr>
                                </table>

                                             </fieldset>
                </td>
            </tr>
        </table>

        <iframe style="visibility:hidden" id=entryResponseFrame name=entryResponseFrame src="" height="0" width="0"></iframe>

    </form>
</div>

