function UserMaster(){
    var self =this;
    self.loadUserDetails = function (userRID) {


        var url = PROJECT_CTXT_PATH + "/UMasterServlet";
        //xmlLoadElementValues(url+"?command=loadSysUsers&userRID="+userRID,document.getElementById('workingDiv'))

        xmlLoadElementValues(url+"?command=loadStaff&userRID="+userRID+"&eRid="+document.getElementById('eRid').value,document.getElementById('desktopWell'))

        document.getElementById('userLoginId').readOnly=true;
        self.formInitUser();
    // userMasterForm.command.value = "loadUserMaster";
    //userMasterForm.userRID.value = userRID;

    //userMasterForm.action = url;
    //userMasterForm.method = "get";

    // userMasterForm.target = "_self";

    //userMasterForm.submit();
    };
    
    self.loadUsers = function(entityRID) {
        document.getElementById('eRid').value = entityRID;
        document.getElementById('userEntityRID').value = entityRID;
        var url = PROJECT_CTXT_PATH + "/UMasterServlet";


        xmlLoadElementValues(url + "?command=loadUsers&entityRID=" + entityRID, document.getElementById('userSelection'));

    // userMasterForm.userName.readOnly=true;
    }

    self.addRolesUser = function () {

        var allRoles = document.getElementsByName("role");

        var roleNames = document.getElementsByName("roleName");

        var assignedRoles= document.getElementsByName("assignedRole");

        for(i = 0; i < allRoles.length; i++) {

            var sel = allRoles[i];

            if(sel.checked) {

                var row = dynTableAppendRow("assignedRolesTbl");

                var fRID = dynTableGetNodeInRow(row, "assignedRole")
                fRID.value = sel.value;

                var txtBox = dynTableGetNodeInRow(row, "assignedRoleName")
                txtBox.value = roleNames[i].value;

                sel.checked = false;

                if(assignedRoles!=null){
                    var flag=0;
                    for(j = 0; j < assignedRoles.length; j++){
                        if(assignedRoles[j].value==sel.value){
                            flag++;
                        }
                    }
                    if(flag>1){
                        dynTableDeleteRow(row);
                    }
                }
            }
        }

    };

    self.removeRoles = function () {

        dynTableDeleteSelectedRows("assignedRoleChk");
    };

    self.clearFormUser = function (prompt) {

        var ans = true;

        if(prompt)
            ans = confirm("Do you really want to clear the form?");

        if(ans) {

             var url ="/UMasterServlet?command=loadUserMaster";
             desktop.loadPage(url,"Users");
            //ConfigModule.selectedFeature.onclick();

        // commented by raghu , if u using selectedFeature.click() then no need of this

        /*
        userMasterForm.reset();

        userMasterForm.userRID.value = 0;
        userMasterForm.userEntityRID.value = 0;

        userMasterForm.userName.value = "";
        userMasterForm.userLoginId.value = "";
        userMasterForm.userEmailId.value = "";

        userMasterForm.isActive.checked = true;

        userMasterForm.command.value = "saveUsersWithMesaage";

        dynTableDeleteAllRows("assignedRolesTbl");

        userMasterForm.userLoginId.readOnly=false;

         document.getElementById('userFullNameMsg').innerHTML=" *";
         document.getElementById('userIdMsg').innerHTML=" *";
         document.getElementById('userRolesMsg').innerHTML=" *";
         */

        }
    };

    /*function handleSuccess(msg) {
       alert("handle success user");
      clearFormUser(true);

      var url = PROJECT_CTXT_PATH + "/UMasterServlet";

      var ent = userMasterForm.entityRID.value;
      if(ent > 0) 
        xmlLoadElementValues(url + "?command=loadUsers&entityRID=" + ent, document.getElementById('userSelection'));
    }

    function handleFailure(msg) {
      alert(msg);
    }*/

    self.formValidateUser = function () {
     
        roleMaster.roleSaveCncldisabled();
        document.getElementById('userFullNameMsg').innerHTML=" *";
        document.getElementById('userIdMsg').innerHTML=" *";
        document.getElementById('userRolesMsg').innerHTML=" *";
        /*if(userMasterForm.userEntityRID.value == 0) {

        alert("Please select user's location");

        userMasterForm.userEntityRID.focus();
        return false;
      }*/
        var isFlag = true;
        if(isEmpty(document.getElementById('userName').value)) {

            document.getElementById('userFullNameMsg').innerHTML=" *Please enter user's full name";

            document.getElementById('userName').focus();

            isFlag = false;
        //return false;
        }

        if(isEmpty(document.getElementById('userLoginId').value)) {

            document.getElementById('userIdMsg').innerHTML=" *Please enter user's Login Id";

            document.getElementById('userLoginId').focus();

            isFlag = false;
       
        }else if(!isAlphaNumeric(document.getElementById('userLoginId').value)) {

            document.getElementById('userIdMsg').innerHTML=" *Login Id must be a single alphanumeric word";

            document.getElementById('userLoginId').focus();

            isFlag = false;
       
        }

        var roles = document.getElementById('assignedRoleChk');

        if(roles == null) {

            document.getElementById('userRolesMsg').innerHTML=" *Please assign a role to the user";

            isFlag = false ;
       
        }

        /*if(isEmployee(userMasterForm.userLoginId.value)){
          if(confirm("Do you really want to convert this employee to system user")){
            return(true);
          }else{
            return(false);
          }
      }*/

        // Added by saurabh.....23.09.2011
        var userEmailId = document.getElementById('userEmailId');

        if(!isEmpty(userEmailId.value)){
            var mailIDVal = userEmailId.value;
            var mailIDValDotSplit = mailIDVal.split(".");
            if(mailIDValDotSplit.length < 2){
                alert("Please enter a proper Mail ID");
                userEmailId.focus();
                isFlag=false;
            }else{
                var iChars = "*|,\":<>[]{}`\';()@&$#%";
                for (var i = 0; i <  mailIDValDotSplit[1].length; i++) {
                    if (iChars.indexOf(mailIDValDotSplit[1].charAt(i)) != -1){
                        alert ("Please enter a proper Mail ID");
                        userEmailId.focus();
                        isFlag=false;
                    }
                }
                var mailIDValAtSplit = mailIDValDotSplit[0].split("@");
                if(mailIDValAtSplit.length != 2){
                    alert("Please enter a proper Mail ID");
                    userEmailId.focus();
                    isFlag=false;
                }else{
                    for (i = 0; i <  mailIDValAtSplit[1].length; i++){
                        if (iChars.indexOf(mailIDValAtSplit[1].charAt(i)) != -1){
                            alert ("Please enter a proper Mail ID");
                            userEmailId.focus();
                            isFlag=false;
                        }
                    }
                }
            }
        }

        if(isFlag == false)
            roleMaster.roleSaveCnclenabled();
        return isFlag;
    
      
    };

    function isEmployee(empLogId) {

        var employees=document.getElementsByName("empName");
        if(employees==null){
            return false;
        }

        for(var i=0;i<employees.length;i++) {

            if(employees[i].value==empLogId){
                return true;
            }
        }
        return false;
    }

    self.formInitUser = function () {
        // alert("its come there");
        dynTableInit('assignedRolesTbl');
        
        var lastRow = dynTableGetLastRow('assignedRolesTbl');

        lastRow.parentNode.removeChild(lastRow);
    };

    function doSearch(){

        var emp = window.showModalDialog(PROJECT_CTXT_PATH + "/jsp/patient/PatientSearch.jsp",
            "toolbar=no,location=no,directories=no, status=no,menubar=no,scrollbars=no,resizable=1,copyhistory=no", "dialogWidth:50em; dialogHeight:35em");

        if(emp == null)
            return;
        var name = emp['patientName'];
        var userRID = emp['patientUserRID'];

        self.loadUserDetails(userRID);

    }

    self.loadPSSMSDetails = function(opt){

        var obj = document.getElementById('year');
        var year = obj.options[obj.selectedIndex].value;

        var obj = document.getElementById('month');
        var month = obj.options[obj.selectedIndex].value;

        var obj = document.getElementById('psID');
        var psID = obj.options[obj.selectedIndex].value;
 
        var url = prjName + '/VisitTrackingServlet?command=loadPSSMSDetails';
        url += '&month=' + month;
        url += '&year=' + year;
        url += '&staffRID=' + psID;
        url += '&reportStatus=' + opt;
        if(opt == 0){
            xmlLoadElementValues(url, document.getElementById('smsDetailsTable'));
        } else {
            //added by pushpanjali: to check whether session expired or not
            if(!sessionExpiryCheck(url))
                return;
            window.open(url);
        }
    }
    self.saveUserDetails = function (){
        if(self.formValidateUser()) {
            var url = PROJ_CTXT_PATH + "/UMasterServlet?command=saveSysUser";
            document.userMasterForm.action = url;
            document.userMasterForm.method = "POST";
            document.userMasterForm.submit();
        }
    }
    self.handleSuccessReload = function (successMsg, url){
            alert(successMsg);
            var url = 'UMasterServlet?command=loadUserMaster';
            xmlLoadElementValues(url, document.getElementById("desktopWell"));
            self.formInitUser();
        };

   self.handleSuccess = function (responseMsg){
            alert(responseMsg);
            var url = 'UMasterServlet?command=loadUserMaster';
            xmlLoadElementValues(url, document.getElementById("desktopWell"));
            self.formInitUser();
            
        };
    self.handleFailure = function (responseMsg){
            alert(responseMsg);
             roleMaster.roleSaveCnclenabled();
    };
};

var userMaster = new UserMaster();