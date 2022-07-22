<iframe id="infoFrame" style="visibility:hidden; display:none; width:400px;z-index:3;" class="infoBox"></iframe>
<div id="infoDiv" style="visibility:hidden; cursor:pointer; display:none; width:400px;z-index:4;" class="infoBox"
     onmouseout="closeInfoDiv()" onmouseover="setCommonInfoDivVisible()">
    <table width="100%">
        <tr>
            <td align="left">
                <div id="infoText" class="labelS"></div>
            </td>
<!--        <td align="right" valign="top"><img src="<%=request.getContextPath()%>/images/wrongHelpDiv.gif" style="cursor:hand;" 
            title="Close" onclick="closeInfoDiv()"></td> -->
            <td align="right" valign="top"><span class="clickMe" onclick="closeInfoDiv()"><u>Close</u></span> </td>
        </tr>
        <tr id="infoRow">
        <div id="sumDiv"></div>
        </tr>
    </table>
            
</div>    