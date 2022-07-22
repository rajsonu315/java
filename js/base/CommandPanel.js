var CommandPanel = function() {
    var self = this;
    var previousMenu = null;

    self.showMenuDiv = function(parentRid,ev) {
        var menuDiv = document.getElementById('childMenuDiv');
        var commandPanelDiv = document.getElementById('commandPanelDiv');
        var commandPanelDivWidth = commandPanelDiv.offsetWidth + 3;
        //var rect = menuDiv.getBoundingClientRect();
   
        if(menuDiv != null) {
            menuDiv.style.visibility = "visible";
            menuDiv.style.display = "block";
            var screenWidth = document.documentElement.clientWidth;
            var screenHeight = document.documentElement.clientHeight;
            // var left = (baGetMouseX(ev) > (screenWidth - 300)) ? (screenWidth - 300) : baGetMouseX(ev);
            var left = (commandPanelDivWidth > (screenWidth - 300)) ? (screenWidth - 300) : commandPanelDivWidth;
            
            var topPosition = (baGetMouseY(ev) > (screenHeight - 300)) ? (screenHeight - 300) : baGetMouseY(ev);
            menuDiv.style.left = left + "px";
            // menuDiv.style.top = document.documentElement.scrollTop + topPosition  + "px";
            menuDiv.style.top = document.documentElement.scrollTop + topPosition - 10 + "px";
            url = PROJECT_CTXT_PATH + "/UUserProfileServlet?command=loadChildFeatures&parentFeatRid=" + parentRid;
            xmlLoadElementValues(url, menuDiv);
        }
       
    }
    self.showMenuDiv = function(parentRid,ev,featDivHeight) {
        var menuDiv = document.getElementById('childMenuDiv');        
        var commandPanelDiv = document.getElementById('commandPanelDiv');
        if(commandPanelDiv.disabled) {
             return false;
        }
        // +3  added to manage cell spacing
        var commandPanelDivWidth = commandPanelDiv.offsetWidth + 3;
        //var rect = menuDiv.getBoundingClientRect();
        featDivHeight = featDivHeight + 30;
        if(menuDiv != null) {
            menuDiv.style.visibility = "visible";
            menuDiv.style.display = "block";           
            var screenWidth = document.documentElement.clientWidth;
            var screenHeight = document.documentElement.clientHeight;
            // var left = (baGetMouseX(ev) > (screenWidth - 300)) ? (screenWidth - 300) : baGetMouseX(ev);
            var left = (commandPanelDivWidth > (screenWidth - 300)) ? (screenWidth - 300) : commandPanelDivWidth;
            var topPosition = (baGetMouseY(ev) > (screenHeight - 320)) ? (screenHeight - 320) : baGetMouseY(ev);
            if(featDivHeight > (screenHeight-topPosition) ) {
                topPosition =  screenHeight-featDivHeight;
            }
            menuDiv.style.left = left + "px";
            
            // 10 = row height /2
            menuDiv.style.top = document.documentElement.scrollTop + topPosition - 10 + "px";
            
            url = PROJECT_CTXT_PATH + "/UUserProfileServlet?command=loadChildFeatures&parentFeatRid=" + parentRid;
            xmlLoadElementValues(url, menuDiv);
            /*
             * Changed by Saurabh
            */
            var childFrame = document.getElementById('childMenuFrame');            
            childFrame.style.position = 'absolute';
            childFrame.style.width =  '178px';
            childFrame.style.height =  featDivHeight+'px';
            childFrame.style.left = document.getElementById('childMenuDiv').style.left;
            childFrame.style.top = document.getElementById('childMenuDiv').style.top;
            childFrame.style.visibility = 'visible';
            childFrame.style.display = 'block';
            childFrame.style.filter = "alpha(opacity=" + 0 + ")";

        }
    }
    self.closeInlineDiv = function() {
        var menuDiv = document.getElementById('childMenuDiv');
        // Added by Saurabh
        var childFrame = document.getElementById('childMenuFrame');

        if(menuDiv != null) {
            menuDiv.style.visibility = "hidden";
            menuDiv.style.display = "none";           
        }
        if(childFrame != null) {
            childFrame.style.visibility = 'hidden';
            childFrame.style.display = 'none';
        }

      
    }
self.enableDisableMenu = function() {
    
   var updationStatus = document.getElementById('updationStatus').value;
   var commandPanelDiv = document.getElementById('commandPanelDiv');
    if(updationStatus == 'FAILED') {
       commandPanelDiv.disabled = true;
    } else {
       commandPanelDiv.disabled = false;
    }

}
//added by subhransu for highlighting the selected main menu
//selectedPreviousParentFeatureRow,and selectedCurrentParentFeatureRow is declared globally in desktop.js
self.setSelectedMenuRow = function(menuRow){
if(selectedPreviousParentFeatureRow!= undefined){
if(selectedPreviousParentFeatureRow.id == menuRow.id){
    selectedPreviousParentFeatureRow = menuRow;
}
}
    selectedCurrentParentFeatureRow = menuRow;
}

self.highlightMenu=function(){
    if(selectedPreviousParentFeatureRow.id != selectedCurrentParentFeatureRow.id){
        selectedPreviousParentFeatureRow.className = "normalMainMenu";
        selectedPreviousParentFeatureRow = selectedCurrentParentFeatureRow;
        selectedCurrentParentFeatureRow.className="highlightMainMenu";
    }else if(selectedPreviousParentFeatureRow.id == selectedCurrentParentFeatureRow.id){
        selectedCurrentParentFeatureRow.className="highlightMainMenu";
    }
    else{
        selectedCurrentParentFeatureRow.className="normalMainMenu";
    }
}
//end
self.highlightMenuItem=function(elemId){
    if(previousMenu){
        document.getElementById(previousMenu).className = "specialRow cursorPointer";
    }
        document.getElementById(elemId).className = "selectedMenu cursorPointer";
        previousMenu = elemId ;
    }



};

var commandPanel = new CommandPanel();

