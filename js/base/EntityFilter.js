/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

var EntityFilter = function(){
        var self= this;

        self.setRegion= function(elem){
            document.getElementById("regionRID").value =elem.value;
        
            xmlLoadElementValues(prjName + '/EntityManagementServlet?command=getChildEntityDetail&regionRID=' +
            elem.value,document.getElementById('CPCombo')) ;
    
        }

        self.setCP= function(elem){
            document.getElementById("cpRID").value =elem.value;
        }
      
}
var entityFilter = new EntityFilter();