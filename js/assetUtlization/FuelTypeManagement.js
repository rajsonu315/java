var FuelTypeManagement = function(){
    var self = this;


    self.validate = function(){
        var typeSel = document.getElementById('typeSel');
        if(typeSel && !typeSel.disabled){
            if(typeSel.selectedIndex == 0){
                alert('Select the UOM');
                typeSel.focus();
                return false;
            }
            
        }

         var fuelCode = document.getElementById('fuelCode');
         if(isEmpty(fuelCode.value)){
            alert('Please enter the Code');
            fuelCode.focus();
            return false;
        }

         var fuelName = document.getElementById('fuelName');
        if(isEmpty(fuelName.value)){
            alert('Please enter the Name');
            fuelName.focus();
            return false;
        }

         var HSD = document.getElementById('hsd');
         if(isEmpty(HSD.value)){
            alert('Enter HSD Equivalent');
            HSD.focus();
            return false;
        }
    }

    self.fuelTypeSearch = function(){
    //debugger;
        var result_String;
        var searchTxt = document.getElementById("searchTxt").value;
        var url = PROJ_CTXT_PATH + "/FuelMasterServlet?command=searchFuelType&searchTxt=" + searchTxt;;
        result_String = window.showModalDialog(url,"center=yes,toolbar=no,location=no,directories=no, status=no,menubar=no,scrollbars=no,resizable=1,copyhistory=no", "dialogWidth:510px; dialogHeight:500px; dialogTop:200px;dialogLeft:200px");

  
        if (result_String != null && result_String != "") {
            var returnArray = result_String.split("~");
            var fuelRid = returnArray[0];
            var fuelCode = returnArray[1];
            var fuelName = returnArray[2];
            var uom = returnArray[3];
            var hsd = returnArray[4];
            var valid = returnArray[5];

            document.getElementById("fuelRid").value = fuelRid;
            document.getElementById("fuelName").value = fuelName;
            document.getElementById("fuelCode").value = fuelCode;
            document.getElementById("typeSel").value = uom;
            document.getElementById("hsd").value = hsd;
            document.getElementById("uomIndex").value = uom;
            document.getElementById("saveBtn").value = 'Modify';
            if (valid == 1) {
                document.getElementById("isActive").checked = true;
            } else {
                document.getElementById("isActive").checked = false;
            }
        }

    }

    self.setUomIndex = function () {
        document.getElementById("uomIndex").value = document.getElementById("typeSel").value;
    }

    self.setIsFuelActive = function () {
        //debugger;
        if(document.getElementById("isActive").checked) {
            document.getElementById("isFuelactive").value = 1;
        } else {
            document.getElementById("isFuelactive").value = 0;
        }
    }

    self.clearDetails = function(){
        document.getElementById('fuelTypeManagement').reset();
      
    }

   self.handleSuccess = function (successMsg) {
     //debugger;
            alert(successMsg);
            document.getElementById('fuelTypeManagement').reset();
           // xmlLoadElementValues(PROJ_CTXT_PATH + "/Fuel?command=initFuelType", document.getElementById("desktopWell"));
        };

  self.handleFailure = function (responseMsg){
            alert(responseMsg);
    };

}
var fuelTypeManagment = new FuelTypeManagement ();
