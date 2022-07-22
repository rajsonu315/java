var templateEditorCache = new Hashtable();
var IS_DIRECTPRINT;

function newPopupCalender(nameOfTxtBox,nameOfBtn) {

    var elem = document.getElementById(nameOfBtn);
    var calElem = Calendar.setup( {
        inputField : nameOfTxtBox, // ID of the input field
        ifFormat : "%d/%m/%Y", // the date format
        weekNumbers : false,
        button : elem // button element
    }
    );

    if(calElem == undefined || calElem == null || calElem == 'undefined') {
        //eval('$("#" + nameOfBtn).' + evType + '()');
        var a = document.getElementById(nameOfBtn);
        var evnt = a["onclick"];
        if (typeof(evnt) == "function") {
            evnt.call(a);
        }
    }
} 

function findPosX(obj) {
    var curleft = 0;
    if(obj.offsetParent)
        while(1) {
            curleft += obj.offsetLeft;
            if(!obj.offsetParent)
                break;
            obj = obj.offsetParent;
        }
    else if(obj.x)
        curleft += obj.x;
    return curleft;
}

function findPosY(obj) {
    var curtop = 0;
    if(obj.offsetParent)
        while(1) {
            curtop += obj.offsetTop;
            if(!obj.offsetParent)
                break;
            obj = obj.offsetParent;
        }
    else if(obj.y)
        curtop += obj.y;
    return curtop;
}

function closeEPR() {
    self.close();
}

function setDefaultFeature(featureRID) {
    var url = PROJECT_CTXT_PATH + "/UMasterServlet?command=setDefaultFeature&newFeatureRID=" +  featureRID;
    var resultStr = trimNewLineSpaces(xmlGetResultString(url),2);  
    
    if(resultStr != 'success')
        alert('Error in re-setting default page. Please try again later') ;
}

function portalHomeInit() {
    document.getElementById('currentActivity').value = '';

}

function hideDiv(){
    var targetDiv = document.getElementById('alertDiv') ;
    if(targetDiv != null) {
        targetDiv.style.visibility = 'hidden' ;
        targetDiv.style.display = 'none' ;
    }
    var targetFrame  = document.getElementById('newFrame');
    if(targetFrame != null) {
        targetFrame.style.visibility = 'hidden' ;
        targetFrame.style.display = 'none' ;
    }
}  

function setActivity(description)  {
    if(document.getElementById('currentActivity') != null) {
        document.getElementById('currentActivity').value = description;
    }
}

function commonErrorMsgFun(errorMsg){
    document.getElementById('commonErrorMsg') != null ? document.getElementById('commonErrorMsg').innerText = errorMsg : "" ;
}

//pushpanjali: for relogin after session expiry
function doRelogin(url, elem){
    desktop.showReloginDiv(url, elem);

    //location.href = PROJECT_CTXT_PATH + "/Login";
}

var Editor = function() {
    
    this.getEditor = function(instanceName, width, height, toolbarSet, targetDiv, cbFunOnComplete) {
        if(toolbarSet == null) {
            toolbarSet = 'UbqDocumentToolbar';
        }
        
        if(width == null) {
            width = 600;
        }
        
        if(height == null) {
            height = 778;
        }
        
        //var editorInstance = desktop.getFromCache(instanceName);
        var editorInstance = document.getElementById(instanceName + 'Div');
        
        if(editorInstance == null) {
            var head = document.getElementsByTagName("head")[0];
            var div = document.createElement('div');
            div.id = instanceName + 'Div';
            //div.style.display = "none";
            div.innerHTML = createDocumentTemplate(instanceName, width, height, toolbarSet );
            div.cbFunOnComplete = cbFunOnComplete;
            //head.appendChild(div);
            //desktop.putIntoCache(instanceName, div);
            editorInstance = div;  // document.getElementById(instanceName + 'Div');
            //editorInstance = div;
        } 
        
        //targetDiv.replaceNode(editorInstance); 
        //targetDiv.innerHTML = editorInstance.innerHTML;
        targetDiv.appendChild(editorInstance); 
        if(document.getElementById(instanceName + '___Frame') != null ){
            document.getElementById(instanceName + '___Frame').src = document.getElementById(instanceName + '___Frame').src;
        }
    }
    
    function createDocumentTemplate(instanceName, width, height, toolbarSet) {
        try{
            var doc_tmpl_oFCKeditor = new FCKeditor(instanceName, width, height, toolbarSet);
            doc_tmpl_oFCKeditor.BasePath = PROJECT_CTXT_PATH + "/js/base/FCKeditor/";
            doc_tmpl_oFCKeditor.Config['ToolbarStartExpanded'] = true;
            return doc_tmpl_oFCKeditor.CreateHTML();
        } catch (e) {
            throw "Recall Function";
        }
    }
    
}  

var myEditor = new Editor();          


function getSelectedRadioValue(radioObjArr){
    var status = document.getElementsByName(radioObjArr);
    if(status.length == 0)
        return null;
    var statusValue = "";
    for(var i=0 ; i<status.length ; i++)
        if(status[i].checked == true)
            statusValue = status[i].value;
    return statusValue;
}


function FCKeditor_OnComplete(editorInstance) {

    var cbFunOnComplete = document.getElementById(editorInstance.Name + 'Div').cbFunOnComplete;
    if(cbFunOnComplete != null) {
        eval(cbFunOnComplete); 
    }
    
}

function FCKeditor_OnAfterSetHTML(editorInstance) {
    
    editorInstance.ResetIsDirty();
}

function ubqGetFloatValue(value) {
    if(value == null || value == '') {
        return parseFloat(0);
    } else {
        return parseFloat(value);
    }
}
//added by pushpanjali: to check whether session expired or not, in case when we are calling window.showModalDialog()
function sessionExpiryCheck(url){
    xmlHttp = GetXmlHttpObject("GET", url, null, false)
          if(xmlHttp != null) {              
            xmlHttp.send(null);
          } else {
            alert("XML connection failed!");
          }          
          if (xmlHttp.status == 200) {
            if (isSessionExpired()) {
                //added by pushpanjali
                doRelogin(url);
                return false;
            }
            return true;
          } else {
            alert("XML data fetch failed:\n" + xmlHttp.statusText);
            return false ;
          }
}

function initSortingOnTable(tableName) {
    // for sorting of the table dynamically
    setTimeout(function(){
        try{
            var tbl = document.getElementById(tableName);
            if(typeof(sorttable) == 'object' && tbl != null) {
                sorttable.makeSortable(tbl);
            }
        } catch(ex) {
            // do nothing
        }
    }, 0);
};