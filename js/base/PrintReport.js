PrintReportManager = function() {
    var self = this;
    self.printReport = function(action, command, ReportFileName, reportName, Format, transRID, isSilent) {
        if(isSilent || confirm("Do you want to print " + reportName + " report?")) {
            var url =   projPath + "/jsp/reports/ReportContainer.jsp" +
            "?action=" + action + 
            "&command=" + command + 
            "&ReportFileName=" + ReportFileName + 
            "&reportName=" + reportName + 
            "&Format=" + Format + 
            "&transRID=" + transRID;
            
            
            var window1 = window.open(url, "_blank", "toolbar=no,'location=no,width=300,height=100',directories=no,status=no,menubar=no,scrollbars=no,resizable=no,copyhistory=no,fullscreen=no,titlebar=no");
            window1.focus();
        }
    }
    
    function _createFolder(fso, folderPath) {
        
        var forderArr = folderPath.split("\\");
        
        var rootFolder = forderArr[0];
        
        for (var i = 1; i < forderArr.length ; i ++) {
            rootFolder += "\\" + forderArr[i];
            if(!fso.FolderExists(rootFolder)) {
                fso.CreateFolder(rootFolder);
            }
        }
        
    }
    
    /* Function     :doDOSPrint
     * Description  :Print report in dos mode
     * Parameter:
     *      cbCSVCreateFunction -> callback function to create the csv File
     *      reportPath          -> Root path of report folder
     *      perlFileName        -> PerlFileName.pl
     *      csvFileName         -> CSV File Name Which contail all data 
     *      reportName          -> Formated report file name
     *      isPreview           -> Direct print or preview in notepad (1/0)
     */
    self.doDOSPrint = function(cbCSVCreateFunction, reportPath,  perlFileName, csvFileName, reportName, isPreview,LinesPerPage,detailRowCount,printCount,dosPrinter) {
        try {

        //fso = new ActiveXObject("Scripting.FileSystemObject");
	
        var pathSeparator = document.printApplet.getPathSeparator();
        var reportPath = document.printApplet.getReportPath();       
        var batchFileName = "printReport.bat";
        if(!document.printApplet.isWindows()) {
            batchFileName = "printReport.sh";
        }
	} catch (e) {
		alert(e);
		return	
	}
	
        if (!document.printApplet.isFileExists(reportPath + pathSeparator + "PerlFiles" + pathSeparator + perlFileName)) {
            
            if(!document.printApplet.isFileExists(reportPath + pathSeparator + "PerlFiles")) {
                var response = document.printApplet.createFolder(reportPath + pathSeparator + "PerlFiles");
                if(response != 'success') {
                    alert (response);
                    return;
                }
                
            }
            
            if(!document.printApplet.isFileExists(reportPath + pathSeparator + "data")) {
                var response = document.printApplet.createFolder(reportPath + pathSeparator + "data");
                if(response != 'success') {
                    alert (response);
                    return;
                }
            }
            
            if(!document.printApplet.isFileExists(reportPath + pathSeparator + "Report")) {
                var response = document.printApplet.createFolder(reportPath + pathSeparator + "Report");
                if(response != 'success') {
                    alert (response);
                    return;
                }
            }
            var url = projPath + "/PrintServlet?command=getPerlFileContents&perlFileName=" + perlFileName;
            var fileContent = xmlGetResultString(url);
            var response = document.printApplet.createFile(reportPath + pathSeparator + "PerlFiles" + pathSeparator + perlFileName, fileContent);
            if(response != 'success') {
                    alert (response);
                    return;
            }
              
            url =  projPath + "/PrintServlet?command=getPrintBatFile&isWindows=" + (document.printApplet.isWindows() ? "1" : "0");
            var fileContent = xmlGetResultString(url);
                        
            response = document.printApplet.createFile(reportPath + pathSeparator + batchFileName, fileContent);
            if(response != 'success') {
                    alert (response);
                    return;
            }
            
        }
        eval(cbCSVCreateFunction)

        //var myshell = new ActiveXObject( "WScript.shell" );
        
        var perlFilePath = reportPath + pathSeparator + "PerlFiles" + pathSeparator + perlFileName;
        var csvFilePath = reportPath + pathSeparator + "data" + pathSeparator + csvFileName;
        var destReportPath  = reportPath + pathSeparator + "Report" + pathSeparator + reportName;
        if(document.printApplet.isWindows()) {  
            var response = document.printApplet.invokeDosPrint('"' + reportPath + pathSeparator + batchFileName + '" "' + perlFilePath + '" "' + csvFilePath + '" "' + destReportPath + '" ' + (isPreview ? 1 : 0)+' '+LinesPerPage+' '+detailRowCount+' '+printCount+' "'+dosPrinter+'" ');
            
	} else {  
            var response = document.printApplet.invokeDosPrint( reportPath + pathSeparator + batchFileName + ' ' + perlFilePath + ' ' + csvFilePath + ' ' + destReportPath + ' ' + (isPreview ? 1 : 0)+' '+LinesPerPage+' '+detailRowCount+' '+printCount+' '+dosPrinter);
              
	}       

        if(response != 'success') {
            alert (response);
            return;
        }        
         
    }

    self.createPerlFile = function(perlFileName) {    alert("test");
        var response ="";
        var reportPath = document.printApplet.getReportPath();
        var pathSeparator = document.printApplet.getPathSeparator();
        var url = projPath + "/PrintServlet?command=getPerlFileContents&perlFileName=" + perlFileName;
        var fileContent = xmlGetResultString(url);
        var response = document.printApplet.createFile(reportPath + pathSeparator + "PerlFiles" + pathSeparator + perlFileName, fileContent);
        if(response != 'success') {
            return;
        }
        return response;
    }
}

var printReportManager = new PrintReportManager();