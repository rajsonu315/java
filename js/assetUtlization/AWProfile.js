
var AWProfile =function() {

    var self = this;

    // modified by @@Avishek
    self.validate = function() {
        document.body.style.cursor='wait';
        if(isEmpty(document.awprofile.code.value)) {
            alert("Please enter Code ");
            document.awprofile.code.focus();
            document.body.style.cursor = 'default';
            return false;
        }

        var regionElem = document.getElementById('region') ;
        if(null != regionElem && regionElem.value == 0){
            alert("Please enter Region ");
            if(!document.getElementById('region').disabled)
                regionElem.focus();
            document.body.style.cursor = 'default';
            return false;
        }


        var prodType = document.getElementsByName('prodType');
        var prodTypeLen = prodType.length;
       
        for(var loop = 0; loop < prodTypeLen; loop++) {
            if(prodType[loop].selectedIndex == 0) {
                alert('Please select a variant');
                prodType[loop].focus();
                return false;
            }
            for(var j = 0; j < loop - 1; j++) {
                if(prodType[j].value == prodType[loop].value) {
                    alert('Please select a different variant');
                    prodType[loop].focus();
                    return false;
                }
            }
        }

//        if(isEmpty(document.awprofile.shifts.value) || parseInt(document.awprofile.shifts.value) == 0) {
//            alert("Please enter no. of shifts");
//            document.awprofile.shifts.focus();
//            document.body.style.cursor = 'default';
//            return false;
//        }
//
//
//        if(isEmpty(document.awprofile.shiftDuration.value) || parseInt(document.awprofile.shiftDuration.value) == 0) {
//            alert("Please enter shift duration");
//            document.awprofile.shiftDuration.focus();
//            document.body.style.cursor = 'default';
//            return false;
//        }
//
        if(isEmpty(document.awprofile.lines.value) || parseInt(document.awprofile.lines.value) == 0) {
            alert("Please enter no. of lines");
            document.awprofile.lines.focus();
            document.body.style.cursor = 'default';
            return false;
        } else {
            var lineNos = document.awprofile.lines.value;
            var specs = document.getElementsByName('specs');
            var descs = document.getElementsByName('desc');            
            if(specs.length != lineNos || descs.length != lineNos) {
                return false;
            }
            for(loop = 0; loop < lineNos; loop++) {
                if(isEmpty(specs[loop].value)) {
                    alert('Please enter specifiaction for Line ' + (loop + 1));
                    specs[loop].focus();
                    return false;
                }
                if(isEmpty(descs[loop].value)) {
                    alert('Please enter description for Line ' + (loop + 1));
                    descs[loop].focus();
                    return false;
                }
            }
        }
        
        if(isEmpty(document.awprofile.ratedCapacityDet.value)) {
            alert("Please enter rated capacity for each line");
            document.getElementById('ratedCapacityLink').focus();
            document.body.style.cursor = 'default';
            return false;
        }

        
        //        if(document.getElementById('prodTypeTR').className == '') {
        //            if(document.getElementById('prodType').value == 0) {
        //                alert("Please select  product type");
        //                document.getElementById('prodType').focus();
        //                document.body.style.cursor = 'default';
        //                return false;
        //            }
        //        }
        
        if(isEmpty(document.awprofile.name.value)) {
            alert("Enter Name ");
            document.awprofile.name.focus();
            document.body.style.cursor = 'default';
            return false;
        }        
        if(isEmpty(document.awprofile.address1.value)) {
            alert("Enter Address1 ");
            document.awprofile.address1.focus();
            document.body.style.cursor = 'default';
            return false;
        }
          
        var emailId = document.getElementById('emailId');

        if(emailId.value.trim() != "" && !emailCheck(emailId.value)) {
            alert("Invalid email id");
            emailId.focus();
            document.body.style.cursor = 'default';
            return false;
        }
        
        document.body.style.cursor='default';
        return true;
    }
    
    self.formInit = function(){
        var val = document.getElementById('entType').value;
        if(val == 'FAC'){
            document.getElementById('prodTypeTR').className = '';
        } else{
            document.getElementById('prodTypeTR').className = 'hidden';
        }
        document.awprofile.code.focus();
    }

    self.handleFailure = function(errMsg) {
        alert (errMsg);
        enableDisableButton('saveBtn', false);
    }

    self.handleSuccess = function(msg) {
        alert("Data saved successfully");    
        self.reLoadAwProfile();
    }  
    
    self.reLoadAwProfile = function() {        
        var url = PROJ_CTXT_PATH + "/EntityManagementServlet?command=initEntityManagement";
        xmlLoadElementValues(url, document.getElementById('desktopWell'));
        self.formInit();
    }        
    
    self.partyProfileSearch = function(){       
        var result_array;
        var searchTxt = document.getElementById("searchTxt").value;
        var entityType = document.getElementById("entityType").value;
        var url = PROJ_CTXT_PATH + "/EntityManagementServlet?command=searchEntity&searchTxt=" + searchTxt + "&entityType=" + entityType;
        result_array = window.showModalDialog(url,"center=yes,toolbar=no,location=no,directories=no, status=no,menubar=no,scrollbars=no,resizable=1,copyhistory=no", "dialogWidth:510px; dialogHeight:500px; dialogTop:200px;dialogLeft:200px");
        if(result_array)
        {
            var entityRID = result_array["entityRID"];
            url = PROJ_CTXT_PATH + "/EntityManagementServlet";
            url = url + "?command=loadProfileDetails&awentityRID=" + entityRID;
            xmlLoadElementValues(url, document.getElementById('entityDetails'));
            document.getElementById("saveBtn").value = "Modify";
            self.formInit();
        }
    }
  
   

    // modified by @@Avishek
    function enableDisableButton(id, actionTag) {
        document.getElementById(id).disabled = actionTag;
    }

    // modified by @@Avishek
    self.validateProfile = function() {
        return confirmForm(1);
    }
   

    // modified by @@Avishek
    confirmForm = function(formType) {
       // debugger;
        // formType : 1 for saving Entity Profile
        // formType : 2 for saving Customer Specefic Details

        enableDisableButton('saveBtn', true);
        ans = confirm("Do you really want to save the changes?");

        if(!ans) {
            enableDisableButton('saveBtn', false);
            return false;
        }
        
        if(formType == '1'){
            if (!self.validate()){
                enableDisableButton('saveBtn', false);
                return false;
            }
        }       
        
        return true;
    }

    self.clearEntityProfile = function() {     
        self.reLoadAwProfile();
    }   
   

    self.showHideSKUType = function(val){
        if(val == 'FAC'){
            document.getElementById('prodTypeTR').className = '';
        } else{
            document.getElementById('prodTypeTR').className = 'hidden';
        }
    };

    self.addVariant = function(imgElem){        
        var row = dynTableRow(imgElem);
        if(dynTableGetNodeInRow(row, "prodType").options.selectedIndex == 0) {
            alert('Select a variant');
            dynTableGetNodeInRow(row, "prodType").focus();
            return false;
        }
        var cloneRow = row.cloneNode(true);
        var addedRow = dynTableAppendGivenRow('variantTab', cloneRow);
        dynTableGetNodeInRow(addedRow, 'prodType').selectedIndex = 0;
        var variantCol = imgElem.parentNode;
        variantCol.removeChild(imgElem);
        var delImgElem = document.createElement('img');
        delImgElem.src = PROJ_CTXT_PATH + '/images/delete.gif';
        delImgElem.alt = 'Delete';
        delImgElem.title = 'Delete this Variant';
        var childElem = variantCol.appendChild(delImgElem);
        childElem.onmouseover = function() {
            this.style.cursor = 'pointer';
        };
        childElem.onmouseout = function() {
            this.style.cursor = 'default';
        };        
        childElem.onclick = function () {
            self.deleteVariant(this);
        }
        document.getElementById('ratedCapacityDet').value = '';
    };

    self.deleteVariant = function(imgElem) {
        var row = dynTableRow(imgElem);
        dynTableDeleteRow(row);
        document.getElementById('ratedCapacityDet').value = '';
    };

    self.addOrDeleteLines = function(textElem) {        
        var row = dynTableRow(textElem);
        var tab = dynTableGetTable(textElem);
        var tabId = tab.id;
        if(textElem.value == '') {
            textElem.value = '0';
        }
        var noOfLines = parseInt(textElem.value);

        var lineDescTab = document.getElementById('lineDescTab');
        if(lineDescTab != null && lineDescTab != undefined) {
            var rowlen = parseInt(lineDescTab.rows.length);
            if(noOfLines == 0){
                for(var loop = rowlen - 1; loop >= 2; loop--) {                   
                    dynTableDeleteRow(lineDescTab.rows[loop]);
                }
                var lineDescTabRow = lineDescTab.rows[loop];
                dynTableGetNodeInRow(lineDescTabRow, "specs").value = '';
                dynTableGetNodeInRow(lineDescTabRow, "desc").value = '';
                $("#lineDescDiv").slideUp(1000);            
            } else {                
                var lastRow = dynTableGetLastRow('lineDescTab');
                if(noOfLines > (rowlen - 1)) {
                    //add extra rows
                    var clonedNode = lastRow.cloneNode(true);
                    var diff = noOfLines - rowlen + 1;
                    for(loop = 1; loop <= diff; loop++) {                        
                        lastRow = dynTableInsertGivenCloneAfterRow('lineDescTab', lastRow, clonedNode);
                        dynTableGetNodeInRow(lastRow, "lineNameText").value = 'Line ' + (rowlen - 1 + loop);
                        dynTableGetNodeInRow(lastRow, "specs").value = '';
                        dynTableGetNodeInRow(lastRow, "desc").value = '';
                        dynTableGetNodeInRow(lastRow, "lineNo").value = rowlen - 1 + loop;                        
                    }                
                } else if(noOfLines < (rowlen - 1)) {
                    // delete rows from the end
                    diff = (rowlen - 1) - noOfLines;
                    for(loop = 1; loop <= diff; loop++){                       
                        dynTableDeleteRow(lastRow);
                        lastRow = dynTableGetLastRow('lineDescTab');                       
                    }        
                }
                $("#lineDescDiv").hide(1);
                $("#lineDescDiv").slideDown(1000);
            }
            document.getElementById('ratedCapacityDet').value = '';
        }
    }

    self.showRatedCapacity = function(anchorElem) {
       // debugger;
        var lineNos = document.getElementById('lines').value;
        var variantElems = document.getElementsByName('prodType');
        var entRid = document.getElementById('awEntityRID').value;
        var variants = document.getElementsByName("prodType");
        var variantIndexes = '';
        for(var loop = 0; loop < variants.length; loop++) {
            if(variants[loop].options.selectedIndex == 0){
                alert("Please select variant");
                variants[loop].focus();
                return false;
            }
            for(var i = 0; i < loop; i++) {
                if(variants[loop].value == variants[i].value) {
                    alert("Select a different variant");
                    variants[loop].focus();
                    return false;
                }
            }
            variantIndexes += variants[loop].value + ",";
        }
        if(variantIndexes.indexOf(',') != -1) {
            variantIndexes = variantIndexes.substring(0, variantIndexes.length - 1);
        }
        if((entRid == 0 || entRid.trim() == '') && (variantElems.length == 0 || (parseInt(lineNos) == 0) || lineNos == '')) {
            alert('Enter line nos');
            document.getElementById('lines').focus();
            return false;
        }
        var url = PROJ_CTXT_PATH + '/EntityManagementServlet?command=showRatedCapacity&lineNos=' + lineNos 
        + '&variantElemsLen=' + variantElems.length + '&entRid=' + entRid + '&variantIndexes=' + variantIndexes;        
        
        var returnVal = window.showModalDialog(url,
            "center=yes,toolbar=no,location=no,directories=no, status=no,menubar=no,scrollbars=yes,resizable=1,copyhistory=no",
            "dialog Width:750px; dialogHeight:500px; center:1");
        if(returnVal) {
            //            var ddIndex = result_array["ddIndex"];
            document.getElementById('ratedCapacityDet').value = returnVal;
        }      

    };

    self.okClick = function() {
       // debugger;
        
        var returnVal = '';
        var variantIndexHidden = 0, lineRidHidden = 0;
        var capacity = document.getElementsByName('capacity');
        var power = document.getElementsByName('power');
        var fuel = document.getElementsByName('fuel');
        var labour = document.getElementsByName('labour');

        for(var loop = 0; loop < capacity.length; loop++) {
            if(isEmpty(capacity[loop].value)){
                alert('Enter return value for Line ' + (loop + 1));
                capacity[loop].focus();
                return false;
            }
            if(isEmpty(power[loop].value)){
                alert('Enter return value for Line ' + (loop + 1));
                power[loop].focus();
                return false;
            }
            if(isEmpty(fuel[loop].value)){
                alert('Enter return value for Line ' + (loop + 1));
                fuel[loop].focus();
                return false;
            }
            if(isEmpty(labour[loop].value)){
                alert('Enter return value for Line ' + (loop + 1));
                labour[loop].focus();
                return false;
            }
                       

            variantIndexHidden = dynTableGetNodeInRow(capacity[loop], 'variantIndexHidden').value;
            lineRidHidden = dynTableGetNodeInRow(capacity[loop], 'lineRidHidden').value;
            returnVal += lineRidHidden + '~' + variantIndexHidden + '~' + capacity[loop].value + '~' + power[loop].value + '~' + fuel[loop].value + '~' + labour[loop].value + ',';
        }
        

        if(returnVal.indexOf(',') != -1) {
            returnVal = returnVal.substring(0, returnVal.length - 1);
        }
        
        window.returnValue = returnVal;
        window.close();
    };

    self.ratedCapacityInit = function () {
        dynTableInit('ratedCapTab');
    };

    self.setStatus = function (isActiveElem) {
        var isActiveStatus = document.getElementById('isActiveStatus');
        if(isActiveElem.checked) {
            isActiveStatus.value = 1;
        } else {
            isActiveStatus.value = 0;
        }
    }

    self.setLineStatus = function (isActiveElem) {
        var isActiveStatusElem = dynTableGetNodeInRow(isActiveElem, 'lineIsActiveHidden');
        if(isActiveElem.checked) {
            isActiveStatusElem.value = 1;
        } else {
            isActiveStatusElem.value = 0;
        }
    }

    self.addNewPlantLine = function (imgElem) {
        var row = dynTableRow(imgElem);
        var lastRow = dynTableGetLastRow('lineDescTab');
        var cloneRow = row.cloneNode(true);
        var newRow = dynTableAppendGivenRow('lineDescTab', cloneRow);
        imgElem.parentNode.removeChild(imgElem);        
        var lastRowLineNo = dynTableGetNodeInRow(lastRow, 'lineNo').value;
        dynTableGetNodeInRow(newRow, 'lineNo').value = parseInt(lastRowLineNo) + 1;
        dynTableGetNodeInRow(newRow, 'lineNameText').value = 'Line ' + (parseInt(lastRowLineNo) + 1);
        dynTableGetNodeInRow(newRow, 'lineRid').value = 0;
        dynTableGetNodeInRow(newRow, 'specs').value = '';
        dynTableGetNodeInRow(newRow, 'desc').value = '';
        dynTableGetNodeInRow(newRow, 'lineIsActive').checked = true;
        dynTableGetNodeInRow(newRow, 'lineIsActiveHidden').value = 1;
        document.getElementById('ratedCapacityDet').value = '';
        document.getElementById('lines').value = parseInt(document.getElementById('lines').value) + 1;
    };

     self.initializePage = function (){
                  window.dialogWidth="600px";
                  window.dialogHeight="520px";
                  window.dialogLeft=280;
                  window.dialogTop=250;
     }
     
     self.showFuelDetails = function (){
         var entRid = document.getElementById("awEntityRID").value;
        // debugger;
         
          var url = PROJ_CTXT_PATH + '/EntityManagementServlet?command=showFuelDetails&entRid=' + entRid;
           var returnVal = window.showModalDialog(url,"center=yes,toolbar=no,location=no,directories=no, status=no,menubar=no,scrollbars=yes,resizable=1,copyhistory=no",
          "dialog Width:100px; dialogHeight:300px; center:1");
          if (returnVal) {
          document.getElementById("fuelDetString").value = returnVal ;
          }
         
     }

     self.initFuelAllowed = function () {
        dynTableInit('allowedFuelTable');
     }

     self.updateHiddenField = function (elem) {
         //debugger;
        if (dynTableGetNodeInRow(elem, "isAllowed").checked == true) {
           dynTableGetNodeInRow(elem, "hidIsAllowed").value = 1;
        } else {
           dynTableGetNodeInRow(elem, "hidIsAllowed").value = 0 ;
        }
     }
     self.saveFuel = function () {
        // debugger;
         var returnVal = "";
         var fuelRid = document.getElementsByName("hidFuelRid");
         var isAllowed = document.getElementsByName("hidIsAllowed");
         var plantRid = document.getElementById("plantRid").value;
         for (var i = 0 ; i < fuelRid.length; i++) {
             returnVal += fuelRid[i].value +'~'+ plantRid +'~'+ isAllowed[i].value + ',';
         }
          if(returnVal.indexOf(',') != -1) {
             returnVal = returnVal.substring(0, returnVal.length - 1);
        }
        window.returnValue = returnVal;
        window.close();
              
     }
    
};
var awProfile = new AWProfile();
