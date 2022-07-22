function AssetUtilization(){
    var self = this;
    var variantCapacityHm = null;
    self.showTimeLossEntry = function(elem){
        var utilizationHeaderRID = document.getElementById("utilizationHeaderRID").value;
        var productionDate = document.getElementById("productionDate").value;
        var lineRID = dynTableGetNodeInRow(elem, "lineRID").value;
        var lineCode = dynTableGetNodeInRow(elem, "lineCode").value;
        var lineName = dynTableGetNodeInRow(elem, "lineName").value;

        var url =  PROJECT_CTXT_PATH + "/AssetUtilizationServlet?command=openTimeLossEntry&lineRID=" + lineRID + "&lineCode=" + lineCode
                   + "&utilizationHeaderRID="+ utilizationHeaderRID + "&productionDate="+ productionDate;
        desktop.showPopup("Time Loss Entry for : " + lineName, url,{width:900,height:520,top:120,left:200,scrollable:true,
        onLoad:function(){
            assetUtilization.initPage();
        }
        }, true);
    }

    self.reloadPage = function(elem){
        var productionDate = elem.value;
        var url = "/AssetUtilizationServlet?command=initAssetUtilization&productionDate=" + productionDate;
        desktop.loadPage(url, 'Line Utilization Entry');
    }

    self.initPage = function(){
        variantCapacityHm = new Hashtable();
        if(document.getElementById("variantRatedCapacity") && "" != document.getElementById("variantRatedCapacity").value){
            var variantRatedCapacity = document.getElementById("variantRatedCapacity").value;
            var variantArray = variantRatedCapacity .split("~");
            for(var i=0;i<variantArray.length;i++){
                var tempStr = variantArray[i];
                var variantIndex = tempStr.split("@")[0];
                var variantCapacity = tempStr.split("@")[1];
                try{
                    variantCapacityHm.put(variantIndex,variantCapacity);
                }catch(ex){
                    alert("Rated capacity is not set for variants");
                }
            }

          self.getFuelDetailsString(); 
        }
    }
    self.loadRatedCapacity = function(selectElem){
        var variantIndex = selectElem.value;
        var capacity = undefined == variantCapacityHm.get(variantIndex)? "" : variantCapacityHm.get(variantIndex);
        dynTableGetNodeInRow(selectElem, "ratedCapacity").value = capacity;
        
        dynTableGetNodeInRow(selectElem, "variantIndex").value = selectElem.value;
    }
    self.close = function(){
        desktop.closePopup();
    }

    self.addVariant = function(elem){
        var curRow = dynTableRow(elem);
        if(!self.validateVariant(elem,false)){
            return false;
        }else{
            self.setVariantDetail(dynTableGetNodeInRow(curRow, "variants"));
            var tmplRow = document.getElementById('lpfRow').cloneNode(true);           
            
            dynTableGetNodeInRow(tmplRow, "variantIndex").value = 0;
            dynTableGetNodeInRow(tmplRow, "variantName").value = "";
            dynTableGetNodeInRow(tmplRow, "ratedCapacity").value = "";
            dynTableGetNodeInRow(tmplRow, "production").value = "";
            dynTableGetNodeInRow(tmplRow, "labour").value = "";
            dynTableGetNodeInRow(tmplRow, "labourAvg").value = "";
            dynTableGetNodeInRow(tmplRow, "power").value = 0;
            dynTableGetNodeInRow(tmplRow, "powerAvg").value = "";
            dynTableGetNodeInRow(tmplRow, "fuel").value = "";
            dynTableGetNodeInRow(tmplRow, "fuelAvg").value = "";
            dynTableGetNodeInRow(tmplRow, "variantRunTime").value = "";         
            dynTableGetNodeInRow(tmplRow,"feulDetailStr").value = self.getFuelDetailsForNewRow();
            //curRow.parentNode.insertBefore(tmplRow, curRow);

            curRow.parentNode.appendChild(tmplRow);
            tmplRow.id="lpfRow";
            curRow.id = "";

            dynTableGetNodeInRow(curRow, "variantName").className = "visible";
            dynTableGetNodeInRow(curRow, "variants").className = "hidden";
            //make the fields readonly
            //dynTableGetNodeInRow(curRow, "sampleCode").readOnly = true;

            dynTableGetNodeInRow(curRow, "variantAdd").className = "hidden";
            dynTableGetNodeInRow(curRow, "variantDelete").className = "visible";
            return true;
        }
    }


    self.deleteVariant = function(elem) {
        var row = dynTableRow(elem);
        dynTableDeleteRow(row);
        self.calculateEffDetails(elem);
    };
    
    self.setVariantDetail = function(elem){
        var variantIndex = elem.options[elem.selectedIndex].value;
        var varinatName = elem.options[elem.selectedIndex].text;
        dynTableGetNodeInRow(elem, "variantIndex").value = variantIndex;
        dynTableGetNodeInRow(elem, "variantName").innerHTML = varinatName;
    }

    self.validateVariant = function(elem,finalValidation){
        var variantSelect = dynTableGetNodeInRow(elem, "variants");
        var ratedCapacity = dynTableGetNodeInRow(elem, "ratedCapacity");
        var production = dynTableGetNodeInRow(elem, "production");
        var labour = dynTableGetNodeInRow(elem, "labour");
        var power = dynTableGetNodeInRow(elem, "power");
        var fuel = dynTableGetNodeInRow(elem, "fuel");
        var variantRunTime = dynTableGetNodeInRow(elem, "variantRunTime");

        var selectedVariantIndex = Number(dynTableGetNodeInRow(elem,"variants").options[dynTableGetNodeInRow(elem,"variants").selectedIndex].value);
        if(variantSelect.value == 0){
            if(finalValidation && !dynTableIsLastRow(elem)){
                alert("Delete the blank rows ");
                return false;
            }
//            else{
//                variantSelect.focus();
//                alert("Select a variant for LPF");
//                return false;
//            }
        }
        var variantIndexs = document.getElementsByName("variantIndex");
        var variantCount = 0;
        for(var i= 0 ;i< variantIndexs.length;i++){
            if(variantIndexs[i].value == selectedVariantIndex){
                variantCount ++;
            }
        }
        if(variantCount > 1){
            alert("Variant already selected");
            dynTableGetNodeInRow(elem,"variants").selectedIndex = 0;
            self.setVariantDetail(dynTableGetNodeInRow(elem,"variants"));
            dynTableGetNodeInRow(elem, "ratedCapacity").value = "";
            dynTableGetNodeInRow(elem, "production").value = "";
            dynTableGetNodeInRow(elem, "labour").value = "";
            dynTableGetNodeInRow(elem, "labourAvg").value = "";
            dynTableGetNodeInRow(elem, "power").value = 0;
            dynTableGetNodeInRow(elem, "powerAvg").value = "";
            dynTableGetNodeInRow(elem, "fuel").value = "";
            dynTableGetNodeInRow(elem, "fuelAvg").value = "";
            return false;
        }

        if(selectedVariantIndex > 0  && ratedCapacity.value == ""){
            alert("Rated capacity is not set for variant");
            ratedCapacity.focus();
            return false;
        }
        if(selectedVariantIndex > 0  &&  production.value == ""){
            alert("Enter value for production");
            production.focus();
            return false;
        }
        if(selectedVariantIndex > 0  &&  labour.value == ""){
            alert("Enter value for labour");
            labour.focus();
            return false;
        }
//        if(power.value == ""){
//            alert("Enter value for power");
//            power.focus();
//            return false;
//        }
//        if(selectedVariantIndex > 0  &&  fuel.value == ""){
//            alert("Enter value for fuel");
//            fuel.focus();
//            return false;
//        }
        if(selectedVariantIndex > 0  &&  variantRunTime.value == ""){
            alert("Enter value for run time");
            variantRunTime.focus();
            return false;
        }
        
        return true;
    }

    self.setAvgValue = function(elem,avgElemId){
        var production = dynTableGetNodeInRow(elem, "production");
        var avgElement = dynTableGetNodeInRow(elem,avgElemId);
        if("" == elem.value){
            return;
        }
        if("" == production.value || 0 == Number(production.value)){
            alert("Production value is not set");
            elem.value = "";
            return;
        }else{
            avgElement.value = (elem.value / production.value).toFixed(2);
        }
    }
    self.setAvgValueForAll = function(elem){
        var production = elem.value;
        var labourAvg = dynTableGetNodeInRow(elem,"labourAvg");
        var labour = dynTableGetNodeInRow(elem,"labour");
        var fuelAvg = dynTableGetNodeInRow(elem,"fuelAvg");
        var fuel = dynTableGetNodeInRow(elem,"fuel");
        if("" == elem.value){
            return;
        }
        var labourValue = labour.value == ""? 0 : labour.value;
        var fuelValue = fuel.value == ""? 0 : fuel.value;
        if(Number(production) > 0){
            labourAvg.value = ((labourValue) / production).toFixed(2);
            fuelAvg.value = (fuelValue / production).toFixed(2);
        }else{
            labourAvg.value = 0;
            fuelAvg.value = 0;
        }
        
    }
    
    self.validateFinazile = function(){

        var paramRIDs = document.getElementsByName("paramRID");
        var totalAvailTime = document.getElementById("totalAvailTime").value;
        var validParamEntry = 0;

        for(var i=0 ;i<paramRIDs.length;i++){
            if("" != dynTableGetNodeInRow(paramRIDs[i],"timeLoss").value){
                validParamEntry = 1;
                break;
            }
        }
        if(validParamEntry == 0){
            alert("Enter necessary parameters to save");
            return false;
        }
        
        for(var j=0 ;j<paramRIDs.length;j++){
            if("" == dynTableGetNodeInRow(paramRIDs[j],"timeLossReason").value && (dynTableGetNodeInRow(paramRIDs[j],"timeLoss").value != ""
                 && parseFloat(dynTableGetNodeInRow(paramRIDs[j],"timeLoss").value) > 0)) {

                if(dynTableGetNodeInRow(paramRIDs[j],"paramCode").value != 'BREAKDOWN' && dynTableGetNodeInRow(paramRIDs[j],"paramCode").value != 'TOTAL_STOP'){
                    alert("Enter remarks for " + dynTableGetNodeInRow(paramRIDs[j],"paramName").value);
                    dynTableGetNodeInRow(paramRIDs[j],"timeLossReason").focus();
                    return false;
                }
            }
        }
        
        //var params = document.getElementsByName("paramRID");
        for(var i =0;i< paramRIDs.length;i++){
            if(Number(dynTableGetNodeInRow(paramRIDs[i],"timeLoss").value) > Number(totalAvailTime)){
                alert( dynTableGetNodeInRow(paramRIDs[i],"paramName").value +  " can not be greater than " + totalAvailTime);
                return false;
            }
        }
        var variantIndexs = document.getElementsByName("variantIndex");
        for(var k=0 ;k<variantIndexs.length;k++){
           if(!self.validateVariant(variantIndexs[k],true)){
               return false;
           }
        }
//        var utilEffValue = document.getElementsByName("utilEffValue");
//        for(var l=0 ;l<utilEffValue.length;l++){
//           if(Number(utilEffValue[l].value) > 100){
//               dynTableGetNodeInRow(utilEffValue[l], "utilEffParamName")
//               alert(dynTableGetNodeInRow(utilEffValue[l], "utilEffParamName").value + " should not be greater than 100 percent");
//               utilEffValue[l].focus();
//               return false;
//           }
//        }

        return confirm("Do you really want to save ?");
    }
    
    self.setShiftDetails= function(){
        var totalTime = document.getElementById("totalTime").value;
        var noOfShifts = document.getElementById("noOfShifts").value;
        var shiftDuration = document.getElementById("shiftDuration");
        if(0 == noOfShifts){
            alert("Select number of shifts");
            shiftDuration.value = 0;
            return;
        }else{
            if((Number(noOfShifts) * Number(shiftDuration.value)) > Number(totalTime) ){
                alert("Total shifts time can not be greater than " + totalTime);
                shiftDuration.value = 0;
                shiftDuration.focus();
                return;
            }
        }
        dynTableGetNodeInRow(document.getElementById("AVAILABE_TIME"),"timeUtilValue").value = (Number(noOfShifts) * Number(shiftDuration.value));
        document.getElementById("totalAvailTime").value = (Number(noOfShifts) * Number(shiftDuration.value));
    }
    
    self.setNoOfShifts = function(elem){
        document.getElementById("noOfShifts").value = elem.value;
        
        var totalTime = document.getElementById("totalTime").value;
        var noOfShifts = document.getElementById("noOfShifts").value;
        var shiftDuration = document.getElementById("shiftDuration");
        
        if((Number(noOfShifts) * Number(shiftDuration.value)) > Number(totalTime) ){
            alert("Total shifts time can not be greater than " + totalTime);
            document.getElementById("noOfShifts").selectedIndex = 0;
            return;
        }
        
        dynTableGetNodeInRow(document.getElementById("AVAILABE_TIME"),"timeUtilValue").value = (Number(noOfShifts) * Number(shiftDuration.value));
        document.getElementById("totalAvailTime").value = (Number(noOfShifts) * Number(shiftDuration.value));
    }

    self.setParentValue = function(elem){

        var noOfShifts = document.getElementById("noOfShifts").value;
        if(0 == noOfShifts){
            alert("Select number of shifts");
            elem.value=0;
            return;
        }
        
        if(Number(elem.lang) == 0){
            self.calculateTimeDetails(elem);
            return;
        }else{
            var totalParentValue = 0;
            var parentParamRID = elem.lang;
            var timeLossElems = document.getElementsByName("timeLoss");
            for(var i=0;i< timeLossElems.length ;i++){
                if(timeLossElems[i].lang == parentParamRID){
                    totalParentValue += Number(timeLossElems[i].value);
                }
            }
            dynTableGetNodeInRow(document.getElementById(parentParamRID), "timeLoss").value = totalParentValue;
            self.setOtherParentValue(dynTableGetNodeInRow(document.getElementById(parentParamRID), "timeLoss"));
            self.calculateTimeDetails(elem);
        }
    }
    self.setOtherParentValue = function(elem){
        if(Number(elem.lang) == 0){
            return;
        }else{
            var totalParentValue = 0;
            var parentParamRID = elem.lang;
            var timeLossElems = document.getElementsByName("timeLoss");
            for(var i=0;i< timeLossElems.length ;i++){
                if(timeLossElems[i].lang == parentParamRID){
                    totalParentValue += Number(timeLossElems[i].value);
                }
            }
            dynTableGetNodeInRow(document.getElementById(parentParamRID), "timeLoss").value = totalParentValue;
        }
    }
    self.saveForm = function(){
        
        if(!self.validateFinazile()){
            return false;
        }else{
            document.timeLossForm.command.value = "saveTimeLoss";
            document.timeLossForm.submit();
            document.getElementById("saveBtn").disabled = true;
        }
    }

    self.handleSuccess = function(msg){
        var msgStr = msg.split("~");
        alert(msgStr[0]);
        document.getElementById("utilizationHeaderRID").value = msgStr[1];
        
        desktop.closePopup();
    }
    self.handleFailure = function(msg){
        alert(msg);
        document.getElementById("saveBtn").disabled = false;
    }


    self.showUtilizationEntries = function(button){
        var plantRID = document.getElementById("cpRID").value;
        var fromDate = document.getElementById("fromDate").value;
        var toDate = document.getElementById("toDate").value;
         var url =  PROJECT_CTXT_PATH + "/AssetUtilizationServlet?command=showUtilizationEntries&plantRID=" + plantRID
                    + "&fromDate="+ fromDate + "&toDate=" + toDate;
         xmlLoadElementValues(url, document.getElementById("detailDiv"));
    }
    self.showAssetUtilizationDetails = function(elem){
        var headerRID = dynTableGetNodeInRow(elem, "headerRID").value;
        var plantRID = dynTableGetNodeInRow(elem, "plantRID").value;
        var url =  PROJECT_CTXT_PATH + "/AssetUtilizationServlet?command=showUtilizationEntry&headerRID=" + headerRID + "&plantRID=" + plantRID;
        desktop.showPopup("Line wise time loss ", url,{width:800,height:520,top:120,left:350,scrollable:true}, true);
    }

    self.finalSave = function(){
        var utilizationHeaderRID = document.getElementById("utilizationHeaderRID").value;
        var plantPowerUnit = document.getElementById("plantPowerUnit").value;
        var plantFuelUnit = document.getElementById("plantFuelUnit").value;
        var plantLabourUnit = document.getElementById("plantLabourUnit").value;
        var productionDate = document.getElementById("productionDate").value;
        if(0 == Number(utilizationHeaderRID)){
            alert("No line details saved");
            return;
        }
        var url = PROJ_CTXT_PATH + "/AssetUtilizationServlet?command=finalUtilizationSave&utilizationHeaderRID=" + utilizationHeaderRID + "&plantFuelUnit=" + plantFuelUnit + "&plantLabourUnit=" + plantLabourUnit  + "&plantPowerUnit=" + plantPowerUnit + "&productionDate=" + productionDate;
                                
        var returnStr = xmlGetResultString(url);
        alert(returnStr);
    }
    self.calculateTimeDetails = function(elem){

        

        
        var totalAvailTime = document.getElementById("totalAvailTime").value;
        self.validateEntry(elem);
        
        var noPlan = Number("" == dynTableGetNodeInRow(document.getElementById("NO_PLAN"),"timeLoss").value ? "0" : dynTableGetNodeInRow(document.getElementById("NO_PLAN"),"timeLoss").value);
        var noAvlRM = Number("" == dynTableGetNodeInRow(document.getElementById("NO_AVL_RM"),"timeLoss").value ? "0" : dynTableGetNodeInRow(document.getElementById("NO_AVL_RM"),"timeLoss").value);
        var noAvlPM = Number("" == dynTableGetNodeInRow(document.getElementById("NO_AVL_PM"),"timeLoss").value ? "0" : dynTableGetNodeInRow(document.getElementById("NO_AVL_PM"),"timeLoss").value);
        var noStorage = Number("" == dynTableGetNodeInRow(document.getElementById("NO_STORAGE"),"timeLoss").value ? "0" : dynTableGetNodeInRow(document.getElementById("NO_STORAGE"),"timeLoss").value);
        var manShort = Number("" ==  dynTableGetNodeInRow(document.getElementById("MAN_SHORTAGE"),"timeLoss").value? "0" : dynTableGetNodeInRow(document.getElementById("MAN_SHORTAGE"),"timeLoss").value);
        var changeClean = Number("" == dynTableGetNodeInRow(document.getElementById("CHNG_CLEAN"),"timeLoss").value ? "0" : dynTableGetNodeInRow(document.getElementById("CHNG_CLEAN"),"timeLoss").value);
        var powerFail = Number("" == dynTableGetNodeInRow(document.getElementById("PWR_FAIL"),"timeLoss").value ? "0" : dynTableGetNodeInRow(document.getElementById("PWR_FAIL"),"timeLoss").value);
        var utilProb = Number("" == dynTableGetNodeInRow(document.getElementById("UTILS_PROB"),"timeLoss").value ? "0" : dynTableGetNodeInRow(document.getElementById("UTILS_PROB"),"timeLoss").value);
        var breakdown = Number("" ==dynTableGetNodeInRow(document.getElementById("BREAKDOWN"),"timeLoss").value ? "0" : dynTableGetNodeInRow(document.getElementById("BREAKDOWN"),"timeLoss").value);
        var trialQALoss = Number("" == dynTableGetNodeInRow(document.getElementById("TRLS_QA_OTHER_LOSS"),"timeLoss").value ? "0" : dynTableGetNodeInRow(document.getElementById("TRLS_QA_OTHER_LOSS"),"timeLoss").value);
        var totalStop = Number("" == dynTableGetNodeInRow(document.getElementById("TOTAL_STOP"),"timeLoss").value ? "0" : dynTableGetNodeInRow(document.getElementById("TOTAL_STOP"),"timeLoss").value);
        
        //validation and computation for total stop
        var totalStopTemp = 0;
        var usedTimeTemp = 0;
        var operationalTime = 0;
        var lineEff = 0;
        var productionTime =0;
                totalStopTemp = noStorage + manShort + changeClean + powerFail + utilProb + breakdown + trialQALoss ;

                if(Number(totalStopTemp) > Number(totalAvailTime)){
                    alert("Time loss for Total stop can not be greater than available time, " + totalAvailTime + " Hr");
                    elem.value =0;
                    self.setParentValue(elem);
                }else{
                    dynTableGetNodeInRow(document.getElementById("TOTAL_STOP"),"timeLoss").value = totalStopTemp;
                }
        //end
        

            if(Number(noPlan) > Number(totalAvailTime)){
                alert("No plan can not be greater than total available time, " + totalAvailTime + " Hr")
                elem.value=0;
                self.setParentValue(elem);
                
            }else{
                usedTimeTemp = Number(totalAvailTime) -  Number(noPlan)
                dynTableGetNodeInRow(document.getElementById("USED_TIME"),"timeUtilValue").value = usedTimeTemp;
            }
        //end
        //validation for operational time;
        var timeLossForResource = Number(noAvlRM) + Number(noAvlPM) + Number(noStorage) + Number(manShort) + Number(trialQALoss);
        if(timeLossForResource > usedTimeTemp){
            alert("Time loss for Non avail of RM, Non avail of PM, No Storage Space, \n Man Power shortage, Trials/QA/Any Other Loss should not be greater than Used Time");
            elem.value = 0;
            self.setParentValue(elem);
        }else{
            operationalTime = Number(usedTimeTemp) - Number(timeLossForResource);
            dynTableGetNodeInRow(document.getElementById("OPERATIONAL_TIME"),"timeUtilValue").value = operationalTime;
        }
        //end
        //validation for production time;
        if(changeClean > operationalTime){
            alert("Time loss for Change Over & Cleaning should not be greater than Operational time");
            elem.value = 0;
            self.setParentValue(elem);
        }else{
            productionTime = Number(operationalTime) - Number(changeClean);
            dynTableGetNodeInRow(document.getElementById("PRODUCTION_TIME"),"timeUtilValue").value = productionTime;
        }

        //validation for effectiveTime
        var breakDownAndPowerFail = Number(powerFail) + Number(utilProb) + Number(breakdown);
        if(Number(breakDownAndPowerFail) > Number(productionTime)){
            alert("Time loss for Power Failure, Utilities Problem, Breakdown should not be more than Production Time");
            elem.value = 0;
            self.setParentValue(elem);
        }else{
            lineEff = Number(productionTime) - Number(breakDownAndPowerFail);
            dynTableGetNodeInRow(document.getElementById("EFFECTIVE_TIME"),"timeUtilValue").value = lineEff;
        }
        //done
    }

    self.calculateEffDetails = function(elem){
        var totalAvailTime = Number("" == dynTableGetNodeInRow(document.getElementById("AVAILABE_TIME"),"timeUtilValue").value ? "0" : dynTableGetNodeInRow(document.getElementById("AVAILABE_TIME"),"timeUtilValue").value);
        var totalTime = Number("" == dynTableGetNodeInRow(document.getElementById("TOTAL_TIME"),"timeUtilValue").value ? "0" : dynTableGetNodeInRow(document.getElementById("TOTAL_TIME"),"timeUtilValue").value);
        var usedTime = Number("" == dynTableGetNodeInRow(document.getElementById("USED_TIME"),"timeUtilValue").value ? "0" : dynTableGetNodeInRow(document.getElementById("USED_TIME"),"timeUtilValue").value);
        var operationalTime = Number("" == dynTableGetNodeInRow(document.getElementById("OPERATIONAL_TIME"),"timeUtilValue").value ? "0" : dynTableGetNodeInRow(document.getElementById("OPERATIONAL_TIME"),"timeUtilValue").value);
        var productionTime = Number("" == dynTableGetNodeInRow(document.getElementById("PRODUCTION_TIME"),"timeUtilValue").value ? "0" : dynTableGetNodeInRow(document.getElementById("PRODUCTION_TIME"),"timeUtilValue").value);
        var effTime = Number("" == dynTableGetNodeInRow(document.getElementById("EFFECTIVE_TIME"),"timeUtilValue").value ? "0" : dynTableGetNodeInRow(document.getElementById("EFFECTIVE_TIME"),"timeUtilValue").value);

        var runTime = dynTableGetNodeInRow(elem,"variantRunTime").value;
        var production = dynTableGetNodeInRow(elem,"production");
        if("" == runTime || 0 == runTime){
            alert("Enter run time");
            production.value = 0;
            dynTableGetNodeInRow(elem,"variantRunTime").focus();
            return;
        }
        
        var variants = document.getElementsByName("variants");
        var totalRatedCapacity = 0;
        var totalRatedCapacityRunTime = 0;
        var totalProduction = 0;
        var totalRunTime = 0;
        for (var i =0;i<variants.length;i++){
            if(variants[i].value > 0){
                totalProduction += Number(dynTableGetNodeInRow(variants[i],"production").value);
                totalRunTime += Number(dynTableGetNodeInRow(variants[i],"variantRunTime").value);
                totalRatedCapacityRunTime += (Number(dynTableGetNodeInRow(variants[i],"ratedCapacity").value) / totalTime) * Number(dynTableGetNodeInRow(variants[i],"variantRunTime").value);
            }
        }
        totalRatedCapacity = (totalRatedCapacityRunTime / totalRunTime) * totalTime;
        
        //now populate the eff fields
        if(Number(totalTime) > 0){
            dynTableGetNodeInRow(document.getElementById("ASSET_AVAILABILITY"),"utilEffValue").value = ((Number(totalAvailTime) * 100)/ Number(totalTime)).toFixed(2);
            dynTableGetNodeInRow(document.getElementById("ASSET_UTILIZATION"),"utilEffValue").value = ((Number(usedTime) * 100)/ Number(totalTime)).toFixed(2);
            dynTableGetNodeInRow(document.getElementById("OPERATIONAL_UTILIZATION"),"utilEffValue").value = ((Number(operationalTime) * 100)/ Number(totalTime)).toFixed(2);
            dynTableGetNodeInRow(document.getElementById("PRODUCTION_UTILIZATION"),"utilEffValue").value = ((Number(productionTime) * 100)/ Number(totalTime)).toFixed(2);
            dynTableGetNodeInRow(document.getElementById("OEE"),"utilEffValue").value = ((Number(effTime) * 100)/ Number(totalTime)).toFixed(2);
        }else{
            dynTableGetNodeInRow(document.getElementById("ASSET_AVAILABILITY"),"utilEffValue").value = 0.0;
            dynTableGetNodeInRow(document.getElementById("ASSET_UTILIZATION"),"utilEffValue").value = 0.0;
            dynTableGetNodeInRow(document.getElementById("OPERATIONAL_UTILIZATION"),"utilEffValue").value = 0.0;
            dynTableGetNodeInRow(document.getElementById("PRODUCTION_UTILIZATION"),"utilEffValue").value = 0.0;
            dynTableGetNodeInRow(document.getElementById("OEE"),"utilEffValue").value = 0;
        }

        if(Number(operationalTime) > 0){
            dynTableGetNodeInRow(document.getElementById("OPERATIONAL_EFFECIENCY"),"utilEffValue").value = ((Number(effTime) * 100)/ Number(operationalTime)).toFixed(2);
        }else{
            dynTableGetNodeInRow(document.getElementById("OPERATIONAL_EFFECIENCY"),"utilEffValue").value = 0.0;
        }

        if(Number(productionTime) > 0){
            dynTableGetNodeInRow(document.getElementById("PRODUCTION_EFFECIENCY"),"utilEffValue").value = ((Number(effTime) * 100)/ Number(productionTime)).toFixed(2);
        }else{
            dynTableGetNodeInRow(document.getElementById("OPERATIONAL_EFFECIENCY"),"utilEffValue").value = 0.0;
        }
        
        if(productionTime > 0){
            dynTableGetNodeInRow(document.getElementById("LINE_EFFECIENCY"),"utilEffValue").value = ((totalProduction * 100)/((totalRatedCapacity / totalTime) * productionTime)).toFixed(2);
        }else{
            dynTableGetNodeInRow(document.getElementById("LINE_EFFECIENCY"),"utilEffValue").value = 0.0;
        }
    }
    
    self.validateEntry = function(elem){
        var totalAvailTime = document.getElementById("totalAvailTime").value;
        if(Number(elem.value) > Number(totalAvailTime)){
            alert(dynTableGetNodeInRow(elem,"paramName").value + " can not be greater than " + totalAvailTime + " (Hr)");
            elem.value = 0;
            self.calculateTimeDetails(elem);
        }
    }

    self.openFuelDetailsPopup = function (elem) {
      
       lpfReference = elem;
       var production = dynTableGetNodeInRow(elem, "production");
       if("" == production.value || 0 == Number(production.value)){
            alert("Production value is not set");
            elem.value = "";
            return;
       }
        var fuelDetStr = dynTableGetNodeInRow(elem,"feulDetailStr").value;
        var defString = "0@ @0@0@0@0@ ,";
        var url = "";
        var lpfdetailRid = dynTableGetNodeInRow(elem,"LPFDetailRid").value;
        if (fuelDetStr == defString) {
           url = PROJ_CTXT_PATH + "/AssetUtilizationServlet?command=getFuelUtilizationDetails&lpfdetailRid=" + lpfdetailRid;
        } else {
            url = PROJ_CTXT_PATH + "/jsp/assetUtlization/FuelConsumptionDetails.jsp?fuelDetailsString=" +fuelDetStr;
        }

       desktop.showPopup("Fuel Consumption Details", url,{width:400,height:200,top:400,left:600,scrollable:true,
        onLoad:function(){
          self.initFuelDetails();
        }
        }, true);

    }

    function populateTotalFuel (returnStr) {
        var elem = lpfReference;
      if(returnStr != "" && returnStr != undefined) {
           var returnArray = returnStr.split('#');
           dynTableGetNodeInRow(elem, "feulDetailStr").value = returnArray[0];
           dynTableGetNodeInRow(elem, "fuel").value = parseFloat(returnArray[2]).toFixed(2);
           var nodeName = 'fuelAvg';
           assetUtilization.setAvgValue(dynTableGetNodeInRow(elem, "fuel"),nodeName);
        }

    }

   

    self.initFuelDetails = function () {
    dynTableInit("fuelDetailsTable");
        
    }

    self.calculateFuelHsdQty = function (elem) {
        var usedfuelQty = elem.value;
        var HSDMult = dynTableGetNodeInRow(elem,"HSDMultiplier").value;
        if(uscmIsNumeric(usedfuelQty,3) && !uscmIsEmpty(usedfuelQty)) {
            var hsdValue = (parseFloat(usedfuelQty) * parseFloat(HSDMult)).toFixed(2);
            dynTableGetNodeInRow(elem,"fuelHSDQty").value = hsdValue;
        } else {
            alert("Enter proper Qty");
            elem.focus();
            return;
        }
    }

    self.saveFuelDetails = function () {
       
        var fuelRid = document.getElementsByName("fuelRID");
        var fuelName = document.getElementsByName("fuelName");
        var fuelUomIndex = document.getElementsByName("fuelUomIndex");
        var fuelUsedqty = document.getElementsByName("fuelusedQty");
        var fuelHSDUsedqty = document.getElementsByName("fuelHSDQty");
        var HSDMultiplier = document.getElementsByName("HSDMultiplier");
        var uomIndex = document.getElementsByName("fueluom");
        var fuelDetailsString = "";
        var totalUsedQty = 0;
        var totalHSDQty = 0;

        for (var i= 0; i<fuelRid.length;i++) {
            if(isEmpty(fuelUsedqty[i].value) || !uscmIsNumeric(fuelUsedqty[i].value,3)) {
                aleret("Please enter proper qty");
                fuelUsedqty[i].focus();
                return;
            }
            
           fuelDetailsString += fuelRid[i].value +'@'+ fuelName[i].value +'@'+ fuelUomIndex[i].value +'@'+ fuelUsedqty[i].value +'@'+ HSDMultiplier[i].value +'@'+ fuelHSDUsedqty[i].value +'@'+ uomIndex[i].value +',';
           totalUsedQty += parseFloat(fuelUsedqty[i].value);
           totalHSDQty += parseFloat(fuelHSDUsedqty[i].value);

        }

       fuelDetailsString =  fuelDetailsString +'#'+ totalUsedQty +'#'+ totalHSDQty;
       populateTotalFuel(fuelDetailsString);
       desktop.closePopup();
       //return (fuelDetailsString);
    }

    self.getFuelDetailsString = function () {
     
        var lpfRid = document.getElementsByName("LPFDetailRid");
        for (var i=0; i<lpfRid.length;i++){
           var url = PROJ_CTXT_PATH + "/AssetUtilizationServlet?command=getFuelDetailsStr&lpfdetailRid=" + lpfRid[i].value;
           var returnStr = xmlGetResultString(url);
           var detailsString = returnStr.trim();
           dynTableGetNodeInRow(lpfRid[i],"feulDetailStr").value = detailsString;
        }
    }

    self.closeFuelDetails = function () {
        desktop.closePopup();
    }

    self.getFuelDetailsForNewRow = function () {
       var lpfRid = 0;
       var url = PROJ_CTXT_PATH + "/AssetUtilizationServlet?command=getFuelDetailsStr&lpfdetailRid=" + lpfRid;
       var returnStr = xmlGetResultString(url);
       var detailsString = returnStr.trim();
       return detailsString;
    }

}
var assetUtilization = new AssetUtilization();