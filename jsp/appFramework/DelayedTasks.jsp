<%@page import="ubq.base.URequestContext, ubq.util.ULocale"%>
<%@page import="java.sql.*,ubq.util.*,java.util.*,java.lang.String.*" %>
<%
String projPath = (String) request.getContextPath();
String workListDetails = "";
String name = "",workListName = "";
String redCount = "",yellowCount = "",wlRID = "",userRID = "",unitRID="";
String worklistDate = request.getParameter("worklistDate");
boolean isEven =true;
boolean isEscLevel1 = "1".equals(request.getAttribute("isEscLevel1")); 
boolean isEscLevel2 = "1".equals(request.getAttribute("isEscLevel2")); 
Vector delayedDetails = null;
Vector overDelayedDetails = null;
boolean isNeitherUnitOrUser = true;
if(isEscLevel2){
 overDelayedDetails = (Vector) request.getAttribute("overDelayedDetails");
}
if(isEscLevel1){
 delayedDetails = (Vector) request.getAttribute("delayedDetails");
}
%>

<div>
    <input type="hidden" name="jsFile" value="<%= projPath %>/js/appFramework/DelayedTasks.js">
    <table border="0" width="100%" cellpadding="3" cellspacing="0">
        <tr class="wellHeader">
            <td colspan="4" height="30px">&nbsp;</td>
        </tr>
        <tr class="specialRow" style="height:30px">
            <td align="left">
                &nbsp;Worklist Name 
            </td>
            
            <td align="center" colspan="2">
                No. Of Delayed Tasks
            </td>
            
        </tr>
        <%
        if(isEscLevel2){
        for(int i = 0 ; i < overDelayedDetails.size(); i++){
         isNeitherUnitOrUser = true;
         workListDetails = (String) overDelayedDetails.get(i);
         workListName = workListDetails.split("~")[0];
         name = workListDetails.split("~")[1];
         redCount = workListDetails.split("~")[2];
         wlRID = workListDetails.split("~")[3];    
         userRID = workListDetails.split("~")[4];    
         unitRID = workListDetails.split("~")[5];    
        if(!"0".equals(userRID) || !"0".equals(unitRID)){
             isNeitherUnitOrUser = false;
             
         }
        %>
        
        <!--tr style="height:30px;cursor:pointer" class="<%=isEven?"oddRow":"evenRow"%>" onclick="delayedTasks.showWorklist(this,<%=wlRID%>,<%=userRID%>,<%=unitRID%>,1,'<%=worklistDate%>')"-->
        <tr style="height:30px;cursor:pointer" class="<%=isEven?"oddRow":"evenRow"%>" 
        onclick="<%=!isNeitherUnitOrUser ? "delayedTasks.showWorklistItem(this,event,'"+wlRID+"','"+worklistDate+"',1)" : "delayedTasks.showWorklist(this,event,'"+wlRID+"','"+userRID+"','"+unitRID+"',1,'"+worklistDate+"')" %>">
            <td>
                &nbsp;<%=workListName%>
            </td>
            <td align="right">
                <img src="images/Clock_gif_small.gif"/>
            </td>
            <td align="left">
                <span><%=redCount%></span>
            </td>
            
        </tr>
     
        <%  isEven = !isEven;
        }}
          workListName = "";
          name = "";
          yellowCount = "";
         if(isEscLevel1){
        for(int j = 0 ; j < delayedDetails.size(); j++){
          isNeitherUnitOrUser = true;
          workListDetails = (String) delayedDetails.get(j);
          workListName = workListDetails.split("~")[0];
          name = workListDetails.split("~")[1];
          yellowCount = workListDetails.split("~")[2]; 
          wlRID = workListDetails.split("~")[3];   
          userRID = workListDetails.split("~")[4];    
          unitRID = workListDetails.split("~")[5];    
         if(!"0".equals(userRID) || !"0".equals(unitRID)){
             isNeitherUnitOrUser = false;
             
         }
        %>
        
        <!--tr style="height:30px;cursor:pointer" class="<%=isEven?"oddRow":"evenRow"%>" onclick="delayedTasks.showWorklist(this,<%=wlRID%>,<%=userRID%>,<%=unitRID%>,2,'<%=worklistDate%>')"-->
        <tr style="height:30px;cursor:pointer" class="<%=isEven?"oddRow":"evenRow"%>" 
        onclick="<%=!isNeitherUnitOrUser ? "delayedTasks.showWorklistItem(this,event,'"+wlRID+"','"+worklistDate+"',2)" : "delayedTasks.showWorklist(this,event,'"+wlRID+"','"+userRID+"','"+unitRID+"',2,'"+worklistDate+"')" %>">
            <td>
                &nbsp;<%=workListName%>
            </td>
            <td align="right">
                <img src="images/Clock_gif_small_orange.png"/>
            </td>  
            <td align="left">
               <span><%=yellowCount%></span>
            </td>
               
           
        </tr>

        <%isEven = !isEven;
        }}        
        %>
    </table>
</div>