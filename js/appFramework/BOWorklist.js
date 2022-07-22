BOWorklist = function () {

    var self = this;
    
    self.openWorklistTask = function (elem, ev, taskArgs) {
        var row = dynTableRow(elem);
        
        var wliRID = dynTableGetNodeInRow(row, "wliRID").value;
        var boCode = dynTableGetNodeInRow(row, "boCode").value;
        var boRID = dynTableGetNodeInRow(row, "boRID").value;
        var worklistType = dynTableGetNodeInRow(row, "worklistType").value;
        var worklistBOWorkContext = dynTableGetNodeInRow(row, "worklistBOWorkContext").value;
        var worklistRID = dynTableGetNodeInRow(row, "worklistRowRID").value;
        var timerFlag = dynTableGetNodeInRow(row, "timerFlag").value;
        var worklistViewMode = dynTableGetNodeInRow(row, "worklistViewMode");

        var isSnoozable = dynTableGetNodeInRow(row, "isSnoozable").value;
        var worklistFeatureCode = dynTableGetNodeInRow(row, "worklistFeatureCode").value;

        var url = PROJECT_CTXT_PATH + "/BOServlet?command=doBOAction&showInWell=0&boCode=" + boCode + "&boRID=" + boRID + "&actionCode=OPEN" +
        "&worklistType=" + worklistType + "&BOWorkContext=" + worklistBOWorkContext + "&worklistRID=" + worklistRID + "&wliRID=" + wliRID; // + "&isManaged=1";
        
        url += "&taskArgs=" + taskArgs + "&timerFlag=" + timerFlag + "&isSnoozable=" + isSnoozable;

        url += "&worklistFeatureCode=" + worklistFeatureCode;

        if(document.getElementById('hidTrackDelays')) {
            var hidTrackDelaysValue = document.getElementById('hidTrackDelays').value;
            url += "&hidTrackDelays=" + hidTrackDelaysValue;
        }
        
        //added by subhransu, to show worklist item in popup:1/openInset:0
        if(worklistViewMode){
            url += "&worklistViewMode=" + worklistViewMode.value;
        }
        if(1 == worklistViewMode.value){
            desktop.showPopup("", url, {width:1150,scrollable:true},true);
        }else{
            desktop.openInset(row, url, ev);
        }
        desktop.initPage();
    };
    
    self.popupWorklistTask = function (elem, ev, taskArgs) {

        var row = dynTableRow(elem);

        var wliRID = dynTableGetNodeInRow(row, "wliRID").value;
        var boCode = dynTableGetNodeInRow(row, "boCode").value;
        var boRID = dynTableGetNodeInRow(row, "boRID").value;
        var worklistRID = dynTableGetNodeInRow(row, "worklistRowRID").value;
        var worklistFeatureCode = dynTableGetNodeInRow(row, "worklistFeatureCode").value;
        var worklistType = dynTableGetNodeInRow(row, "worklistType").value;

        var url = PROJECT_CTXT_PATH + "/BOServlet?command=doBOAction&showInWell=0&boCode=" + boCode + "&boRID=" + boRID + "&actionCode=OPEN" +
          "worklistType=" + worklistType + "&worklistRID=" + worklistRID + "&wliRID=" + wliRID;
        
        url += "&worklistFeatureCode=" + worklistFeatureCode;

        desktop.showPopup("Activity Detail", url, {width:800});

        // ???? desktop.initPage(); ????
    };
        
    self.openUnmanagedWorklistTask = function (elem, openTaskURL, ev, taskArgs) {
        
        var row = dynTableRow(elem);
        
        var wliRID = dynTableGetNodeInRow(row, "wliRID").value;
        var boCode = dynTableGetNodeInRow(row, "boCode").value;
        var boRID = dynTableGetNodeInRow(row, "boRID").value;
        var worklistType = dynTableGetNodeInRow(row, "worklistType").value;
        var worklistRID = dynTableGetNodeInRow(row, "worklistRowRID").value;
        var timerFlag = dynTableGetNodeInRow(row, "timerFlag").value;
        
        var URL = PROJECT_CTXT_PATH + "/" + openTaskURL + "&boRID=" + boRID + "&wliRID=" + wliRID + "&actionCode=OPEN";
        
        URL += "&taskArgs=" + taskArgs + "&timerFlag=" + timerFlag; 
        
        //desktop.showPopup("BO", URL, {width:800});
        
        desktop.openInset(row, URL, ev);
        desktop.initPage();
    };
    

    var selectedWorklistRow = null;
    
    self.loadWorklistItem = function(row) {
        
        // initially we dont get 'isDateSpecific' value since the page is not loaded. so send the current date   
        // subsequently when you change the date, selected worklist will be loaded accordingly     
        var worklistDate = document.getElementById('worklistDate').value;
        /*var worklistDate = document.getElementById('worklistDate') != null && WorklistRow == row ?
            document.getElementById('worklistDate').value : presentDate; 
         */
        
        var worklistRID = dynTableGetNodeInRow(row, "worklistRID").value;
        var url = dynTableGetNodeInRow(row, "worklistCommand").value;
        var worklistName = dynTableGetNodeInRow(row, "worklistName").value;
        var worklistViewMode = dynTableGetNodeInRow(row, "worklistViewMode");

        var worklistCount = dynTableGetNodeInRow(row, "worklistCount").value;

        if(document.getElementById('currentActivity')){
            document.getElementById('currentActivity').innerHTML = worklistName;
        }

        
        var isDateSpecific = dynTableGetNodeInRow(row, "isDateSpecific") != null;
        if(isDateSpecific) {
            url += "&isDateSpecific=1";
        }
        
        url += "&worklistDate=" + worklistDate;
        url += "&worklistRID=" + worklistRID;
        url += "&worklistCount=" + worklistCount;
        
        var taskCommandURL = dynTableGetNodeInRow(row, "taskCommandURL").value;
        var isManaged = dynTableGetNodeInRow(row, "isManaged").value;
        
        url += "&isManaged=" + isManaged;
        
        if(taskCommandURL != "") {
            url += "&taskCommandURL=" + taskCommandURL;
        }
        
        var taskCommandURL = dynTableGetNodeInRow(row, "taskCommandURL").value;
        var isManaged = dynTableGetNodeInRow(row, "isManaged").value;
        
        url += "&isManaged=" + isManaged;
        
        if(taskCommandURL != "") {
            url += "&taskCommandURL=" + taskCommandURL;
        }
        
         if(dynTableGetNodeInRow(row, "wliTrackDelays")) {
             url += "&hidTrackDelays=" + dynTableGetNodeInRow(row, "wliTrackDelays").value;
         }
         if(worklistViewMode){
          url += "&worklistViewMode=" + worklistViewMode.value;
         }
        
        var wname = dynTableGetNodeInRow(row, "worklistName").value;
        desktop.loadPage(url, wname);
        //xmlLoadElementValues(url, document.getElementById('desktopWell'));
        
        setActivityBarTitle("Worklist: " + wname);
        
        clearWorklistSelection(row);
        
        selectedWorklistRow = row.cloneNode(true);
        
        // Load all the JS files that this worklist item needs
        var jsFiles = document.getElementsByName('jsFile');
        
        for(var i = 0; i < jsFiles.length; i++) {
            var jsFileName = jsFiles[i].value;
            desktop.jsLoad(jsFileName);
        }
        
        // Load all the CSS files that this worklist item needs
        var cssFiles = document.getElementsByName('cssFile');
        
        for(var i = 0; i < cssFiles.length; i++) {
            var cssFileName = cssFiles[i].value;
            desktop.cssLoad(cssFileName);
        }
        
        var initCmds = document.getElementsByName('onWorklistLoad');

        for(var i = 0; i < initCmds.length; i++) {
            eval(initCmds[i].value);
        }
        
    };
    
    function clearWorklistSelection(selectedElem) {
        var worklistTable = document.getElementById("worklistTable");
        for(var i = 0; i < worklistTable.rows.length; i++) {
            worklistTable.rows[i].className = "whiteBG";
        }
        selectedElem.className = "selectedWorklistItem";
    };

    function setActivityBarTitle(title) {
        desktop.setActivity(title);
    }
    
    self.refreshWorklist = function(refreshWell) {
        
        refreshWell = (refreshWell == null ? true : refreshWell);
        var isManaged = 0;
        
        var desktopWell = document.getElementById('desktopWell');
        
        var handlePageReload = 0;
        if(document.getElementById('handlePageReload')){
            handlePageReload = document.getElementById('handlePageReload').value;
        }
        if(desktopWell && refreshWell && 1 != handlePageReload) {
            desktopWell.innerHTML = "<table width=100% class=wellHeader ><tr><td></td></tr></table>";
        }
        
        // We need to refresh the selected row  
        
        if(self.refreshWorklistTable() && selectedWorklistRow != null && refreshWell) {
            var w = document.getElementsByName('worklistRID');
            
            for(var i = 0; i < w.length ; i++) {
                if(w[i].value == dynTableGetNodeInRow(selectedWorklistRow, "worklistRID").value) {
                    var row = dynTableRow(w[i]);
                    if(row) {
                        row.className = "selectedWorklistItem";
                    }
                    var worklistDate = document.getElementById('worklistDate').value; 
                    var worklistRID = dynTableGetNodeInRow(selectedWorklistRow, "worklistRID").value;
                    var url = dynTableGetNodeInRow(selectedWorklistRow, "worklistCommand").value;
                    var isDateSpecific = dynTableGetNodeInRow(selectedWorklistRow, "isDateSpecific") != null;
                    if(dynTableGetNodeInRow(selectedWorklistRow, "isManaged")) {
                        isManaged = dynTableGetNodeInRow(selectedWorklistRow, "isManaged").value;
                    }
                    
                    if(isManaged == 1)
                        url += "&isManaged=" + isManaged;
                    
                    var isManaged = dynTableGetNodeInRow(selectedWorklistRow, "isManaged").value;
                    
                    if(isDateSpecific) {
                        url += "&isDateSpecific=1";
                    }
                    url += "&worklistDate=" + worklistDate;
                    url += "&worklistRID=" + worklistRID;
                    
                    var taskCommandURL = dynTableGetNodeInRow(selectedWorklistRow, "taskCommandURL").value;
                    if(taskCommandURL != "") {
                        url += "&taskCommandURL=" + taskCommandURL;
                    }
                    
                    if(dynTableGetNodeInRow(selectedWorklistRow, "wliTrackDelays")) {
                        url += "&hidTrackDelays=" + dynTableGetNodeInRow(selectedWorklistRow, "wliTrackDelays").value;
                    }
                    //added by subhransu, to open worklistitem in popup/inline.
                    if(dynTableGetNodeInRow(selectedWorklistRow, "worklistViewMode")) {
                        url += "&worklistViewMode=" + dynTableGetNodeInRow(selectedWorklistRow, "worklistViewMode").value;
                    }
                    //end
                    url = PROJECT_CTXT_PATH + url;

                    xmlLoadElementValues(url, desktopWell);
                    break;
                }
            }
            
        }
        pageLoaded();
        
    };

    self.clearWorklistTable = function() {
        var wListDiv = document.getElementById('worklistItemsDiv');
        if(wListDiv) {
            
             wListDiv.innerHTML = '&nbsp;Click <a href="#" onClick="boWorklist.refreshWorklistTable()"><b>here</b></a> to refresh';
        }
        return true;
    };
    
    self.refreshWorklistTable = function(showNotification) {
        showNotification = (showNotification == null ? false : showNotification);
        var wListDiv = document.getElementById('worklistItemsDiv');
        if(wListDiv) {
            var url = PROJECT_CTXT_PATH + "/BOServlet?command=refreshWorklist";
            
            var worklistDate = document.getElementById('worklistDate').value; 
            url += "&worklistDate=" + worklistDate;
            
            if(selectedWorklistRow) {
                var selectedWorklistRID = dynTableGetNodeInRow(selectedWorklistRow, "worklistRID").value;
                url += "&selectedWorklistRID=" + selectedWorklistRID;
                
                if(dynTableGetNodeInRow(selectedWorklistRow, "wliTrackDelays")) {
                    url += "&hidTrackDelays=" + dynTableGetNodeInRow(selectedWorklistRow, "wliTrackDelays").value;
                }
            }
            
            var oldWorklistItems = getWorklistItems();
            xmlLoadElementValues(url, wListDiv);
            
            var newWorklistItems = getWorklistItems();            
            if(showNotification) {
                checkWorklistItems(oldWorklistItems, newWorklistItems);
            }            
        }

        return true;
    };
    
    function getWorklistItems() {
        
        var worklistItems = new Hashtable();
        var worklistTable = document.getElementById("worklistTable");
        var keys = "0";
        if(worklistTable) {
            var rows = worklistTable.rows;
            for(var i = 0; i < rows.length; i++) {
                if(rows[i].getAttribute('itemRow')) {
                    var row = dynTableRow(rows[i]);
                    var worklistName = dynTableGetNodeInRow(row, "worklistName").value;
                    var worklistCount = dynTableGetNodeInRow(row, "worklistCount").value;
                    keys += "~" + worklistName;
                    worklistItems.put(worklistName, worklistCount);
                }
            }
        }
        worklistItems.put("keys", keys);
        return worklistItems;
    };
    
    function checkWorklistItems(oldWorklistItems, newWorklistItems) {
        
        var oldKeys = oldWorklistItems.get("keys").split("~");
        var newKeys = newWorklistItems.get("keys").split("~");
        var keys = (oldKeys.length > newKeys.length ? oldKeys : newKeys);
        for(var i = 1; i < keys.length; i++) {
            var delayTime = i * 500;
            var itemName = keys[i];
            if(newWorklistItems.get(itemName) != null && oldWorklistItems.get(itemName) == null) {
                notification.alert(itemName, "You have new task(s) for " + itemName, delayTime);
            } else if(newWorklistItems.get(itemName) != null && oldWorklistItems.get(itemName) != null) {
                var oldItemCount = oldWorklistItems.get(itemName); 
                var newItemCount = newWorklistItems.get(itemName); 
                if(newItemCount > oldItemCount) {
                    notification.alert(itemName, (newItemCount - oldItemCount) + " new task(s) for " + itemName, delayTime);
                } else if(newItemCount < oldItemCount){
                    notification.alert(itemName, (oldItemCount - newItemCount) + " task(s) executed for " + itemName, delayTime);
                }
            }
        }
    };
    
    self.addDaysToWorklistDate = function(days) {
        var date = null;
        if(days != null) {
            date = addDaysToGivenDate(document.getElementById('worklistDate').value, days);
        } else {
            date = document.getElementById('worklistDate').value;
        }
        document.getElementById('worklistDate').value = date;
        document.getElementById('worklistDateLink').innerHTML = getRelativeTimePeriod(date);
        boWorklist.refreshWorklist();
        
        var worklistTable = document.getElementById('worklistTable');
        if(worklistTable) {
            worklistTable.focus();
        }
    };
    
    function getRelativeTimePeriod(date) {
        var currentDate = document.getElementById("currentDate");
        if(currentDate != null) {
            currentDate = currentDate.value;
            var dateDiffValue = dateDiff(currentDate, date);
            if(dateDiffValue == -1) {
                return "Yesterday";
            } else if(dateDiffValue == 0) {
                return "Today";
            } else if (dateDiffValue == 1) {
                return "Tomorrow";
            }
        } 
        
        return date;
        
    };
    
    self.enableOrDisableActionableButtons = function (showButtons) {

        var row = document.getElementById("actionsTR");
        var buttonCell  = row.getElementsByTagName("td")[0];
        var inputElements = buttonCell.getElementsByTagName("input");
        var boWorklistRID = document.getElementById("boWorklistRID").value;

        // alert(document.getElementsByName('worklistIsSnoozable').length); // TEST LINE!!
        var isSnoozable = document.getElementById('worklistIsSnoozable').value; // alert(isSnoozable);

        if(showButtons) {
            if(boWorklist.chkIsAnyTimerStopped(boWorklistRID)) {
                alert("You cannot stop the timer for more than one worklist item");
                return;
            }
            
            var userCodeValue = userCode.returnUserCode();
            var url = PROJECT_CTXT_PATH + "/NotificationServlet?command=validateUser";
            url += ('&userCode=' + userCodeValue);
            url += ('&featureCode=CAN_STOP_THE_WORKLIST_TIMER');
            var resString = xmlGetResultString(url);
            if(resString != "validUser") {
                return;
            }
        }
        for (var i = 0; i < inputElements.length; i++) {
            var element = inputElements[i];
            if(element.value == "Clear" || element.value == "Close" || element.value == "Snooze") {
                continue;
            }
            if(showButtons) {

                if (isSnoozable == 1 || isSnoozable == "1") {
                    element.setAttribute("class", "snoozeBtn");
                } else {
                    element.className = "";
                }
            } else { 
                element.className = "hidden";  
            }
        }
        if(showButtons) {
            document.getElementById("stopTimer").className = "hidden"; 
            document.getElementById("startTimer").className = ""; 
            var url = PROJECT_CTXT_PATH + "/NotificationServlet?command=stopTimer&boWorklistRID=" + boWorklistRID;
            boWorklist.applyTimerFlag(boWorklistRID, false);
            var responseStr = xmlGetResultString(url);
        } else {
            document.getElementById("startTimer").className = "hidden"; 
            document.getElementById("stopTimer").className = ""; 
            var url = PROJECT_CTXT_PATH + "/NotificationServlet?command=startTimer&boWorklistRID=" + boWorklistRID;
            boWorklist.applyTimerFlag(boWorklistRID, true);
            var responseStr = xmlGetResultString(url);
        }
        
        boWorklist.applyOlderColor(boWorklistRID);
    };
    
    self.chkIsAnyTimerStopped = function(boWorklistRID) {
        var tblElem = document.getElementById('worklistTaskTbl');
        if( document.getElementById('worklistTaskTbl') == null) {
            return false;
        }
        var  noOfRows = tblElem.rows.length;
        var rowBoWorklistRID = 0;
        for(var i=1; i<(noOfRows); i++){
            var currRow = tblElem.rows[i]; 
            var timerFlag = 0;
            if(dynTableGetNodeInRow(currRow, 'timerFlag') && dynTableGetNodeInRow(currRow, 'wliRID')) {
                timerFlag = dynTableGetNodeInRow(currRow, 'timerFlag').value;
                rowBoWorklistRID = dynTableGetNodeInRow(currRow, 'wliRID').value;
                if(rowBoWorklistRID == boWorklistRID) {
                    continue;
                }
                if(timerFlag == 1) {
                    return true;
                }
            }
            
        }
        return false;
    }
    
    self.applyTimerFlag = function(boWorklistRID, reSet) {
        var tblElem = document.getElementById('worklistTaskTbl');
        if(document.getElementById('worklistTaskTbl') == null) {
            return;
        }
        var  noOfRows = tblElem.rows.length;
        var rowBoWorklistRID = 0;
        for(var i=1; i<(noOfRows); i++){
            var currRow = tblElem.rows[i]; 
            var timerFlag = 0;
            if(dynTableGetNodeInRow(currRow, 'timerFlag') && dynTableGetNodeInRow(currRow, 'wliRID')) {
                rowBoWorklistRID = dynTableGetNodeInRow(currRow, 'wliRID').value;
                if(rowBoWorklistRID == boWorklistRID && reSet) {
                    dynTableGetNodeInRow(currRow, 'timerFlag').value = 0;
                    currRow.setAttribute("style", dynTableGetNodeInRow(currRow, 'bgColourSpec').value);
                    break;
                }else if(rowBoWorklistRID == boWorklistRID && !reSet) {
                    dynTableGetNodeInRow(currRow, 'timerFlag').value = 1;
                    currRow.setAttribute("style", dynTableGetNodeInRow(currRow, 'timerColourSpec').value);
                    break;
                }
            }
            
        }
    }
    
    self.applyOlderColor = function(boWorklistRID) {
        var tblElem = document.getElementById('worklistTaskTbl');
        if( document.getElementById('worklistTaskTbl') == null) {
            return;
        }
        var  noOfRows = tblElem.rows.length;
        var rowBoWorklistRID = 0;
        for(var i=1; i<(noOfRows); i++){
            var currRow = tblElem.rows[i]; 
            var timerFlag = 0;
            if(dynTableGetNodeInRow(currRow, 'timerFlag') && dynTableGetNodeInRow(currRow, 'wliRID')) {
                rowBoWorklistRID = dynTableGetNodeInRow(currRow, 'wliRID').value;
                if(rowBoWorklistRID == boWorklistRID) {
                    continue;
                } 
                currRow.setAttribute("style", dynTableGetNodeInRow(currRow, 'bgColourSpec').value);
            }
        }
    }

    self.loadWorklistSequenceMaster = function(){
	var url = PROJECT_CTXT_PATH + "/BOServlet?command=setWorklistSequence";

	var worklistRID = document.getElementsByName("worklistRID");
	var worklistType = document.getElementsByName("worklistType");

	var unManagedWL = "0", boWL = "0";
	for(var i = 0; i < worklistRID.length; i++){
	    if(worklistType[i].value == "0") {
		unManagedWL += "," + worklistRID[i].value;
	    } else {
		boWL += "," + worklistRID[i].value;
	    }
	}

	url += "&unManagedWLRIDs=" + unManagedWL + "&boWLRIDs=" + boWL;
	
	desktop.showPopup("Set Worklist Sequence", url, {
	    width:500
	});
	
    }

    self.saveWorklistSequence = function () {
	var responseStr = xmlPostForm(document.worklistSequenceFrm, "BOServlet", null);
	if(responseStr == "done") {
	    alert("Saved Successfully");
	    desktop.closePopup();
	    boWorklist.refreshWorklistTable();
	}else {
	    alert(responseStr);
	}
    }

     self.exportWorklist = function () {

        if (document.getElementById('worklistConfigRID')) {

            var worklistRID = document.getElementById('worklistConfigRID').value;
            var worklistName = document.getElementById('worklistName').value;

            var URL = PROJECT_CTXT_PATH + "/BOServlet?command=exportWorklistTasks&worklistRID=" + worklistRID +
                "&worklistName=" + worklistName + "&checkExportFlag=2";

            window.open(URL, "_blank", "toolbar=yes,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,copyhistory=no,fullscreen=nod,titlebar=yes");

        } else {
            alert('Error while retrieving worklist details.')
            return;
        }
    }
    
    self.discardWorklistRowItem = function (elem, ev, worklistItemRID) {

        baCancelEvent(ev); // alert(worklistItemRID); // TEST LINE!!

        if (confirm('Are you sure you want to discard this worklist row item?')) {

            var URL = PROJECT_CTXT_PATH + "/BOServlet?command=discardWorklistRowItem&worklistItemRID=" + worklistItemRID;

            var responseStr = xmlGetResultStringWithAuthentication(URL, 'DISCARD_WORKLIST_ROW_ITEM');

            if (responseStr == 'done') {
                alert('The worklist row item has been successfully discarded.');
                boWorklist.refreshWorklist();
            
            } else {
                // Do nothing!!
            }

        } 

    }
    
};

var boWorklist = new BOWorklist();