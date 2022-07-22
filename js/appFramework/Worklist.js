/*
BOWorklist = function () {
    
  this.openWorklistTask = function (elem) {
        
        var row = dynTableGetRow(elem);
        
        var boCode = dynTableGetNodeInRow(row, "boCode");
        var boRID = dynTableGetNodeInRow(row, "boRID");
        
    var url = "BOServlet?command=doBOAction&boCode=" + boCode + "&boRID=" + boRID + "&actionCode=OPEN"
        desktop.showPopup("BO", url, {width:700});
    };

}

var boWorklist = new BOWorklist();
*/