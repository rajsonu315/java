function RoleMaster(){
    var self = this;

    self.clearFormRole = function(prompt) {

        var ans = true;

        if(prompt)
            ans = confirm("Do you really want to clear the form?");

        if(ans) {

            document.roleMasterForm.reset();

            document.getElementById('roleName').value = "";
            document.getElementById('isActive').checked = true;

            document.getElementById('roleRID').value = 0;
            document.getElementById('command').value = "saveRoleWithMesaage";
            resetDirtyBit() ;
            dynTableDeleteAllRows("assignedFeatureTbl");
            document.getElementById('roleNameMsg').innerHTML=" *";
        }
    };

    self.loadRole = function (roleRID) {

        var url = PROJECT_CTXT_PATH + "/UMasterServlet?command=loadRoleMasterSorted&roleRID=" + roleRID;

        document.roleMasterForm.action = url;
        document.roleMasterForm.method = "get";

        //xmlLoadElementValues(url, document.getElementById('workingDiv'));
        xmlLoadElementValues(url, document.getElementById('desktopWell'));
        self.formInitRole();
    };

    self.addFeatures = function () {

        var prodFeatures = document.getElementsByName("productFeature");

        var prodFeatureNames = document.getElementsByName("productFeatureName");

        var assignedFeatures=document.getElementsByName("assignedFeature");

        for(i = 0; i < prodFeatures.length; i++) {

            var sel = prodFeatures[i];

            if(sel.checked) {

                var row = dynTableAppendRow("assignedFeatureTbl");
                // alert('step 2')
                var fRID = dynTableGetNodeInRow(row, "assignedFeature")
                fRID.value = sel.value;

                var txtBox = dynTableGetNodeInRow(row, "assignedFeatureName")
                txtBox.value = prodFeatureNames[i].value;

                sel.checked = false;

                if(assignedFeatures!=null){
                    var flag=0;
                    for(j=0;j<assignedFeatures.length;j++){
                        if(assignedFeatures[j].value==sel.value){
                            flag++;
                        }
                    }
                    if(flag>1){
                        dynTableDeleteRow(row)

                    }
                }
            }
        }

    };

    self.removeFeatures = function () {
        dynTableDeleteSelectedRows("assignedFeatureChk");
    }

    self.formInitRole =  function () {
       
        dynTableInit('assignedFeatureTbl');
        //document.getElementById('successHandler').value = "roleMaster.handleSuccess";
        //document.getElementById('failureHandler').value = "roleMaster.handleFailure";
        var lastRow = dynTableGetLastRow('assignedFeatureTbl');

        lastRow.parentNode.removeChild(lastRow);
    }

    self.formValidateRole = function () {
        self.roleSaveCncldisabled();
        if(isEmpty(document.getElementById('roleName').value)) {

            document.getElementById('roleNameMsg').innerHTML=" *Please enter a name for the role";

            document.getElementById('roleName').focus();
            self.roleSaveCnclenabled();
            return false;
        }

        return true;
    }

    self.roleSaveCncldisabled = function (){
        document.getElementById('saveBtn').disabled = true;
        document.getElementById('clearBtn').disabled = true;
    }

    self.roleSaveCnclenabled = function (){
        document.getElementById('saveBtn').disabled = false;
        document.getElementById('clearBtn').disabled = false;
    }
    
    self.handleSuccessReload = function (successMsg, url){
        alert(successMsg);
        var url = 'UMasterServlet?command=loadRoleMaster';
        xmlLoadElementValues(url, document.getElementById("desktopWell"));
        self.formInitRole();
    };

    self.handleSuccess = function (responseMsg){
        alert(responseMsg);
        var url = 'UMasterServlet?command=loadRoleMasterSorted';
        xmlLoadElementValues(url, document.getElementById("desktopWell"));
        self.formInitRole();

    };
    self.handleFailure = function (responseMsg){
        alert(responseMsg);
        self.roleSaveCnclenabled();
    };
}
 
var roleMaster = new RoleMaster();   




