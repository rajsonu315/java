<%-- 
    Document   : TimeLossEntry
    Created on : Apr 5, 2013, 1:18:46 PM
    Author     : subhransu
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="windows-1252"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%
            ResultSet timeLossParmsRs = (ResultSet) request.getAttribute("timeLossParmsRs");
            ResultSet rsVarinats = (ResultSet) request.getAttribute("rsVarinats");

            HashMap timeLossHm = (HashMap) request.getAttribute("timeLossHm");
            
            ResultSet LPFRs = (ResultSet) request.getAttribute("LPFRs");


            HashMap timeUtilHm = (HashMap) request.getAttribute("timeUtilHm");

            HashMap utilEffHm = (HashMap) request.getAttribute("utilEffHm");
            
            ResultSet rsEffParams = (ResultSet)request.getAttribute("rsEffParams");
            
            DecimalFormat fmt = new DecimalFormat("####0.0");



            
            String productionDate = (String) request.getAttribute("productionDate");
            String variantRatedCapacity = (String) request.getAttribute("variantRatedCapacityStr");

            int plantRID = null == request.getAttribute("plantRID")? 0 :(Integer)request.getAttribute("plantRID");
            int lineRID = null == request.getAttribute("lineRID")? 0 :(Integer)request.getAttribute("lineRID");
            int utilizationHeaderRID= null == request.getAttribute("utilizationHeaderRID")? 0 :(Integer)request.getAttribute("utilizationHeaderRID");
            int canModify = null == request.getAttribute("canModify")? 0 :(Integer)request.getAttribute("canModify");
            int viewMode = null == request.getAttribute("viewMode")? 0 :(Integer)request.getAttribute("viewMode");

            int noOfShifts = null == request.getAttribute("noOfShifts")? 0 :(Integer)request.getAttribute("noOfShifts");
            float shiftDuration = null == request.getAttribute("shiftDuration")? 0 :(Float)request.getAttribute("shiftDuration");
            Float totalAvailTime = null == request.getAttribute("totalAvailTime") ? 0 : (Float) request.getAttribute("totalAvailTime");
            Float totalTime = null == request.getAttribute("totalTime") ? 0 : (Float) request.getAttribute("totalTime");

            int noOfParams = 0;
            String projPath = request.getContextPath();
            String disableString = "";
            String readOnlyString = "";

            if(1 == viewMode && 0 == canModify){
                disableString = "disabled";
                readOnlyString = "readonly";
            }else{
                disableString = "";
                readOnlyString = "";
            }

            String saveBtnText = "";
            String FeulDetString = "0@ @0@0@0@0@ ,";


%>
<div style="width: 100%">
    <form id="timeLossForm" name="timeLossForm" action="<%= projPath%>/AssetUtilizationServlet" method="post" target="targetEntryResponse">
        <input type="hidden" id="variantRatedCapacity" name="variantRatedCapacity" value="<%= variantRatedCapacity%>">
        <input type="hidden" name="lineRID" id="lineRID" value="<%= lineRID%>">
        <input type="hidden" name="plantRID" id="lineRID" value="<%= plantRID%>">
        <input type="hidden" name="successHandler" id="successHandler" value="assetUtilization.handleSuccess">
        <input type="hidden" name="failureHandler" id="failureHandler" value="assetUtilization.handleFailure">
        <input type="hidden" id="totalTime" name="totalTime" value="<%= totalTime%>">
        <input type="hidden" id="totalAvailTime" name="totalAvailTime" value="<%= totalAvailTime%>">
        <input type="hidden" id="productionDate" name="productionDate" value="<%= productionDate%>">
        <input type="hidden" id="command" name="command" value="">
        <input type="hidden" id="canModify" name="canModify" value="<%= canModify%>">
        <input type="hidden" id="viewMode" name="viewMode" value="<%= viewMode%>">
        
        <fieldset style="width: 98%">
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td width="100%" colspan="100%">
                        <fieldset>
                        <table width="100%" cellpadding="0" cellspacing="0">
                            <td width="52%">&nbsp;</td>
                            <td width="12%">No of Shifts</td>
                            <td width="10%">

                                <select id="noOfShiftsSelect" style="width: 45px" onchange="assetUtilization.setNoOfShifts(this);" <%= disableString %>>
                                    <option value="0"></option>
                                    <%for(int i=1; i <= 3; i++){%>
                                    <option value="<%= i%>" <%if(noOfShifts == i){%>selected<%}%> ><%= i%></option>
                                    <%}%>
                                </select>
                                <input type="hidden" id="noOfShifts" name="noOfShifts" value="<%= noOfShifts%>">

                            </td>
                            <td width="12%">Shift Duration (Hr.)</td>
                            <td width="10%"><input type="text" style="text-align: right;border: none" name="shiftDuration" id="shiftDuration" value="<%= shiftDuration%>" size="4"
                                                   onkeypress="restrictInput(this,keybDecimal,event)" readonly
                                                    ></td>
                        </table>
                        </fieldset>
                    </td>
                </tr>
                <tr>
                    <td width="50%">
                        <table width="100%"  cellpadding="0" cellspacing="1" border="0">
                            <tr class="header" valign="top" style="height: 20px">
                                <td width="30%" style="padding-left: 2px">
                                    <b> Time Loss Factor</b>
                                </td>
                                <td width="8%" style="padding-left: 2px">
                                    <b>Time Loss (Hrs.)</b>
                                </td>
                                <td width="15%" style="padding-left: 2px">
                                    <b>Reason for Time Loss</b>
                                </td>
                            </tr>
                            <%if (null != timeLossParmsRs && timeLossParmsRs.next()) {

                                            noOfParams = 1;
                                            //String readonlyStr = "";
                                            timeLossParmsRs.beforeFirst();
                                            while (timeLossParmsRs.next()) {
                                                String timeLoss = "";
                                                String remarks = "";
                                                String className = "";
                                                String readOnlyClass = "";
                                                String readOnlyStr = "";
                                                String paramName = timeLossParmsRs.getString("ltp_name");
                                                String paramCode = timeLossParmsRs.getString("ltp_code");
                                                int paramParentRid = timeLossParmsRs.getInt("ltp_parent_rid");
                                                int paramRid = timeLossParmsRs.getInt("ltp_rid");
                                                //if (paramParentRid > 0) {
                                                if ("PROCESS_BRKDWN".equals(paramCode) || "ELECT_BRKDWN".equals(paramCode) || "OVEN_BRKDWN".equals(paramCode) || "MACHINE_BRKDWN".equals(paramCode)) {
                                                    className = "childParamRow";
                                                } else {
                                                    className = "parentParamRow";
                                                }

                                                if ("BREAKDOWN".equals(paramCode) || "TOTAL_STOP".equals(paramCode)) {
                                                    //readonlyStr = "readonly";
                                                    readOnlyClass = "readOnlyBackground";
                                                    readOnlyStr = "readonly";
                                                } else {
                                                    readOnlyClass = "";
                                                    readOnlyStr = "";
                                                }
                                                if (null != timeLossHm) {
                                                    String lossAndRemarksStr = null == timeLossHm.get(paramCode) ? "" : (String) timeLossHm.get(paramCode);
                                                    if (!"".equals(lossAndRemarksStr)) {
                                                        String[] lossAndRemarksArr = lossAndRemarksStr.split("~~");
                                                        timeLoss = lossAndRemarksArr[0];
                                                        if (lossAndRemarksArr.length > 1) {
                                                            remarks = lossAndRemarksArr[1];
                                                        }
                                                    }
                                                }

                            %>
                            <tr class="<%= className%>">
                                <td width="30%" style="padding-left: 2px">
                                    <%= paramName%>
                                    <input type="hidden" id="paramName" name="paramName" value="<%= paramName%>">
                                    <input type="hidden" id="paramRID" name="paramRID" value="<%= paramRid%>">
                                    <input type="hidden" id="paramParentRID" name="paramParentRID" value="<%= paramParentRid%>">
                                    <input type="hidden" id="paramCode" name="paramCode" value="<%= paramCode%>">
                                    <input type="hidden" id="<%=paramRid%>" name="<%=paramRid%>">
                                    <input type="hidden" id="<%=paramCode%>" name="<%=paramCode%>">
                                </td>
                                <td width="8%">
                                    <input type="text" style="text-align: right" lang ="<%=paramParentRid%>" size="8" id="timeLoss" name ="timeLoss" class="<%=readOnlyClass%>"
                                           onkeypress="restrictInput(this,keybDecimal,event)"
                                           onblur="assetUtilization.setParentValue(this);" <%= readOnlyString%> <%= readOnlyStr%>
                                           value="<%= timeLoss%>"
                                           >
                                </td>
                                <td width="15%">
                                    <input type="text" id="timeLossReason" name ="timeLossReason"  value="<%= remarks%>" <%= readOnlyString%>>
                                </td>
                            </tr>
                            <%}
                            } else {%>
                            <tr>
                                <td width="100%">
                                    No Factor Found
                                </td>
                            </tr>
                            <%}%>
                        </table>
                    </td>
                    <td width="50%">
                        <table width="100%" cellspacing="1" cellpadding="0">
                            <%
                            int paramType = 0;
                            String paramCode = "";
                            float effValue = 0;
                            if(null != rsEffParams && rsEffParams.next()){
                                %>
                                <tr class="header" valign="top" style="height: 20px">
                                <td width="40%" style="padding-left: 2px" >
                                    <b> Time Utilization Details</b>
                                </td>
                                <td width="10%" style="padding-left: 10px" colspan="2">
                                    <b> (Hrs.)</b>
                                </td>
                                </tr>
                                <%
                                rsEffParams.beforeFirst();
                                while(rsEffParams.next()){
                                    effValue = 0;
                                    paramType = rsEffParams.getInt("pep_parameter_type");
                                    paramCode = rsEffParams.getString("pep_code");
                                  if(1== paramType){
                                    if(null != timeUtilHm && timeUtilHm.size() > 0){
                                     effValue = Float.valueOf(null == timeUtilHm.get(paramCode)? "0" :timeUtilHm.get(paramCode).toString());
                                    }
                                %>
                                    <tr  valign="top" style="height: 20px; background-color: #D3DEB3" >
                                        <td width="40%" style="padding-left: 2px">
                                             <%= rsEffParams.getString("pep_name")%>
                                        </td>
                                        <td width="10%" style="padding-left: 2px">
                                            <input type="hidden" id="<%= paramCode%>" name="<%= paramCode%>" value="0">
                                            <input type="text" size ="5" id="timeUtilValue" name="timeUtilValue" style="text-align: right"
                                             value="<%= fmt.format(Double.valueOf(effValue))%>" readonly>
                                        </td>
                                        <td width="50%" style="padding-left: 5px">
                                            <%= rsEffParams.getString("pep_definition")%>
                                        </td>
                                    </tr>
                            <%  }
                               }
                               rsEffParams.beforeFirst();
                             }
                            %>
                            <%if(null != rsEffParams && rsEffParams.next()){

                                %>
                                <tr class="header" valign="top" style="height: 20px">
                                <td width="40%" style="padding-left: 2px" colspan="1">
                                    <b> Utilization Efficiency Details</b>
                                </td>
                                <td width="10%" style="padding-left: 10px" colspan="2">
                                    <b>(%)</b>
                                </td>
                                </tr>
                                <%
                                rsEffParams.beforeFirst();
                                while(rsEffParams.next()){
                                    effValue = 0;
                                    paramType = rsEffParams.getInt("pep_parameter_type");
                                    paramCode = rsEffParams.getString("pep_code");
                                    if(2 == paramType){
                                    if(null != utilEffHm && utilEffHm.size() > 0){
                                        effValue = Float.valueOf(utilEffHm.get(paramCode).toString());
                                    }

                                %>
                                    <tr valign="top" style="height: 20px;background-color: #D3DEB3">
                                        <td width="40%" style="padding-left: 2px">
                                             <%= rsEffParams.getString("pep_name")%>
                                        </td>
                                        <td width="10%" style="padding-left: 2px">
                                            <input type="hidden" id="<%= paramCode%>" name="<%= paramCode%>" value="0">
                                            <input type="hidden" id="utilEffParamName" name="utilEffParamName" value="<%= rsEffParams.getString("pep_name")%>">
                                            <input type="text" size="5" id="utilEffValue" name="utilEffValue" style="text-align: right"
                                                   value="<%= fmt.format(Double.valueOf(effValue))%>" readonly>
                                        </td>
                                        <td width="50%" style="padding-left: 5px">
                                             <%= rsEffParams.getString("pep_definition")%>
                                        </td>
                                    </tr>
                                <%}
                                }
                              }%>
                        </table>
                    </td>
                </tr>
                
                <tr>
                    <td width="100%" colspan="3">
                        <fieldset style="width: 97%">
                            <legend>LPF Entry</legend><br>
                            <div style="height: 100px;overflow: auto">
                                <table width="100%" cellpadding="0" cellspacing="1">
                                    <tr class="specialRow" valign="top">
                                        <td width="20%" style="padding-left: 2px">Variant
                                        </td>
                                        <td width="8%" style="padding-left: 2px">Rated Cap.(MT/Day)
                                        </td>
                                        <td width="8%" style="padding-left: 2px">Run Time (Hrs.)
                                        </td>
                                        <td width="8%" style="padding-left: 2px">Production (MT)
                                        </td>
                                        <td width="7%" style="padding-left: 2px">Labour (Manday)
                                        </td>
                                        <td width="7%" style="padding-left: 2px">Labour (Manday/MT)
                                        </td>
                                        <td width="7%" style="padding-left: 2px">Power (KWH)
                                        </td>
                                        <td width="7%" style="padding-left: 2px">Power (KWH/MT)
                                        </td>
                                        <td width="12%" style="padding-left: 2px">Fuel (HSD Ltr)
                                        </td>
                                        <td width="7%" style="padding-left: 2px">Fuel (HSD Ltr/MT)
                                        </td>
                                        <td width="5%">&nbsp;
                                        </td>
                                    </tr>
                                    <%if(null != LPFRs && LPFRs.next()){
                                        
                                        LPFRs.beforeFirst();
                                        while(LPFRs.next()){
                                            if(null != rsVarinats){
                                                rsVarinats.beforeFirst();
                                            }
                                            int varIndex = LPFRs.getInt("lvd_variant_index");
                                            float ratedCap = LPFRs.getFloat("lvd_line_rated_capacity");
                                            float production = LPFRs.getFloat("lvd_production");
                                            float labour = LPFRs.getFloat("lvd_labour");
                                            float labourAvg = LPFRs.getFloat("lvd_labour_per_prod_unit");
                                            float power = LPFRs.getFloat("lvd_power");
                                            float powerAvg = LPFRs.getFloat("lvd_power_per_prod_unit");
                                            float fuel = LPFRs.getFloat("lvd_fuel");
                                            float fuelAvg = LPFRs.getFloat("lvd_fuel_per_prod_unit");
                                            float variantRunTime = LPFRs.getFloat("lvd_run_time");
                                            int lpfRid = LPFRs.getInt("lvd_rid");

                                            %>
                                            <tr id ="lpfRow" valign="top">

                                            <input type ="hidden" name="LPFDetailRid" id="LPFDetailRid" value="<%= lpfRid%>">
                                            <input type="hidden" name="feulDetailStr" id="feulDetailStr" value="<%= FeulDetString%>">
                                                <td width="20%">
                                                    <select id="variants" name="variants" style="width: 150px"
                                                            onchange="assetUtilization.loadRatedCapacity(this);" <%= disableString%>>
                                                        <option value="0"> </option>

                                                        <%while (rsVarinats != null && rsVarinats.next()) {
                                                            String variantName = rsVarinats.getString("dd_value");
                                                            int variantIndex = rsVarinats.getInt("pmv_variant_index");
                                                        %>
                                                        <option value="<%= variantIndex%>" <%if(varIndex == variantIndex){%>selected<%}%>>
                                                            <%= variantName%> </option>
                                                        <%}%>

                                                    </select>
                                                    <label id="variantName" name="variantName"  class="hidden" ></label>
                                                    <input type="hidden" id="variantIndex" name="variantIndex" value="<%= varIndex%>">
                                                </td>
                                                <td width="8%">
                                                    <input type="text" value="<%= ratedCap%>" id="ratedCapacity" name="ratedCapacity" readonly size="5"
                                                           style="text-align: right;background-color: lightgray;">
                                                </td>
                                                <td width="8%">
                                                    <input type="text" value="<%= variantRunTime%>" id="variantRunTime" name="variantRunTime" onkeypress="restrictInput(this,keybDecimal,event)"  size="7"
                                                           style="text-align: right">
                                                </td>
                                                <td width="8%">
                                                    <input type="text" value="<%= production%>" id="production" name="production" onkeypress="restrictInput(this,keybDecimal,event)" size="7" <%= readOnlyString%>
                                                           onchange="assetUtilization.calculateEffDetails(this);assetUtilization.setAvgValueForAll(this);"
                                                           style="text-align: right">
                                                </td>
                                                <td width="7%">
                                                    <input type="text" value="<%= labour%>" id="labour" name="labour" onkeypress="restrictInput(this,keybDecimal,event)" size="7" onchange="assetUtilization.setAvgValue(this,'labourAvg')"
                                                           style="text-align: right">
                                                </td>
                                                <td width="7%">
                                                    <input type="text" value="<%= labourAvg%>" id="labourAvg" name="labourAvg" onkeypress="restrictInput(this,keybDecimal,event)" readonly size="7" class="readOnlyBackground"
                                                           style="text-align: right">
                                                </td>
                                                <td width="7%">
                                                    <input type="text" value="<%= power%>" id="power" name="power" onkeypress="restrictInput(this,keybDecimal,event)" size="7" style="text-align: right"
                                                            onchange="assetUtilization.setAvgValue(this,'powerAvg')" 
                                                           >
                                                </td>
                                                <td width="7%">
                                                    <input type="text" value="<%= powerAvg%>" id="powerAvg" name="powerAvg" onkeypress="restrictInput(this,keybDecimal,event)" readonly size="7" class="readOnlyBackground"
                                                           style="text-align: right">
                                                </td>
                                                <td width="12%">
                                                    <input type="text" value="<%= fuel%>" id="fuel" name="fuel" readonly onkeypress="restrictInput(this,keybDecimal,event)" size="7" onchange="assetUtilization.setAvgValue(this,'fuelAvg')"
                                                           style="text-align: right">
                                                    <span><input type="button" name="fuelDetailsBtn" id="fuelDetailsBtn" size="1" value="..." onclick="assetUtilization.openFuelDetailsPopup(this);"></span>
                                                </td>
                                                <td width="7%">
                                                    <input type="text" value="<%= fuelAvg%>" id="fuelAvg" name="fuelAvg" onkeypress="restrictInput(this,keybDecimal,event)" readonly size="7" class="readOnlyBackground"
                                                           style="text-align: right">
                                                </td>
                                                
                                                <td width="5%">
                                                     <img name="variantAdd" id="variantAdd" class="hidden"
                                                     onclick="assetUtilization.addVariant(this);"
                                                     src="<%= projPath%>/images/add.png" alt="Add more Variant" >
                                                     <img name="variantDelete" id="variantDelete" class="hidden"
                                                     onclick="assetUtilization.deleteVariant(this);"
                                                     src="<%= projPath%>/images/delete.gif" alt="Delete the Variant" >
                                                </td>
                                            </tr>
                                        <%}
                                    }else{%>
                                    <tr id ="lpfRow" valign="top">
                                    <input type ="hidden" name="LPFDetailRid" id="LPFDetailRid" value="0">
                                    <input type="hidden" name="feulDetailStr" id="feulDetailStr" value="<%= FeulDetString%>">
                                        <td width="20%">
                                            <select id="variants" name="variants" style="width: 150px" onchange="assetUtilization.loadRatedCapacity(this)">
                                                <option value="0"> </option>

                                                <%while (rsVarinats != null && rsVarinats.next()) {
                                                    String variantName = rsVarinats.getString("dd_value");
                                                    int variantIndex = rsVarinats.getInt("pmv_variant_index");
                                                %>
                                                <option value="<%= variantIndex%>"> <%= variantName%> </option>
                                                <%}%>

                                            </select>
                                            <label id="variantName" name="variantName"  class="hidden" ></label>
                                            <input type="hidden" id="variantIndex" name="variantIndex" value="0">
                                        </td>
                                        <td width="8%">
                                            <input type="text" style="text-align: right;background-color: lightgray;" value="" id="ratedCapacity" name="ratedCapacity" readonly size="5">
                                        </td>
                                        <td width="8%">
                                            <input type="text" style="text-align: right;" value="" id="variantRunTime" name="variantRunTime" onkeypress="restrictInput(this,keybDecimal,event)"
                                                   size="7">
                                        </td>
                                        <td width="8%">
                                            <input type="text" style="text-align: right" value="" id="production" name="production" onkeypress="restrictInput(this,keybDecimal,event)" size="7"
                                                   onchange ="assetUtilization.calculateEffDetails(this);assetUtilization.setAvgValueForAll(this);">
                                        </td>
                                        <td width="7%">
                                            <input type="text" style="text-align: right" value="" id="labour" name="labour" onkeypress="restrictInput(this,keybDecimal,event)" size="7" onchange="assetUtilization.setAvgValue(this,'labourAvg')">
                                        </td>
                                        <td width="7%">
                                            <input type="text" style="text-align: right;background-color: lightgray;" value="" id="labourAvg" name="labourAvg" onkeypress="restrictInput(this,keybDecimal,event)" readonly
                                                   size="7">
                                        </td>
                                        <td width="7%">
                                            <input type="text" style="text-align: right" value="0" id="power" name="power" onkeypress="restrictInput(this,keybDecimal,event)" size="7"
                                                    onchange="assetUtilization.setAvgValue(this,'powerAvg')"
                                                   >
                                        </td>
                                        <td width="7%">
                                            <input type="text" style="text-align: right;background-color: lightgray;" value="" id="powerAvg" name="powerAvg" onkeypress="restrictInput(this,keybDecimal,event)" readonly
                                                   size="7">
                                        </td>
                                        <td width="12%">
                                            <input type="text" style="text-align: right" value="" id="fuel"  name="fuel" readonly onkeypress="restrictInput(this,keybDecimal,event)" size="7" onchange="assetUtilization.setAvgValue(this,'fuelAvg')">
                                            <span><input type="button" name="fuelDetailsBtn" id="fuelDetailsBtn" size="1" value="..." onclick="assetUtilization.openFuelDetailsPopup(this);"></span>
                                        </td>
                                        <td width="7%">
                                            <input type="text" style="text-align: right;background-color: lightgray;" value="" id="fuelAvg" name="fuelAvg" onkeypress="restrictInput(this,keybDecimal,event)" readonly
                                                   size="7">
                                        </td>
                                        
                                        <td width="5%">
                                             <img name="variantAdd" id="variantAdd"
                                             onclick="assetUtilization.addVariant(this);"
                                             src="<%= projPath%>/images/add.png" alt="Add more Variant" >
                                             <img name="variantDelete" id="variantDelete" class="hidden"
                                             onclick="assetUtilization.deleteVariant(this);"
                                             src="<%= projPath%>/images/delete.gif" alt="Delete the Variant" >
                                        </td>
                                    </tr>
                                    <%}%>
                                </table>
                            </div>
                        </fieldset>
                    </td>
                </tr>
                <tr align="right">
                    <td width="100%" colspan="100%" style="padding-right: 15px">
                        <%if(1== viewMode && 1 == canModify){
                                saveBtnText = " Modify ";
                          }else{
                                saveBtnText = " Save ";
                          }
                        %>
                       <%if(1 == canModify){%>
                            <input type="button" id="saveBtn" name="saveBtn" value=" <%= saveBtnText %> " onclick="assetUtilization.saveForm()">
                       <%}%>
                       <input type="button" id="closeBtn" name="closeBtn" value=" Close " onclick="assetUtilization.close()">
                    </td>
                </tr>
            </table>
        </fieldset>
    </form>
    <iframe id="targetEntryResponse" name="targetEntryResponse" style="visibility: hidden;display: none;"></iframe>
</div>
