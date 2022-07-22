
var LPFEficiencyReport = function () {
   var self = this;

   self.setFilter = function(option){

        if(option == 1){
            document.getElementById('cumulative').checked = true
            self.hideDiv('cumulativeDiv',false);//unhide
           // self.hideDiv('reportLvlDiv',false);//unhide
            self.hideDiv('dateRangeDiv',true);
        } else if(option == 0) {
            document.getElementById('dateRange').checked = true
            self.hideDiv('dateRangeDiv',false);//unhide
            self.hideDiv('cumulativeDiv',true);
            //self.hideDiv('reportLvlDiv',true);

        }

    }

  self.hideDiv = function(name,hide){

        if(hide == true){
            document.getElementById(name).style.display = "none";
            document.getElementById(name).style.visibility = "hidden";
        }else{
            document.getElementById(name).style.display = "block";
            document.getElementById(name).style.visibility = "visible";
        }
    }
  
  self.formDate = function(fromDateID,toDateID){
        var cmbWeekObj = document.getElementById("selectWeek");
        var cmbMonthObj = document.getElementById("selectMonth");
        var cmbYearObj = document.getElementById("selectYear");
        var sday;
        var eday
        var toDate ;
        var fromDate;

        var year = parseInt(cmbYearObj.value);
        if(cmbMonthObj.value==0){

            alert("Please Select Month")
            cmbWeekObj.options[0].selected = true;
            cmbMonthObj.focus();
            return false;
        }

        if(cmbMonthObj.value!=0){
            var month =parseInt(cmbMonthObj.value);
            if(cmbWeekObj.value!=0){
                eday = parseInt(self.getDay(2,cmbWeekObj.value));
                sday = parseInt(self.getDay(1,cmbWeekObj.value));
                if(eday == 0){
                    eday=new Date(year, month, 0).getDate();
                }
            }else{
                sday = self.getDay(1,1);
                eday = self.getDay(2,4);
                if(eday == 0){
                    eday=new Date(year, month, 0).getDate();
                }
            }
            if(sday<10)
                sday="0"+sday;
            if(eday<10)
                eday="0"+eday;
            if(month<10)
                month="0"+month;
            toDate = eday +"/"+month +"/"+ year;
            fromDate = sday +"/"+month +"/"+ year;

        }else{

            toDate = "01"+"/"+"01"+"/"+year;
            fromDate = "31"+"/"+"12"+"/"+year;
        }

        document.getElementById(toDateID).value=toDate;
        document.getElementById(fromDateID).value=fromDate;
        return true;
    }

  self.getDay = function(option,selWeek){
        var tempWeek;
        var week1= new Array (01,07);
        var week2= new Array (08,14);
        var week3= new Array (15,21);
        var week4= new Array (22,0);
        if(selWeek ==1 ){
            tempWeek =week1;
        }else if(selWeek ==2){
            tempWeek =week2;
        }else if(selWeek ==3){
            tempWeek =week3;
        }else{
            tempWeek =week4;
        }
        if(option ==1)
            return tempWeek[0];
        else
            return tempWeek[1];
    }

  self.setDateSelection= function(elem){
        if(elem.value==1){
            document.getElementById("from_Date").readonly=false;
            document.getElementById("to_Date").readonly=false;
            document.getElementById("from_date_button").disabled = false
            document.getElementById("to_date_button").disabled=false;
            document.getElementById("selectedFromDate").value=document.getElementById("from_Date").value;
            document.getElementById("selectedToDate").value=document.getElementById("to_Date").value;
            document.getElementById("reportType").value="Daily Report";
            
            
        }else{
            document.getElementById("from_Date").readonly=true;
            document.getElementById("to_Date").readonly=true;
            document.getElementById("from_date_button").disabled = true;
            document.getElementById("to_date_button").disabled=true;
            document.getElementById("selectedToDate").value=document.getElementById("currentdate").value;
            if(elem.value==2){
                document.getElementById("selectedFromDate").value=document.getElementById("weekStartDate").value;
                document.getElementById("reportType").value="Weekly Report";
            }else{
                document.getElementById("selectedFromDate").value=document.getElementById("monthStartDate").value;
                document.getElementById("reportType").value="Month Report";
                
            }
            
        }
    }

   self.clearForm = function(){
        assetReportFilter.setFilter(0)
        document.getElementById("lpfEficiencyReportForm").reset();
    }


   self.openLPFEficiencyReport = function(option){
    
        var cumulativeDetailDate ="";
       
        if(document.getElementById('cumulative').checked == true){

            if(!self.formDate('selectedFromDate','selectedToDate')){
                return false;
            }
            var cmbWeekObj = document.getElementById("selectWeek");
            if(cmbWeekObj.value !=0){
                document.getElementById("reportType").value="Weekly Report";
                cumulativeDetailDate =  cmbWeekObj.options[cmbWeekObj.selectedIndex].text + " - ";
            }else{
                document.getElementById("reportType").value="Month Report";
            }
            var cmbMonth = document.getElementById("selectMonth");
            cumulativeDetailDate = cumulativeDetailDate +cmbMonth.options[cmbMonth.selectedIndex].text + " -";
            var cmbYearObj = document.getElementById("selectYear");
            cumulativeDetailDate =  cumulativeDetailDate +cmbYearObj.options[cmbYearObj.selectedIndex].text;


//                if(document.getElementById('summaryReport').checked == true){
//                    document.getElementById("reportLevel").value = 1;
//                }else{
//                    document.getElementById("reportLevel").value = 0;
//                }


        }else{
            document.getElementById("reportLevel").value = 0;
            toDate = document.getElementById('to_Date').value;
            frmDate = document.getElementById('from_Date').value;
            if(!isEmpty(frmDate) && !isDate(frmDate,"dd/MM/yyyy") ){

                alert("Please select a valid From Date!");
                document.getElementById('from_Date').focus();
                return;
            }
            if(!isEmpty(toDate) && !isDate(toDate,"dd/MM/yyyy") ){
                alert("Please select a valid To Date!");
                document.getElementById('to_Date').focus();
                return;
            }
            if(!isEmpty(toDate) && !isEmpty(frmDate) && uscmIsMoreDate(frmDate,toDate) ){

                alert("From Date cannot be greater than To Date!");
                document.getElementById('from_Date').focus();
                return;
            }
            document.getElementById("selectedFromDate").value=document.getElementById("from_Date").value;
            document.getElementById("selectedToDate").value=document.getElementById("to_Date").value;
            document.getElementById("reportType").value="Daily Report";
        }
        document.getElementById("cumulativeDetailDate").value = cumulativeDetailDate;
        if(0==option){
            document.getElementById('targetScreen').value ="screen";
            document.lpfEficiencyReportForm.target = "_blank";
            document.lpfEficiencyReportForm.command.value = "showLPFEfficiencyReport";
           
        }else if (1 == option) {
            document.getElementById('targetScreen').value ="Excel";
            document.lpfEficiencyReportForm.target = "_blank";
            document.lpfEficiencyReportForm.command.value = "showLPFEfficiencyReport";
            
        } else if (2 == option) {
            document.getElementById('targetScreen').value ="Excel";
            document.lpfEficiencyReportForm.target.value = "_blank";
            document.lpfEficiencyReportForm.command.value = "plantLevelLPF";
            
        }
        document.lpfEficiencyReportForm.submit();
    }

    
}
var lpfEficiencyReport = new LPFEficiencyReport();

