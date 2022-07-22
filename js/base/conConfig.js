function  ConfigModule() {
    var me = this;   
    var selectedFeature = null;
 me.loadPage = function(url,command) {
    url = prjName + url;

    //pushpanjali: change is related to relogin when session is expired.
    //If session expired then return 'false' so that it will not execute remaining part, otherwise 'true'
    if(!xmlLoadElementValues(url, document.getElementById('workingDiv'))) {
        return false;
    }

    url = "";

    if(command == 'Roles'){
    document.getElementById('currentActivity').value = ' Config : Roles';
    roleMaster.formInitRole();
    }else if(command == 'User'){
    document.getElementById('currentActivity').value = ' Config : Users';
    userMaster.formInitUser();
    }else if(command == 'ConfigPortal'){
    document.getElementById('currentActivity').value = ' Config : Portal';
    portal.configPortalFormInit();
    }
    // document.getElementById('workingDiv').innerHtml = "" ;
    return true;
}

me.handleSuccessReload = function(reloadPage,url) {

  var temp = "";
  desktop.confirmMessage(reloadPage);
  temp = url.split('~');
  me.loadPage(temp[0], temp[1]); 
} 
  

me.handleSuccess = function (responseMsg){        
   desktop.confirmMessage(responseMsg);
   ConfigModule.selectedFeature.onclick();

};


 me.handleFailure = function(responseMsg){
    // roleMaster.roleSaveCnclenabled();
    alert(responseMsg);
    //ConfigModule.selectedFeature.onclick();
    disableSaveAndClear(false);
 };    

function disableSaveAndClear(bEnable){
    if(document.getElementById('saveBtn') != null){
        document.getElementById('saveBtn').disabled = bEnable;
    }
    if(document.getElementById('clearBtn') != null){
        document.getElementById('clearBtn').disabled = bEnable;
    }
}

 var configCurrSelection ;

 me.highlightSelection = function (elem, url, command) {
      waitLoading();
    var row;
    if (!desktop.checkTransition()) 
         return false;

    //pushpanjali: change is related to relogin when session is expired.
    //If session expired then return 'false' so that highlighted row will remain the same, otherwise 'true'
    if(!me.loadPage(url, command))
        return false;
    
    if(configCurrSelection != null) {
        row = dynTableRow(configCurrSelection);
        row.className = "lhsMenuTable" ;
    } 
    row = dynTableRow(elem);
    row.className = "selectedRow";
    configCurrSelection = elem;
    pageLoaded();
 };

  function loadFirstFeature(){
        var index = 1
        var featureId = "controlMenuId"+index;
        document.getElementById(featureId).onclick();
   } 
me.configInit = function(){
        configCurrSelection = null; 
        loadFirstFeature();
};

me.showInfo = function(event){

    var helpMessage = "";
    if(document.getElementById('configInfo').value == "user") {

        helpMessage = "<u><h4>User Management</h4></u>" +
        "<li> This feature is used to manage the roles assigned to user of the system<br>" +
        "<li> To add a new User, Search 'Location' for which the user need to be created by Clicking on the button(...) provided.Select Location from the pop up window.<br> " +
        "<li> Searching can be simplified by entering few characters in the 'Location' Text box provided near to '...' button. <br>" + 
        "<li> Enter data and click on the 'Save' button to Save.<br>" +
        "<li> To make changes to an existing User record, select location from 'Select Location' drop down list, " + 
        " Select User from 'Select User' List. It loads user information. <br> " + 
        "<li> Make changes, and then click on the 'Save' button to Save.<br>"+
        "<li> Click on 'Clear' button to clear the current selection.<br>";
                
    } else if(document.getElementById('configInfo').value == "role") {
        helpMessage = "<u><h4>Roles Management</h4></u>" +
        "<li> This screen is used to manage features available to each role in the system<br>" +
        "<li> To add a new Role, Enter role name 'Role name' Text box. <br> " + 
        "<li> Tick Features in 'Feature list' section and click on 'Add Selected' button to add the selected feature.<br>" +
        "<li> Click on 'Save' button to save the role<br>" + 
        "<li> To make changes to an existing Role, Select a role from 'select Role' List. It list features not given for the role in 'Feature List' " + 
        " section and already assigned features in 'Accessible Features' section.<br> " +
        "<li> To remove already assigned role, Tick on features to be removed in 'Accessible Features' section and click on 'Remove Selected' button.<br> " +
        "<li> To add feature,Tick features in 'Feature list' section and click on 'Add Selected' button.<br>" + 
        "<li> Click on 'Save' button to save the modification done.<br>" + 
        "<li> Click on 'Clear' button to clear the current selection.<br>";
    } else if(document.getElementById('configInfo').value == "configPortal"){
        helpMessage = "No help available now";
    }

    showInfoDiv(helpMessage,event);
}


}
var configModule = new ConfigModule();
