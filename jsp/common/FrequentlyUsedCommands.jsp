<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="ubq.base.*" import = "java.util.*" %>

<div id="frequentlyUsedCommandsDiv">

<%
  Vector fv = (Vector) request.getAttribute("frequentlyUsedCommands");
%>
  <table class="lhsMenuTable" width="100%" height="100%"  border="0" cellpadding="0" cellspacing="0">

    <tr>
      <td>
          <table width="100%" height="100%"  border="0" cellpadding="0" cellspacing="0"  class="lhsMenuTable shadow">
          <tr class="lhsMenuHeader" height="25px">
            <td width="100%" ><strong>&nbsp;Frequently Used Links</strong></td>
          </tr>
          
          <tr>
            <td>
   	      <div id="vertical_container" >

<%
  if(fv != null && fv.size() > 0) {

    String currentCommandGroup = "";

    for(int i = 0; i < fv.size(); i++) {
      UFeature f = (UFeature) fv.elementAt(i);
      String cmd_name = f.featName;
      String link_url = f.featCommand;
      String commandGroup = f.rootParentDesc;
      if(!currentCommandGroup.equals(commandGroup)) {
          currentCommandGroup = commandGroup;

          if(i != 0) {
%>
                </div>
<%
          }
%>
                <h2 class="accordion_toggle"><%= commandGroup%></h2>
                <div class="accordion_content">              
<%
      }
%>
<!--                    &nbsp;<a href="javascript:window.open(url,"_blank", "toolbar=yes,location=no,directories=no,status=no,menubar=no,resizable=no,copyhistory=no,fullscreen=no,titlebar=yes")">
                        CIR User Manual</a><br><br>-->
                    &nbsp;<a href="javascript:desktop.loadPage('<%= link_url%>')"><%= cmd_name%></a><br><br>
<%
    }
  } else {
%>
                <br>&nbsp;No frequently used links set<br><br> 
<%
  }
%>
<!--              &nbsp;<a href="#" onclick='javascript:window.open("AttachmentsServlet?command=writeAttachment&filePath=C:/Ubq-data/AppPrivate/QMS/CIReporting.pdf","_blank", "toolbar=yes,location=no,directories=no,status=no,menubar=no,resizable=no,copyhistory=no,fullscreen=no,titlebar=yes")'>
                        CIR Protocol</a><br><br>
              &nbsp;<a href="#" onclick='javascript:window.open("AttachmentsServlet?command=writeAttachment&filePath=C:/Ubq-data/AppPrivate/QMS/CIR_User_Manual.doc","_blank", "toolbar=yes,location=no,directories=no,status=no,menubar=no,resizable=no,copyhistory=no,fullscreen=no,titlebar=yes")'>
                        CIR User Manual</a><br><br>
              &nbsp;<a href="#" onclick='javascript:window.open("AttachmentsServlet?command=writeAttachment&filePath=C:/Ubq-data/AppPrivate/QMS/CQI_User_Manual.doc","_blank", "toolbar=yes,location=no,directories=no,status=no,menubar=no,resizable=no,copyhistory=no,fullscreen=no,titlebar=yes")'>
                        CQI User Manual</a><br><br>
              &nbsp;<a href="#" onclick='javascript:window.open("AttachmentsServlet?command=writeAttachment&filePath=C:/Ubq-data/AppPrivate/QMS/Audits_User_Manual.doc","_blank", "toolbar=yes,location=no,directories=no,status=no,menubar=no,resizable=no,copyhistory=no,fullscreen=no,titlebar=yes")'>
                        Audits User Manual</a><br><br>-->
              </div>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>

</div>
