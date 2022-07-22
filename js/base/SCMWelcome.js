var SCMWelcome = function() {

var self = this;

self.loadNextPage = function() {
/*
    var currentPage = "";
    if (null == document.getElementById("currentPage")) {
        currentPage = "NO_PAGE";
    } else {
        currentPage = document.getElementById("currentPage").value;
    }
    
    var nextURL = "";
    if ("APP_LOAD_ACTIVITIES" == currentPage) {
        // Load the user feature preferences screen
        nextURL = PROJECT_CTXT_PATH + "/UUserProfileServlet?command=loadFeaturePreferences";
        xmlLoadElementValues(nextURL, document.getElementById("appLoadActivitiesDiv"));
        
    } else if ("USER_FEAT_PREFERENCES" == currentPage || "NO_PAGE" == currentPage) {
        // nextURL = PROJECT_CTXT_PATH + "/UUserProfileServlet?command=loadFeaturePreferences";
        desktop.shrinkenDesktopWell();
    }
*/
}

self.welcomeUser = function() {
/*
    // Load the sales trend graph
    var url = PROJECT_CTXT_PATH + "/SCMDashBoard";
    xmlLoadElementValues(url, document.getElementById("chartDiv"));

    // Load the app load activity section
    url = PROJECT_CTXT_PATH + "/Welcome?command=loadAppLoadActivities";
    xmlLoadElementValues(url, document.getElementById("appLoadActivitiesDiv"));
*/
    desktop.shrinkenDesktopWell();
    
    // Load the sales trend graph
    var url = PROJECT_CTXT_PATH + "/SCMDashBoard";
    //xmlLoadElementValues(url, document.getElementById("chartDiv"));

    // Load the app load activity section
    url = PROJECT_CTXT_PATH + "/Welcome?command=loadAppLoadActivities";
    //xmlLoadElementValues(url, document.getElementById("appLoadActivitiesDiv"));

/*    // if no default screen set by user load dashboard in work area
    var url = PROJECT_CTXT_PATH + "/SCMDashBoard";
    xmlLoadElementValues(url, document.getElementById("desktopWell"));
*/
        var defaultFeatureCommand = document.getElementById("defaultFeatureCommand");
        if(defaultFeatureCommand){
            desktop.loadPage(defaultFeatureCommand.value, document.getElementById("defaultFeatureName").value);
        }
}

self.invokeAppLoadActivities = function() {
//setTimeout(function() {
   var commandPanelDiv = document.getElementById('commandPanelDiv');
    var activityCodeArr = document.getElementsByName("activityCode");
    var activityTitleArr = document.getElementsByName("activityTitle");
    var activityWorkUrlArr = document.getElementsByName("activityWorkUrl");
    var activityIsMandatory = document.getElementsByName("activityIsMandatory");

    var len = 0;
    if (null != activityCodeArr) {
        len = activityCodeArr.length;
    }

    var actCode = "", actTitle = "", actUrl = "", actIsMandatory = 0;
    for (var i = 0; i < len; i++) {
        actCode = activityCodeArr[i].value;
        actTitle = activityTitleArr[i].value;
        actUrl = activityWorkUrlArr[i].value;
        actIsMandatory = activityIsMandatory[i].value;
        if(commandPanelDiv.disabled) {
            return false;
        }
        if(actIsMandatory == 1) {
            commandPanelDiv.disabled = true;
        }
        
        actUrl = PROJECT_CTXT_PATH + actUrl + "&activityCode=" + actCode + "&activityTitle=" + actTitle;
        xmlLoadElementValues(actUrl, document.getElementById("activityDiv_" + actCode));
        desktop.callFunction(actCode + "_OnLoadFunction");
    }
//}, 500);
}

self.appLoadActivityStarted = function() {
    document.getElementById('continueLink').style.visibility = "hidden";
}

self.appLoadActivityFinished = function() {
    document.getElementById('continueLink').style.visibility = "visible";
}

};

var scmWelcome = new SCMWelcome();
