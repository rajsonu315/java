function baIsIEBrowser() {
    if(navigator.appName == 'Microsoft Internet Explorer')
        return true;
    else
        return false;
};

function baGetEventSource(event) {
    if(event) {			//Moz
        return event.target;
    }

    if(window.event) {	//IE
        return window.event.srcElement;
    }
}

function baGetKeyCode(event) {
    if(event) {	        //Mozilla
        return event.keyCode;
    }

    if(window.event) {	//IE
        return window.event.keyCode;
    }
}

function baGetASCIICode(event) {

    if(baIsIEBrowser()) {	//IE
        return window.event.keyCode;
    } else if(event) {	        //Mozilla
        return event.which;
    }

    return 0;
}

function baCancelEvent(event) {

    if(event) {	        //Mozilla
        event.cancelBubble = true;
    }

    if(window.event) {	//IE
        window.event.cancelBubble = true;
        // The following should not be necessary but the above doesn't work.
        /* This statment blocks backspace event outside the components.
           And allows backspace functionality inside the components such as text box. - Girish */
        if(window.event != null) {
            window.event.keyCode = null;
        }
    //window.event.returnValue = false; // commented because in IE backspace is not working
    }

}

function baAddOption(combo, opt) {
    try {
        combo.add(opt, null);  // Standard compliant but does not work in IE
    } catch (e) {
        combo.add(opt); // IE Only
    }
}

function baGetMouseX(event) {
    if(event) {	        //Mozilla
        return event.clientX;
    }

    if(window.event) {	//IE
        return window.event.x;
    }
}

function baGetMouseY(event) {
    if(event) {	        //Mozilla
        return event.clientY;
    }

    if(window.event) {	//IE
        return window.event.y;
    }
}

function baGetTblFirstRow(tbl) {
    if(baIsIEBrowser()) {
        return tbl.firstChild.firstChild; //  for IE
    } else {
        return tbl.firstChild.nextSibling.firstChild; // for Firefox
    }
};

// overriding of getElementById
// If id is not specified but name is specified for the element,
// in that case in IE we can get that element by getElementById()
// but in other bowsers(Firefox) we need to specify id.
// So to override that and work as it was working in IE below is some modified native code


document.nativeGetElementById = document.getElementById;
document.getElementById = function(id){

    var elem = document.nativeGetElementById(id);
    var elemByName = document.getElementsByName(id);
    if(elem) {
        if(baIsIEBrowser()) {
            return elem;
        }

        if(elem.attributes['id'].value == id) {
            return elem;
        } /* else {

            alert('ALL Elements Call: For testing ');
            for(var i=1;i<document.all[id].length;i++) {
                if(document.all[id][i].attributes['id'].value == id) {
                    return document.all[id][i];
                }
            }
        } */
    } else if(elemByName != null && elemByName.length > 0) {
        // prompt("'" + elemByName[0].attributes['name'].value + "' element has no ID, but accessed by ID. Define a ID to this element.",  elemByName[0].attributes['name'].value  );
        return elemByName[0];
    }
    return null;
};


function baGetPreviousSibling(node){
    var tempNode = node.previousSibling;
    if(tempNode != null) {
        while(tempNode.nodeType!=1){
            tempNode = tempNode.previousSibling;
            if(tempNode == null)
                return null;
        }
    }
    return tempNode;
};

function baGetNextSibling(node){
    var tempNode = node.nextSibling;
    if(tempNode != null) {
        while(tempNode.nodeType!=1){
            tempNode = tempNode.nextSibling;
            if(tempNode == null)
                return null;
        }
    }
    return tempNode;
};


function baMergeAttributes(srcElement, destElement) {
    if(destElement.mergeAttributes)   {  //IE

        destElement.mergeAttributes(srcElement);
        destElement.name = srcElement.name;
        destElement.id = srcElement.id;

    } else { //merge Attributes is not supported
        for(var i = 0; srcElement.attributes != null && i < srcElement.attributes.length; i++) {

            var attrName = srcElement.attributes[i].name;
            var attrValue = srcElement.attributes[i].value;

            if(destElement.attributes && destElement.attributes[attrName]) { // If attribute is already defined;
                destElement.attributes[attrName].value = attrValue;
            } else if(destElement.setAttribute){ //add as a new attribute to the object
                destElement.setAttribute(attrName, attrValue);
            }
        }
    }

}

function baMouseRightClicked(event) {
    if(baIsIEBrowser() && event.button == 2) {
        return true;
    } else if (event.which == 3) {
        return true;
    }
    return false;
}


// Added by Saurabh....16.09.2011
function baEnableDisableLink (elem, disable){
    if(disable){
        var href = elem.getAttribute("href");
        if(href && href != "" && href != null){
            elem.setAttribute('href_bak', href);
        }        
        elem.removeAttribute('href');
        elem.style.color="gray";
        elem.onmouseover = elem.style.textDecoration = 'none';
        elem.onmouseout = elem.style.textDecoration = 'none';        
    } else{
        elem.setAttribute('href', elem.attributes['href_bak'].nodeValue);
        elem.style.color="blue";
        elem.removeAttribute('href_bak');
    }

}


function baToggleEnableDisable(el,disable) {
    try {
        el.disabled = disable;
    }
    catch(E){
    }
    if (el.childNodes && el.childNodes.length > 0) {
        for (var x = 0; x < el.childNodes.length; x++) {            
            baToggleEnableDisable(el.childNodes[x],disable);
        }
    }
}