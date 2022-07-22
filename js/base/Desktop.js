var Desktop = function(){
    var self = this;
    
    var cache = new Hashtable();
    var loaded = false;
    var dirtyBit = '0' ;
    var selectedFeatureCommand = '';
    var selectedFeatureName = '';
    
    self.dirtyBitSet = function() {
        return dirtyBit == '1';
    };
    
    self.setDirtyBit = function(eventCheck){
        /*
         * Due to some explict handle of keycode which is done on body keydown, we don not require keyCode check.
         * If you do not want to perform keyCode check here send false as eventCheck i.e., setDirtyBit(false);
         */
        eventCheck = (eventCheck == null ? true : eventCheck);
        
        if(event != null && eventCheck == true && (event.keyCode == 126 || event.keyCode == 94 || event.keyCode == 27 || (event.keyCode == 13 && event.srcElement.tagName != "TEXTAREA" )|| event.keyCode == 18 ) ){
            window.event.returnValue=false;           
            return;
        }     
        
        dirtyBit = '1' ;
        
    };
    
    //call this function when the form is cleared
    self.resetDirtyBit = function(){    
        
        dirtyBit = '0' ;    
        
    };
    
    //this function will be called internally when any link is clicked. (you dont have to bother about it)
    self.checkTransition = function() {    
        var ans;
        if(dirtyBit == '1'){ 
            ans = confirm("Selected action will discard any entered data. Continue?");
            if(ans) {
                
                dirtyBit = '0' ;
                return true;
            } else {
                return false;
            }
        }
        
        return true ;
    };
    
    
    self.jsLoad = function(jsFile) {
        var f = document.getElementById(jsFile);
        
        if (f != null) { // Already exists
            return;
        }
        
        var head = document.getElementsByTagName("head")[0];
        var script = document.createElement('script');
        script.id = jsFile;
        script.type = 'text/javascript';
        script.src = jsFile;
        head.appendChild(script);
	
        loadedScriptNodes.push(script);
    };
    
    self.openInset = function(row, url, ev) {
        // @@ check if the row already exists
        if(baGetNextSibling(row) != null && baGetNextSibling(row).attributes['detailsRowExpanded'] != null) {
            self.closeInset(baGetNextSibling(row));
        //return;
        }
        
        desktop.showLoading(ev);
        
        var targetDiv = createInsetRow(row);
        xmlLoadElementValues(url, targetDiv);
        //self.initPage();
        desktop.hideLoading();
    };
    
    var lastCreatedInsetRow = null; 
    function createInsetRow(row, handleClose) {
        // @@ creating a row for loading the page
        var newRow = document.createElement('tr');
        //newRow.className = "inset";
        newRow.setAttribute("detailsRowExpanded", "true");

        var tdElem = document.createElement('td');
        tdElem.colSpan = row.cells.length;
        tdElem.width = "100%";
        tdElem.className = "inset";
        
        var divElem = document.createElement('div');
        divElem.className = "whiteBG";
        tdElem.appendChild(divElem);
        newRow.appendChild(tdElem);
        if(lastCreatedInsetRow) {
            try {
                dynTableDeleteRow(lastCreatedInsetRow);
            } catch(e) {
            // do nothing
            }
        }
        lastCreatedInsetRow = row.parentNode.insertBefore(newRow, baGetNextSibling(row));
        /*
        if(handleClose) {
            // @@ creating a row for close button
            var newRow2 = document.createElement('tr');
            newRow2.className = "inset";
            
            var tdElem2 = document.createElement('td');
            tdElem2.colSpan = row.cells.length;
            tdElem2.width = "100%";
            tdElem2.align = "right";
            tdElem2.innerHTML = "<input type='button' value='Close' onclick='desktop.closeInset(this)' >";
            
            newRow2.appendChild(tdElem2);
            newRow.parentNode.insertBefore(newRow2, baGetNextSibling(newRow));
        }
         */
        return divElem;
    };
    
    self.closeInset = function(elem) {
        var row = dynTableRow(elem);
        //dynTableDeleteRow(baGetPreviousSibling(row));
        dynTableDeleteRow(row);
    };
    
    function cssLoad(cssFile) {
        
        var f = document.getElementById(cssFile);
        
        if (f != null) { // Already exists
            return;
        }
        
        var head = document.getElementsByTagName("head")[0];
        var lnk = document.createElement('link');
        lnk.id = cssFile;
        lnk.type = 'text/css';
        lnk.rel = 'stylesheet';
        lnk.href = cssFile;
        head.appendChild(lnk);
    };
    
    var loadedScriptNodes;

    function loadJsCssFile() {
        var jsFiles = document.getElementsByName('jsFile');

        loadedScriptNodes = new Array();

        for(var i = 0; i < jsFiles.length; i++) {
            var jsFileName = jsFiles[i].value;
           
            self.jsLoad(jsFileName);
        }
       
        var cssFiles = document.getElementsByName('cssFile');
        
        for(var i = 0; i < cssFiles.length; i++) {
            var cssFileName = cssFiles[i].value;
           
            cssLoad(cssFileName);
        }

    }; 
    
    
    //    self.checkAllJsLoaded = function(endFunc) {
    //
    //        for(var i = 0; i < loadedScriptNodes.length; i++) {
    //            if(loadedScriptNodes[i].readyState != 'loaded' && loadedScriptNodes[i].readyState != 'complete') {
    //                setTimeout(function() {self.checkAllJsLoaded(endFunc)}, 200);
    //                return;
    //            }
    //        }
    //
    //        endFunc();
    //    }
    // shiv
    self.checkAllJsLoaded = function(endFunc) {

        for(var i = 0; i < loadedScriptNodes.length; i++) {
            //alert(loadedScriptNodes[i].id + ":" + loadedScriptNodes[i].readyState);
            if(loadedScriptNodes[i].readyState == null)
                break;

            if(loadedScriptNodes[i].readyState != 'loaded' && loadedScriptNodes[i].readyState != 'complete') {
                setTimeout(function() {
                    self.checkAllJsLoaded(endFunc)
                }, 200);
                return;
            }
        }
        //alert("Calling init Func");

        endFunc();
    };
    
    this.showJSFileCount = function (msg) {
        var scr = document.getElementsByTagName("script");
        var jsf = document.getElementsByName("jsFile");
        alert(msg + scr.length + ", " + jsf.length);
    }

    self.initPopupPage = function() {

        loadJsCssFile();

        setTimeout(function() {
            self.checkAllJsLoaded(callOnLoadPopupFunctions)
        }, 500);
    }
    
    
    self.initPage = function() {

        loadJsCssFile();
        
        setTimeout(function() {
            self.checkAllJsLoaded(callOnLoadFunctions)
        }, 500);
    }
    
    function callOnLoadFunctions() {
        var initCmds = document.getElementsByName('onLoadFunction');
        for(var i = 0; i < initCmds.length; i++) {
            
            evalFunctions(initCmds[i].value);
        }
        self.hideBusyMessage();
    };
    
    function callOnLoadPopupFunctions() {
        var initCmds = document.getElementsByName('onLoadPopupFunction');
        for(var i = 0; i < initCmds.length; i++) {
            evalFunctions(initCmds[i].value);
        }
        self.hideBusyMessage();
    };
    
    function callOnUnloadPopupFunctions() {
        var initCmds = document.getElementsByName('onUnloadPopupFunction');
        for(var i = 0; i < initCmds.length; i++) {
            evalFunctions(initCmds[i].value);
        }
    };
    
    var callCount = 0;
    function evalFunctions(funName) {
        callCount++;
        var functionName = funName.substring(0, funName.indexOf('('));
        try{
            var functionExist = eval(functionName); // checking if function exists
            try {
                eval(funName); // function is loaded and is executing
            } catch (ex) {
                if(ex == "Recall Function") { // Function is loaded but function has subsequent calls to other function which are not loaded. So its called after some time
                    throw "Recall Function";  // The onload function need to handle this
                } else {
                    throw "Function error";
                }
            }
        } catch (e) {
            if(e == "Function error") {
                alert("Failed to execute onload function '" + funName + "'");
                callCount = 0;
            } else {
                if(callCount < 13) {
                    setTimeout(function() {
                        evalFunctions(funName)
                    }, 2000) ;
                } else {

                    callCount = 0;
                }
            }
        }
    };
    
    self.loadPage = function(featureCommand, featureName) {
        
        
        var height = document.documentElement.clientHeight;//.clientHeight;
        var divHeight = Math.round(Number(height) * (70/100));
        document.getElementById('desktopWell').style.height = divHeight + "px";
        
        var selectedFeatureCommand = document.getElementById("selectedFeatureCommand");
        var selectedFeatureName = document.getElementById("selectedFeatureName");

        if(featureCommand != null && featureCommand != '' && document.getElementById('desktopWell') != null) {
            document.getElementById('currentActivity').innerHTML = featureName;
            var featureCommandFinal = PROJECT_CTXT_PATH + featureCommand;

            //pushpanjali: change is related to relogin when session is expired.
            if(!xmlLoadElementValues(featureCommandFinal, document.getElementById('desktopWell'))){
                return false;
            }
            self.initPage();
            selectedFeatureCommand.value = featureCommand;
            selectedFeatureName.value = featureName;
            
            //var tempFeatureCommand = featureCommand.substring(featureCommand.lastIndexOf('/') + 1, featureCommand.length);
            //var tempURL = "UDesktop?command=setSelectedFeature&selectedFeature=" + featureCommand;
            return true;
        //xmlGetResultString(tempURL);

        }
    }


    
    var inlinePopupKey = null;
    self.showInlinePopup = function(url) {
        var desktopWell = document.getElementById('desktopWell');
        if(desktopWell != null) {
            cache.put(url, desktopWell.innerHTML);
            xmlLoadElementValues(url, desktopWell);
            inlinePopupKey = url;
            self.initPage();     
        }        
    }
    
    self.closeInlinePopup = function() {
        var desktopWell = document.getElementById('desktopWell');
        if(desktopWell != null && inlinePopupKey != null) {
            var tempPageCache = cache.get(inlinePopupKey);
            if(tempPageCache != null) {
                desktopWell.innerHTML = tempPageCache;
            }
            self.clearCahce(inlinePopupKey);
            inlinePopupKey = null;
        }  
    }
    
    self.clearCahce = function(key){
        cache.remove(key) ;
    }    
    
    
    
    self.showBusyMessage = function(){
        desktop.setActivity('');
        var desktopWell = document.getElementById('desktopWell') ;  
        if(desktopWell != null) {
            desktopWell.innerHTML = "<div align='right' style='height:50px;' ><br><span class=loadingMessage >&nbsp;Loading... Please wait...&nbsp;&nbsp;</span></div>";
            
        }
    };    
    
    self.unHideBusyMessage = function(){
        var desktopLoadingMessageDiv = document.getElementById('desktopLoadingMessageDiv') ;  
        
        if(desktopLoadingMessageDiv != null) {
            
            desktopLoadingMessageDiv.style.display = "block";
        }
    };  
    
    self.hideBusyMessage = function() {        
        var desktopLoadingMessageDiv = document.getElementById('desktopLoadingMessageDiv') ;  
        if(desktopLoadingMessageDiv != null) {
            desktopLoadingMessageDiv.style.display = "none";
        }
    }
    
    
    /*self.showLoading = function(event){
        
        var loadingDiv = document.getElementById('loadingDiv');
        if(loadingDiv != null && event != null) {
            loadingDiv.style.left = event.x;
            loadingDiv.style.top = document.documentElement.scrollTop + event.y;
            loadingDiv.style.display = "inline";
        }
        
    }*/
    self.showLoading = function(ev){

        if(!ev) 
            ev = window.event;
        
        var loadingDiv = document.getElementById('loadingDiv');
        if(loadingDiv != null) {
            var screenWidth = document.documentElement.clientWidth;
            var left = (baGetMouseX(ev) > (screenWidth - 200)) ? (screenWidth - 200) : baGetMouseX(ev);
            loadingDiv.style.left = left + "px";
            loadingDiv.style.top = document.documentElement.scrollTop + baGetMouseY(ev) + "px";
            loadingDiv.style.display = "inline";
        }
        
    };
    
    
    self.hideLoading = function(){
        var loadingDiv = document.getElementById('loadingDiv');
        if(loadingDiv != null) {
            loadingDiv.style.display = "none";
        }
    }
    
    self.hideBusyMessage = function() {
        var desktopLoadingMessageDiv = document.getElementById('desktopLoadingMessageDiv') ;  
        if(desktopLoadingMessageDiv != null) {
            desktopLoadingMessageDiv.style.display = "none";
        }
    }
    
    
    
    
    self.handlePageUnload = function(){
        var fn = document.getElementById('onUnloadFunction');
        
        if(fn != null) {
            eval(fn.value);
        }
    };
    
    self.handleKeyDown = function() {  
        
        var fn = document.getElementById('keyDownHandler');
        
        if(fn != null) {
            eval(fn.value);
        }
    };

    //    self.handleBackspace = function() {
    //        if(event.keyCode != null && event.keyCode==8) {
    //            event.keyCode = null;
    //        }
    //    } ;
    // shiv
    self.handleBackspace = function(ev) {
        var kc = baGetKeyCode(ev);

        if(kc != null && kc == 8) {
            baCancelEvent(ev);
        }
    };
    self.handleRefresh = function() {
        var fn = document.getElementById('refreshHandler');
        
        if(fn != null) {
            eval(fn.value);
        }
    };
    
    self.handleUnitChange = function(unitRID) {   
        var fn = document.getElementById('unitChangeHandler');
        
        if(fn != null) {
            eval(fn.value + "(" + unitRID + ");");
        }
    };
    
    self.putIntoCache = function(key, value) {
        cache.put(key, value);
    };
    
    self.getFromCache = function(key, url) {
        
        var r = cache.get(key);
        
        if(r == null && url != null) {
            
            //alert("Loading cache from server (" + key + ")");
            
            self.putIntoCache(key, xmlGetResultString(url));
            
            r = cache.get(key);
        }
        
        return r;
    };
    
    self.setActivity = function(description) {
        if(document.getElementById('currentActivity') != null) {
            document.getElementById('currentActivity').value = description;
        }
    };
    
    
    var popupDiv = new UPopupDiv();
    
    self.showPopup = function(title, url, popupArg,blurBackground) {
                
        var tempPopupArg = popupArg;
        tempPopupArg.onPopupInit = "desktop.initPopupPage()";
        
        popupDiv.showPopup(title, url, tempPopupArg,blurBackground);
    
    }
    
    self.closePopup = function(popupID) {
        popupDiv.closePopup(popupID);
        callOnUnloadPopupFunctions();
    }
    
    self.startPopup = function(popupID){
        popupDiv.startPopup(popupID);
    }
    
    self.stopPopup = function(){
        popupDiv.stopPopup();
    }
    
    self.movePopup = function(event){
        popupDiv.movePopup(event);
    }
    
    
    
    self.confirmMessage = function(successMsg){
        var targetIFrame = document.getElementById('statusMessageFrame') ;  
        var targetDiv = document.getElementById('statusMessageDiv') ;  
        targetIFrame.style.display = 'inline' ;
        targetDiv.style.display = 'inline' ;
        var tempSpan = targetDiv.getElementsByTagName('span');    
        tempSpan[0].innerHTML = successMsg ;
        setTimeout(hideDiv,2000) ;
    };     
    
    function hideDiv(){
        var targetDiv = document.getElementById('statusMessageDiv') ;
        targetDiv.style.display = 'none' ;
        var targetIFrame = document.getElementById('statusMessageFrame') ; 
        targetIFrame.style.display = 'none' ;            
    };
    
    self.getHandler = function(handlerID){
        var handler = document.getElementById(handlerID);
        
        var containerHandlerName = popupDiv.getContainerHandler();
        
        if(popupDiv.hasContainorHandler() && containerHandlerName != null) {
            // for now its hard coded, later we need to find different logic
            
            var handlerName = "";
            if(handlerID == 'successHandler') {
                handlerName = 'handleSuccess';
            } else  if(handlerID == 'failureHandler') {
                handlerName = 'handleFailure';
            } else  if(handlerID == 'reloadSuccessHandler') {
                handlerName = 'handleSuccessReload';
            }
            
            return (containerHandlerName + "." + handlerName);
        } 
        
        if(handler != null) {
            return handler.value;
        }
        
    };

    self.getUserUnitRID = function() {
        return document.getElementById('cmbUnit').value;
    }

    //pushpanjali: for relogin after session expiry
    self.relogin = function() {
        
        document.getElementById('btnRelogin').disabled = true;
        document.getElementById('btnCloseRelogin').disabled = true;

        var entCode = document.getElementById('userEntityCode').value;
        var locationRID = document.getElementById('userEntityRID').value;
        var password = document.getElementById('loginPassWord').value;
        var userID = document.getElementById('userID').value;
        //var generatedSessionID = document.getElementById('generatedSessionID').value;

        var url = PROJECT_CTXT_PATH + "/Login?command=relogin&userName=" + userID +
        "&password=" + password +
        "&entCode=" + entCode +
        "&locationRID=" + locationRID ;
                                        
        var response = xmlPostSync(url);
        document.getElementById('btnRelogin').disabled = false;
        document.getElementById('btnCloseRelogin').disabled = false;
        
        if(Number(response) != 1) {
            alert('Login Failed. Please verify the password and try again')
            document.getElementById('loginPassWord').value = '';
            document.getElementById('loginPassWord').focus();
            return;
        }

        var cmb = document.getElementById('cmbUnit');
        if(cmb){
            try {
                var unitRID = cmb.options[cmb.selectedIndex].value;
                var unitName = cmb.options[cmb.selectedIndex].text;
                var url = PROJECT_CTXT_PATH + "/UUnitServlet?command=setUnit&unitRID=" + unitRID + "&unitName="+unitName;
                xmlPostSync(url);
            } catch(e) {
            // do nothing
            }
        }

        self.closeReloginDiv(true);

        if(currentURL && elemToBeReplaced == document.getElementById('desktopWell')) {
            
            var contextPath = PROJECT_CTXT_PATH;
            var currentURLWithoutContextPath ="";
            if(currentURL.indexOf(contextPath) != -1){
                //now removing the contextPath as it is added in loadPage();
                currentURLWithoutContextPath = currentURL.substring(contextPath.length,currentURL.length);
            }else{
                currentURLWithoutContextPath = currentURL;
            }
            if(!self.loadPage(currentURLWithoutContextPath, '', ''))
                return false;
        }
    };
    //pushpanjali: for relogin after session expiry
    self.closeReloginDiv = function(success) {
        document.getElementById('reloginDiv').style.display = "none";
        document.getElementById('desktopReloginIFrame').style.display = "none";

        if(document.getElementById('desktopPopupWell'))
            document.getElementById('desktopPopupWell').className = 'visible';
    };

    var currentURL = null;
    var elemToBeReplaced = null;
    ////pushpanjali: for relogin after session expiry
    self.showReloginDiv = function(url, elem) {

        currentURL = null;
        elemToBeReplaced = null;

        if(url && elem) {
            currentURL = url;
            elemToBeReplaced = elem;
        }

        var reloginDiv = document.getElementById('reloginDiv');
        var desktopReloginIFrame = document.getElementById('desktopReloginIFrame');
        //var reloginDiv = reloginTempDiv.cloneNode(true);
        //  var desktopReloginIFrame = desktopReloginTempIFrame.cloneNode(true);
        //var parentElem =  reloginTempDiv.parentNode;
        //parentElem.removeChild(reloginTempDiv);
        // parentElem.removeChild(desktopReloginIFrame);
        if(reloginDiv != null) {
            reloginDiv.style.left =  "300px";
            reloginDiv.style.top = document.documentElement.scrollTop + 200 + "px";
            reloginDiv.style.display = "inline";
            document.getElementById('loginPassWord').value = '';
            document.getElementById('loginPassWord').focus()

            desktopReloginIFrame.style.left =  "300px"
            desktopReloginIFrame.style.top = document.documentElement.scrollTop + 200 + "px";
            desktopReloginIFrame.style.display = "inline";
            desktopReloginIFrame.style.width = reloginDiv.style.width;
            desktopReloginIFrame.style.height = reloginDiv.style.height;
            document.getElementById('btnRelogin').disabled = false;
            document.getElementById('btnCloseRelogin').disabled = false;
        // parentElem.appendChild(reloginDiv);
        // parentElem.appendChild(desktopReloginIFrame);

        }

        if(document.getElementById('desktopPopupWell'))
            document.getElementById('desktopPopupWell').className = 'hidden';

    };
    //pushpanjali: for relogin after session expiry
    self.reloginOnEnter = function(ev) {
        var kc = baGetKeyCode(ev);

        if(kc != null && kc == 13) {
            self.relogin();
        }
    }
    
}; // end of class



function handleSuccess(successMsg) {
    var fn = desktop.getHandler('successHandler');
    
    if(fn != null) {
        var callStr = fn + "('" + successMsg + "');";
        
        eval(callStr);
    }

    if(boWorklist){
        boWorklist.refreshWorklistTable();
    }
}

function handleFailure(errorMsg) {
    var fn = desktop.getHandler('failureHandler');
    
    if(fn != null)
        eval(fn + "('" + errorMsg + "');");
}

function handleSuccessReload(reloadPage, url) {
    var fn = desktop.getHandler('reloadSuccessHandler');
    
    if(fn != null)
        eval(fn + "('" + reloadPage + "', '" + url + "');");
    if(boWorklist){
        boWorklist.refreshWorklistTable();
    }

}

var UPopupDiv = function(){
    var self = this;
    var containerHandler = new Hashtable();
    var containerPointer = -1;
    var uniquePopup = new Hashtable(); // if the popup should be opened only once
    
    self.getContainerHandler = function(){
        return containerHandler.get(containerPointer);
    }
    
    self.hasContainorHandler = function(){
        return (containerPointer > -1);
    }
    
    self.showPopup = function(title, url, popupArg,blurBackground) {
        
        var width, height, top, left, scrollable, floatable, containerHandlerName, id, onCloseFun, onPopupInit, onLoad;
        
        if(popupArg != null) {
            width = popupArg.width;
            height = popupArg.height;
            top = popupArg.top;
            left = popupArg.left;
            scrollable = popupArg.scrollable;
            floatable = popupArg.floatable;
            containerHandlerName = popupArg.containerName;
            onCloseFun = popupArg.onCloseFun;
            onPopupInit = popupArg.onPopupInit;
            onLoad = popupArg.onLoad;
            id = popupArg.id; // commented because right now we are allowing only one instance on popup. once the class structure is done we can go with this model
        //id = "MedicsPopup";
        //            if(uniquePopup.get(id) != null) {
        //
        //                if(title != null && title != '') {
        //                    alert('Only one instance of ' + title + ' can be opend')
        //                } else {
        //                    alert('Only one instance of the popup window can be opened')
        //                }
        //                return;
        //
        //            //containerPointer--;
        //            }
            
        }
        
        scrollable = (scrollable == null ? false : scrollable);
        floatable = (floatable == null ? false : floatable);
        
        if(title == null) {
            title = "";
        }

        if(url == null) {
            alert('Please specify the url for popup window');
            return false;
        }
        
        containerPointer++;
        if(id != null) {
            uniquePopup.put(id, containerPointer);
            uniquePopup.put(containerPointer, id);
        }
        createPopup(containerPointer, onCloseFun,blurBackground); // create a node for popup
        
        //        document.getElementById('desktopPopUpWorkArea' + containerPointer).innerHTML = "<h5>&nbsp;&nbsp;Loading... Please wait...<h5>";

        //        setTimeout(function(){

        // modified by saurabh... 23.05.2012 ... need to check the return value as based upon that we need to either return or continue...
        var returnVal = xmlLoadElementValues(url, document.getElementById('desktopPopUpWorkArea' + containerPointer));

        // Added by saurabh...23.05.2012
        if(!returnVal){
            removePopup(containerPointer);
            return false;
        }
        // @end saurabh
        
        setTimeout(function(){

            if(onPopupInit != null) {
                eval(onPopupInit);
            }
            
            if(onLoad != null) {
                try{
                    
                    if(typeof(onLoad) == "function") {
                        onLoad();
                    } else if (typeof(onLoad) == "string"){
                        eval(onLoad);
                    }
                    
                } catch(ex) {
                    // Error while calling onLoad function. Request user to try again.
                    alert("Desktop error: Failed to execute " + onLoad + "...please try again");
                }
            }
            if(document.getElementById('desktopPopUpTitle' + containerPointer )){
                document.getElementById('desktopPopUpTitle' + containerPointer ).innerHTML = "&nbsp;" + title;
            }
            
        }, 0);
        //        }, 0);
        
        if(containerHandlerName != null) {
            containerHandler.put(containerPointer, containerHandlerName);
        }
        
        var desktopPopUpDiv = document.getElementById('desktopPopUpDiv' + containerPointer);
        var desktopPopUpFrame = document.getElementById('desktopPopUpFrame' + containerPointer);
        var desktopPopUpScroll = document.getElementById('desktopPopUpScroll' + containerPointer);
        var desktopPopUpWorkArea = document.getElementById('desktopPopUpWorkArea' + containerPointer);
        
        document.getElementById('desktopPopUpTitle' + containerPointer ).innerHTML = "&nbsp;" + title + "...please wait...";
        desktopPopUpDiv.style.visibility = 'visible';
        desktopPopUpDiv.style.display = 'inline';
        desktopPopUpFrame.style.visibility = 'visible';
        desktopPopUpFrame.style.display = 'inline';
        
        if(scrollable) {
            if(width == null) {
                width = 700;
            }
            
            if(height == null) {
                height = 700;
            }
        } else {
            if(height == null) {
                height = desktopPopUpDiv.offsetHeight;    
            }
            
            if(width == null) {
                width = desktopPopUpDiv.offsetWidth;    
            }
        }
        
        
        if(top == null) {
            var screenHeight = document.documentElement.clientHeight;
            var scrollTop = document.documentElement.scrollTop;
            top = ((screenHeight - height) / 2 - 20) ;
            if(top < 0) {
                top = 5;
            }
            top += scrollTop;
        }
        
        if(left == null) {
            var screenWidth = document.documentElement.clientWidth;
            var scrollLeft = document.documentElement.scrollLeft;
            left = (screenWidth - width) / 2 + 7;
            if(left < 0) {
                left = 5;
            }
            left += scrollLeft;
        }
        // shiv, for browser compatible
        desktopPopUpDiv.style.height = height + "px";
        desktopPopUpDiv.style.width = width + "px";
        desktopPopUpFrame.style.height = (height + 2) + "px";
        desktopPopUpFrame.style.width = width + "px";        
        
        if(scrollable) {
            desktopPopUpFrame.style.height  = (height + 20) + "px";
            desktopPopUpScroll.style.height = height + "px";
            desktopPopUpScroll.style.width = '100%';
            if(baIsIEBrowser()) {
                //desktopPopUpWorkArea.style.width = '97.5%';
                desktopPopUpWorkArea.style.width = '100%';
            }
            desktopPopUpScroll.style.overflow = 'auto';
        } else {
            desktopPopUpScroll.style.height = '';
            desktopPopUpScroll.style.width = '';
            if(baIsIEBrowser()) {
                desktopPopUpWorkArea.style.width = '100%';
            }
            desktopPopUpScroll.style.overflow = '';
        }
        
        
        
        if(floatable) {
            JSFX_FloatDiv("desktopPopUpDiv" + containerPointer, left, top).floatIt();
            JSFX_FloatDiv("desktopPopUpFrame" + containerPointer, left, top).floatIt();
        } else {
            desktopPopUpDiv.style.top = top + "px";
            desktopPopUpDiv.style.left = left+ "px";
            desktopPopUpFrame.style.top = top+ "px";
            desktopPopUpFrame.style.left = left+ "px";
        }
        
        return true;
    }
    
    
    self.closePopup = function(popupID){
        
        removePopup(popupID);
        uniquePopup.remove(uniquePopup.get(containerPointer));
        uniquePopup.remove(containerPointer);
        containerHandler.remove(containerPointer);
        containerPointer--;
    //        if(containerPointer == -1) {
    //
    //            var curDesc = document.getElementById('activityDescrow');
    //            curDesc.disabled = false;
    //
    //            var controltd = document.getElementsByName('controlFeat');
    //
    //            if(controltd != null) {
    //
    //                 for (var i = 0; i < controltd.length; i++) {
    //
    //                        controltd[i].disabled = false;
    //                    }
    //                }
    //        }
    //        //subhransu , to activae on close function of pop up
    //          if(onCloseFun != null) {
    //                try{
    //                    if(typeof(onCloseFun) == "function") {
    //                        onCloseFun();
    //                    } else if (typeof(onCloseFun) == "string"){
    //                        eval(onCloseFun);
    //                    }
    //
    //                } catch(ex) {
    //                    // Error while calling onCloseFun function. Request user to try again.
    //                    alert("Desktop error: Failed to execute " + onCloseFun + "...please try again");
    //                }
    //            }
    }
    
    
    var ns = (navigator.appName.indexOf("Netscape") != -1);
    var d = document;
    function JSFX_FloatDiv(id, sx, sy) {
        var el=d.getElementById?d.getElementById(id):d.all?d.all[id]:d.layers[id];
        var px = document.layers ? "" : "px";
        window[id + "_obj"] = el;
        if(d.layers)el.style=el;
        el.cx = el.sx = sx;
        el.cy = el.sy = sy;
        el.sP=function(x,y){
            this.style.left=x+px;
            this.style.top=y+px;
        };
        
        el.floatIt=function() {            
            var pX, pY;
            pX = (this.sx >= 0) ? 0 : ns ? innerWidth : 
            document.documentElement && document.documentElement.clientWidth ?
            document.documentElement.clientWidth : document.body.clientWidth;
            pY = ns ? pageYOffset : document.documentElement && document.documentElement.scrollTop ?
            document.documentElement.scrollTop : document.body.scrollTop;
            if(this.sy<0)
                pY += ns ? innerHeight : document.documentElement && document.documentElement.clientHeight ?
                document.documentElement.clientHeight : document.body.clientHeight;
            this.cx += (pX + this.sx - this.cx)/8;
            this.cy += (pY + this.sy - this.cy)/8;
            this.sP(this.cx, this.cy);
            setTimeout(this.id + "_obj.floatIt()", 1);
        }
        return el;
    }
    
    
    var popupMove = false;
    var fixLeft = false;
    var tempMouseX = 0;
    
    self.stopPopup = function() {
        popupMove = false;
        fixLeft = false;
    }
    
    self.startPopup = function() {
        popupMove = true;
    }
    
    self.movePopup = function(evt) {
        //evt = evt?evt:window.event;
        if (popupMove ) {            
            var mouseX = evt.pageX ? evt.pageX : evt.clientX;
            mouseY = evt.pageY ? evt.pageY : document.documentElement.scrollTop + evt.clientY;
            var desktopPopUpDiv = document.getElementById('desktopPopUpDiv' + containerPointer);
            var desktopPopUpFrame = document.getElementById('desktopPopUpFrame' + containerPointer);
            
            var desktopPopUpDiv = document.getElementById('desktopPopUpDiv' + containerPointer);
            var desktopPopUpFrame = document.getElementById('desktopPopUpFrame' + containerPointer);
            if(desktopPopUpDiv != null && desktopPopUpFrame != null) {
                
                if(fixLeft == false) {
                    tempMouseX = (mouseX - desktopPopUpDiv.offsetLeft);
                    fixLeft = true;
                }
                mouseX = mouseX - 5;
                mouseY = mouseY - 15;
                desktopPopUpDiv.style.left = (mouseX - tempMouseX) + "px";
                desktopPopUpDiv.style.top = mouseY + "px";
                desktopPopUpFrame.style.left = (mouseX - tempMouseX) + "px";
                desktopPopUpFrame.style.top = mouseY + "px";
            }
        }
    }
    function getDocHeight() {
        var D = document;
        return Math.max(
            Math.max(D.body.scrollHeight, D.documentElement.scrollHeight),
            Math.max(D.body.offsetHeight, D.documentElement.offsetHeight),
            Math.max(D.body.clientHeight, D.documentElement.clientHeight)
            );
    }

    
    function createPopup(popupID, onCloseFun,blurBackground) {

        var desktopPopupWell = document.getElementById("desktopPopupWell");
        //subhransu, added to make the background screen focus out, on 26/03/2012
        if(blurBackground){
            var height = getDocHeight() - 20;
            var width = document.body.clientWidth;
            var transparentDiv = document.createElement('divTransparent');
            transparentDiv.id = 'trnsparentDiv' + popupID;
            transparentDiv.innerHTML = "<iframe style='position:absolute;width:" + width + "px;height:" + height + "px;display:none;z-index:1;' frameborder='1' scrolling='no' ></iframe>" +
            "<div style='width:" + width + "px;height:"+height+"px;position:absolute;z-index:1;filter:alpha(opacity=70);-moz-opacity:0.7; -khtml-opacity: 0.7; opacity: 0.7;background-color:#EEE;'></div>" ;
            desktopPopupWell.appendChild(transparentDiv);
        }
        //end
        var div = document.createElement('div');
        div.id = 'popup' + popupID;
        div.onCloseFun = onCloseFun;
        div.innerHTML = "<iframe id='desktopPopUpFrame" + popupID + "' style='position:absolute;width:400px;height:400px;display:none;z-index:1;' frameborder='0' scrolling='no' ></iframe>" +
        "<div id='desktopPopUpDiv" + popupID + "' style='visibility:hidden;display:none;position:absolute;background-color:white;z-index:1;' class='border'>" +
        "<table width='100%' cellpadding='0' cellspacing='0' border='0'  class='whiteBG'>" +
        "<tr class='popupColor' >" +
        "<td  width='95%' id='desktopPopUpTitle" + popupID + "' height='25px' onmousedown='desktop.startPopup()' style='cursor:crosshair;'  >" +
        "</td>" +
        "<td width='5%' align='right'><span style='cursor:pointer;' title='Close window' " +
        " onclick='desktop.closePopup(" + popupID + ")'><u>Close</u>&nbsp;</span>" +
        "</td>" +
        "</tr>" +
        "<tr>" +
        "<td colspan='2' style='padding-left:0px;' > " +
        "<div id='desktopPopUpScroll" + popupID + "' ><div id='desktopPopUpWorkArea" + popupID + "' ></div></div>" +
        "</td>" +
        "</tr>" +
        "</table>" +
        "</div>";

        desktopPopupWell.appendChild(div);
    }
    
    function removePopup(popupID) {
        if(popupID == null) {
            popupID = containerPointer;
        }
        
        var desktopPopupWell = document.getElementById("desktopPopupWell");
        var popupDiv = document.getElementById('popup' + popupID);
        //subhransu, added.
        var trnsparentDiv = document.getElementById('trnsparentDiv' + popupID);
        //end
        if(popupDiv.onCloseFun != null) {
            eval(popupDiv.onCloseFun);
        }
        if(trnsparentDiv != null || trnsparentDiv != undefined){
            desktopPopupWell.removeChild(trnsparentDiv);
        }
        desktopPopupWell.removeChild(popupDiv);
    }
    
} // End of pop function



var desktop = new Desktop();
