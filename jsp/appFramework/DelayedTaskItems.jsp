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

if(isEscLevel2){
 overDelayedDetails = (Vector) request.getAttribute("overDelayedWorklist");
}
if(isEscLevel1){
 delayedDetails = (Vector) request.getAttribute("delayedWorklist");
}
%>

<div>
    <input type="hidden" name="jsFile" value="<%= projPath %>/js/appFramework/DelayedTasks.js">
    <table border="0" width="100%" cellpadding="3" cellspacing="0">
     

        <%
        if(isEscLevel2){
        for(int i = 0 ; i < overDelayedDetails.size(); i++){
         workListDetails = (String) overDelayedDetails.get(i);
        
         name = workListDetails.split("~")[0];
         redCount = workListDetails.split("~")[1];
         wlRID = workListDetails.split("~")[2];    
         userRID = workListDetails.split("~")[3];    
         unitRID = workListDetails.split("~")[4];    
        %>
        
        <tr style="height:30px;cursor:pointer" class="<%=isEven?"oddRow":"evenRow"%>" 
        onclick="delayedTasks.showWorklist(this,event,<%=wlRID%>,<%=userRID%>,<%=unitRID%>,1,'<%=worklistDate%>')">
        
            <td width="500px">
                &nbsp;<%=name%>
            </td>
            <td width="100px" align="right">
                <img src="images/Clock_gif_small.gif"/>
            </td>
            <td width="100px" align="left">
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
          workListDetails = (String) delayedDetails.get(j);
        
          name = workListDetails.split("~")[0];
          yellowCount = workListDetails.split("~")[1]; 
          wlRID = workListDetails.split("~")[2];   
          userRID = workListDetails.split("~")[3];    
          unitRID = workListDetails.split("~")[4];    
        %>
        
        <tr style="height:30px;cursor:pointer" class="<%=isEven?"oddRow":"evenRow"%>" 
        onclick="delayedTasks.showWorklist(this,event,<%=wlRID%>,<%=userRID%>,<%=unitRID%>,2,'<%=worklistDate%>')">
            <td width="500px">
                &nbsp;<%=name%>
            </td>
            <td width="100px" align="right">
                <img src="images/Clock_gif_small_orange.png"/>
            </td>  
            <td width="100px" align="left">
               <span><%=yellowCount%></span>
            </td>
               
           
        </tr>

        <%isEven = !isEven;
        }}        
        %>
    </table>
</div>