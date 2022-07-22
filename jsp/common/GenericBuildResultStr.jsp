<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8" language="java" import="java.sql.*" import="java.util.*" import="java.text.*" errorPage="" %>
<%if (request.getAttribute("rsCommon") != null) {
    ResultSet rs = (ResultSet)request.getAttribute("rsCommon") ;
    ResultSetMetaData rsmd = rs.getMetaData();
    int numCols = rsmd.getColumnCount() ;
    String resultStr = "" ;
    rs.beforeFirst();
    while(rs.next()){
        for(int i=1; i <= numCols; i++)
            resultStr = resultStr + rs.getString(i) + "~";
        resultStr = resultStr + "^";
    }
    out.print(resultStr);
}%>