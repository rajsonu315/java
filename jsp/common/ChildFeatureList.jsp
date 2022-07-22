<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@page pageEncoding="UTF-8" import="ubq.base.UFeature" import = "java.util.*"%>
<%Vector pv = (Vector) request.getAttribute("accessibleCommandChild");%>

<div id="childFeaturelistDiv">
    <table width="70%" cellpadding="3" cellspacing="2" class="workAreaBackgroundColor border" id="childFeaturelistTab" name="childFeaturelistTab" border="0">
        <%  if (pv != null && pv.size() > 0) {
                        String featRid = "", featCode = "", featureName = "", featureCommand = "";
                        for (int i = 0; i < pv.size(); i++) {
                            UFeature f = (UFeature) pv.elementAt(i);
                            featureName = f.featName;
                            featCode = f.featCode;
                            featRid = String.valueOf(f.featRID);
                            featureCommand = f.featCommand;

        %>
        <tr height="20px">
            <td width="70%" nowrap>
                <a  href="#"
                    onclick="desktop.loadPageChanged('<%= featureCommand%>', '<%= featureName%>'); commandPanel.closeInlineDiv();commandPanel.highlightMenu()"
                    class="menuLink" ><%=featureName%></a>

            </td>
        </tr>


        <%
                        }
                    }
        %>
    </table>
</div>
    <%--Added by Saurabh--%>
<iframe class="hidden" id="childMenuFrame"></iframe>
