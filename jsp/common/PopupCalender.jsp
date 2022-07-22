<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<% String project = request.getContextPath(); %>
<script language="javascript">
    
</script>
<head>
<title>Popup Calender</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href = "<%=project%>/style/UbqColors.css" rel="stylesheet" type="text/css">
<link href = "<%=project%>/style/UbqStyles.css" rel="stylesheet" type="text/css">
<link href = "<%=project%>/style/StockStyles.css" rel="stylesheet" type="text/css">
<link href="<%=project%>/js/calendar/calendar-uhealth.css" rel="stylesheet" type="text/css" media="all" title="blue" />
<style>
    .selectedRow 
            { 
                background-color:#0066CC;
                font-family:Arial, Helvetica, sans-serif;
                font-size: small;
                color: #FFFFFF;
            }
    .deSelectedRow { 
        background-color:#FFFFFF;
        font-family:Arial, Helvetica, sans-serif;
        font-size: small;
        color: #000000;
     }   

</style>
<SCRIPT LANGUAGE="JavaScript" SRC = "<%=project%>/js/base/DynamicTableTemplate.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC = "<%=project%>/js/base/ValidateFunction.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" SRC="<%=project%>/js/base/CalendarPopup.js"></SCRIPT>
<script type="text/javascript" src="<%=project%>/js/calendar/calendar.js"></script>
<script type="text/javascript" src="<%=project%>/js/calendar/lang/calendar-en.js"></script>
<script type="text/javascript" src="<%=project%>/js/calendar/calendar-setup.js"></script>
<script language="javascript">
   
function product_ok_click(date, month, year, dayOfweek) {

   month = Number(month) + 1;
   if (month < 10) 
        month = "0" + month; 
   if (date < 10) 
        date = "0" + date;
   var setDate = date + "/" + month + "/" + year;
   window.returnValue = setDate;
   window.close();
}

function product_cancel_click()
{
  window.close();
}

</script>
</head>
<body >

<form action="<%=project%>/GenericProductSearchServlet" method="post" name="product_search" id="product_search" target="_self" onsubmit="product_ok_click(); return false;">
 <div name="popupCalenderDiv" id="popupCalenderDiv">
        
    </div>
 <script type="text/javascript">

 function dateChanged(calendar) {

    if(calendar.dateClicked) {
         var y = calendar.date.getFullYear();
         var m = calendar.date.getMonth();
         var d = calendar.date.getDate();
         var dow = calendar.date.getDay();

       // setDate(d, m, y, dow);
       product_ok_click(d, m, y, dow);
       }
  }

  Calendar.setup(
        {
        flat       : "",
        weekNumbers : false,
        flatCallback : dateChanged
        }
   );

    </script>
   
</form>
</body>
</html>