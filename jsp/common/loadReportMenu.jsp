<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.util.*" import="ubq.base.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <title>Menu Items</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <link href="/uSCM/style/dqiColors.css" rel="stylesheet" type="text/css">
    <link href="/uSCM/style/dqiStyles.css" rel="stylesheet" type="text/css">
    <SCRIPT LANGUAGE="JavaScript" SRC="/uSCM/js/base/ValidateFunction.js"></SCRIPT>
    <SCRIPT LANGUAGE="JavaScript" SRC="/uSCM/js/base/DynamicTableTemplate.js"></SCRIPT>
    <style type="text/css">
      <!--
      body {
      margin-left: 8px;
      margin-top: 6px;
      margin-right: 2px;
      margin-bottom: 4px;
      }
      -->
    </style>
<script>
function confirmTransition(arg1, arg2){
  if(checkTransition()){
    parent.blankFrame.location = arg1 ;
    parent.activityFrame.location = arg2 ;
    resetDirtyBit() ;
    return;
  }
}

function showPages(pageURL1, pageURL2){
  //parent.blankFrame.location = pageURL1 ;
  //parent.activityFrame.location = pageURL2 ;
    if(checkTransition()){
      parent.blankFrame.location = pageURL1 ;
      parent.activityFrame.location = pageURL2 ;
      return;
    }
}

function showBlankPage(arg1) {
  if(checkTransition()){
    parent.activityFrame.location = arg1 ;
    parent.blankFrame.location = '/uSCM/jsp/common/scmEmpty.jsp' ;
    resetDirtyBit() ;
    return;
  }
}

 function setNewSelection(selection){
     highlightSelection(selection);
   }

var currSelection ;

function highlightSelection(elem) {
    var row;
   
    if(currSelection != null) {
      row = dynTableRow(currSelection);
      row.style.background = currSelection.savedBackground;
      currSelection.style.background = currSelection.savedBackground;
    } 
      elem.savedBackground = elem.style.background;
      elem.style.background = "#FD9A00";
      row = dynTableRow(elem);
      row.style.background = "#FD9A00";
      currSelection = elem;
}

var curDiv = null;
function handleDiv(divId) {
  
  curDiv = divId;
  var allDiv = document.getElementsByTagName('div');
  
  for(var i = 0; i < allDiv.length; i++) {
  
    if(allDiv(i).id == divId) {
        showDiv(document.getElementById(allDiv(i).id));          
    } else if(allDiv(i).id != curDiv) {
        hideDiv(document.getElementById(allDiv(i).id));
       
    }    
    
  }

}

function showDiv(divObj) {
  divObj.style.visibility = "visible";
  divObj.style.display = "block";
}

function hideDiv(divObj) {
  divObj.style.visibility = "hidden";
  divObj.style.display = "none";
}

</script>

  </head>   

  <body class="workAreaBackgroundColor" 
        onload="handleDiv('ReportsDiv');setNewSelection(document.getElementById('ReportsLink'))">
    <form name="menu" id="menu">
        <table width="100%" height="672" border="0" cellpadding="0" cellspacing="0" class="activityBackgroundColor">
            <tr valign="top">
            <td>
            
      <table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" >
        <tr class="tableHeaderColor" height="30">
          <td class="tableHeader">&nbsp;Menu Items</td>
        </tr>
      
          <%
            Vector v = (Vector) request.getAttribute("accessibleCommands");
            String parentMenu ="";
            parentMenu = request.getParameter("parentMenu");
            String currFeatGroup = " " ;
            if(v == null){
              out.print("You do not have access to any features of this product. ");
              out.println("Please contact your system administrator.");
            } else {

          %>
             <tr><td><div name="dummyDiv" id="dummyDiv"><table width="100%" cellspacing="0" cellpadding="0" border="1" >
          
          <%
              for(int i = 0; i < v.size(); i++) {

                UFeature f = (UFeature) v.elementAt(i);

                String cmd_name = f.featName;
                String link_url = f.featCommand;
                String cmd_help = f.featHelp;
                String cmd_grp = f.featGroup ;
                String cmd_grp_desc = f.featGroupDesc ;
               
                if(cmd_grp != null && !cmd_grp_desc.equals(currFeatGroup)){%>
                
             </table></div></td></tr>
             
                  <tr><td height="5"></td></tr>
                  <tr valign="top">
                   <td   class="heading">
                   &nbsp;&nbsp; <a href="#" class="menuLinkLabel"  id="<%= cmd_grp_desc%>Link" 
                    onclick="handleDiv('<%= cmd_grp_desc%>Div');setNewSelection(this)">
                    <%= cmd_grp_desc%> </a> </td>
                  </tr>
                  
                <tr><td><div name="<%=cmd_grp_desc%>Div" id="<%=cmd_grp_desc%>Div" ><table width="100%" cellspacing="0" cellpadding="0" border="0" >   
                      
                <%
                  currFeatGroup = cmd_grp_desc ;
                }
                
                if(link_url != null && !link_url.equals("")){
                %>
                    <tr  valign="top">
                <td  onclick="setNewSelection(this)">
                    &nbsp;&nbsp;<a href="javascript:confirmTransition('<%= link_url%>','<%= cmd_help%>')"  class="smallLabel"> <%= f.featName%></a>
                </td>
                    </tr>
                
          <%
                }
               }
          %>
            </table></div></td></tr>
            
          <%  
           }   
              if("Reports".equals(parentMenu) || "Master-Admin".equals(parentMenu) || "Masters".equals(parentMenu)){
          %>  
            <tr  valign="top">
                <td  onclick="setNewSelection(this)">
           <a href="/uSCM/SCMMasterServlet?command=loadAccessibleCommands" onclick="javascript:showPages('/uSCM/jsp/common/scmEmpty.jsp','/uSCM/jsp/common/scmActivity.jsp')" target="menuFrame" class="heading"> <-- Back</a>
                </td></tr>
          <%    }          
              
            
       %>
          
      </table>
            </td>
            </tr>
      </table>
    </form>
  </body>
</html>