var keybDecimal = new keybEdit('0123456789.');
var keybDecimalSigned = new keybEdit('-0123456789.');
var keybNumber = new keybEdit('0123456789');
var keybNegNumber = new keybEdit('0123456789-');
var keybPhoneNumber = new keybEdit('-+0123456789'); // added by @@Avishek '+' is added as the phone number character
var keybNegDecimal = new keybEdit('-0123456789.');
var keybNaturalNo = new keybEdit('123456789');
var keybDate = new keybEdit('0123456789/');
var keybDateChar = new keybEdit('0123456789/'); //Dunno where all its used.So adding a duplicate item Netto
// commented by @@Avishek for restricting the duplicates
//var keybNumber = new keybEdit('0123456789');
//var keybPhoneNumber = new keybEdit('-0123456789/');
var keybBatchNumber = new keybEdit('-0123456789abcdefghijklmnopqrstuvwxyz');
var keybCode = new keybEdit('-abcdefghijklmnopqrstuvwxyz');
var keybCodeNumber =  new keybEdit('0123456789abcdefghijklmnopqrstuvwxyz-');
var keybString =  new keybEdit(' 0123456789abcdefghijklmnopqrstuvwxyz+-\'\"(){}|/%,.:*<>?=_[]^&#@!');
var keybCurrency = new keybEdit('0123456789.,');
var keybTime = new keybEdit('0123456789:');
var keybName = new keybEdit(' abcdefghijklmnopqrstuvwxyz.');
var nonFolderNamingChars = new keybEdit('\\/*?"<>|:');
var keybSplChars =  new keybEdit(' 0123456789abcdefghijklmnopqrstuvwxyz-');
var keybCSVChars =  new keybEdit(' 0123456789abcdefghijklmnopqrstuvwxyz+-\'\"(){}|/%.:*<>?=_[]^&#@!;');


function keybEdit(strValid, strMsg)
{
    var reWork = new RegExp('[a-z]','gi');		//	Regular expression\
    //	Properties
    if(reWork.test(strValid))
        this.valid = strValid.toLowerCase() + strValid.toUpperCase();
    else
        this.valid = strValid;
    if((strMsg == null) || (typeof(strMsg) == 'undefined'))
        this.message = '';
    else
        this.message = strMsg;
    //	Methods
    this.getValid = keybEditGetValid;
    this.getMessage = keybEditGetMessage;
    function keybEditGetValid() {
        return this.valid.toString();
    }
    function keybEditGetMessage() {
        return this.message;
    }
}

// Added by saurabh
function checkKeyCode(ev, allowNumeric, allowAlphabets, allowDot){
    var keyCode = ev.keyCode;
    var retVal = 0;
    if(allowNumeric && allowAlphabets && allowDot){
        if((keyCode >=48 && keyCode <= 57) ||
            (keyCode >= 97 && keyCode <= 122) ||
            (keyCode >= 65 && keyCode <= 90) || keyCode == 46){
            return true;
        }else{
            return false;
        }
    }
    if(allowDot){
        if(keyCode == 46){
            retVal = 1;
        }else{
            retVal = 0;
        }
    }
    if(allowNumeric){
        if(keyCode >=48 && keyCode <= 57 || retVal == 1){
            retVal = 1;
        }else{
            retVal = 0;
        }
    }
    if(allowAlphabets){
        if((keyCode >= 97 && keyCode <= 122) ||
            (keyCode >= 65 && keyCode <= 90) || retVal == 1){
            retVal = 1;
        }else{
            retVal = 0;
        }
    }
    if(retVal == 1)
        return true;
    else
        return false;
}

function editKeyBoard(objForm, objKeyb,ev)
{
    strWork = objKeyb.getValid();
    strMsg = '';							// Error message
    blnValidChar = false;					// Valid character flag
    var BACKSPACE = 8;
    var DELETE = 46;
    var TAB = 9;
    var LEFT = 37 ;
    var UP = 38 ;
    var RIGHT = 39 ;
    var DOWN = 40 ;
    var END = 35 ;
    var HOME = 35 ;

    // Checking backspace and delete
    if(baGetKeyCode(ev) == BACKSPACE || baGetKeyCode(ev) == DELETE || baGetKeyCode(ev) == TAB
        || baGetKeyCode(ev) == LEFT || baGetKeyCode(ev) == UP || baGetKeyCode(ev) == RIGHT || baGetKeyCode(ev) == DOWN)  {

        blnValidChar = true;

    }
    if(!blnValidChar) // Part 1: Validate input
        for(i=0;i < strWork.length;i++){

            if(baGetASCIICode(ev) == strWork.charCodeAt(i) ) {
                blnValidChar = true;
                break;
            }
        }
    // Part 2: Build error message
    if(!blnValidChar)
    {
        //if(objKeyb.getMessage().toString().length != 0)
        //		alert('Error: ' + objKeyb.getMessage());
        ev.returnValue = false;		// Clear invalid character

        if(!baIsIEBrowser()) {
            //ev.cancel = true;
            ev.preventDefault();
        }
        objForm.focus();						// Set focus
    }
}

// modified by @@Avishek
function restrictInput(objForm, objKeyb,event)
{
    strWork = objKeyb.getValid();
    strMsg = '';							// Error message
    blnValidChar = false;					// Valid character flag

    if(!blnValidChar){ // Part 1: Validate input
        for(i=0;i < strWork.length;i++){
            if(baIsIEBrowser()){                
                if(window.event.keyCode == strWork.charCodeAt(i)) {
                    blnValidChar = true;
                    break;
                }
            }else {
                if(event.which == strWork.charCodeAt(i)) {
                    blnValidChar = true;
                    break;
                }
            }
        }
    }    
    // Part 2: Build error message
    if(!blnValidChar)    {
        //if(objKeyb.getMessage().toString().length != 0)
        //		alert('Error: ' + objKeyb.getMessage());
        if(baIsIEBrowser()) {
            window.event.returnValue = false;
        } else {
            window.event.preventDefault();
        }
	// Clear invalid character
        //ev.cancel = true;
        objForm.focus();						// Set focus
    }
}


// modified by @@Avishek
function restrictInput(objForm, objKeyb)
{

    strWork = objKeyb.getValid();
    strMsg = '';							// Error message
    blnValidChar = false;					// Valid character flag

    if(!blnValidChar) // Part 1: Validate input
        for(i=0;i < strWork.length;i++)
            if(window.event.keyCode == strWork.charCodeAt(i)) {
                blnValidChar = true;
                break;
            }
    // Part 2: Build error message
    if(!blnValidChar)
    {
        //if(objKeyb.getMessage().toString().length != 0)
        //		alert('Error: ' + objKeyb.getMessage());
        window.event.returnValue = false;		// Clear invalid character
        objForm.focus();						// Set focus
    }
}
