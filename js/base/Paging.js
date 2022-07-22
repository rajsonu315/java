
var Paging = function() {
    
    var self = this;
    var _orignalURL = null; // your target url
    var _targetName = null; // specify the target name where the page loads
    var _controlTargetName = null;  // specify the location where you want the paging (navigation) controllers  
    var _limit = 0; // specify the limit of rows to be displayed per page  
    var _fromLimit = 0;
    var _toLimit = _limit;
    var _objName = 'paging'; // the name of the object instanstated below
    var _foundRows = 0; // total no of rows found
    var _pageCount = 1;  // total page count
    var _currentPage = 1; // current page in view
    
    self.init = function(targetURL, targetName, pagingControlName, limitPerPage) {
        _orignalURL = targetURL;
        _targetName = targetName; 
        _controlTargetName = pagingControlName; 
        _limit = parseInt(limitPerPage); 
        if(_limit < 0) {
            _limit = 0;
        }
        _fromLimit = 0;
        _toLimit = _limit;
        _foundRows = 0;
        _pageCount = 1;
        _currentPage = 1;
        
        var url = _orignalURL + "&fromLimit=" + _fromLimit + "&toLimit=" + _toLimit;
        _loadPage(url);
        
    };
    
    function _buildControllerStr() {
        var str = "&nbsp;<input type=button class=arrow value=' |&#9668; ' onclick='" + _objName +".moveFirst()' " + (_currentPage == 1 ? 'disabled' : '') + " >" + 
        "&nbsp;<input type=button class=arrow value=' &#9668;  ' onclick='" + _objName +".movePrevious()' " + (_currentPage == 1 ? 'disabled' : '') + " >" +  " " + _currentPage + "/" + _pageCount +   
        "&nbsp;<input type=button class=arrow value='  &#9658; ' onclick='" + _objName +".moveNext()' " + (_currentPage == _pageCount ? 'disabled' : '') + " >" + 
        "&nbsp;<input type=button class=arrow value=' &#9658;| ' onclick='" + _objName +".moveLast()' " + (_currentPage == _pageCount ? 'disabled' : '') + " >";
        
        var controlTarget = document.getElementById(_controlTargetName);
        if(controlTarget != null){
            controlTarget.innerHTML = str;
        }
        
        _showRowCount();    
    }
    
    function _showRowCount() {
        
        var rowCntObj = document.getElementById('pagingRowCountLabel');
        
        if(rowCntObj != null) {
            var pageMinValue = (_limit * (_currentPage - 1)) + 1;
            var pageMaxValue = (_limit * _currentPage);
            
            if(pageMaxValue > _foundRows) pageMaxValue = _foundRows;
            
            rowCntObj.innerHTML = pageMinValue + " - " + pageMaxValue + " of " + _foundRows + ' records';
        }
    }
    
    self.moveFirst = function(){
        if(_currentPage == 1) {
            alert('You are at first page');
            return;
        }
        
        _fromLimit = 0;
        _toLimit = _limit;
        _currentPage = 1;
        var url = _orignalURL + "&fromLimit=" + _fromLimit + "&toLimit=" + _toLimit;
        _loadPage(url);
    };
    
    self.movePrevious = function(){
        if(_currentPage == 1) {
            alert('You are at first page');
            return;
        }
        
        _fromLimit = _fromLimit - _limit;
        _toLimit = _limit;
        if(_fromLimit < 0 ) {
            _fromLimit = 0;
        }    
        _currentPage = _currentPage - 1;
        
        var url = _orignalURL + "&fromLimit=" + _fromLimit + "&toLimit=" + _toLimit;
        _loadPage(url);
        
    };
    
    self.moveNext = function(){
        if(_currentPage == _pageCount) {
            alert('You are at last page');
            return;
        }
        
        _fromLimit = _fromLimit + _limit;
        _toLimit = _limit;
        _currentPage = _currentPage + 1;
        
        var url = _orignalURL + "&fromLimit=" + _fromLimit + "&toLimit=" + _toLimit;
        _loadPage(url);
    };
    
    self.moveLast = function(){
        if(_currentPage == _pageCount) {
            alert('You are at last page');
            return;
        }
         
        _fromLimit = (_limit * (_pageCount -1)) + 1 ;
        _toLimit = _limit;
        _currentPage = _pageCount;
        
        var url = _orignalURL + "&fromLimit=" + _fromLimit + "&toLimit=" + _toLimit;
        _loadPage(url);
    };
    
    function _loadPage(url){
        var target = document.getElementById(_targetName);
        if(target != null) {
            xmlLoadElementValues(url, target);
            
            if(_foundRows == 0) {
                var foundRows = document.getElementById('foundRows');
                if(foundRows != null) {
                    foundRows =  parseInt(document.getElementById('foundRows').value);
                }    
                _foundRows = foundRows;
                _pageCount = parseInt(_foundRows / _limit ) + ( (_foundRows % _limit == 0) || (_foundRows == _limit) ? 0 : 1);
            }
            
            if(_limit != 0) {
                _buildControllerStr();
            }
        }
    }
    
};    

var paging = new Paging();