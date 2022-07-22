<%-- 
    Document   : FuelManagement
    Created on : 17 Jan, 2014, 2:34:47 PM
    Author     : ubqtech037
--%>

<%@ page pageEncoding="UTF-8" contentType="text/html; charset=iso-8859-1" language="java"
         import="java.sql.*" import="java.util.*" import="java.text.*" errorPage="" %>

          <%
            String projPath = request.getContextPath();
          %>
<div>
    
   
   
    
<form name="fuelTypeManagement" id="fuelTypeManagement" action="<%= projPath%>/FuelMasterServlet" method="Post"
          onsubmit="return fuelTypeManagment.validate();" target="myIframe">
    <input type="hidden" name="jsFile" value="<%= projPath%>/js/assetUtlization/FuelTypeManagement.js">
    <input type="hidden" name="successHandler"  value="fuelTypeManagment.handleSuccess">
    <input type="hidden" name="failureHandler"  value="fuelTypeManagment.handleFailure">
     <input type="hidden" name="command" id="command" value="saveFuelType">

        <table width="100%" cellpadding="0" cellspacing="0" border="0">
            <tr>
                <td>
                    <fieldset>
                        <legend><b>Manage Fuel Details</b></legend>
                        <table width="100%" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td>
                                    <div style="overflow:auto">
                                        <table align="right" border="0" cellpadding="0" cellspacing="2">
                                            <tr align="right">
                                                    <td align="right">
                                                    <label> Search &nbsp;</label>
                                                    <input type="text" name="searchTxt" id="searchTxt">
                                                    <input type="button" name="search" value="..." onclick="fuelTypeManagment.fuelTypeSearch()">
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div style="valign:top; overflow:auto">
                                        <jsp:include page="/jsp/common/FuelDetails.jsp" flush="true">
                                            <jsp:param name="projPath" value=""/>
                                        </jsp:include>

                                    </div>
                                </td>
                            </tr>
                            <tr width="100%">
                                <td width="100%" align="right">
                                    <input name="saveBtn" id="saveBtn" type="submit" value="Save" class="buttonSize">
                                    <input name="clearBtn" id="clearBtn" type="button" value="Clear" class="buttonSize" onclick="fuelTypeManagment.clearDetails();">
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

