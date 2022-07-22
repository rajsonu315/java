var Notification = function() {
    var self = this;
    
    var NOTIFICATION = 1;
    var CAUTION = 2;
    var ALERT = 3;
    var ALARM = 4;
    var LIMIT = 3;
    
//    var notificationControl = new Roar({
//        position: 'lowerRight',
//        duration: 5000
//    });
//    
    self.showNotifications = function(limit) {
        
        limit = (limit == null ? LIMIT : limit);
        
        for(var i = notificationControl.items.length; i >= 0; i--) {
            notificationControl.remove(notificationControl.items[i], true);
        }
        
        var url = PROJECT_CTXT_PATH + "/NotificationServlet?command=showNotifications&limit=" + limit + "&date=" + new Date();
        var responseStr = xmlGetResultString(url);
        
        var notifications = responseStr.split("^");  //notificationRID~Name~type~Description^
        for(var i = 0; i < notifications.length; i++) {
            var notificationDetails = notifications[i].split("~");
            var notificationRID = notificationDetails[0];
            var notificationName = notificationDetails[1];
            var notificationType = notificationDetails[2];
            var notificationDescription = notificationDetails[3];
            var notificationParams = {title:notificationName, description:notificationDescription, delayTime:i, rid:notificationRID, type:notificationType};
            if(notificationType == NOTIFICATION) {
                self.notifiy(notificationParams);
            } else if(notificationType == CAUTION) {
                self.caution(notificationParams);
            } else if(notificationType == ALERT) {
                self.alert(notificationParams);
            } else if(notificationType == ALARM) {
                self.alarm(notificationParams);
            } 
        }
        
    };
    
    function getControlString(notificationParams, notificationControl) {
        var controlString = "<table width=100% cellpading=0 cellspacing=0 border=0 ><tr><td height=20px align=right >";
        controlString += "<span class=notificationControl onclick=\"notification.markAsSeen(this, event, " + notificationParams.rid + ")\" >Mark as seen</span>&nbsp;&nbsp;";
        controlString += "<span class=notificationControl onclick=\"notification.showLater(this, event, " + notificationParams.rid + ", " + notificationControl.items.length + ")\" >Show later</span>";
        controlString += "</td></tr></table>";
        return controlString;
    }
    
    self.notifiy = function(notificationParams) {
        notificationControl.options.className = "roar-notification";
        notificationControl.options.duration = 0;
        notificationControl.options.position = 'lowerRight';
        notificationParams.description += getControlString(notificationParams, notificationControl);
        self.showAlert(notificationParams);
    };
    
    self.caution = function(notificationParams) {
        notificationControl.options.className = "roar-caution";
        notificationControl.options.duration = 0;
        notificationControl.options.position = 'lowerRight';
        notificationParams.description += getControlString(notificationParams, notificationControl);
        self.showAlert(notificationParams);
    };
    
    self.alert = function(notificationParams) {
        notificationControl.options.className = "roar-alerts";
        notificationControl.options.duration = 0;
        notificationControl.options.position = 'lowerRight';
        notificationParams.description += getControlString(notificationParams, notificationControl);
        self.showAlert(notificationParams);
    };
    
    self.alarm = function(notificationParams) {
        notificationControl.options.className = "roar-alarm";
        notificationControl.options.duration = 0;
        notificationControl.options.position = 'lowerRight'; 
        notificationParams.description += getControlString(notificationParams, notificationControl);
        self.showAlert(notificationParams);
    };
    
    self.showAlert = function(notificationParams) {
        if(notificationControl) {
            var delayTime = (notificationParams.delayTime == null ? 0 : notificationParams.delayTime * 500);
            //setTimeout(function() {
            notificationControl.alert(notificationParams.title, notificationParams.description);
            //}, delayTime);
        } else {
            alert(notificationParams.description);
        }
    };
    
    self.showLater = function(elem, ev, notificationRID) {
        refreshNotifications('showLater', notificationRID);
    };
    
    self.markAsSeen = function(elem, ev, notificationRID) {
        refreshNotifications('markAsSeen', notificationRID);
    };
    
    function refreshNotifications(command, notificationRID) {
        
        var url = PROJECT_CTXT_PATH + "/NotificationServlet?command=" + command + "&notificationRID=" + notificationRID + "&afterXMin=5";
        var responseStr = xmlGetResultString(url);
        if(responseStr == 'done') {
            setTimeout(function() { self.showNotifications(3); }, 500);
        }
        
        baCancelEvent(ev);
    };
    
};

var notification = new Notification();
