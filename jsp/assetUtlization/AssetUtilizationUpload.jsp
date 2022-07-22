<%-- 
    Document   : AssetUtilizationUpload
    Created on : Apr 26, 2013, 7:43:48 PM
    Author     : subhransu
--%>

<%@page contentType="text/html" pageEncoding="windows-1252"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%
            String projectPath = request.getContextPath();
%>

<div>
    <form name="utilizationUploadForm" id="utilizationUploadForm" action="<%= projectPath%>/AssetUtilizationUploadServlet"
          target="entryResponseFrameAU"  method="POST" enctype="multipart/form-data">

        <input type="hidden" id="jsFile" name="jsFile" value="<%=projectPath%>/js/assetUtlization/AssetUtilizationUpload.js">
        <input type="hidden" id="successHandler" name="successHandler" value="assetUtilizationUpload.handleSuccess">
        <input type="hidden" id="failureHandler" name="failureHandler" value="assetUtilizationUpload.handleFailure">

        <input type="hidden" id="command" name="command" value="uploadUtilization">
        <input type="hidden" id="canOverwrite" name="canOverwrite" value="0">
        
        <table width="100%" cellpadding="3" cellspacing="2">
            <tr class="specialRow">
                <td colspan="2">
                    <b>Utilization Time Loss Upload</b>
                </td>
            </tr>
            <tr >
                <td colspan="2">
                    <a href="#" onclick="assetUtilizationUpload.downloadLineMaster();"><b>Download line master</b></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <a href="#" onclick="assetUtilizationUpload.downloadVariantMaster();"><b>Download variant master</b></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <a href="#" onclick="assetUtilizationUpload.downloadFuelMaster();"><b>Download fuel master</b></a>
                </td>
            </tr>
            <tr>
                <td  width="30%" >
                    Time Loss: Select a XLS file to upload
                </td>
                <td width="70%">
                    <input type="file" name="filePath1" id="filePath1" value="" size="59" style="font-size:10pt">&nbsp;&nbsp;
                    <span class="userInfo">*</span>
                    <br><br>
                </td>
            </tr>
            <tr>
                <td  width="30%">
                    LPF : Select a XLS file to upload
                </td>
                <td width="70%">

                    <input type="file" name="filePath2" id="filePath2" value="" size="59" style="font-size:10pt">&nbsp;&nbsp;

                    <span class="userInfo">*</span>
                    <br><br>
                </td>
            </tr>           
            <tr>
                <td  width="30%">
                    Plant Level LPF : Select a XLS file to upload
                </td>
                <td width="70%">

                    <input type="file" name="filePath3" id="filePath3" value="" size="59" style="font-size:10pt">&nbsp;&nbsp;

                    <span class="userInfo">*</span>                    
                </td>
            </tr>
            <tr>
                <td align="right" colspan="2" style="padding-right: 20px">
                    <br>
                    <input type="button" name="upload"
                           id="upload" value=" Upload " class="buttonSize"
                           onclick="assetUtilizationUpload.validateAndUpload()" accesskey="U">
                </td>
            </tr>
        </table>
    </form>
    <iframe width="100%" frameborder="0" height="420px" id="entryResponseFrameAU" name="entryResponseFrameAU" src=""
            style="visibility: hidden; display: none">
    </iframe>
</div>