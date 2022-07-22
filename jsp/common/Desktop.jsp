<%@ page contentType="text/html; charset=iso-8859-1" language="java"  errorPage="" %>
<%@ page pageEncoding="UTF-8" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
            String prjName = request.getContextPath();
            String projPath = prjName;
            String defaultFeature = request.getAttribute("defaultFeature") != null ? request.getAttribute("defaultFeature").toString() : "";
//added by pushpanjali
            String userEntityName = session.getAttribute("userEntityName").toString();
            String userEntityCode = session.getAttribute("userEntityCode").toString();
            String userID = session.getAttribute("userID").toString();
            int entityRID = Integer.parseInt(session.getAttribute("userEntityRID").toString());
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link id="<%= prjName%>/style/UbqApp.css" href="<%= prjName%>/style/UbqApp.css" rel="stylesheet" type="text/css">
        <link id="<%= prjName%>/js/calendar/calendar-uhealth.css" href="<%= prjName%>/js/calendar/calendar-uhealth.css" rel="stylesheet" type="text/css" media="all" title="blue" />
        <SCRIPT id="<%= prjName%>/js/base/xmlHelper.js" language="Javascript" src="<%= prjName%>/js/base/xmlHelper.js"></SCRIPT>
        <SCRIPT id="<%= prjName%>/js/base/HashTable.js" language="Javascript" src="<%= prjName%>/js/base/HashTable.js"></SCRIPT>
        <SCRIPT id="<%= prjName%>/js/base/Desktop.js" language="Javascript" src="<%= prjName%>/js/base/Desktop.js"></SCRIPT>
        <SCRIPT id="<%= prjName%>/js/base/Attachment.js" language="Javascript" src="<%= prjName%>/js/base/Attachment.js"></SCRIPT>
        <!--SCRIPT id="<%= prjName%>/js/base/FCKeditor/fckeditor.js" language="Javascript" src="<%= prjName%>/js/base/FCKeditor/fckeditor.js"></script-->
        <script>
            var PROJECT_CTXT_PATH = "<%= prjName%>";
            var PROJ_CTXT_PATH = PROJECT_CTXT_PATH;
            var prjName = PROJECT_CTXT_PATH;
           
            // Commenting now since it is not implemented every where. Need to enable later
            function waitLoading() {
                var loadingImageDiv = document.getElementById('loadingImageDiv');
                if(loadingImageDiv!=null){
                    loadingImageDiv.style.visibility = "visible";                    
                }  
            }

            // Commenting now since it is not implemented every where. Need to enable later
            function pageLoaded() {               
                var loadingImageDiv = document.getElementById('loadingImageDiv');
                if(loadingImageDiv!=null){
                    loadingImageDiv.style.visibility = "hidden";
                }                      
            }
           
        </script>

        <%--Sortable.js should be included before actb.js --%>
        <!--SCRIPT id="<%= prjName%>/js/base/sorttable.js" language="Javascript" src="<%= prjName%>/js/base/sorttable.js"></script-->
        <SCRIPT id="<%= prjName%>/js/base/Common.js" language="Javascript" src="<%= prjName%>/js/base/Common.js"></SCRIPT>
        <SCRIPT id="<%= prjName%>/js/base/CalendarPopup.js" language="Javascript" src="<%= prjName%>/js/base/CalendarPopup.js"></SCRIPT>
        <SCRIPT id="<%= prjName%>/js/calendar/calendar.js" language="Javascript" src="<%= prjName%>/js/calendar/calendar.js"></SCRIPT>
        <SCRIPT id="<%= prjName%>/js/calendar/lang/calendar-en.js" language="Javascript" src="<%= prjName%>/js/calendar/lang/calendar-en.js"></SCRIPT>
        <SCRIPT id="<%= prjName%>/js/calendar/calendar-setup.js" language="Javascript" src="<%= prjName%>/js/calendar/calendar-setup.js"></SCRIPT>
        <SCRIPT id="<%= prjName%>/js/base/ValidateFunction.js" language="Javascript" src="<%= prjName%>/js/base/ValidateFunction.js"></SCRIPT>
        <SCRIPT id="<%= prjName%>/js/base/UbqValidations.js" language="Javascript" src="<%= prjName%>/js/base/UbqValidations.js"></SCRIPT>
        <SCRIPT id="<%= prjName%>/js/base/HelpMsg.js" language="Javascript" src="<%= prjName%>/js/base/HelpMsg.js"></SCRIPT>
        <SCRIPT id="<%= prjName%>/js/base/RestrictInputFunction.js" language="Javascript" src="<%= prjName%>/js/base/RestrictInputFunction.js"></SCRIPT>
        <SCRIPT id="<%= prjName%>/js/base/actb/actb.js" language="Javascript" src="<%= prjName%>/js/base/actb/actb.js"></SCRIPT>
        <SCRIPT id="<%= prjName%>/js/base/actb/common.js" language="Javascript" src="<%= prjName%>/js/base/actb/common.js"></SCRIPT>
        <SCRIPT id="<%= prjName%>/js/base/BrowserAbstraction.js" language="Javascript" src="<%=prjName%>/js/base/BrowserAbstraction.js"></SCRIPT>
        <SCRIPT id="<%= prjName%>/js/base/TableKeyboardHandler.js" language="Javascript" src="<%=prjName%>/js/base/TableKeyboardHandler.js"></SCRIPT>
        <SCRIPT id="<%= prjName%>/js/base/DynamicTableTemplate.js" language="Javascript" src="<%= prjName%>/js/base/DynamicTableTemplate.js"></SCRIPT>
        <SCRIPT id="<%= prjName%>/js/base/Util.js" language="Javascript" src="<%= prjName%>/js/base/Util.js"></SCRIPT>
        <SCRIPT id="<%= prjName%>/js/base/Paging.js" language="Javascript" src="<%= prjName%>/js/base/Paging.js"></SCRIPT>
        <SCRIPT id="<%= prjName%>/js/report/common.js" language="Javascript" src="<%= prjName%>/js/report/common.js"></SCRIPT>
        <!-- Added by Saurabh For Making SFA compatible for firefox and ie 8 and 9 -->
        <SCRIPT id="<%= prjName%>/js/report/common.js" language="Javascript" src="<%= prjName%>/js/base/autoSearch.js"></SCRIPT>
        <SCRIPT id="<%= projPath%>/js/base/TableSearch.js" language="Javascript" src="<%= projPath%>/js/base/TableSearch.js"></SCRIPT>
        <!-- added by suhas to enable boFramework -->
        <SCRIPT id="<%= prjName%>/js/appFramework/AppFramework.js" language="Javascript" 
        src="<%= prjName%>/js/appFramework/AppFramework.js"></SCRIPT>

        <SCRIPT id="<%= prjName%>/js/appFramework/BOWorklist.js" language="Javascript" 
        src="<%= prjName%>/js/appFramework/BOWorklist.js"></SCRIPT>

        <SCRIPT id="<%= prjName%>/js/appFramework/DelayedTasks.js" language="Javascript" 
        src="<%= prjName%>/js/appFramework/DelayedTasks.js"></SCRIPT>

        <SCRIPT id="<%= prjName%>/js/appFramework/Notification.js" language="Javascript" 
        src="<%= prjName%>/js/appFramework/Notification.js"></SCRIPT>

        <SCRIPT id="<%= prjName%>/js/appFramework/UserTasks.js" language="Javascript" 
        src="<%= prjName%>/js/appFramework/UserTasks.js"></SCRIPT>

        <SCRIPT id="<%= prjName%>/js/appFramework/Worklist.js" language="Javascript" 
        src="<%= prjName%>/js/appFramework/Worklist.js"></SCRIPT>

        <title>Production Management and Information System</title>
        <script>
            
            function desktopInit() {
                var defaultFeature = document.getElementById('defaultFeature').value;
                var height = document.documentElement.clientHeight;//.clientHeight;
                var divHeight = Math.round(Number(height) * (65/100));
                document.getElementById('desktopWell').style.height = divHeight + "px";
                boWorklist.refreshWorklistTable();
                if(defaultFeature != ''){
                    desktop.loadPage(defaultFeature, 'Desktop Welcome');
                }else{
                    desktop.hideBusyMessage();
                }
                //getServerDowntime();
            }
             
        </script>
    </head>
    <body class="bodyBackground"   onload="desktopInit()" onunload="desktop.handlePageUnload()" onkeydown="desktop.handleKeyDown();desktop.handleBackspace(event);" onmouseup="desktop.stopPopup()" onmousemove="desktop.movePopup(event)" >
        <input type="hidden" name="defaultFeature" id="defaultFeature" value="<%=defaultFeature%>">
        
        <input type="hidden" name="selectedFeatureCommand" id="selectedFeatureCommand" value="">
        <input type="hidden" name="selectedFeatureName" id="selectedFeatureName" value="">
        <div name="desktopPopupWell" id="desktopPopupWell" style="border: 1">

        </div>

        <div name="loadingDiv" id="loadingDiv" style="position:absolute;height:50px; display:none; ">
            <br><span class=loadingMessage >&nbsp;Loading... Please wait...&nbsp;&nbsp;</span>
        </div>

        <%@ include file="/jsp/common/HelpMsg.jsp"%>
        <iframe name="desktopMessageIFrame" id="desktopMessageIFrame" style="position: absolute; display:none; width:300px; height:50px;z-index:1;left:40%;top:40%;">    
        </iframe>      

        <div name="desktopMessageDiv" id="desktopMessageDiv" style=" display:none; width:295px; height:45px;z-index:2;left:40.1%;top:40.2%; 
             position: absolute; background-color: #FFFF66; font-weight: bold; font-family: Arial, Helvetica, sans-serif ;
             text-align: center ; border: #666666 1px solid ;" >
            <table  width="100%" height="100%" border="0" cellpadding="3" cellspacing="0" >
                <tr> 
                    <td valign="middle" align="center"><span name="desktopMessageSpan" id="desktopMessageSpan">Loading. Please wait..</span></td>
                </tr>
                <tr name="desktopProgressBar" id="desktopProgressBar">
                    <td  align="center">
                        <img src="images/busy.gif" width="100px" height="12px">
                    </td>
                </tr>
            </table>
        </div>


        <table border="0" cellpadding="0" cellspacing="0" width="100%" name="skeletonTable" id="skeletonTable">
            <tr>
                <td colspan="100%" bgcolor="#FFFFF" valign="top" style="background-image: url('images/new_banner_fade.jpg'); background-position: right; background-repeat: no-repeat">
                    <%@include file="../common/Banner.jsp"%>
                </td>
            </tr>

            <tr>
                <%--<td ><%@include file="../common/ActivityDesc.jsp"%></td>--%>
                <td colspan="3"> <%@include file="../common/ActivityDhtmlMenus.jsp"%></td>
            </tr>
            <tr>
                <!-- @suhas -->
                <td  valign="top" colspan="3">
                    <div style="width: 20%;float: left">
                    <table width="100%" height="100%"  border="0" cellpadding="0" cellspacing="0" >
                        <tr valign="top" >
                            <td height="10px">&nbsp;</td>
                        </tr>
                        <tr>
                            <td>
                                <%--<%@include file="/jsp/common/InlineWorklist.jsp"%>--%>
                                <jsp:include page="../common/InlineWorklist.jsp">
                                    <jsp:param name="projPath" value="<%= projPath%>"/>
                                </jsp:include>
                            </td>
                        </tr>

                        <tr>
                            <td>
                                <%@include file="/jsp/common/FrequentlyUsedCommands.jsp"%>
                            </td>
                        </tr>


                    </table>
                    </div>
                    <div style="width: 1%;float: left">&nbsp;</div>
                    <div style="width: 79%;float: left">
                        <table width="100%" border="0" cellpadding="0" cellspacing="0" >
                            <tr valign="top" >
                                <td height="10px">&nbsp;</td>
                            </tr>
                            <tr><td class="shadow">
                                    <!--                                <div id="desktopWell" name="desktopWell" style="cursor: default; height: 450px" class="workingDivColor">-->
                                    <!--                                <div id="desktopWell" name="desktopWell" style="cursor: default;overflow-x:hidden;overflow-y:scroll;" class="workingDivColor">-->
                                    <div id="desktopWell" name="desktopWell" style="cursor: default;overflow: auto" class="workingDivColor">

                                        <!--                        <div align='right' style='height:590px;' >-->

                                        <div align='right' style='' id="desktopLoadingMessageDiv">
                                            <br><span class="loadingMessage" >&nbsp;Loading... Please wait...&nbsp;&nbsp;</span>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>

<!--            <tr><td colspan="100%"><%@include file="/jsp/common/Footer.jsp"%></td></tr>-->
        </table>

        <iframe name="statusMessageFrame" id="statusMessageFrame" style="display:none; width:300px; height:50px;z-index:1;" class="centered">    
        </iframe>      
        <div name="statusMessageDiv" id="statusMessageDiv" style=" display:none; width:300px; height:50px;z-index:2;" class="centered">
            <table width="100%" height="100%" border="0" cellpadding="3" cellspacing="0">
                <tr> 
                    <td valign="middle"> <img src="images/info.gif" width="33px" height="33px"></td>
                    <td valign="middle" align="center"> <span> Success Message</span></td>
                </tr>
            </table>
        </div>

        <!-- added by pushpanjali -->
        <iframe id="desktopReloginIFrame"
                style="position:absolute;width:420px;display:none;" class="hidden">
        </iframe>
        <div id="reloginDiv" style="position:absolute;width:420px;border:2px solid #360; border-color:#445677;;display:none;cursor: default" >
            <table width="100%" cellpadding="0" cellspacing="0" border="0" class="whiteBG" >
                <tr class="heading" >
                    <td align="center" height="25px" >
                        Your session has expired. Please login again...
                    </td>
                </tr>
                <tr>
                    <td width="100%">
                        <table width="100%" cellpadding="2" border="0">
                            <tr>
                                <td width="40%" height="25px"  >
                                    Customer ID
                                </td>
                                <td width="60%">
                                    : <b><%= userEntityCode%></b>
                                    <input type="hidden" name="userEntityCode" id="userEntityCode" value="<%= userEntityCode%>">
                                    <input type="hidden" name="userEntityRID" id="userEntityRID" value="<%= entityRID%>">
                                </td>
                            </tr>
                            <tr>
                                <td height="25px" >
                                    Customer Name
                                </td>
                                <td>
                                    : <b><%= userEntityName%></b>
                                    <input type="hidden" name="userEntityName" id="userEntityName" value="<%= userEntityName%>">
                                </td>
                            </tr>
                            <tr>
                                <td height="25px" >
                                    User ID
                                </td>
                                <td>
                                    : <b><%= userID%></b>
                                    <input type="hidden" name="userID" id="userID" value="<%= userID%>">
                                </td>
                            </tr>
                            <tr>
                                <td height="25px" >
                                    Password
                                </td>
                                <td>
                                    : <input type="password" id="loginPassWord"  name="loginPassWord" onkeydown="desktop.reloginOnEnter(event)">
                                </td>
                            </tr>
                            <tr>
                                <td height="35px" ></td>
                                <td align="right" >
                                    <input type="button" id="btnRelogin" name="btnRelogin" onclick="desktop.relogin()" value="Login">
                                    <input type="button" id="btnCloseRelogin" name="btnCloseRelogin" onclick="desktop.closeReloginDiv(false)" value="Close"> &nbsp;  &nbsp;
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
        <%--<div  id="loadingImageDiv" style="position:absolute; left:50%; top:40%;z-index:100;visibility: hidden;cursor: default">
            <table border="0" cellpadding="0" cellspacing="0">
                <tr align="center">
                    <td>
                        <img name=imageLoad src="../..<%=request.getContextPath()%>/images/Loading.gif">
                    </td>
                </tr>
                <tr align="center">
                    <td>
                        <label class="imageLoadMessage" >Please wait... </label>
                    </td>
                </tr>
            </table>
        </div>--%>

    </body>
</html>


