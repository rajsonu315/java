function TableSearch() {

    var lastSelectedRow = null;

    var self = this;
    var WORKLIST_TABLE = null;

    self.searchRow = function(tbl, col, searchStr) {

        if(searchStr.trim() == "") {
            alert("Please enter what to search");
            return;
        }

        var rows = tbl.getElementsByTagName('TR');
     
        for(var i = 0; i < rows.length; i++) {
            var cells = rows[i].getElementsByTagName('TD');

            if(cells.length == 0)
                cells = rows[i].getElementsByTagName('TH');
            if(cells.length < col) {
                /* This row doesn't have the required number of columns. Skip. */
                continue;
            }

            if(cells[col] == null)
                continue;

            var cellStr = cells[col].innerHTML; // @@ Maybe we should look for Text Nodes inside the cell.
       
            // Remove leading and trailing whitespaces from the cell string
            cellStr = cellStr.replace(/^\s+|\s+$/g, '');
        
            try {
                cellStr = cellStr.replace("&nbsp;", '');
//                if(lastSelectedRow != null) {
//                    // Restore row class
//                    lastSelectedRow.className = lastSelectedRow.getAttribute("savedClassName");
//
//                }
                 if(rows[i].getAttribute("savedClassName") != null) {
                          rows[i].className = rows[i].getAttribute("savedClassName")
                 }

            } catch (e) {};
        var flag = false ;
            if(searchStr.trim().toUpperCase() == cellStr.substring(0, searchStr.length).toUpperCase()) {
                rows[i].setAttribute("savedClassName", rows[i].className);
                rows[i].className = "selectedRow cursorPoint"  ;
        
                // lastSelectedRow = rows[i];

               // rows[i].scrollIntoView(false);

            //return;
                flag = true ;
            }
        }
     if(flag = false)
        alert("There are no rows that match the specified search phrase");
    }
    
    self.init = function(tblWklId, isSorting){

        var tblWlk = document.getElementById(tblWklId);
        var tblFilter = document.getElementById("tblWorklistSearch");
        var wklSearchCombo = document.getElementById("wklSearchCombo");
        var rows = tblWlk.getElementsByTagName('TR');

        if(isSorting && isSorting == 'true')
            initSortingOnTable(tblWklId);

        WORKLIST_TABLE = tblWlk ;
        if(rows && rows.length > 0 ){
            if(rows[0].getElementsByTagName('TD') || rows[0].getElementsByTagName('TH'))
                var cells = rows[0].getElementsByTagName('TD');
            if(cells.length == 0)
                cells = rows[0].getElementsByTagName('TH');

            for (var i = 0 ; cells && i < cells.length ; i++ ){
                if(wklSearchCombo){

                    var header  = cells[i].innerHTML.trim().replace('&nbsp;', '');                    
                    var index = header.indexOf('<', 0);                  
                    if(index > 0){
                        header = header.substr(0, index);
                    }
                    var opt = document.createElement("option");                   
                    opt.value = i;
                    opt.text = header;
                    wklSearchCombo.options.add(opt);
                }
            }
        }
    }

    self.search = function(){
        var searchByCol = document.getElementById('wklSearchCombo').value;
        var searchStr = document.getElementById('wklSearchString').value;
        if(searchStr.trim() == "") {
            alert("Please enter what to search");
            return;
        }
          
        tableSearch.searchRow(WORKLIST_TABLE, searchByCol, searchStr);

    }



  
}

var tableSearch = new TableSearch();