var SKUList = function() {
            var self = this;

            self.initializePage = function (){                  
                  window.dialogWidth="540px";
                  window.dialogHeight="520px";
                  window.dialogLeft=250;
                  window.dialogTop=100;
            }

            self.checkKeyStroke = function () {
                 var keycode = window.event.keyCode;
                 if (keycode == 13) 
                 self.okClick() ;
            }

            self.cancelClick = function() {
               window.close();            
            }

            self.okClick = function(){                
                var selectedValue ;
                var selectedIndex = document.searchSKUListform.results_list.selectedIndex;

                if(selectedIndex >= 0) {
                    selectedValue = (document.searchSKUListform.results_list.options[selectedIndex].value);
                } else {
                    alert("Select any item or click on the Cancel button");
                    return;
                }
                //var result_array = selectedValue.split("~") ;
                var assoc_array = new Array() ;
                assoc_array["ddIndex"] = selectedValue
                window.returnValue = assoc_array;
                window.close() ;
            }
};

var skuList = new SKUList();