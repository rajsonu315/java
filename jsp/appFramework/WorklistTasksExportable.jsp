<%-- 
    Document   : WorklistTasksExportable
    Created on : Dec 20, 2011, 12:59:29 PM
    Author     : Biswajyoti
--%>

<%@ page import="java.sql.*, ubq.util.*, ubq.base.*, ubq.appFramework.*" %>

<%
            int context = request.getAttribute("context") == null ? 0 : (Integer) request.getAttribute("context");
            int worklistConfigRID = request.getAttribute("worklistConfigRID") == null ? 0 : (Integer) request.getAttribute("worklistConfigRID");
            String worklistName = request.getAttribute("worklistName") == null ? " " : String.valueOf(request.getAttribute("worklistName"));

            /* Setting the 'content-type' dynamically!! */
            if (context == 2) {
                response.setContentType("application/vnd.ms-excel; charset=iso-8859-1");
            } else {
                response.setContentType("text/html");
            }

            response.setHeader("Content-Disposition", "attachment; filename=\"" + worklistName + ".xls\"");
            
%>


<%
            String[] header = (String[]) request.getAttribute("worklistTaskHeader");
%>

<%
            URequestContext ctxt = (URequestContext) request.getAttribute("ctxt");
            int isSnoozable = ctxt.getAttribute("isSnoozable") == null ? 0 : (Integer) ctxt.getAttribute("isSnoozable");
            ResultSet rs = (ResultSet) ctxt.getAttribute("worklistTasks");
            if (rs != null && rs.first()) {
%>
<html>
    <body>

        <table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr >
                
                <%
                                    java.sql.Timestamp now = UDate_Old.currentTimestamp();

                                    String worklistRID = (String) request.getParameter("worklistRID");
                                    String worklistType = (String) request.getAttribute("worklistType");

                                    header = (String[]) request.getAttribute("worklistTaskHeader");
                                    String[] contentFields = (String[]) request.getAttribute("worklistTaskFields");

                                    for (int i = 0; i < header.length; i++) {
                %>
                <th align="left"><%= (i == 0 ? "&nbsp;" : "") + header[i]%></th>
                <%
                                    }
                %>
                <td width="1%">&nbsp;</td>
                <th></th>
            </tr>
            <%
                                int timerFlag = 0;
                                int rowNum = 1;
                                String timerColourSpec = "background-color: #FBC64A;";
                                boolean writeFromResultset = "RESULT_SET".equals((String) request.getAttribute("worklistContentSource")) ? true : false;

                                String taskCommandURL = request.getParameter("taskCommandURL");

                                if (taskCommandURL == null) {
                                    taskCommandURL = "";
                                }

                                if (rs != null) {
                                    rs.beforeFirst();
                                    while (rs.next()) {
                                        int wliRID = rs.getInt("wli_rid");
                                        int boRID = rs.getInt("wli_bo_rid");
                                        String boCode = rs.getString("bo_code");

                                        String worklistFeatureCode = rs.getString("feature_code");

                                        String actualClass = rowNum % 2 == 0 ? "evenRow" : "oddRow";

                                        java.sql.Timestamp timer1 = rs.getTimestamp("wli_timer1_expiry");
                                        java.sql.Timestamp timer2 = rs.getTimestamp("wli_timer2_expiry");
                                        java.sql.Timestamp stoppedTimerTime = rs.getTimestamp("wli_timer_stopped_time");

                                        String bgColourSpec = "";
                                        timerFlag = rs.getInt("wli_timer_flag");

                                        if (timer2 != null && now.compareTo(timer2) > 0) {
                                            bgColourSpec = UConfig.getParameterValue(ctxt, "LEVEL2_ALERT_STYLE", "background-color:red;font-weight: bold;"); //#ED9894;");
                                        } else if (timer1 != null && now.compareTo(timer1) > 0) {
                                            bgColourSpec = UConfig.getParameterValue(ctxt, "LEVEL1_ALERT_STYLE", "background-color:orange;"); //#F5D19A;");
                                        }
                                        if (timerFlag == 1) {
                                            if (stoppedTimerTime != null && timer2 != null && stoppedTimerTime.compareTo(timer2) > 0) {
                                                bgColourSpec = UConfig.getParameterValue(ctxt, "LEVEL2_ALERT_STYLE", "background-color:red;font-weight: bold;"); //#ED9894;");
                                            } else if (stoppedTimerTime != null && timer1 != null && stoppedTimerTime.compareTo(timer1) > 0) {
                                                bgColourSpec = UConfig.getParameterValue(ctxt, "LEVEL1_ALERT_STYLE", "background-color:orange;"); //#F5D19A;");
                                            } else if (stoppedTimerTime != null && timer1 != null && timer1.compareTo(stoppedTimerTime) >= 0) {
                                                bgColourSpec = "";
                                            }
                                        }

                                        String taskArgs = rs.getString("wli_task_args");
            %>

            <tr>

                <%

                                            int contentLength = 0;
                                            if (writeFromResultset) {
                                                if (null != contentFields) {
                                                    contentLength = contentFields.length;
                                                }
                                                for (int i = 0; i < contentLength; i++) {
                %>
                <td ><%= (i == 0 ? "" : "") + UString.blankIfNull(rs.getString(contentFields[i]))%></td>
                <%
                                                            }
                                                        } else {
                                                            String boDescriptorStr = rs.getString("wli_descriptor");
                                                            String[] boDescriptor = null;
                                                            if (null != boDescriptorStr) {
                                                                boDescriptor = (String[]) boDescriptorStr.split("&");
                                                                contentLength = boDescriptor.length;
                                                            }
                                                            for (int i = 0; i < contentLength; i++) {
                %>
                <td  ><%= (i == 0) ? ("" + boDescriptor[i]) : boDescriptor[i]%></td>
                <%
                                                }
                                            }

                                            for (int i = 0; i < header.length - contentLength; i++) {
                %>
                <td></td>
                <%                                                    }
                %>
                <td>

                </td>
                <td >

                    <%= rs.getInt("wli_priority") == BOWorklistManager.HIGH_PRIORITY ? "" : ""%>

                </td>
            </tr>
            <%
                                        rowNum++;
                                    }
                                }
            %>
        </table>



        <%
                    }
        %>

    </body>
</html>
