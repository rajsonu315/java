<%@page import="java.sql.*, ubq.base.URequestContext" %>

<div class="whiteBG">
    <form name="worklistSequenceFrm" >
	<input type="hidden" name="command" value="saveWorklistSequence">
	<%
		    URequestContext ctxt = (URequestContext) request.getAttribute("ctxt");
		    ResultSet rsWLDefinations = (ResultSet) ctxt.getAttribute("rsWLDefinations");
	%>
	<table cellpadding="0" cellspacing="0" width="100%" >
	    <tr align="left" >
		<th style="padding-left: 10px" height="25px" >
		    Name
		</th>
		<th  class="hidden" >
		   Type
		</th>
		<th>
		    Sequence
		</th>
	    </tr>
	    <% if (rsWLDefinations != null) {
			    rsWLDefinations.beforeFirst();
			    while (rsWLDefinations.next()) {
	    %>
	    <tr>
		<td style="padding-left: 10px" height="25px" >
		    <%= rsWLDefinations.getString("w_name")%>
		    <input type="hidden" name="wRID" value="<%= rsWLDefinations.getInt("w_rid")%>" >
		    <input type="hidden" name="wName" value="<%= rsWLDefinations.getString("w_name")%>" >
		</td>
		<td class="hidden" >
		    <%= rsWLDefinations.getString("w_type")%>
		    <input type="hidden" name="wType" value="<%= rsWLDefinations.getString("w_type")%>" >
		</td>
		<td>
		    <input type="text" size="4" maxlength="5" name="sequenceNo" onkeypress="editKeyBoard(event, this,keybNumber)"
			   class="rightAlignedTextbox" value="<%= rsWLDefinations.getString("w_seq_no")%>" >
		</td>
	    </tr>
	    <%			}
			}%>

	    <tr><td colspan="100%" height="5px" ></td></tr>
	    <tr><td colspan="100%" height="1px" bgcolor="gray" ></td></tr>
	    <tr>
		<td colspan="100%" align="right" height="30px" >
		    <input type="button" value="Save" onclick="boWorklist.saveWorklistSequence()">
		    <input type="button" value="Close" onclick="desktop.closePopup();">&nbsp;&nbsp;&nbsp;&nbsp;
		</td>
	    </tr>

	</table>
    </form> 
</div>