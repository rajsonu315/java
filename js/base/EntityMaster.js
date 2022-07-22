/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
var EntityMaster = function()
{
    var self = this;

 self.selectComboItem = function(targetCombo, targetItem){
	for(var i =0; i < targetCombo.options.length; i++){
		if(targetCombo.options[i].text == targetItem){
			targetCombo.options[i].selected = true ;
                        targetCombo.options[i].value = targetItem;
			return ;
		}
	}
}


self.entityTypeOnchange = function(selectBox){
var i = selectBox.selectedIndex;
selectBox.options[i].value = selectBox.options[i].text;
}

self.loadEntityMaster = function(selectBox) {
   document.entityMasterForm.entityCode.value = "";
   document.entityMasterForm.entityType.text = "";

  var i = selectBox.selectedIndex;

  entityMasterForm.entity.value = selectBox.options[i].text;
  var valArray = selectBox.options[i].value.split("~");
  entityMasterForm.entityRID.value = selectBox.options[i].value;

  if(selectBox.options[i].value == 0){
  document.entityMasterForm.entity.value = "" ;
  document.entityMasterForm.entityType.value = 0;
  document.entityMasterForm.entityCode.value = "";
  }
  else{
  selectComboItem(document.entityMasterForm.entityType,valArray[1]);
  document.entityMasterForm.entityCode.value = valArray[2];
  entityMasterForm.entityRID.value = valArray[0];
  }
  var isActive = entityMasterForm.entityValid[i].value;

  entityMasterForm.isActive.checked = (isActive == 1) ? true : false;
}

self.clearForm = function(prompt) {

  var ans = true;

  if(prompt)
    ans = confirm("Do you really want to clear the form?");

  if(ans) {
    entityMasterForm.reset();
    entityMasterForm.entityRID.value = "0";
    entityMasterForm.entity.value = "";
  }
}

self.handleSuccess = function(msg) {
  self.clearForm(false);

  var url = PROJECT_CTXT_PATH + "/UMasterServlet";
//  xmlLoadElementValues(url + "?command=loadEntityMaster", document.getElementById('returnEntitySelection'));

  entityMasterForm.method = "get";
  entityMasterForm.command.value = "loadEntityMaster";
  entityMasterForm.action = url + "?command=loadEntityMaster";
  entityMasterForm.target = "_self";
  entityMasterForm.submit();

}

self.handleFailure = function(msg) {

  alert(msg);
}

self.formValidate = function() {

  if(isEmpty(entityMasterForm.entity.value)) {

    alert("Please enter factory ");

   entityMasterForm.entity.focus();
    return false;
  }
   if(isEmpty(entityMasterForm.entityCode.value)) {

    alert("Please enter factory Code");

   entityMasterForm.entityCode.focus();
    return false;
  }

   var i = document.entityMasterForm.entityType.selectedIndex;
   if(document.entityMasterForm.entityType.options[i].value == 0) {
    alert("Please select factory Type");
    entityMasterForm.entityType.focus();
    return false;
  }

  return true;

}


};
var entityMaster = new EntityMaster();