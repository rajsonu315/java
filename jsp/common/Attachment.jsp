<%@ page import="java.sql.*, java.io.*, ubq.util.*, ubq.base.*" %>

<%

            boolean readonly = false;
            if (request.getParameter("readonly") != null) {
                readonly = Boolean.parseBoolean(request.getParameter("readonly"));
            } else if (request.getAttribute("readonly") != null) {
                readonly = Boolean.parseBoolean(request.getAttribute("readonly").toString());
            }

            int contextRID = 0;
            if (request.getParameter("contextRID") != null) {
                contextRID = Integer.parseInt((String) request.getParameter("contextRID"));
            } else if (request.getAttribute("contextRID") != null) {
                contextRID = Integer.parseInt(request.getAttribute("contextRID").toString());
            }


            String contextType = "";
            if (request.getParameter("contextType") != null) {
                contextType = request.getParameter("contextType");
            } else {
                contextType = (String) request.getAttribute("contextType");
            }

            boolean hideDelete = (new Boolean(true)).equals(request.getAttribute("hideDelete"));

            ResultSet rsAttachments = (ResultSet) request.getAttribute("rsAttachments");

            int maxNoOfAttachment = request.getAttribute("maxNoOfAttachment") == null ? 0 : (Integer) request.getAttribute("maxNoOfAttachment");

            String contextPath = request.getContextPath();
%>

<div >
    <%--<input type="hidden" name="jsFile" value="<%= contextPath%>/js/base/Attachment.js" >--%>
    <input type="hidden" name="contextRID" value="<%= contextRID%>" >
    <input type="hidden" name="contextType" value="<%= contextType%>" >
    <table border="0" cellpadding="3" cellspacing="0" width="100%" class="whiteBG"  >
        <tr>
            <td>

                <div id="attachmentDiv">
                    <table id="attachmentTable" border="0" cellpadding="0" cellspacing="0" width="100%" >
                        <input type="hidden" name="maxNoOfAttachment" id="maxNoOfAttachment" value="<%=maxNoOfAttachment%>">
                        <tr class="specialRow <%= readonly ? "hidden" : ""%>" id="rowHeader">
                            <td width="1%" height="20px" >&nbsp; </td>
                            <td align="left" width="35%" style="padding-left:3px;" >File Description <%= readonly ? "" : "<span class='userInfo'>*</span>"%></td>
                            <td align="left" width="40%" style="padding-left:3px;" >File Selection</td>
                            <td width="24%">&nbsp; </td>
                        </tr>
                        <tr><td colspan="4" height="4px" ></td></tr>

                        <tr id="attachmentCloneRow" align="left" class ="<%= readonly ? "hidden" : ""%>">
                            <td height="25px" ><span id="rowErrorMsg" class="errorInfo"></span></td>
                            <td style="padding-left:3px;" >
                                <input type="hidden" id="attachmentRID" name="attachmentRID" value="0">
                                <input type="text" name="attachmentDesc" id="attachmentDesc" value="" size="50" >
                            </td>
                            <td style="padding-left:3px;" >            
                                <input type="hidden" id="deleteFlag" name="deleteFlag" value="0">
                                <input type="hidden" id="attachmentChanged" name="attachmentChanged" value="0">
                                <span id="attachmentFileName" name="attachmentFileName" class="hidden" ></span>
                                <input type="hidden" name="filePath" id="filePath">
                                <input type="hidden" name="oldPath" id="oldPath">
                                <input type="hidden" name="oldContentType" id="oldContentType">
                                <input type="file" size="45" maxlength="300" id="file" name="file" value="" class="file"
                                       onchange="attachment.setAttachmentPath(this);" >
                            </td>
                            <td align="left" valign="middle" style="padding-left: 9px">
                             
                                <input type="button" class="link"
                                        title="Add more attachments"
                                        style="cursor: pointer"
                                        name="attachmentAdd" id="attachmentAdd"
                                        onclick="attachment.addAttachment(this);"
                                        value="Add"
                                        >
<!--                                    <span>Add</span>-->
<!--                                </button>-->
                                <input type="button" class="link hidden"
                                        title="Delete this attachment"
                                        name="attachmentDelete"
                                        id="attachmentDelete"
                                        style="color: red;"
                                        value="Delete"
                                        onclick="attachment.deleteAddedAttachment(this);"
                                        >
<!--                                    <span>Delete</span>-->
<!--                                </button>-->

                                <%--<img src="<%= contextPath%>/images/add.png"
                                     title="Add more attachments"
                                     style="cursor: pointer"

                                     name="attachmentAdd" id="attachmentAdd"
                                     onclick="attachment.addAttachment(this);"/>--%>

                                <%--<img src="<%= contextPath%>/images/delete.gif"
                                     title="Delete this attachment"
                                     class="hidden"
                                     name="attachmentDelete"
                                     id="attachmentDelete"
                                     style="cursor: pointer;padding-left: 9px"
                                     onclick="attachment.deleteAddedAttachment(this);"/>--%>
                            </td>
                        </tr>

                        <%
                                    if (rsAttachments != null && rsAttachments.first()) {
                                        rsAttachments.beforeFirst();
                                        while (rsAttachments.next()) {

                                            String filePath = rsAttachments.getString("ad_file_path");
                                            String contentType = rsAttachments.getString("ad_file_content_type");

                        %>
                        <tr align="left" >
                            <td height="25px" ><span id="rowErrorMsg" class="errorInfo"></span></td>
                            <td style="padding-left:3px;" >
                                <input type="hidden" id="attachmentRID" name="attachmentRID" value="<%= rsAttachments.getString("ad_rid")%>">
                                <input type="hidden" id="deleteFlag" name="deleteFlag" value="0">
                                <input type="hidden" id="attachmentChanged" name="attachmentChanged" value="0">
                                <input type="hidden" name="filePath" id="filePath" value="<%= rsAttachments.getString("ad_file_path")%>">
                                <input type="hidden" name="oldPath" id="oldPath" value="<%= rsAttachments.getString("ad_file_path")%>">
                                <input type="hidden" name="oldContentType" id="oldContentType" value="<%= rsAttachments.getString("ad_file_content_type")%>">
                                <input type="hidden" name="file" value="" >

                                <span class="displayText" onclick="attachment.showAttachment('<%= filePath%>','<%= contentType%>')" style="cursor:pointer">
                                    <%= rsAttachments.getString("ad_desc")%>
                                </span>

                            </td>
                            <td colspan="2">
                                <input type="button" class="link <%= readonly ? "hidden" : ""%>"
                                        title="Delete this attachment"
                                        name="attachmentDelete"
                                        id="attachmentDelete"
                                        style="color: red;padding-left: 9px;"
                                        value="Delete"
                                        onclick="attachment.deleteAttachment(this, <%= rsAttachments.getString("ad_rid")%>, '<%= readonly%>');"
                                        >
<!--                                    <span >Delete</span>-->
<!--                                </button>-->
                                <%--<img src="<%= contextPath%>/images/delete.gif"
                                     title="Delete this attachment"
                                     name="attachmentDelete"
                                     id="attachmentDelete"
                                     style="cursor: pointer;padding-left: 9px"
                                     onclick="attachment.deleteAttachment(this, <%= rsAttachments.getString("ad_rid")%>, '<%= readonly%>');"
                                     class ="<%= readonly ? "hidden" : ""%>"/>--%>
                            </td>
                        </tr>
                        <%
                                                         }
                                                     } else if (readonly) {%>
                        <tr id="TRNoAttachments" name="TRNoAttachments">
                            <td height="25px" style="padding-left:5px" colspan="4" >No attachments</td>
                        </tr>
                        <% }%>
                    </table>
                </div>
            </td>
        </tr>

    </table>
</div>

