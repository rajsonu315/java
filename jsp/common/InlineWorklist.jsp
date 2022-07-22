<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*,ubq.util.*,java.util.*" errorPage="" %>
<%
String projPath = request.getParameter("projPath");
%>

<div>
    <input type="hidden" name="jsFile" value="<%= projPath %>/js/base/Worklist.js">
    
    <input type="hidden" name="jsFile" value="<%= projPath %>/js/base/Common.js">
    
    <input type="hidden" id="currentDate" name="currentDate" value="<%= UDate.nowDisplayString()%>">

<table width="100%"  border="0" cellpadding="0" cellspacing="0">

  <tr>
    <td>
      <%--<table width="100%" height="100%"  border="0" cellpadding="0" cellspacing="0"  class="lhsMenuTable shadowTable" >--%>
      <table border="0" width="100%" height="100%"  border="0" cellpadding="0" cellspacing="0"  class="lhsMenuTable shadow" >

        <tr style="height:25px" class="lhsMenuHeader" >
            <td width="85%">
                &nbsp;Worklist for
                <a href="javascript:" id="worklistDateLink" name="worklistDateLink" 
                   onclick="newPopupCalender('worklistDate','worklistDateLink');" valign="bottom"
                   onfocus="newPopupCalender('worklistDate','worklistDateLink');" style="font-size:11px;color:white" tabindex="-1" >Today</a>
                
                <input type="hidden" id="worklistDate" name="worklistDate" value="<%= UDate.nowDisplayString()%>" 
                       onchange="boWorklist.addDaysToWorklistDate()" >
            </td>
          <td width="15%" align="center" class="cursorPoint" style="font-weight:normal;font-size:90%;cursor: pointer;">
              <img src="<%= projPath %>/images/refresh.png" height="15px" width="15px" 
                   onClick="boWorklist.refreshWorklistTable()" title="Refresh worklist"
                   onmouseover="this.style.borderStyle = 'solid';this.style.borderColor='green';"
                   onmouseout="this.style.borderStyle = 'none';"
                   >&nbsp;
          </td>
        </tr>

        <tr valign="top">
          <td colspan="2">
            <%@include file="/jsp/common/WorklistItems.jsp"%>
          </td>
        </tr>
      </table>
    </td>
  </tr>

  <tr><td>&nbsp;</td></tr>

</table>

</div>
