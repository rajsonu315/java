var UDataSwitcher = function() {
    var self = this;
    
    //**
    //* xmlLoadElementValues
    //* url = target url 
    //* elem = target object
    //* offlineCbFunc = off line call back function
    //* explicitOffline = work off line explicitly
    //**    
    self.xmlLoadElementValues = function(url, elem, offlineCbFunc, explicitOffline) {
        explicitOffline = explicitOffline == null ? false : explicitOffline;
        var responseText = "";
        
        if( (offlineCbFunc == null || uOfflineManager.canAccessServer()) && explicitOffline == false) {
            try {
                responseText = xmlGetResultString(url);
            } catch (ex) {
                // if server status is active and not updated but the network is not avaliable
                if(ex.message != null && ex.message.indexOf("system cannot locate the resource specified") > 0) {
                    uOfflineManager.setServerActiveState(false);
                    responseText = eval(offlineCbFunc);
                }
            }
        } else if(uOfflineManager.canGoOffline()){
            responseText = eval(offlineCbFunc);
        } else {
            // if offline privilege is not there and the server is not accessible 
            responseText = xmlGetResultString(url);
        }
        
        if(responseText != null) {
            var _parent = elem.parentNode;
            elem.parentNode.innerHTML = responseText;
            
            var _new_elem = _parent.childNodes[0];
            
            baMergeAttributes(elem, _new_elem);
            
        }
        
        return responseText;
    };
    
    //**
    //* xmlGetResultString
    //* url = target url 
    //* offlineCbFunc = off line call back function
    //* explicitOffline = work off line explicitly
    //* returns the response string
    //**  
    self.xmlGetResultString = function(url, offlineCbFunc, explicitOffline){
        explicitOffline = explicitOffline == null ? false : explicitOffline;
        var responseText = "";
        
        if( (offlineCbFunc == null || uOfflineManager.canAccessServer()) && explicitOffline == false) {
            try {
                responseText = xmlGetResultString(url);
            } catch (ex) {
                // if server status is active and not updated but the network is not avaliable
                if(ex.message != null && ex.message.indexOf("system cannot locate the resource specified") > 0) {
                    uOfflineManager.setServerActiveState(false);
                    responseText = eval(offlineCbFunc);
                }
            }
        } else if(uOfflineManager.canGoOffline()) {
            responseText = eval(offlineCbFunc);
        } else {
            // if offline privilege is not there and the server is not accessible 
            responseText = xmlGetResultString(url);
        }    
        
        return responseText;       
    };
    
    //**
    //* xmlPostSync
    //* url = target url 
    //* offlineCbFunc = off line call back function
    //* explicitOffline = work off line explicitly
    //* returns the response string
    //**  
    self.xmlPostSync = function(url, offlineCbFunc, explicitOffline){
        explicitOffline = explicitOffline == null ? false : explicitOffline;
        var responseText = "";
        
        if( (offlineCbFunc == null || uOfflineManager.canAccessServer()) && explicitOffline == false) {
            try {
                responseText = xmlPostSync(url);
            } catch (ex) {
                // if server status is active and not updated but the network is not avaliable
                if(ex.message != null && ex.message.indexOf("system cannot locate the resource specified") > 0) {
                    uOfflineManager.setServerActiveState(false);
                    responseText = eval(offlineCbFunc);
                }
            }
        } else if(uOfflineManager.canGoOffline()) {
            responseText = eval(offlineCbFunc);
        } else {
            // if offline privilege is not there and the server is not accessible 
            responseText = xmlPostSync(url);
        }
        
        return responseText;       
    };
    
    //**
    //* formSubmitter
    //* onlineCbFunc = the function which is used for submit 
    //* onSubmitFunc = if you have any form validation function which returns boolean
    //* offlineCbFunc = on click of submit call this function if offline
    //* explicitOffline = work off line explicitly
    //**  
    self.formSubmitter = function(onlineCbFunc, onSubmitFunc, offlineCbFunc, explicitOffline) {
        explicitOffline = explicitOffline == null ? false : explicitOffline;
        if(onSubmitFunc != null && onSubmitFunc != '') {
            if(!eval(onSubmitFunc)) {
                return false;
            }
        }
        if(!uOfflineManager.canGoOffline() ){ // if no offline support
            eval(onlineCbFunc);
        } else if( (offlineCbFunc == null || uOfflineManager.canAccessServer()) && explicitOffline == false) {
            //if no offline feature or server is accessable(on line) and there is no explicit request for offline mode
            eval(onlineCbFunc);
        } else {
            //offline mode
            eval(offlineCbFunc);
        } 
    };    
};

var uDataSwitcher = new UDataSwitcher();
