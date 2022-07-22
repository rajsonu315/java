<%@ page contentType="text/html; charset=iso-8859-1" import="java.util.*, ubq.util.*, ubq.base.*, ubq.appFramework.*" %>

<div>
    
    <input type="hidden" id="failureHandler" name="failureHandler" value="appFramework.handleFailure">
    <%
    String contentType = (String) request.getAttribute("contentType");
    URequestContext ctxt = (URequestContext) request.getAttribute("ctxt");
    String historyTrackingEnabled = (String) request.getAttribute("historyTrackingEnabled");


    int worklistType = ctxt.getIntParameter("worklistType");
    String taskArgs = "", worklistCode = ""; // TEST LINE!!

    int worklistIsManaged = 1;
    int worklistIsSnoozable = ctxt.getAttribute("isSnoozable") == null ? 0 : (Integer) ctxt.getAttribute("isSnoozable"); 

    String featureCode = ctxt.getAttribute("worklistFeatureCode") == null ? "" : String.valueOf(ctxt.getAttribute("worklistFeatureCode"));

    boolean isPopup = ctxt.getAttribute("isPopup") != null && Boolean.parseBoolean(ctxt.getAttribute("isPopup").toString());
    boolean hasActButtons = false;

    if(isPopup) {
    %>
    <input type="hidden" id="successHandler" name="successHandler" value="appFramework.handlePopupSuccess">
    <%
    } else {
    %>
    
    <input type="hidden" id="successHandler" name="successHandler" value="appFramework.handleSuccess">
    <%
    }
    %>
    
    <%
    String actionCode = ctxt.getParameter("actionCode");
    
    String boCode = ctxt.getParameter("boCode");
   // int boRID = ctxt.getIntParameter("boRID");
    int boRID = ((Integer)request.getAttribute("boRID")).intValue();
    int boWorklistRID = ctxt.getIntParameter("wliRID");
    int timerFlag = ctxt.getIntParameter("timerFlag");
    int hidTrackDelays = ctxt.getIntParameter("hidTrackDelays");
            
    String url = "/BOServlet?command=includeView&boRID=" + boRID + "&actionCode=" + actionCode;
    
    boolean showInWell = ctxt.getParameter("showInWell") == null || ctxt.getIntParameter("showInWell") == 1;
    
    int worklistRID = ctxt.getIntParameter("worklistRID");
    
    %>
    <%
        if("multipart/form-data".equals(contentType)) {
    %>
        <form name="BOContainerForm" enctype="multipart/form-data" id="BOContainerForm" action="BOServlet" method="post" target="dataEntryResponse">        
    <%
        } else {
    %>
        <form name="BOContainerForm"  id="BOContainerForm" action="BOServlet" method="post" target="dataEntryResponse">
    <%
        }
    
    %>            
        <input type="hidden" id="boCode" name="boCode" value="<%= boCode%>">
        <input type="hidden" id="boRID" name="boRID" value="<%= boRID%>">
        <input type="hidden" id="actionCode" name="actionCode" value="">
        <input type="hidden" id="command" name="command" value="doBOAction">
        <input type="hidden" id="worklistRID" name="worklistRID" value="<%= worklistRID%>">
         <input type="hidden" id="boWorklistRID" name="boWorklistRID" value="<%= boWorklistRID%>">

         <input type="hidden" id="featureCode" name="featureCode" value="<%= featureCode %>" >

         <input type="hidden" id="worklistIsManaged" name="worklistIsManaged" value="<%= worklistIsManaged %>" >
         <input type="hidden" id="worklistIsSnoozable" name="worklistIsSnoozable" value="<%= worklistIsSnoozable %>" >

         <input type="hidden" id="snoozeTxt" name="snoozeTxt" value="0">
         <input type="hidden" id="snoozeTxtType" name="snoozeTxtType" value="0">
    
        <table width="100%" cellpadding="0" cellspacing="0" border="0">
<%--            <%
            if(showInWell) {
            %>
            <tr height="30px" class="wellHeader"><td valign="top"><div id="desktopWellHeaderDiv"></div></td></tr>
            <%
            }
            %>--%>
            <tr>
                <td>
                    <table width="100%" <%--<%= (showInWell) ? "class=boxShape" : "" %>--%> cellpadding="0" cellspacing="0">
                        <tr>
                            <td>
                                <div>
                                    <jsp:include flush="true" page="<%= url %>" />
                                </div>
                            </td>
                        </tr>
                        
                        <tr><td><%--<hr>--%></td></tr>
                        
                        
                        <tr id="actionsTR">
                            <td align="right" id="actionableBtnCell">
                                <%
                                if(worklistType == BOWorklistManager.FYI) {
                                %>
                                
                                <input type="button" value="Mark as Seen" onclick="appFramework.doBOAction('MARK_AS_SEEN', this)">&nbsp;
                                
                                <%
                                } else if(worklistType == BOWorklistManager.ACTIONABLE || worklistType == 0) {
        
                                    Vector actions = (Vector) ctxt.getAttribute("permittedActions");


                                    for(int i = 0; i < actions.size(); i++) {

                                        String[] a = (String[]) actions.get(i);

                                        String code = a[0];
                                        String name = a[1];

                                        if(BOAction.BUILTIN_ACTION.equals(code))
                                            continue;
                                        hasActButtons = true;
                                %>

                                <input type="button" value="<%= name%>" id="actionBtn<%=code%>" name="actionBtn<%=code%>"
                                       onclick="appFramework.doBOAction('<%= code%>', this)"
                                       class="<%= (timerFlag == 0 && boRID > 0 && (hidTrackDelays == 1)) ? "hidden":""%>">&nbsp;
                                <%
                                        
                                    }
        
                                }
                                %>

                                <% if (worklistType == BOWorklistManager.ACTIONABLE
                                        && worklistIsSnoozable == 1) { %>
                                <input type="button" value="Snooze" onclick="worklistSnooze.openWorklistSnoozeDiv(this, event)" >
                                <% } %>

                                <%
                                if(worklistType != BOWorklistManager.FOLLOWUP) {
                                %>
                                <input type="reset" id="clearBtn" value="Clear" onclick="appFramework.handleOnClear()">&nbsp;
                                <%
                                }
                                if(ctxt.getIntParameter("featureRID") == 0 && isPopup) { %>
                                <input type="button" value="Close" onclick="desktop.closePopup();" > &nbsp;
                                <% } else if(ctxt.getIntParameter("featureRID") == 0 && !isPopup){%>

                                <input type="button" value="Close" onclick="desktop.closeInset(dynTableGetTable(dynTableRow(dynTableGetTable(this))))" > &nbsp;
                                <% } %>
                            </td>
                        </tr>
                        <tr id="showHistoryLinkTR">
                            <td>&nbsp;

                                <%
                                if("1".equals(historyTrackingEnabled)) {
                                %>
                                <span id="showHistoryLinkSpn"><a class="clickMe" id="showHistoryLink" onclick="appFramework.showTransitionLog();">Show history</a></span>&nbsp;
                                <% } %>

                                <%
                                if(worklistType != BOWorklistManager.FYI && hasActButtons  && boRID > 0 && (hidTrackDelays == 1)) {
                                %>
                                <input type="button" id="stopTimer" name="stopTimer" value="Stop timer" onclick="boWorklist.enableOrDisableActionableButtons(true)" class="<%= timerFlag == 0 ? "":"hidden"%>">
                                <input type="button" id="startTimer" name="startTimer" value="Resume timer"  class="<%= timerFlag == 1 ? "":"hidden"%>" onclick="boWorklist.enableOrDisableActionableButtons(false)">
                                <% } %>



                            </td> 
                        </tr>
                        <%
                        if("1".equals(historyTrackingEnabled)) {
                        %>
                        <tr>
                            <td class="hidden" id="transitionLogView">
                                <jsp:include flush="true" page="../appFramework/BOTransitionLog.jsp" />
                            </td>
                        </tr>
                        <%
                        }
                        %>
                    </table> 
                </td>
            </tr>
            
        </table>
    </form>
    
    <iframe name="dataEntryResponse" id="dataEntryResponse" width="0" height="0" style="visibility:hidden">
    </iframe>
    
</div>

<div id="snoozeSpanSmallDiv" class="hidden">
    <%@include file="../common/WorklistSnoozeSpanSelection.jsp"%>
</div>
