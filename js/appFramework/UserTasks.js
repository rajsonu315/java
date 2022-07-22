var UserTasks = function() {
    var self = this;
    
    self.saveTasks = function() {
        
        //var taskNameFld = document.getElementById("taskNameFld").value;
        var taskDateFld =  document.getElementById("taskDateFld").value;
        var taskDescArea = document.getElementById("taskDescArea").value;
        var taskTimeFld = document.getElementById("taskTimeFld").value;
        var notifyMe = document.getElementById("notifyMe");
        var taskReminderDate = document.getElementById("dateFld").value;
        
        var taskReminderTime = document.getElementById("remindtimeFld").value;
        
        // var remindtimeFld = document.getElementById("remindtimeFld");
        // alert(remindtimeFld.value)
        
        if(!uscmIsValidDate(document.getElementById('taskDateFld').value) || uscmIsEmpty(document.getElementById('taskDateFld').value)) {
            alert("Enter a valid date");
        }
        if( !isValidTime(document.getElementById('taskTimeFld'))|| uscmIsEmpty(document.getElementById('taskTimeFld'))) {
            //alert("Enter a valid time");
        }
        
        if(document.getElementById("notifyMe").checked == true){
            notifyMe.value = 1;
        }
        document.userTasksForm.command.value = 'saveUserTasks';
        var userTaskDv = document.getElementById("userTaskDiv");
        
        var responseStr = xmlPostForm(document.userTasksForm, "UserTasksServlet", null);
        if(responseStr == "done") {
            alert("Saved Successfully");
            boWorklist.refreshWorklist();
            desktop.loadPage("UserTasksServlet?command=createUserTask", "New Task", "NEW_TASK");
            
        } else {
            alert(responseStr)
        }
    }
    
    self.cancel = function(elem) {
        desktop.loadPage("UserTasksServlet?command=createUserTask", "New Task", "NEW_TASK");
    };
    
    self.cancelInset = function(elem) {
        // desktop.closeInset(document.getElementById('viewUserTaskDiv'));
        boWorklist.refreshWorklist(); 
    };
    
    self.taskDone = function(taskRID) {
        var url = PROJECT_CTXT_PATH + "/UserTasksServlet?command=doneWithTask&taskRID=" + taskRID;
        var responseStr = xmlGetResultString(url);
        if(responseStr == 'done'){
            boWorklist.refreshWorklist();
        } else {
            alert("The user has to complete the task");
        }
    };
};
var userTasks = new UserTasks();