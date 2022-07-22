function AssetUtilizationUpload(){

   var self = this;
   self.validateAndUpload = function(){
        
        var upload = document.getElementById("upload");
        upload.disabled = true;

      if ((document.getElementById("filePath1").value != "" ) || (document.getElementById("filePath2").value != "" ) ) {
           var timeLossFile = document.getElementById("filePath1").value;
           if(timeLossFile == "") {
                 alert("Please select a file for time loss");
                 document.getElementById("filePath1").focus();
                 upload.disabled = false;
                 return false;
            }

           if(document.getElementById('filePath1').value.search(/\.(xls)$/) == -1) {
                 alert("Invalid filename extension for time loss");
                 document.getElementById("filePath1").value = "";
                 upload.disabled = false;
                 return false;
          }
        
          var lpfFile = document.getElementById("filePath2").value;
          if(lpfFile == "") {
                alert("Please select a file for LPF");
                document.getElementById("filePath2").focus();
                upload.disabled = false;
                return false;
          }

          if(document.getElementById('filePath2').value.search(/\.(xls)$/) == -1) {
               alert("Invalid filename extension for LFP");
               document.getElementById("filePath2").value = "";
               upload.disabled = false;
               return false;
         }
       }
       
        if(document.getElementById('filePath3').value != "") {
          if(document.getElementById('filePath3').value.search(/\.(xls)$/) == -1) {
              alert("Invalid filename extension for Plant Level LFP");
              document.getElementById("filePath3").value = "";
              upload.disabled = false;
             return false;
         }
        }
       
        document.utilizationUploadForm.action = PROJ_CTXT_PATH + "/AssetUtilizationUploadServlet?command=uploadUtilization";
        document.utilizationUploadForm.submit();

        return true;
   }

   self.handleSuccess = function(msg){
       var upload = document.getElementById("upload");
       alert(msg);
       document.getElementById("canOverwrite").value = 0;
       document.getElementById("filePath1").value = "";
       document.getElementById("filePath2").value = "";
       document.getElementById("filePath3").value = "";
       upload.disabled = false;
   }
   self.handleFailure = function(msg){
       
        var errorMsg = "";
        var msgArr = msg.split("~");

        if(msgArr.length > 0){
            errorMsg = msgArr[0];
        }
        
        if(msgArr.length > 1 && msgArr[1].trim() == "1"){
            var ans = confirm(errorMsg + ". \nDo you want to continue?");
            if(true == ans){
                document.getElementById("canOverwrite").value = 1;
                self.validateAndUpload();
                return;
            }
        } else {
            alert(errorMsg);
            document.getElementById("canOverwrite").value = 0;
        }
        
        var upload = document.getElementById("upload");
        upload.disabled = false;
   }

   self.downloadLineMaster = function(){
       document.utilizationUploadForm.action = PROJECT_CTXT_PATH + "/AssetUtilizationServlet?command=downloadLineMaster";
       document.utilizationUploadForm.method = "POST";
       document.utilizationUploadForm.submit();
       
   }

   self.downloadVariantMaster = function(){
       document.utilizationUploadForm.action = PROJECT_CTXT_PATH + "/AssetUtilizationServlet?command=downloadVariantMaster";
       document.utilizationUploadForm.method = "POST";
       document.utilizationUploadForm.submit();

   }

   self.downloadFuelMaster = function () {
     document.utilizationUploadForm.action = PROJECT_CTXT_PATH + "/AssetUtilizationServlet?command=downloadFuelMaster";
     document.utilizationUploadForm.method = "POST";
     document.utilizationUploadForm.submit();
   }
}
var assetUtilizationUpload = new AssetUtilizationUpload();