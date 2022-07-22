<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="ubq.util.*" import="java.util.*" import="ubq.base.*" errorPage="" %>
<%@page pageEncoding="UTF-8"%>

<%--
<html>
    <% String projPath = request.getContextPath(); %>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<frameset rows="50,30,*" cols="*" frameborder="0" border="0" bordercolor="#4A4A4C">
  <frame src="<%= projPath %>/jsp/common/scmBanner.jsp" name="banner" scrolling="no" noresize frameborder="0" allowtransparency>
  <frame src="<%= projPath %>/jsp/common/scmActivity.jsp" name="activityFrame" scrolling="NO" noresize frameborder="0" allowtransparency>
  
  <frameset rows="*" cols="17%,*" frameborder="0" border="0" bordercolor="#4A4A4C">
    <!--<frame src="<%= projPath %>/jsp/common/scmMenuItems.jsp" name="menuFrame" scrolling="NO" noresize frameborder="0" allowtransparency> -->
    <frame src="<%= projPath %>/SCMMasterServlet?command=loadAccessibleCommands" name="menuFrame" scrolling="NO" noresize frameborder="0" allowtransparency>
    <!--<frame src="<%= projPath %>/TargetViewServlet" name="blankFrame" scrolling="NO" frameborder="0" allowtransparency> -->
    <frame src="<%= projPath %>/SCMDashBoard" name="blankFrame" scrolling="NO" frameborder="0" allowtransparency>
    
  </frameset>	
</frameset><noframes></noframes>

<body>
</body>
</html>
--%>

<% 
    String projPath = request.getContextPath();
//    String chartUrl = "/SCMDashBoard";
//    String loginRoutinesUrl = "/Welcome?command=loginRoutines";
%>
<div>
    <input type="hidden" name="jsFile" value="<%= projPath%>/js/base/xmlHelper.js">
    <input type="hidden" name="jsFile" value="<%= projPath%>/js/base/ValidateFunction.js">
    <input type="hidden" name="cssFile" value="<%=projPath%>/style/UbqApp.css">
    
    <input type="hidden" name="jsFile" value="<%=projPath%>/js/base/SCMWelcome.js">
    <input type="hidden" name="jsFile" value="<%=projPath%>/js/common/DataUploadUtilities.js">
    <input type="hidden" name="jsFile" value="<%=projPath%>/js/common/DBActivityUtils.js">
    
    <input type="hidden" name="onLoadFunction" value="scmWelcome.welcomeUser();">
    
    <table>
        <tr valign="top">
            <td width="55%">
                <div id="chartDiv"></div>
            </td>
            <td width="45%">
                <div id="appLoadActivitiesDiv"></div>
            </td>
        </tr>
        <tr>
            <td><a style="" id="continueLink" href="#" onclick="scmWelcome.loadNextPage();"><b></b></a>
            </td>
        </tr>
    </table>
</div>
