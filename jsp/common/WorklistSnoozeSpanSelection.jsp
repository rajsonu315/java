<%-- 
    Document   : WorklistSnoozeSpanSelection
    Created on : Aug 29, 2011, 3:59:59 PM
    Author     : Biswajyoti
--%>

<%@page contentType="text/html; charset=iso-8859-1"%>
<%@page pageEncoding="UTF-8" import="java.sql.*" import="ubq.util.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<div id="snoozeSpanSmallDiv"  style="width:300px;height:40px;padding-left:10px;padding-right:10px;">

    <table border="0" cellpadding="3" cellspacing="0" style="padding-bottom:5px;" bgcolor="#E9EBEF"
           class="borderLine" width="100%" id="validFor" >
        
       <tr>
           <td width="40%" align="left" height="30px">
                <input type="radio" id="snoozeSelectionFor" name="snoozeSelection"
                       onclick="worklistSnooze.toggleUserRadioSelection();" checked>
                <label for="snoozeSelectionFor" ><b>Snooze for</b></label>
            </td>
            <td width="60%" style="padding-top:10px;padding-left:5px;" height="30px">
                <input type="text" onkeypress="editKeyBoard(event, this, keybNumber)" style="text-align: right;"
                       name="snoozePeriodTxt" id="snoozePeriodTxt" maxlength="2" size="3">
                <select name="snoozePeriod" id="snoozePeriod">
                    <option value="1">Month(s)</option>
                    <option value="2">Week(s)</option>
                    <option value="3" selected>Day(s)</option>
                    <option value="4">Hour(s)</option>
                </select>&nbsp;
            </td>
        </tr>

        <tr>
            <td width="40%" align="left" height="30px">
                <input type="radio" id="snoozeSelectionTill" name="snoozeSelection"
                       onclick="worklistSnooze.toggleUserRadioSelection();">
                <label for="snoozeSelectionTill" ><b>Snooze till</b></label>
            </td>
            <td width="60%" style="padding-top:10px;padding-left:5px;" height="30px">
                <input type="text" name="snoozeTillDate" id="snoozeTillDate" size="11" 
                       value=""  class="hidden" maxlength="10"
                       onkeypress="editKeyBoard(event, this, keybDate)" onblur="validateDate(this);" >

                <input type="button" name="snoozeTillDateBtn" id="snoozeTillDateBtn" value="..."
                       class="hidden"
                       onclick="newPopupCalender('snoozeTillDate','snoozeTillDateBtn', this);"
                       onfocus="newPopupCalender('snoozeTillDate','snoozeTillDateBtn', this);"
                       accesskey="r" >&nbsp;&nbsp;
            </td>
        </tr>

        <tr style="padding-bottom:10px;" height="30px">
            <td align="right" colspan="2" style="padding-top:10px;">
                <input type="button" id="btnDiscOk" value=" OK " class=""
                    onclick="worklistSnooze.setValueForSnooze(this, <%= boRID %>,'<%= taskArgs %>', '<%= worklistCode %>')" >
                <input type="reset" value="Cancel" onclick="worklistSnooze.closeSnoozeDIV()" >
            </td>
        </tr>
    </table>
</div>