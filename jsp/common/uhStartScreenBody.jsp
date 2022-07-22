<%@ page session="true" %>
<%@ page import="java.sql.*" import="java.util.*" import="ubq.base.*" %>
<html>
<Head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<!-- Importing the required CSS files -->
<link href="styles/UbqColors.css" rel="stylesheet" type="text/css">
<link href="styles/UbqStyles.css" rel="stylesheet" type="text/css">
<title>Body</title>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>
</Head>

<!-- Body of JSP Starts -->
<body class="workAreaBackgroundColor"> 

<!-- Creating Table which have 2 columns with 1 row -->
<table width="100%">
  <tr>
    <td width="290" height="700"><img src="images/Image.jpg" height="700" width="290"></img></td>
    <td width="30" height="700">&nbsp;</td>
    <td width="655"> 

      <!--Creating an Inner Table with 4 rows  -->
      <table width="650" border="0"> 
<!--
        <tr>
	  <td height="28"colspan="5"  align="center">
 		<span class="activityHeader">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
   		  Welcome, <%= session.getAttribute("userTitle")+" "+session.getAttribute("userName") %>!
		</span>
	  </td>
        </tr>
-->
        <tr>
	  <td height="14"></td>
	</tr>
        <tr>
          <td height="20" colspan="5"  align="center" class="activityBody">&nbsp;&nbsp;&nbsp;&nbsp; <%= new java.util.Date() %></td>
        </tr>
	<tr>
          <table width="100%" height="500" border="0" align="center" cellspacing="0" cellpadding="4">
            <tr>
	      <td height="35" colspan="3" align="center" class="tableHeaderColor"><span class="tableHeader">Start Screen : Click on the desired activity</span></td>
	    </tr>
<%
  Vector v = (Vector) request.getAttribute("accessibleCommands"); 

  if(v == null) {
    out.print("You do not have access to any features of this product. ");
    out.println("Please contact your system administrator.");
  } else {

    for(int i = 0; i < v.size(); i++) {

      UFeature f = (UFeature) v.elementAt(i);

      String cmd_name = f.featName;
      String link_url = f.featCommand;
      String cmd_help = f.featHelp;

      if(link_url != null && !link_url.equals("")) {
%>
	    <tr class="tableBodyColor">
              <td width="49%" height="80" >
                <a href="<%= link_url%>" class="tableElementHeader"><%out.println(cmd_name);%></a><br>
                <span class="tableElement" ><%= cmd_help%></span>
              </td>
	      <td width="2%">&nbsp;</td>
	      <td width="49%"></td>
            </tr>
<%
    }
  }
}
%>
	  </table> <!-- InnerMost Table Ends -->
        </tr>
      </table> <!-- Inner Table Ends --> 
    </td>
  </tr>
</table><!-- OuterMost Table Ends -->


</body>
<!-- JSP Body Ends -->		
		
		
		
</html>