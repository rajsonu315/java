var Attachment = function() {

    var self = this;

    self.loadForm = function(contextRID, contextType, ev, viewMode, maxNoOfAttachment) {

        if(maxNoOfAttachment == null || maxNoOfAttachment == ''){
            var maxNoOfAttachment = 0;
        }

        var targetURL =  PROJECT_CTXT_PATH + "/AttachmentServlet?command=loadForm&contextRID=" + contextRID +
        "&contextType=" + contextType + "&noOfAttachment=" + maxNoOfAttachment;

        if (document.getElementById('fromEMR')) {
            var fromEMR = document.getElementById('fromEMR').value;
            targetURL += "&fromEMR=" + fromEMR ;
        }

        if(viewMode) {
            targetURL += "&viewMode=1";
        }

        desktop.showPopup("Attachments", targetURL, {width:750, onLoad:function(){
            var attachmentDate = document.getElementById("attachmentDate");
            if(attachmentDate != null) {
                attachmentDate.focus();
            }
        },containerName:'attachmentContainer'});

        baCancelEvent(ev);

    };

    self.save = function() {
        // alert('att');

        if(document.getElementById("attachmentDesc").value == "" && !uscmIsEmpty(document.getElementById("file").value)) {
            alert('Enter some description for the attachment');
            document.getElementById("attachmentDesc").focus();
            return false;
        }
        var maxAttachment = document.getElementsByName('attachmentRID');
        var len = maxAttachment.length;
        var count = 0;
        for (var i = 0; i < len; i ++ ) {
            if ((dynTableGetNodeInRow(maxAttachment[i], 'deleteFlag')
                    && dynTableGetNodeInRow(maxAttachment[i], 'deleteFlag').value != '1'
                    && !uscmIsEmpty(dynTableGetNodeInRow(maxAttachment[i], 'attachmentDesc').value))) {
                    count ++;
            }else if((dynTableGetNodeInRow(maxAttachment[i], 'deleteFlag')
                    && dynTableGetNodeInRow(maxAttachment[i], 'deleteFlag').value != '1')
                    && uscmIsEmpty(dynTableGetNodeInRow(maxAttachment[i], 'attachmentDesc').value)){
                    count = count ;
                    }
        }

        var maxNoOfAttachment = 0;
        if(document.getElementById('maxNoOfAttachment'))
            maxNoOfAttachment = document.getElementById('maxNoOfAttachment').value;

        if(maxNoOfAttachment > 0 && count > maxNoOfAttachment){
            alert("Maximum of only two attachments can be added");
            return false;
        }

        document.attachmentsFrm.submit();
    };

    self.handleSave = function(message) {
        alert("Document(s) saved successfully");
        desktop.closePopup();
    };

    self.deleteAttachment = function(elem, attachmentRID, readonly) {

        var row = dynTableRow(elem);
        var ans = confirm("Details will be lost. Do you want to continue?");
        if(ans) {
            if(readonly == 'true') {
                var url = PROJECT_CTXT_PATH + "/AttachmentServlet?command=deleteAttachment&attachmentRID=" + attachmentRID;

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
//        dynTableGetNodeInRow(row, "attachmentDate").value = document.getElementById("currentDate").value;
        var attachmentDesc = dynTableGetNodeInRow(row, "attachmentDesc");
            attachmentDesc.value = "";

        dynTableGetNodeInRow(row, "filePath").value = "";
        dynTableGetNodeInRow(row, "file").value = "";
        dynTableGetNodeInRow(row, "attachmentRID").value = "0";

        var attachmentFileName = dynTableGetNodeInRow(row, "attachmentFileName");
        if(attachmentFileName) {
            dynTableGetNodeInRow(row, "attachmentFileName").innerHTML = "";
        }
    };

    self.setAttachmentPath = function(elem) {
        var row = dynTableRow(elem);

        var filePath = elem.value;
        var fileName = "";
        if(filePath != null && filePath != ""){
            fileName = filePath.substr(filePath.lastIndexOf("\\")+1, filePath.length);
        }
        dynTableGetNodeInRow(row, "filePath").value = elem.value;
        dynTableGetNodeInRow(row, "attachmentFileName").innerHTML = fileName;
        dynTableGetNodeInRow(row, "attachmentChanged").value = "1";
    };


    function validateAttachmentRow(row) {

        var all_is_fine = true ;
        var setFocusObj = null;

        dynTableGetNodeInRow(row,"rowErrorMsg").innerHTML = '';
        dynTableGetNodeInRow(row,"rowErrorMsg").title = "";


//        if(dynTableGetNodeInRow(row,"attachmentDate").value == "" ) {
//            dynTableGetNodeInRow(row,"rowErrorMsg").innerHTML = '!  ';
//            dynTableGetNodeInRow(row,"rowErrorMsg").title += "Enter date\n";
//            if(setFocusObj == null) setFocusObj = dynTableGetNodeInRow(row, "attachmentDate");
//            all_is_fine = false ;
//        } else

//        if(uscmIsMoreDate(dynTableGetNodeInRow(row,"attachmentDate").value,document.getElementById("currentDate").value)) {
//            dynTableGetNodeInRow(row,"rowErrorMsg").innerHTML = '!  ';
//            dynTableGetNodeInRow(row,"rowErrorMsg").title += "Date cannot be future date\n";
//            if(setFocusObj == null) setFocusObj = dynTableGetNodeInRow(row, "attachmentDate");
//            all_is_fine = false ;
//        } else
//        if(uscmIsEmpty(dynTableGetNodeInRow(row,"attachmentDate").value) || !isDate(dynTableGetNodeInRow(row,"attachmentDate").value,"dd/MM/yyyy")) {
//            dynTableGetNodeInRow(row,"rowErrorMsg").innerHTML = '!  ';
//            dynTableGetNodeInRow(row,"rowErrorMsg").title += "Invalid date format\n";
//            if(setFocusObj == null) setFocusObj = dynTableGetNodeInRow(row, "attachmentDate");
//            all_is_fine = false ;
//        }

        if(dynTableGetNodeInRow(row,"attachmentDesc").value == "" ) {
            alert('Enter description');
            dynTableGetNodeInRow(row,"rowErrorMsg").innerHTML = '!  ';
            dynTableGetNodeInRow(row,"rowErrorMsg").title += "Enter a description! \n ";
            if(setFocusObj == null) setFocusObj = dynTableGetNodeInRow(row, "attachmentDesc");
            all_is_fine = false ;
        }

        if(all_is_fine == false) {
            return false;
        }

        if(dynTableGetNodeInRow(row,"filePath").value == "") {
            alert('You must select a file to attach');
            dynTableGetNodeInRow(row,"rowErrorMsg").innerHTML = '!  ';
            dynTableGetNodeInRow(row,"rowErrorMsg").title += "Select an attachment! \n ";
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
           return;
        }
        var tmplRow = document.getElementById('attachmentCloneRow').cloneNode(true);
        clearAttachmentRow(tmplRow);
        curRow.id = "";
        dynTableGetNodeInRow(curRow, "attachmentRID").value = "0";
        dynTableGetNodeInRow(curRow, "attachmentAdd").className = "hidden";
        dynTableGetNodeInRow(curRow, "attachmentDelete").className = "link visible";
        dynTableGetNodeInRow(curRow, "file").className = "hidden";
        dynTableGetNodeInRow(curRow, "attachmentFileName").className = "visible";

        curRow.parentNode.insertBefore(tmplRow, curRow);

        dynTableGetNodeInRow(tmplRow, 'attachmentDesc').focus();
        
    };

    self.showAttachment = function(fileLocation,contentType) {
        var command = "writeAttachment";
        var url = PROJ_CTXT_PATH + "/AttachmentsServlet?command="+ command +"&fileContentType="+ contentType +"&filePath="+ fileLocation+"&templatefileName=a";
        window.open(url,"_blank", "toolbar=yes,location=no,directories=no, status=no,menubar=no,scrollbars=yes,resizable=no, copyhistory=no,fullscreen=no,titlebar=yes");
    }



    var PositionX = 100;
    var PositionY = 100;

    // Set these value approximately 20 pixels greater than the
    // size of the largest image to be used (needed for Netscape)

    var defaultWidth  = 500;
    var defaultHeight = 500;

    // Set autoclose true to have the window close automatically
    // Set autoclose false to allow multiple popup windows

    var AutoClose = true;

    // Do not edit below this line...
    // ================================
    var isNN;
    var isIE;
    if (parseInt(navigator.appVersion.charAt(0))>=4){
        isNN=(navigator.appName=="Netscape")?1:0;
        isIE=(navigator.appName.indexOf("Microsoft")!=-1)?1:0;
    }
    var optNN='scrollbars=yes,width='+defaultWidth+',height='+defaultHeight+',left='+PositionX+',top='+PositionY;
    var optIE='scrollbars=yes,width=150,height=100,left='+PositionX+',top='+PositionY;

    self.popImage = function(imageURL, imageTitle){

        if (isNN){imgWin=window.open('about:blank','',optNN);}
        if (isIE){imgWin=window.open('about:blank','',optIE);}
        with(imgWin.document){
            writeln('<html><head><title>Loading...</title><style>body{margin:0px;}</style>');writeln('<sc'+'ript>');
            writeln('var isNN,isIE;');writeln('if (parseInt(navigator.appVersion.charAt(0))>=4){');
            writeln('isNN=(navigator.appName=="Netscape")?1:0;');writeln('isIE=(navigator.appName.indexOf("Microsoft")!=-1)?1:0;}');
            writeln('function reSizeToImage(){');writeln('if (isIE){');writeln('window.resizeTo(300,300);');
            writeln('width=300-(document.body.clientWidth-document.images[0].width);');
            writeln('height=300-(document.body.clientHeight-document.images[0].height);');
            writeln('window.resizeTo(width,height);}');writeln('if (isNN){');
            writeln('window.innerWidth=document.images["George"].width;');writeln('window.innerHeight=document.images["George"].height;}}');
            writeln('function doTitle(){document.title="'+imageTitle+'";}');writeln('</sc'+'ript>');
            if (!AutoClose) writeln('</head><body bgcolor=000000 scroll="yes" onload="reSizeToImage();doTitle();self.focus()">')
            else writeln('</head><body bgcolor=000000 scroll="yes" onload="reSizeToImage();doTitle();self.focus()" onblur="self.close()">');
            writeln('<img name="George" src='+imageURL+' style="display:block"></body></html>');
            close();
        }
    };

    self.close = function() {
        documentSection.closePopup();
    };

    self.validateAttachment = function(){
        if(document.getElementById("attachmentDesc").value == "" && !uscmIsEmpty(document.getElementById("file").value)) {
            alert('Enter some description for the attachment');
            document.getElementById("attachmentDesc").focus();
            return false;
        }
        var maxAttachment = document.getElementsByName('attachmentRID');
        var len = maxAttachment.length;
        var count = 0;
        for (var i = 0; i < len; i ++ ) {
            if ((dynTableGetNodeInRow(maxAttachment[i], 'deleteFlag')
                    && dynTableGetNodeInRow(maxAttachment[i], 'deleteFlag').value != '1'
                    && !uscmIsEmpty(dynTableGetNodeInRow(maxAttachment[i], 'attachmentDesc').value))) {
                    count ++;
            }else if((dynTableGetNodeInRow(maxAttachment[i], 'deleteFlag')
                    && dynTableGetNodeInRow(maxAttachment[i], 'deleteFlag').value != '1')
                    && uscmIsEmpty(dynTableGetNodeInRow(maxAttachment[i], 'attachmentDesc').value)){
                    count = count ;
                    }
        }

        var maxNoOfAttachment = 0;
        if(document.getElementById('maxNoOfAttachment'))
            maxNoOfAttachment = document.getElementById('maxNoOfAttachment').value;

        if(maxNoOfAttachment > 0 && count > maxNoOfAttachment){
            alert("Maximum of only two attachments can be added");
            return false;
        }
        return true;
    }

};

var attachment = new Attachment();

var AttachmentContainer = function() {
    var self = this;

    self.handleSuccess = function(message) {
        attachment.handleSave(message);
    };

    self.handleFailure = function(message) {
        alert(message);
    };
};

var attachmentContainer = new AttachmentContainer();