var ProdTypeManagement = function(){
    var self = this;

    self.formInit = function(){        
        var prodType = document.getElementById('prodType').value;
        var brand = document.getElementById('brand').value;
        var variety = document.getElementById('variety').value;

        if(prodType > 0){
            document.getElementById('productTypeTr').className = '';
        } else {
            document.getElementById('productTypeTr').className = 'hidden';
        }

        if(brand > 0){
            document.getElementById('brandTr').className = '';
        } else {
            document.getElementById('brandTr').className = 'hidden';
        }

        if(variety > 0){
            document.getElementById('varietyTr').className = '';
        } else {
            document.getElementById('varietyTr').className = 'hidden';
        }

        if(brand == 0 && variety == 0 && prodType == 0){
            document.getElementById('productTypeTr').className = 'hidden';
        }
    }

    self.productTypeSearch = function(){
        var result_array;
        var searchTxt = document.getElementById("searchTxt").value;
        var searchBy = document.getElementById("searchBy").value;
        var url = PROJ_CTXT_PATH + "/ProductMasterServlet?command=searchProductType&searchTxt=" + searchTxt + "&searchBy=" + searchBy;
        result_array = window.showModalDialog(url,"center=yes,toolbar=no,location=no,directories=no, status=no,menubar=no,scrollbars=no,resizable=1,copyhistory=no", "dialogWidth:510px; dialogHeight:500px; dialogTop:200px;dialogLeft:200px");
        if(result_array) {
            var ddIndex = result_array["ddIndex"];
            url = PROJ_CTXT_PATH + "/ProductMasterServlet";

            // @Make changes here....saurabh.....12.12.12
            url = url + "?command=loadProductTypeDetails&ddIndex=" + ddIndex;
            xmlLoadElementValues(url, document.getElementById('productTypeDetails'));
            document.getElementById("saveBtn").value = "Modify";
            self.formInit();
        }
    }
    

    self.handleSuccess = function(msg){
        if(msg == ''){
            msg = 'Data saved successfully';
        }
        alert(msg);
        xmlLoadElementValues(PROJ_CTXT_PATH + '/ProductMasterServlet?command=initSKUType', document.getElementById('desktopWell'));
        self.formInit();
    }

    self.handleFailure = function(msg){
        if(msg == ''){
            msg = 'Failed to save';
        }
        alert(msg);
    }
    
    
    self.clearDetails = function() {
        self.reLoadPage();
    }

    self.reLoadPage = function() {
        var url = PROJ_CTXT_PATH + "/ProductMasterServlet?command=initSKUType";
        xmlLoadElementValues(url, document.getElementById('desktopWell'));
        self.formInit();
    }

    self.validate = function(){
        var typeSel = document.getElementById('typeSel');
        if(typeSel && !typeSel.disabled){
            if(typeSel.selectedIndex == 0){
                alert('Please select the type');
                typeSel.focus();
                return false;
            }
        }

        var desc = document.getElementById('desc');
        if(isEmpty(desc.value)){
            alert('Please enter the description');
            desc.focus();
            return false;
        }

        var productTypeTr = document.getElementById('productTypeTr');
        if(productTypeTr && productTypeTr.className == ''){
            var prodTypeSel = document.getElementById('prodTypeSel');
            if(prodTypeSel.selectedIndex == 0){
                alert('Please select product type');
                prodTypeSel.focus();
                return false;
            }
        }

        var brandTr = document.getElementById('brandTr');
        if(brandTr && brandTr.className == ''){
            var brandSel = document.getElementById('brandSel');
            if(brandSel.selectedIndex == 0){
                alert('Please select brand');
                brandSel.focus();
                return false;
            }
        }

        var varietyTr = document.getElementById('varietyTr');
        if(varietyTr && varietyTr.className == ''){
            var prodTVarietySel = document.getElementById('prodTVarietySel');
            if(prodTVarietySel.selectedIndex == 0){
                alert('Please select product variety');
                prodTVarietySel.focus();
                return false;
            }
        }
        return true;
    }

    self.showHideParentCombo = function(childType){
        var productTypeTr = document.getElementById('productTypeTr');
        var brandTr = document.getElementById('brandTr');
        var varietyTr = document.getElementById('varietyTr');
        
        if(childType == 100){
            productTypeTr.className = 'hidden';
            brandTr.className = 'hidden';
            varietyTr.className = 'hidden';
        } else if(childType == 200){
            productTypeTr.className = '';
            brandTr.className = 'hidden';
            varietyTr.className = 'hidden';
        } else if(childType == 300){
            productTypeTr.className = 'hidden';
            brandTr.className = '';
            varietyTr.className = 'hidden';
        } else {
            productTypeTr.className = 'hidden';
            brandTr.className = 'hidden';
            varietyTr.className = 'hidden';
        }
    }

    self.setParentIndex = function(parentIndex){
        document.getElementById('parent').value = parentIndex;
    }

    self.setStatus = function(isChecked) {
        var isActiveStatus = document.getElementById('isActiveStatus');
        if(isChecked) {
            isActiveStatus.value = 1;
        } else {
            isActiveStatus.value = 0;
        }
    }

    
}
var prodTypeManagement = new ProdTypeManagement();