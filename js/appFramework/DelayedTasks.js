var DelayedTasks = function() {
    
    var self = this;
    
    self.showWorklistItem = function(elem,ev,worklistRID,worklistDate,delayType){       
        var row = dynTableRow(elem); 
        var url = PROJECT_CTXT_PATH + "/DelayedTasksServlet?command=showDelayedWorklistItem&worklistRID="+worklistRID+
        "&worklistDate="+worklistDate+"&delayType="+delayType;
        desktop.openInset(row,url,ev);       
    }    
    
    self.showWorklist = function(elem,ev,worklistRID,userRID,unitRID,delayType,worklistDate){      
        var row = dynTableRow(elem); 
        var isDelayedTasks = 1;   
        var url = PROJECT_CTXT_PATH + "/BOServlet?command=showDelayedWorklistTasks&worklistRID="+worklistRID+
        "&isDelayedTasks="+isDelayedTasks+"&userRID="+userRID+"&unitRID="+unitRID+"&delayType="+delayType+"&worklistDate="+worklistDate+"&isDateSpecific=1";
        desktop.openInset(row,url,ev,true);       
    }  
    
    self.modifyWorklistDetails = function(elem, ev) { 
        var curRow = dynTableRow(elem);
        var isModifiedFlg = dynTableGetNodeInRow(curRow,'isModified').value;
        
        if(ev == '[object MouseEvent]') {
            
            var isTimeDelayExists = dynTableGetNodeInRow(curRow,'isTimeDelayExists').value;
            
            if(isTimeDelayExists == 0) {
                dynTableGetNodeInRow(curRow,'isTimeDelayExists').value = 1;
            }
            if(isTimeDelayExists == 1) {
                dynTableGetNodeInRow(curRow,'isTimeDelayExists').value = 0; 
            }
        }
        if(isModifiedFlg == 0) {
            dynTableGetNodeInRow(curRow,'isModified').value = 1 ;
        }
    }
    
    self.saveWorklistDetails = function(elem, ev) {
        elem.disabled = true;
        var table = document.getElementById('timeDelayDetailsTable');
        var rows = table.getElementsByTagName('TR');
        var count = 0;
        var timeDelay1 = 0;
        var timeDelay2 = 0;
        for(var i = 0; i < rows.length; i++) {
            var currentRow = dynTableRow(rows[i]);
            if(dynTableGetNodeInRow(currentRow,'isModified') != null) {
                var isModified = dynTableGetNodeInRow(currentRow,'isModified').value;
            }
            if(isModified == 1) { 
                count++;
                if(dynTableGetNodeInRow(currentRow,'isTimeDelayExists') != null) {
                    var isTimeDelayExists = dynTableGetNodeInRow(currentRow,'isTimeDelayExists').value;
                }
                if(isTimeDelayExists == 1) { 
                    if(dynTableGetNodeInRow(currentRow,'timeDelay1') != null)
                     timeDelay1 = parseInt(dynTableGetNodeInRow(currentRow,'timeDelay1').value);
                    if(dynTableGetNodeInRow(currentRow,'timeDelay2') != null)
                     timeDelay2 = parseInt(dynTableGetNodeInRow(currentRow,'timeDelay2').value);
                    if(timeDelay1 == 0 ) { 
                        alert(" TimeDelay 1 should be greater than Zero");
                        dynTableGetNodeInRow(currentRow,'timeDelay1').focus();
                        elem.disabled = false;
                        return;
                    }
                    if(timeDelay2 == 0) { 
                        alert(" TimeDelay 2 should be greater than Zero");
                        dynTableGetNodeInRow(currentRow,'timeDelay2').focus();
                        elem.disabled = false;
                        return;
                    }
                    if(timeDelay2 < timeDelay1) { 
                        alert("timeDelay 2 should not be less than timeDelay 1");
                        dynTableGetNodeInRow(currentRow,'timeDelay2').focus();
                        elem.disabled = false;
                        return;
                    }
                }
            }
        }
        if(count == 0) {
            alert('Nothing to save');
            elem.disabled = false;
            return;
        }
        
        var responseStr = xmlPostForm(document.worklistTimeDelayDetails, "DelayedTasksServlet");
        
        if(responseStr == "done") {
            alert("Updated successfully");
        }
        else {
            alert(responseStr);
        }
        var url = PROJECT_CTXT_PATH + "/DelayedTasksServlet?command=WorklistTimeDelaySettings";
        xmlLoadElementValues(url,document.getElementById("timeDelayDiv"));
        
        elem.disabled = false;
    }
    
    self.printWorklistTimeDelays = function(elem, ev) { 
        var url = PROJECT_CTXT_PATH + "/DelayedTasksServlet?command=WorklistTimeDelaySettings&printFlag=true";
        window.open(url,"_blank", "toolbar=yes,location=no,directories=no, status=no,menubar=no,scrollbars=yes,resizable=yes, copyhistory=no,fullscreen=nod,titlebar=yes");                
    }
}
var delayedTasks = new DelayedTasks();