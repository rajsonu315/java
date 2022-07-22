<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*, ubq.util.*" errorPage="" %>

<% 
ResultSet rsSupportDetails = (ResultSet)request.getAttribute("rsSupportDetails");
%>

<div id="supportDiv" class="helpDesk" style="height:45px">
    <table width="100%" border="0" cellpadding="0" cellspacing="2">
        
        <% if(rsSupportDetails != null && rsSupportDetails.first()){
    if(rsSupportDetails.getString("hd_contact_person") != null && !"".equals(rsSupportDetails.getString("hd_contact_person"))){%>
        <tr>
            <td width="35%">&nbsp;<b>Contact person : </b></td>
            <td  width="65%"><%= rsSupportDetails.getString("hd_contact_person") %></td>
        </tr>
        <%  }
    if(rsSupportDetails.getString("hd_contact_no") != null &&  !"".equals(rsSupportDetails.getString("hd_contact_no"))){%>
        <tr>
            <td width="35%">&nbsp;<b>Contact No : </b></td>
            <td  width="65%"><%= rsSupportDetails.getString("hd_contact_no") %></td>
        </tr>
        <%  }
    if(rsSupportDetails.getString("hd_email") != null &&  !"".equals(rsSupportDetails.getString("hd_email"))){%>
        <tr>
            <td width="35%">&nbsp;<b>Email : </b></td>
            <td  width="65%"><a href="mailto:<%= rsSupportDetails.getString("hd_email") %>"><%= rsSupportDetails.getString("hd_email") %></a></td>
        </tr>
        <%  }
        }  else {%>
        <tr>
            <td>Contact details have not been set</td>
        </tr>
        <%}%>
    </table>
    
</div>    