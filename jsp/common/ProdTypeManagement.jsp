<%-- 
    Document   : ProdTypeManagement
    Created on : Dec 12, 2012, 3:41:03 PM
    Author     : saurabh
--%>

<%@ page pageEncoding="UTF-8" contentType="text/html; charset=iso-8859-1" language="java"
         import="java.sql.*" import="java.util.*" import="java.text.*" errorPage="" %>
<%
            String projPath = request.getContextPath();
%>

<div>
    <input type="hidden" name="jsFile" value="<%= projPath%>/js/assetUtlization/ProdTypeManagement.js">
    <input type="hidden" name="onLoadFunction" value="prodTypeManagement.formInit()">
    <input type="hidden" name="successHandler" id="successHandler" value="prodTypeManagement.handleSuccess">
    <input type="hidden" name="failureHandler" id="failureHandler" value="prodTypeManagement.handleFailure">
    <form name="productTypeManagement" id="productTypeManagement" action="<%= projPath%>/ProductMasterServlet" method="Post"
          onsubmit="return prodTypeManagement.validate();" target="myIframe">
        <input type="hidden" name="command" id="command" value="saveProductType">
        <table width="100%" cellpadding="0" cellspacing="0" border="0">
            <tr>
                <td>
                    <fieldset>
                        <legend><b>Manage Product Categories</b></legend>
                        <table width="100%" border="0" cellpadding="0" cellspacing="0">                           
                            <tr>
                                <td>
                                    <div style="overflow:auto">
                                        <table align="right" border="0" cellpadding="0" cellspacing="2">
                                            <tr align="right">
                                                <td align="right"> Search By &nbsp;</td>
                                                <td>
                                                    <jsp:include page="/jsp/common/PartyFilter.jsp" flush="true" >
                                                        <jsp:param name="searchType" value="prodType"/>                                                        
                                                    </jsp:include>
                                                </td>
                                                <td>
                                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                                </td>
                                                <td align="right">
                                                    <label> Search &nbsp;</label>
                                                    <input type="text" name="searchTxt" id="searchTxt">
                                                    <input type="button" name="search" value="..." onclick="prodTypeManagement.productTypeSearch()">
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>                          
                            <tr>
                                <td>
                                    <div name="productTypeDiv" id="productTypeDiv" style="valign:top; overflow:auto">
                                        <jsp:include page="/jsp/common/ProductTypeDetails.jsp" flush="true">
                                            <jsp:param name="projPath" value="<%=projPath%>"/>                                            
                                        </jsp:include>

                                    </div>
                                </td>
                            </tr>
                            <tr width="100%">
                                <td width="100%" align="right">
                                    <input name="saveBtn" id="saveBtn" type="submit" value="Save" class="buttonSize">                                   
                                    <input name="clearBtn" id="clearBtn" type="button" value="Clear" class="buttonSize" onclick="prodTypeManagement.clearDetails();">
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                </td>
            </tr>
        </table>


        <iframe style="visibility: hidden;display:none;" name="myIframe" id="myIframe"> </iframe>

    </form>

</div>



