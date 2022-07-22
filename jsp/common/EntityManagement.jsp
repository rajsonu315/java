<%-- 
    Document   : EntityManagement
    Created on : Dec 11, 2012, 5:46:31 PM
    Author     : saurabh
--%>

<%@ page pageEncoding="UTF-8" contentType="text/html; charset=iso-8859-1" language="java"
         import="java.sql.*" import="java.util.*" import="java.text.*" errorPage="" %>
<%
            String projPath = request.getContextPath();
            boolean isProfileEditable = true;
            boolean isManageProfile = false;
%>

<div>    
    <input type="hidden" name="jsFile" value="<%= projPath%>/js/assetUtlization/AWProfile.js">
    <form name="awprofile" id="awprofile" action="<%= projPath%>/EntityManagementServlet" method="Post" onsubmit="return awProfile.validateProfile();" target="myIframe">
        <input type="hidden" name="command" id="command" value="saveAWDetails">        
        <table width="100%" cellpadding="0" cellspacing="0" border="0">
            <tr>
                <td>
                    <fieldset>
                        <legend><b>Entity Profile</b></legend>
                        <table width="100%" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td>
                                    <div style="overflow:auto">
                                        <table align="right" border="0" cellpadding="0" cellspacing="2">
                                            <tr align="right">
                                                <td align="right"> Entity Type &nbsp;</td>
                                                <td>
                                                    <jsp:include page="/jsp/common/PartyFilter.jsp" flush="true" >
                                                        <jsp:param name="searchType" value="entity"/>                                                        
                                                    </jsp:include>
                                                </td>
                                                <td>
                                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                                </td>
                                                <td align="right">
                                                    <label> Search &nbsp;</label>
                                                    <input type="text" name="searchTxt" id="searchTxt">
                                                    <input type="button" name="search" value="..." onclick="awProfile.partyProfileSearch()">
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>                            
                            <tr>
                                <td>
                                    <div name="awProfileDiv" id="awProfileDiv" style="valign:top; overflow:auto">
                                        <jsp:include page="/jsp/common/Profile.jsp" flush="true">
                                            <jsp:param name="isProfileEditable" value="<%=isProfileEditable%>"/>
                                            <jsp:param name="projPath" value="<%=projPath%>"/>
                                            <jsp:param name="isManageProfile" value="<%=isManageProfile%>"/>
                                        </jsp:include>

                                    </div>
                                </td>
                            </tr>
                            <tr width="100%">
                                <td width="100%" align="right">
                                    <input name="saveBtn" id="saveBtn" type="submit" value="Save" class="buttonSize">                                 
                                    <input name="clearBtn" id="clearBtn" type="button" value="Clear" class="buttonSize" onclick="awProfile.clearEntityProfile();">
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                </td>
            </tr>
        </table>
        <iframe style="visibility: hidden;display:none;" name="myIframe" id="myIframe"> </iframe>
    </form>
</div>



