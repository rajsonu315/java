<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="ubq.base.UFeature"  %>
<%@page import="java.util.*" %>
<%
            String projectPath = request.getContextPath();
            Vector pv = (Vector) request.getAttribute("accessibleCommandParents");
            Vector freqAccFeatures = (Vector) request.getAttribute("frequentlyAccessedCommands");

            String defFeatName = null;
            String defFeatCommand = null;
%>
<div id="commandPanelDiv" style="height:580px" >
    <input type="hidden" name="jsFile" value="<%=projectPath%>/js/base/CommandPanel.js">
    <table class="lhsMenuTable" width="100%"  border="0" cellpadding="0" cellspacing="0" id="parentFeatureTable" name="parentFeatureTable">
        <tr valign="top">
            <td valign="top" class="shadow1">
                <table width="100%"  border="0" cellpadding="0" cellspacing="1"  class="content">
                    <!-- show frequently accessed commands  -->
                    <%
                                String featRid = "", featCode = "", featName = "", featureCommand = "";
                                int featDivHeight = 0;


                                if (freqAccFeatures != null && freqAccFeatures.size() > 0) {
                    %>
                    <tr class="lhsMenuHeader">
                        <td width="100%"  height="25px">&nbsp;Favourites</td>

                    </tr>
                    <%
                               for (int i = 0; i < freqAccFeatures.size(); i++) {
                                   UFeature f = (UFeature) freqAccFeatures.elementAt(i);
                                   featName = f.featName;
                                   featCode = f.featCode;
                                   featRid = String.valueOf(f.featRID);
                                   featureCommand = f.featCommand;
                    %>
                    <tr>
                        <td width="100%" height="20px">
                            <a  href="#" onclick="desktop.loadPage('<%= featureCommand%>', '<%= featName%>');commandPanel.closeInlineDiv();"
                                class="menuLink" >&nbsp;<%= featName%></a>

                        </td>
                    </tr>

                    <%      }
                                }
                    %>

                    <!-- show accessible  menu items -->
                    <%  if (pv != null && pv.size() > 0) {
                                    for (int i = 0; i < pv.size(); i++) {
                                        UFeature f = (UFeature) pv.elementAt(i);
                                        featName = f.featName;
                                        featCode = f.featCode;
                                        featRid = String.valueOf(f.featRID);
                                        featDivHeight = f.featDivHeight;
                                        featureCommand = f.featCommand;

                    %>

                    <% if (f.featRID == f.featParentGroup) {%>
                    <tr class="lhsMenuHeader">
                        <td  height="25px" width="100%" valign="top">&nbsp;<%=featName%>
                        </td>
                    </tr>
                    <% } else {%>
                    <tr class="specialRow cursorPointer" id="featureTR<%=i%>" onclick="desktop.loadPage('<%= featureCommand%>', '<%= featName%>');commandPanel.highlightMenuItem('featureTR<%=i%>')">
                        <td  height="25px" width="100%" valign="top">
                    <%=featName%>
                        </td>
                    </tr>


                    <%
                     if(defFeatName == null){
                        defFeatName = featName;
                        defFeatCommand = featureCommand;
                    }
                    }
                                    }
                                }
                    %>
                </table>
            </td>
            <td class="workAreaBackgroundColor">                
                <div id="childMenuDiv" style="height:200px;width:250px;position:absolute;z-index:1"></div>                
            </td>

        </tr>
    </table>
                <input type="hidden" id="defaultFeatureName" name="defaultFeatureName" value="<%= defFeatName%>">
                <input type="hidden" id="defaultFeatureCommand" name="defaultFeatureCommand" value="<%= defFeatCommand%>">
</div>
