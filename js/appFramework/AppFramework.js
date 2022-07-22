AppFramework = function () {
    var self = this;
    
    var currentBO = null;
    var lastAction = null;
            
    function _handleSubmit(actionCode, actionBtn) {
        
        var elem = document.getElementById('validateFunc');
        
        if(elem != null) {
            var validateFunc = eval(elem.value);
            
            if(!validateFunc(actionCode, actionBtn))
                return false;
        }
        
        if(actionBtn) {
            lastAction = actionBtn;
            actionBtn.disabled = true;
        }
        waitLoading();
        document.getElementById('actionCode').value = actionCode;
        document.BOContainerForm.submit(); 

        return true;
    }
    
    function _handleGet(actionCode) {
        
    // desktop.showPopup("BO", url, {width:800});
    }
    
    function _handleGetFullScreen(actionCode) {
    }
    
    self.doBOAction = function (actionCode, actionBtn) {
        /*
    if(actionType == SUBMIT_ACTION)
      _handleSubmit(actionCode);
    else if(actionType == GET_ACTION)
      _handleGet(actionCode);
    else if(actionType == GET_ACTION_FULL_SCREEN)
      _handleGetFullScreen(actionCode);
    */
        if(actionBtn) {
            lastAction = actionBtn;
            actionBtn.disabled = true;
        }
        
        if(!_handleSubmit(actionCode, actionBtn)) {
            
            if(actionBtn)
                actionBtn.disabled = false;
            
        } else if(actionCode == 'MARK_AS_SEEN') {
            boWorklist.refreshWorklist();
        }
        
    }
    
    self.handleSuccess = function (msg) {        
        pageLoaded();
        resetDirtyBit();
        var refreshWell = null;
        var fn = document.getElementById("boSuccessHandler");
        if(fn != null) {
            var fnh = eval(fn.value);
            refreshWell = fnh(msg);
        } else {
            alert(msg);
        }    
                
        boWorklist.refreshWorklist(refreshWell);
    }
    
    self.handlePopupSuccess = function (msg) {        
        resetDirtyBit();
        var refreshWell = null;
        var fn = document.getElementById("boSuccessHandler");
        var handleClosePopup = 0;
        //This condition is for closing popup by checking the value of "handleClosePopup" which is a hidden variable set in the jsp
        if(document.getElementById("handleClosePopup")){
            handleClosePopup = document.getElementById("handleClosePopup").value;
        }
        //this is the default for closing the popup by framework
        if(0 == handleClosePopup){
            desktop.closePopup();
        }
        
       // alert(msg);
       var refreshWell = null;
        //desktop.closePopup();
        var fn = document.getElementById("boSuccessHandler");
        if(fn != null) {
            var fnh = eval(fn.value);
            refreshWell = fnh(msg);
        } else {
            alert(msg);
        }
        boWorklist.refreshWorklist();
    }
    
    self.handleFailure = function (msg) {
        if(lastAction) {
            lastAction.disabled = false;
        }
        alert(msg);
    }
    
    self.handleOnClear = function() {
        var elem = document.getElementById('clearFunc');
        if(elem != null) {
            var clearFunc = eval(elem.value);
            
            clearFunc();
        }
        return true;
    };
    
    self.showTransitionLog = function() {        
        document.getElementById("transitionLogView").className = "";
        document.getElementById("showHistoryLinkTR").className = "hidden";                       
    };

    self.hideHistory = function() {
                
        document.getElementById("transitionLogView").className = "hidden";
        document.getElementById("showHistoryLinkTR").className = "";
    }

    var lastSelectedRow = null;

    self.searchTask = function() {
        var searchByCol = document.getElementById('boSearchBy').value;
        var searchStr = document.getElementById('boSearchString').value;

        if(searchStr.trim() == "") {
            alert("Please enter what to search");
            return;
        }

        var tbl = document.getElementById('worklistTaskTbl');

        tableSearch.searchRow(tbl, searchByCol, searchStr);
    }
}

var appFramework = new AppFramework();
