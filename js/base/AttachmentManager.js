var AttachmentManager = function() {
    var self = this;
    
    self.loadForm = function(contextRID, contextType, ev, viewMode) {
        var targetURL =  PROJECT_CTXT_PATH + "/AttachmentsServlet?command=loadForm&contextRID=" + contextRID +
        "&contextType=" + contextType;
        if(viewMode) {
            targetURL += "&viewMode=1";
        }
        
        desktop.showPopup("Add Attachments", targetURL, {width:750, height:170, onLoad:function(){
            var attachmentDate = document.getElementById("attachmentDate");
            if(attachmentDate != null) {
                attachmentDate.focus();
            }
        },containerName:'attachmentsContainer' });
        baCancelEvent(ev);
 
    };
    
    self.save = function() {
        document.attachmentsFrm.submit();
    };
    
    self.handleSave = function(message) {
        desktop.closePopup();
    };
    
    self.deleteAttachment = function(elem, attachmentRID, readonly) {
        
        var row = dynTableRow(elem);
        var ans = confirm("Details will be lost. Do you want to continue?");
        if(ans) {
            if(readonly == 'true') {
                var url = PROJECT_CTXT_PATH + "/AttachmentsServlet?command=deleteAttachment&attachmentRID=" + attachmentRID;
                
                var returnValue = xmlGetResultString(url);
                if(returnValue == "done") {
                    dynTableDeleteRow(row); 
                } else {
                    alert("Error in deleting details. Please try again later or report to the System Administrator");	
                }
            } else {
                dynTableGetNodeInRow(row, "deleteFlag").value = "1";
                row.className = "hidden";
            }
        }
    };
    
    self.deleteAddedAttachment = function(elem) {
        var row = dynTableRow(elem);
        var ans = confirm("Details will be lost.Do you want to continue?");
        if(ans) {
            dynTableDeleteRow(row); 
        }
    };
    
    function clearAttachmentRow(row) {
        dynTableGetNodeInRow(row, "attachmentDate").value = document.getElementById("currentDate").value;
        dynTableGetNodeInRow(row, "attachmentDesc").value = "";
        dynTableGetNodeInRow(row, "filePath").value = "";
        dynTableGetNodeInRow(row, "attachmentFileName").innerHTML = "";    
    };
    
    self.setAttachmentPath = function(elem) {
        var row = dynTableRow(elem);
        dynTableGetNodeInRow(row, "filePath").value = elem.value;
        dynTableGetNodeInRow(row, "attachmentFileName").innerHTML = elem.value;
        dynTableGetNodeInRow(row, "attachmentChanged").value = "1";        
    };
    
    
    function validateAttachmentRow(row) {
        
        var all_is_fine = true ;
        var setFocusObj = null;
        
        dynTableGetNodeInRow(row,"rowErrorMsg").innerHTML = '';
        dynTableGetNodeInRow(row,"rowErrorMsg").title = ""; 
        
        
        if(dynTableGetNodeInRow(row,"attachmentDate").value == "" ) {
            dynTableGetNodeInRow(row,"rowErrorMsg").innerHTML = '!  ';
            dynTableGetNodeInRow(row,"rowErrorMsg").title += "Enter date\n";       
            if(setFocusObj == null) setFocusObj = dynTableGetNodeInRow(row, "attachmentDate");
            all_is_fine = false ;                   
        } else if(uscmIsMoreDate(dynTableGetNodeInRow(row,"attachmentDate").value,document.getElementById("currentDate").value)) {
            dynTableGetNodeInRow(row,"rowErrorMsg").innerHTML = '!  ';
            dynTableGetNodeInRow(row,"rowErrorMsg").title += "Date cannot be future date\n";       
            if(setFocusObj == null) setFocusObj = dynTableGetNodeInRow(row, "attachmentDate");
            all_is_fine = false ;                             
        } else if(uscmIsEmpty(dynTableGetNodeInRow(row,"attachmentDate").value) || !isDate(dynTableGetNodeInRow(row,"attachmentDate").value,"dd/MM/yyyy")) {         
            dynTableGetNodeInRow(row,"rowErrorMsg").innerHTML = '!  ';
            dynTableGetNodeInRow(row,"rowErrorMsg").title += "Invalid date format\n";       
            if(setFocusObj == null) setFocusObj = dynTableGetNodeInRow(row, "attachmentDate");
            all_is_fine = false ;         
        }
        
        if(dynTableGetNodeInRow(row,"attachmentDesc").value == "" ) {        
            dynTableGetNodeInRow(row,"rowErrorMsg").innerHTML = '!  ';
            dynTableGetNodeInRow(row,"rowErrorMsg").title += "Enter description\n";       
            if(setFocusObj == null) setFocusObj = dynTableGetNodeInRow(row, "attachmentDesc");
            all_is_fine = false ;                
        }
        
        if(dynTableGetNodeInRow(row,"filePath").value == "") {
            dynTableGetNodeInRow(row,"rowErrorMsg").innerHTML = '!  ';
            dynTableGetNodeInRow(row,"rowErrorMsg").title += "Select attachment\n";       
            if(setFocusObj == null) setFocusObj = dynTableGetNodeInRow(row, "file");
            all_is_fine = false;
        }
        
        if(all_is_fine == false)
            return false;
        else
            return true;                    
    };
    
    self.addAttachment = function(elem) {
        var curRow = dynTableRow(elem);
        if(!validateAttachmentRow(curRow)){
            return false ;
        } else {
        var tmplRow = document.getElementById('attachmentCloneRow').cloneNode(true);
        clearAttachmentRow(tmplRow);
        curRow.id = "";
        dynTableGetNodeInRow(curRow, "attachmentRID").value = "0";
        dynTableGetNodeInRow(curRow, "attachmentAdd").className = "deleteSmallButton whiteBG hidden";
        dynTableGetNodeInRow(curRow, "attachmentDelete").className = "deleteSmallButton whiteBG visible";
        dynTableGetNodeInRow(curRow, "file").className = "hidden";
        dynTableGetNodeInRow(curRow, "attachmentFileName").className = "visible";
        
        curRow.parentNode.insertBefore(tmplRow, curRow);
        
        dynTableGetNodeInRow(tmplRow, 'attachmentDesc').focus();
        return true ;
           }
    };
    
    self.showAttachment = function(filePath, fileContentType) {
        var url = PROJECT_CTXT_PATH + "/AttachmentsServlet?command=writeAttachment" +
        "&filePath=" + filePath + "&fileContentType=" + fileContentType;        
        window.open(url,"_blank", "toolbar=yes,location=no,directories=no, status=no,menubar=no,scrollbars=yes,resizable=no, copyhistory=no,fullscreen=no,titlebar=yes");   
    };
    
    self.close = function() {
        documentSection.closePopup();
    };
    
};

var attachmentManager = new AttachmentManager();

var AttachmentsContainer = function() {
    var self = this;
    
    self.handleSuccess = function(message) {
        attachmentManager.handleSave(message);
    };
    
    self.handleFailure = function(message) {
        alert(message);
    };
};

var attachmentsContainer = new AttachmentsContainer();