<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*"
         import="ubq.util.UDate" errorPage="" %>
<%
    ResultSet rsPlantLines = (ResultSet)request.getAttribute("rsPlantLines");
    ResultSet rsEntityDetails = (ResultSet)request.getAttribute("rsEntity");
    String  productionDate = (String)request.getAttribute("productionDate");
    //ResultSet  shiftDetails = (ResultSet)request.getAttribute("shiftDetails");
    ResultSet  plantLPFRs = (ResultSet)request.getAttribute("plantLPFRs");
    
    int plantRID = null == request.getAttribute("plantRID")? 0 : (Integer)request.getAttribute("plantRID");
    int viewOnly = null == request.getAttribute("viewOnly")? 0 : (Integer)request.getAttribute("viewOnly");
    
    int utilizationHeaderRID = null == request.getAttribute("headerRID")? 0:(Integer) request.getAttribute("headerRID");
    String projectPath =  request.getContextPath();
    String plantName = "";
    int noOfShifts = 0;
    int shiftTime = 0;
    float plantPower = 0;
    float plantFuel = 0;
    float plantLabour = 0;
    String disableStr = "";
    if(viewOnly == 1){
        disableStr = "disabled";
    }
        

    while(null != rsEntityDetails && rsEntityDetails.next()){
        plantName = rsEntityDetails.getString("ent_name");
    }
    
    /* while(null != shiftDetails && shiftDetails.next()){
        noOfShifts = shiftDetails.getInt("psd_no_of_shifts");
        shiftTime = shiftDetails.getInt("psd_shift_time");
    }*/
    
    while(null != plantLPFRs && plantLPFRs.next()){
        plantPower = plantLPFRs.getFloat("pll_total_power");
        plantFuel = plantLPFRs.getFloat("pll_total_fuel");
        plantLabour = plantLPFRs.getFloat("pll_total_labour");
    }
%>

<div id="utilizationEntry" style="background-color: #F1F4F2">

    <input type="hidden" name="jsFile" id="jsFile" value="<%= projectPath%>/js/assetUtlization/AssetUtilization.js">
    <input type="hidden" name="utilizationHeaderRID" id="utilizationHeaderRID" value="<%= utilizationHeaderRID%>">
    <input type="hidden" name="plantRID" id="plantRID" value="<%= plantRID%>">
    
        <table width="100%" cellpadding="0" cellspacing="0" border="0">
            <tr>
                <td width="100%">
                    <fieldset>
                        <table width="100%" border="0">
                            <tr>
                                <td width="10%">Plant Name
                                </td>
                                <td width="20%">
                                    <%= plantName%></td>
                                <td width="10%">Production Date
                                </td>
                                <td width="20%">
                                    <input type="text" name="productionDate" id="productionDate" size="10" value="<%=productionDate%>" readonly onchange="assetUtilization.reloadPage(this)">
                                    <input type="button" name="productionDateButton" id="productionDateButton" value="..." onclick="newPopupCalender('productionDate','productionDateButton');"
                                           <%= disableStr%>>
                                </td>
                                <td width="40%">&nbsp;
                                </td>
                            </tr>
<!--                            <tr>
                                <td width="10%">No of shifts
                                </td>
                                <td width="20%">
                                <//%= noOfShifts%></td>
                                <td width="10%">No of Hrs./Shift
                                </td>
                                <td width="20%">
                                <//%= shiftTime%></td>
                                <td width="40%">&nbsp;
                                </td>
                            </tr>-->
                        </table>
                    </fieldset>
                </td>
            </tr>
            <tr>
                <td width="100%" style="padding-left: 2px">
                    <fieldset class="specialRow" style="vertical-align: middle"> <b>Line Details</b></fieldset>
                </td>
            </tr>
            <tr>
                <td width="100%">
                    <div style="height: 300px;overflow: auto;" id="entryLinesDiv">
                    <table width="100%" cellpadding="0" cellspacing="4" border="0">
                        <% if(null != rsPlantLines && rsPlantLines.next()){
                            rsPlantLines.beforeFirst();
                            %>
                            <tr>
                                <td colspan="4" width="100%">
                                    <fieldset>
                                        <font style="color: #26466D">
                                            Click on the line to enter time loss details
                                        </font>
                                    </fieldset>
                                </td>
                            <tr>

                            <%
                            while(rsPlantLines.next()){
                                int lineRID = rsPlantLines.getInt("pml_rid");
                                String lineCode = rsPlantLines.getString("pml_code");
                                String lineName = rsPlantLines.getString("pml_name");
                                String lineDescription = rsPlantLines.getString("pml_description");
                                String lineSpecification = rsPlantLines.getString("pml_specification");
                            %>
                                <tr>
                                    <td width="25%" style="padding-left: 3px;cursor: pointer;background-color: #87CEEB;height:
                                        30px;border:groove;border-style: groove;" onclick ="assetUtilization.showTimeLossEntry(this)">
                                        <input type="hidden" name="lineRID" name="lineRID" value="<%= lineRID%>">
                                        <input type="hidden" name="lineCode" name="lineCode" value="<%= lineCode%>">
                                        <input type="hidden" name="lineName" name="lineName" value="<%= lineName%>">
                                        <b><%= lineName %></b>
                                        <br>
                                        <label id="lineName"><%= lineSpecification%></label>
                                    </td>
                                    <td width="1%" style="padding-left: 3px;height: 30px">&nbsp;</td>
                                    <td width="40%" style="background-color:#EAE7C4;border:groove;border-style: groove;height: 30px">
                                        <%= lineDescription%>
                                    </td>
                                    <td width="34%">&nbsp;
                                    </td>
                                </tr>
                        <%}}else{%>
                            <tr>
                                <td width="100%" colspan="100%">
                                    No Lines Found for this plant
                                </td>
                            </tr>
                        <%}%>
                    </table>
                    </div>
                </td>
            </tr>
        </table>
                    
        <div>
            <fieldset>
                <table width="100%" cellpadding="0" cellspacing="2">
                    <tr>
                         <td width="15%" align="left" style="padding-left: 10px;background-color: #87CEEB">
                            Labour (Manday)
                        </td>
                        <td width="15%" align="left">
                            <input type="text" size="6" id="plantLabourUnit" name="plantLabourUnit" value="<%= plantLabour%>" style="text-align: right"
                                   onkeypress="restrictInput(this,keybDecimal,event)"  <%if(viewOnly == 1){%> readonly <%}%>>
                        </td>
                        <td width="15%" align="left" style="padding-left: 10px;background-color: #87CEEB">
                            Power (KWH)
                        </td>
                        <td width="15%" align="left" >
                            <input type="text" size ="6" id="plantPowerUnit" name="plantPowerUnit" value="<%= plantPower%>" style="text-align: right"
                                   onkeypress="restrictInput(this,keybDecimal,event)" <%if(viewOnly == 1){%> readonly <%}%>>
                        </td>
                        <td width="15%" align="left" style="padding-left: 10px;background-color: #87CEEB">
                            Fuel (HSD Ltr)
                        </td>
                        <td width="15%" align="left">
                            <input type="text" size="6" id="plantFuelUnit" name="plantFuelUnit" value="<%= plantFuel%> " style="text-align: right"
                                   onkeypress="restrictInput(this,keybDecimal,event)" <%if(viewOnly == 1){%> readonly <%}%>>
                        </td>
                       
                        <td width="10%"></td>
                    </tr>
                    <tr>
                        <td width="100%"  align="right" style="padding-right: 30px" colspan="7"><br><br>
                            <%if(viewOnly == 0){%>
                                <input type="button" id="saveButton" name="saveButton" value="  Save  " onclick="assetUtilization.finalSave();">
                            <%}%>
                        </td>
                    </tr>
                </table>
            </fieldset>
    </div>
</div>