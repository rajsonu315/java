<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.util.*"
  import="java.text.*" import="ubq.salesForceAutomation.common.FeatureUtil" import="ubq.util.*" errorPage="" %>

  <div>
   <p align="right">   
       <input type="text" id="searchDesc" name="searchDesc"  size="13" value="Search Staff" style="border:0;" class="label">
       <input type="text" accesskey="F" id="searchTxt" name="searchTxt" autocomplete="off" onkeydown="masterSearch.keyAscii(event.keyCode)" tabindex="0">
       
<!--        <input type="button" name="searchBtn" id="searchBtn" value="Search" onclick="masterSearch.searchMasters();">-->
        <input type="hidden" id = "searchingForStr" name ="searchingForStr" value="staff">
   </p>
  </div>