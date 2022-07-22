<%@page contentType="text/html" language="java" import="java.sql.*" import="java.util.*" import="java.text.*" errorPage=""%>
<%@page pageEncoding="UTF-8"%>

        <% String selectedValue = request.getParameter("selectedValue"); 
               String rsName = request.getParameter("resultSetName"); 
               String comboId = request.getParameter("comboId");
               String comboName = request.getParameter("comboName");
               String colId = request.getParameter("colId");
               String colName = request.getParameter("displayColName");
               String onChangeFunction = request.getParameter("onChangeFunction");
               String isDisabled = request.getParameter("isDisabled");
               isDisabled = isDisabled != null?isDisabled:"";
               if (selectedValue == null )
                    selectedValue ="0"; %>
                    
        <select name="<%= comboName %>" id="<%= comboId %>" style="width:150px;" <%= isDisabled %> <% if (onChangeFunction != null){%> onchange="<%= onChangeFunction %>;"<%}%> > 
            <option >  </option>
            <%
               
              ResultSet rs = (ResultSet) request.getAttribute(rsName);
                if(rs != null) 
                {
                    while(rs.next()) {%>                            
                        <option value= "<%= rs.getString(colId)%>" <% if (selectedValue.equals(rs.getString("id"))){ %> selected <%}%> > <%= rs.getString(colName)%> </option>
                        <% }
                    rs.close();
                 }
                    %>   
        </select>                  
   
