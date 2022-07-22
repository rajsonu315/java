

    function initiateDirectPrint(isDirectPrint, isPrintOnly, printerName, browserName) {
       if ((isDirectPrint == 1 || isDirectPrint == '1') && (isPrintOnly != 0 && isPrintOnly != '0')) {
        //setTimeout(printReportDirectly, 500);
        if (browserName == 'Netscape') {
            printReportDirectly(printerName);
        } else {
            //printIEReportDirectly(printerName);
        }
    }
}

function printReportDirectly(printerName) {
    try {
        jsPrintSetup.setSilentPrint(false);
        var defaultPrinter = jsPrintSetup.getPrinter();

        if(printerName == null || printerName == 'null' || printerName == '') {
               return;
        } else {
            jsPrintSetup.setPrinter(printerName);
        }
        
        jsPrintSetup.setOption('orientation', jsPrintSetup.kPortraitOrientation);
        
        // set page header
        jsPrintSetup.setOption('headerStrLeft', '');
        jsPrintSetup.setOption('headerStrCenter', '');
        jsPrintSetup.setOption('headerStrRight', '&PT');
        
        // margin
        jsPrintSetup.setOption('marginTop', '0');
        jsPrintSetup.setOption('marginBottom', '0');
        jsPrintSetup.setOption('marginLeft', '0');
        jsPrintSetup.setOption('marginRight', '0');
        
        // set empty page footer
        jsPrintSetup.setOption('footerStrLeft', '');
        jsPrintSetup.setOption('footerStrCenter', '');
        jsPrintSetup.setOption('footerStrRight', '');
        
        // Suppress print dialog
        jsPrintSetup.setSilentPrint(true);
        
        // Do Print
        jsPrintSetup.print();
        
        // Restore print dialog
        
        setTimeout(restoreSilentPrint, 1000);
        
        
    } catch(ex) {
        alert('An add-on seems to be missing in your browser. Please download and install this add-on https://addons.mozilla.org/en-US/firefox/addon/js-print-setup/');
    //window.print();
    }
    
}

function restoreSilentPrint() {
    
    jsPrintSetup.setSilentPrint(false);
    window.close();
}

