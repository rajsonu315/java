<%@page contentType="text/html" language="java" import="java.sql.*" import="java.util.*" 
 import="ubq.salesForceAutomation.sales.PromotionManager" import="java.text.*" import="java.lang.*" errorPage=""%>
<%@page pageEncoding="UTF-8"%>

<% 
             
         if ("LoadMultiSelectList".equals(request.getParameter("command")))
            {
                String tabName = request.getParameter("currentTableName");
                String parentHiddenFieldName = request.getParameter("parentHiddenIdFieldName");
                String parentColName = (String) request.getAttribute("parentColName");
                String trIdName = request.getParameter("trIdName");
                String onClickFunction = request.getParameter("onClickFunction");
                String tableCheckBoxName = request.getParameter("tableCheckBoxName");
        %>
        <table name="<%= tabName %>" id="<%= tabName %>" width="100%" border="0" cellpadding="0" cellspacing="0">
            <%
                ResultSet rs = (ResultSet)request.getAttribute("rsList");
                if (rs!=null){
                    int rowid=0;
                    while (rs.next()) {
                        rowid++;
                        String trId = rowid + trIdName;
                        String parentColId = rowid + parentHiddenFieldName;
                        String rid =  rs.getString("id");
                        String name = rs.getString("name");
                        String parentId = null ;
                        if (parentColName != null)
                            parentId = rs.getString(parentColName);
            %>
            <tr id="<%= trId %>">
                <td ><input name="<%= tableCheckBoxName %>" type="checkbox" value="<%= rid %>" <% if (onClickFunction != null){ %> onclick="<%= onClickFunction %>" <%}%>>
                    <%= name %>  
                    <% if (parentId != null && parentHiddenFieldName != null ) {%>
                    <input name="<%= parentHiddenFieldName %>" type="hidden" value="<%= parentId %>">
                    <%}%>
                </td>
            </tr>
            <% }
                        rs.close(); }%>
            
        </table>
        <%}%>
        <% if ("LoadBeat".equals(request.getParameter("operationType")))
            {
        %>
        <table name="beatTab" id="beatTab" width="100%" border="0" cellpadding="0" cellspacing="0">
            <%
                String checkbeatColId ="";
                String salesmanbeatColId ="";
                String beatRowId="";
                ResultSet rsBeat = (ResultSet)request.getAttribute("beatRS");
                if (rsBeat!=null){
                    int rowid=0;

                    while (rsBeat.next()) {
                        rowid++;
                        beatRowId=rowid+"beatRowId";
                        checkbeatColId= rowid+ "checkbeatColId";
                        salesmanbeatColId=rowid+"salesmanbeatColId";
                        String rid =  rsBeat.getString("id");
                        String beatName = rsBeat.getString("name");
                        String salemanBeatId= rsBeat.getString("bt_salesman_rid");
            %>
            <tr id="<%= beatRowId %>">
                <td id= "<%= rowid %> + colId" ><input name="chkbeat" type="checkbox" id="<%= checkbeatColId %>" value="<%= rid %>">
                    <%= beatName %>  
                    <input name="salesmanid" type="hidden" id="<%= salesmanbeatColId %>" value="<%= salemanBeatId %>">
                </td>
            </tr>
            <% }
                rsBeat.close(); }%>
            
        </table>
        <%}%>
        <% if ("view".equals(request.getParameter("operationType")))
            {
        %>
        <table name="invoiceTab" id="invoiceTab" width="100%" border="0" cellpadding="0" cellspacing="1" >
            <%
                SimpleDateFormat fmt = new  SimpleDateFormat("dd/MM/yyyy");
                ResultSet rsInvoice = (ResultSet)request.getAttribute("invoiceRS");
                if (rsInvoice!=null){
                    int rowid=0;

                    while (rsInvoice.next()) {
                        rowid++;
                        String rid =  rsInvoice.getString("sih_rid");
                        String invoiceNo = rsInvoice.getString("sih_inv_number");
                        String shop = rsInvoice.getString("cust_name");
                        String customerId = rsInvoice.getString("cust_rid");
                        java.sql.Date invddate = rsInvoice.getDate("sih_inv_date");
                        String invoiceDate = fmt.format(invddate);
                        float invoiceAmount = rsInvoice.getFloat("sih_net_amt");
                        float paidAmount = rsInvoice.getFloat("sih_paid_amt");
                        //float balanceAmount=invoiceAmount - paidAmount;
                        float balanceAmount  = rsInvoice.getFloat("due_amount");
            %>  
            <tr valign="top">
                <input type="hidden" name="invrid" id="invrid" value=<%= rid %>>
                <input type="hidden" name="customerId" id="customerId" value=<%= customerId %>>
                <input type="hidden" name="invoiceDate" value="<%= invoiceDate %>" id="<%= rowid + "invoiceDate" %>">
                <td width="9%" align="left" class="label" id="<%= rowid + "invoiceNo" %>">
                <input type="checkbox" name="invCheckBox" id="invCheckBox" value="<%= balanceAmount %>" checked onclick="actonGridRow(this);">
                <%= invoiceNo %></td>
                <td width="16%" align="left" class="label"><%= shop %></td>
                <td width="8%" align="right" class="label"><%= invoiceAmount %></td>
                <td width="9%" align="right" id="<%= rowid + "balanceAmount" %>" class="label"><%= balanceAmount %> </td>
                <td width="11%" align="center" class="label"><input type="text" size="8" maxlength="8" style="text-align:right" name="currentPayment" id="<%= rowid + "currentPayment" %>"   value="<%= balanceAmount %>" onchange="return validateCurrentPayment(this.id);">
                    <input type="hidden" name="tempcurrentPayment" id="<%= rowid + "tempcurrentPayment" %>" value="<%= balanceAmount %>">
                </td>
                <td width="12%" align="center" class="label"><input type="text" size="8" maxlength="10" name="receiptNo" id="<%= rowid + "receiptNo"%>" value="" onchange="setModifiedBit();"></td>
                <td id=rowid+"colChequeNo" width="11%" align="center" class="label"><input size="7" maxlength="10" type="text" name="chequeNo" id="<%= rowid + "chequeNo" %>" value="" onchange="setModifiedBit();"></td>
                <td id=rowid+"colChequeDate" width="8%"  align="center" class="label"><input size="8" maxlength="10" type="text" name="chequeDate" id="<%= rowid + "chequeDate" %>" value="" onchange="return validateChequeDate(this.id);"></td>
                <td id=rowid+"colBank" width="8%" align="center" class="label"><input type="text" size="8" maxlength="30" name="bank" id="<%= rowid + "bank" %>" value="" onchange="setModifiedBit();"></td>
                <td id=rowid+"colOutStation" width="7%"  align="center" class="label"><input type="checkbox" name="<%= rowid + "IsOutstation"%>" id="<%= rowid + "IsOutstation"%>" value="<%= rowid %>" onchange="setModifiedBit();"> </td>
            </tr>
                            <% }
            rsInvoice.close(); }%>        
        </table>
        <%}%>
          
                         <% if ("LoadChequeDetail".equals(request.getParameter("command")))  
{
        %>
        <table id="chequeTab" name="chequeTab" width="100%" border="0" cellpadding="0" cellspacing="0">	  	
            <!-- Processing the ResultSet and displaying the results in browser -->
            
            <% 
                SimpleDateFormat fmt = new  SimpleDateFormat("dd/MM/yyyy");
                ResultSet rs = (ResultSet)request.getAttribute("unRealizedchq");
                int rowid =0    ;
                if (rs!=null){
                    while (rs.next()) {
                        rowid ++;
                        String chequeDateColId= rowid + "chequeDateCol";
                        String invoicenoColId = rowid + "invoicenoColId";
                        java.sql.Date chq_ddate = rs.getDate("chq_date");
                        String chq_date ="";
                        String prev_realizedate ="";
                        String chq_rdate="";
                        if (chq_ddate !=null)
                            chq_date = fmt.format(chq_ddate);
                        String chq_rid = rs.getString("chq_rid");
                        String chq_Status = rs.getString("chq_status");
                        String invoice_no = rs.getString("invoice_no");
                        if (invoice_no==null)
                            invoice_no="";
                        String chq_no = rs.getString("chq_no");
                        String chq_amount = rs.getString("chq_amount");
                        if (chq_amount == null)
                            chq_amount ="";
                        String chq_bank_name = rs.getString("chq_bank_name");
                        java.sql.Date chq_realdate = rs.getDate("chq_realize_date");
                        if  (chq_realdate!=null)
                            chq_rdate=fmt.format(chq_realdate);
                        prev_realizedate =chq_rdate;
            %>
            <tr>
                <input type="hidden" name="chq_rid" id="chq_rid" value="<%= chq_rid %>" />
                <input type="hidden" name="prev_realizedate" id="prev_realizedate" value="<%= prev_realizedate %>"/>
                <td width="15%" class="label" ><%= chq_no %></td>
                <td width="10%" class="label"><%= chq_bank_name %></td>
                <td width="19%" align="left">
                    <%if ("1".equals(chq_Status)){
                    %>
                    <input name= "chequeDate" type="text" id="<%= chequeDateColId %>" size="10" maxlength="10" onchange ="return validateDate(this, document.chequerealization.sysDate.value);" value="";  >
                    <input name="ChequeDate_button" type="button" id="ChequeDate_button" value=" ... "  onclick="cal.select(document.getElementById('<%= chequeDateColId %>'),'ChequeDate_button','dd/MM/yyyy'); return false;"  > 
                  
                    <%}%>
                    <%if ("2".equals(chq_Status)){
                    %>
                    <input name= "chequeDate" type="text" id="<%= chequeDateColId %>" size="10" maxlength="10" onchange ="return validateDate(this, document.chequerealization.sysDate.value);" value="<%= chq_rdate%>";  >
                    <input name="ChequeDate_button" type="button" id="ChequeDate_button" value=" ... "  onclick="cal.select(document.getElementById('<%= chequeDateColId %>'),'ChequeDate_button','dd/MM/yyyy'); return false;"  >  
                    <%}%>
                </td>
                <td width="13%" class="label" align="left">
                <input type="text" size="8" tabindex="-1" value="<%= chq_amount %>" style="text-align:right" class="readOnlyTableElement" readonly ></td>
                <td width="18%" class="label"><input type="text" id="<%= invoicenoColId %>" name="invoiceNo" size=10 value="<%= invoice_no %>" readonly tabindex="-1" class="readOnlyTableElement"></td>
                <td width="25%" class="label"><%= chq_date %></td>
            </tr>
            
                                     <% }
rs.close(); }%>
        </table>
        <%}%> 
                    <% if ("LoadDraftDetail".equals(request.getParameter("command")))  
        {
        %>
    
        <table id="draftTab" name="draftTab" width="100%" border="0" cellpadding="0" cellspacing="0">
           <%   SimpleDateFormat fmt = new  SimpleDateFormat ("dd/MM/yyyy");
                DecimalFormat df2 = new DecimalFormat( "############0.00" );

                ResultSet rs1 = (ResultSet)request.getAttribute("draftdetail");
                if (rs1!=null){
                while (rs1.next()) {
                String invoice_date ="";
                String draft_no = rs1.getString("draft_no");
                String bank = rs1.getString("bank");
                String draft_amt = df2.format(rs1.getDouble("draft_amt"));
                String balance_amt = df2.format(rs1.getDouble("balance_amt"));
                String invoice_no = rs1.getString("invoice_no"); 
                if (invoice_no == null)
                invoice_no ="";
                java.sql.Date invoice_ddate = rs1.getDate("invoice_date");
                if (invoice_ddate!=null)
                invoice_date=fmt.format(invoice_ddate);

                String amt_adjusted = df2.format(rs1.getDouble("amt_adjusted"));
                if (amt_adjusted == null)
                amt_adjusted = "0";
        
            %>
            <tr class="label">
                <td width="12%">&nbsp;<%= draft_no %></td>
                <td width="13%"><%= bank %></td>
                <td width="13%" > 
                    <input type="text" size="8" tabindex="-1" value="<%= draft_amt %>" style="text-align:right" class="readOnlyTableElement" readonly >
                </td>
                <td width="17%" align="center">
                <input type="text" size="8" tabindex="-1" value="<%= balance_amt %>" style="text-align:right" class="readOnlyTableElement" readonly >
                </td>
                <td width="16%"><%= invoice_no %></td>
                <td width="12%"><%= invoice_date %></td>
                <td width="17%" align="center">
                <input type="text" size="8" tabindex="-1" value="<%= amt_adjusted %>" style="text-align:right" class="readOnlyTableElement" readonly >
                </td>
            </tr>
            <% }
                rs1.close(); }%>
            </table> 
        <%}%>
 
                         <% if ("LoadCustomerInvoice".equals(request.getParameter("command")))  
{
        %>
        <table id="invoiceTab" name="invoiceTab" width="100%" border="0" cellpadding="0" cellspacing="0">
            <!-- table population code starts here-->	
                            <%
                SimpleDateFormat fmt = new SimpleDateFormat("dd/MM/yyyy");                 
                ResultSet rsInvoice = (ResultSet)request.getAttribute("invoiceRS");
                DecimalFormat decFmt = new DecimalFormat("#####.##");
                String ckhSelected = "Modify".equals(request.getParameter("mode"))?"checked":"";
                String ckhDisabled = "true".equals(request.getParameter("status"))?"disabled":"";

                if (rsInvoice != null){
                int rowid=0;   
                String chequeColId ="";
                String cpColId  ="";
                String dueAmountColId="" ;
                String currentPaymnt = "";        
                String collectionDetailRid = "";
                while (rsInvoice.next()) {
                rowid++;
                cpColId  = rowid + "cpColId";
                chequeColId  = rowid + "chequeColId";
                dueAmountColId= rowid + "dueAmountColId";
                String invoice_date = "";
                String inv_rid =  rsInvoice.getString("sih_rid");
                String inv_no = rsInvoice.getString("sih_inv_number");
                collectionDetailRid = rsInvoice.getString("cld_rid");
                float inv_amt = rsInvoice.getFloat("sih_net_amt");
                //inv_amt  = decFmt.format(inv_amt);
                float paid_amt = rsInvoice.getFloat("sih_paid_amt");
                String status = rsInvoice.getString("sih_status");
                //paid_amt  = decFmt.format(paid_amt);
                if ("Modify".equals(request.getParameter("mode")))
                currentPaymnt =  rsInvoice.getString("cld_amt_adjusted");
                //currentPaymnt = decFmt.format(currentPaymnt);
                inv_no = inv_no != null?inv_no:"";
                java.sql.Date invoice_ddate = rsInvoice.getDate("sih_inv_date");
                if (invoice_ddate!=null)
                invoice_date=fmt.format(invoice_ddate);
                float inv_due_amt = rsInvoice.getFloat("due_amount");
                float org_inv_due_amt = 0;
                if ("Modify".equals(request.getParameter("mode")))
                //org_inv_due_amt =  inv_amt - paid_amt  + Float.parseFloat(currentPaymnt); 
                org_inv_due_amt = inv_due_amt + Float.parseFloat(currentPaymnt); 
                else
                org_inv_due_amt = inv_due_amt;
                //org_inv_due_amt =  inv_amt - paid_amt ; 
                //float inv_due_amt = inv_amt - paid_amt  ;
            // inv_due_amt = decFmt.format(inv_due_amt);
            %>
            <tr class="label">
                <input type="hidden" name="inv_rid" id="inv_rid" value="<%= inv_rid %>"/>
                <input type="hidden" name="dueAmount" id="<%= dueAmountColId %>" value="<%= org_inv_due_amt %>" />
                <input type="hidden" name="prevAdjustedAmount" id="prevAdjustedAmount" value="<%= currentPaymnt %>" />
                <input type="hidden" name="collectionDetailRid" id="collectionDetailRid" value="<%= collectionDetailRid %>" />
                <td td width="3%" align="center" ><input name="chkInv" type="checkbox" id="<%= chequeColId %>" value="<%= rowid %>" <%= ckhSelected %> <%= "-3".equals(status)?"disabled":ckhDisabled %>  onclick=" return calculateCurrentPayement(this.id);" ></td>
                <td width="18%" align="center" >&nbsp;<%= inv_no %></td>
                <td width="16%" align="center" ><%= invoice_date %></td>
                <td width="18%" align="center" ><%= inv_amt %></td>
                <td width="15%" align="center" ><%= paid_amt %></td>
                <td width="14%" align="center" ><%= inv_due_amt %></td>
                <td width="16%" align="center" ><input name="currentPayment" value="<%= currentPaymnt %>" class="readOnlyTextBox" type="text" id="<%= cpColId %>" maxlength="10" size="15" align="left" readonly></td>
            </tr>
                            <% }
            rsInvoice.close(); }%>        
        </table>
        <%}%>   
   
                         <% if ("getPromotions".equals(request.getParameter("command")))
{
        %>
        <table name="promoTable" id="promoTable" width="100%" border="0" cellpadding="0" cellspacing="0" class="activityBackgroundColor" >
                        <%
                String discountStr = ""; 
                HashMap[] PromoValueArr = (HashMap[])request.getAttribute("promoValues");
                if (PromoValueArr!=null || PromoValueArr.length > 0){
                int rowid=0;
                for(int i=0; i < PromoValueArr.length; i++ ) {
                PromotionManager.PromoValue promoObj = (PromotionManager.PromoValue) PromoValueArr[i].get("PromoValue");  
                String[] tmpComboTextArr = ((String) PromoValueArr[i].get("stkComboText")).split("#");
                String[] tmpCombovalueArr = ((String) PromoValueArr[i].get("stkCombovalue")).split("#");
                int[] saleProdRid = promoObj.saleProdRid;

                int promoItemType = 0;
                String prodRIdStr="";
                String prodQtyStr="";
                String prodWtStr="";
                String prodAmtStr="";
                String itemRowStr = "";
                String prodName = "";
                String prodTypeName = "";
                double reimbPrice = 0;
                //Iterator prodIterator = saleProdRid.iterator();
                //if(promoObj.freeProdRid.length > 0 || promoObj.freeArticleRid.length > 0){
                if(promoObj.freeQty.length > 0){
                for(int j =0; j < promoObj.freeQty.length; j++  ){
                String[] stkComboText =tmpComboTextArr[j].split("\\^");
                String[] stkCombovalue =tmpCombovalueArr[j].split("\\^");

                if (promoObj.freeProdRid != null && promoObj.freeProdRid.length > 0 ){
                promoItemType = 1;
                prodTypeName  = "Free Item ";
                prodName = promoObj.freeProdName[j];
                reimbPrice = promoObj.reimbursePrice[j];
                itemRowStr = promoObj.freeProdRid[j] + "~" + promoObj.freeProdName[j] + "~" + promoItemType;
                } else if (promoObj.freeArticleRid != null && promoObj.freeArticleRid.length > 0 ){
                promoItemType = 2;
                prodTypeName  = "Free Article";
                prodName = promoObj.freeArticleName[j];
                reimbPrice = 0;
                itemRowStr = promoObj.freeArticleRid[j] + "~" + promoObj.freeArticleName[j] + "~" + promoItemType;
                }

                prodRIdStr = "";
                prodQtyStr = "";
                prodWtStr = "";
                prodAmtStr = "";

                if (saleProdRid.length > 0){
                for (int m=0; m < saleProdRid.length; m++)
                {
                int prodRID = saleProdRid[m];

                if(prodRIdStr.length() > 0){
                prodRIdStr = prodRIdStr + "#";
                prodQtyStr = prodQtyStr + "#";
                prodWtStr = prodWtStr + "#";
                prodAmtStr = prodAmtStr + "#";
                }    
                prodRIdStr = prodRIdStr + prodRID ;
                prodQtyStr = prodQtyStr + promoObj.saleProdPktQty[m];
                prodWtStr = prodWtStr + promoObj.saleProdWtKg[m];
                prodAmtStr = prodAmtStr + promoObj.saleProdAmtRs[m];
                }
                }

                itemRowStr = itemRowStr + "~" + promoObj.freeQty[j] + "~" + promoObj.promoRid + "~" + prodRIdStr + "~" + promoObj.saleProdQty + "~" + prodQtyStr + "~" + prodWtStr + "~" + prodAmtStr + "~" + reimbPrice + "~" + promoObj.discountTotalAmt;

                if(!"".equals(itemRowStr)){          
        
            %>
            <tr  class="workTableBodyColor">
                <td width="3%" class="label" align="center"><input type="checkbox" <%if("".equals(tmpCombovalueArr[j].trim())){%> disabled <%} else {%> checked <%}%> name="promoSelect" 
                id="promoSelect" value = "<%= itemRowStr %>" ></td>
                
                <td align="left" width="10%" class = "label" ><%= promoObj.promoCode %></td>
                <td align="left" width="20%" class = "label" ><%= promoObj.promoName %></td>
                <td align="left" width="30%" class = "label" ><%= prodName %></td>
                <td align="left" width="5%" class = "label" > PKT </td>
                <td align="left" width="5%" class = "label" ><%= promoObj.freeQty[j] %></td>
                <td align="left" width="15%" class = "label" >
                    <select name="promostkQtySelect" id="promostkQtySelect" onchange ="" style="width:100px;">
                        <% for (int k= 0; k < stkComboText.length; k++){ %>
                        <option value= "<%= stkCombovalue[k] %>" <% if (k==0){%>selected <% } %> >
                            <%= stkComboText[k] %>
                        </option>
                        <% } %>
                    </select>
                </td>
                <td width="15%" class = "label" ><%= prodTypeName %></td>
            </tr>
                       
                                     <% 
                         }
                         }  
                         } else {
                         //Integer[] prodRIDArr = (Integer[]) saleProdRid.toArray();

                         if(saleProdRid.length > 0){
                         for(int j = 0; j < saleProdRid.length ; j++){
                         int prodRID = saleProdRid[j];
                         if(discountStr.length() > 1 )
                         discountStr = discountStr + "^";
                         if(promoObj.discountAmtPerPkt > 0 ){
                         discountStr =  discountStr  + promoObj.promoRid + "~" + prodRID + "~" + promoObj.discountAmtPerPkt + "~0~" + promoObj.saleProdQty + "~" + promoObj.saleProdPktQty[j] + "~" + promoObj.saleProdAmtRs[j] + "~" + promoObj.saleProdWtKg[j] + "~" + promoObj.discountTotalAmt;   
                         } else if ( promoObj.discountPercent > 0 ) {
                         discountStr =  discountStr  + promoObj.promoRid + "~" + prodRID + "~" + promoObj.discountPercent + "~1~" + promoObj.saleProdQty + "~" + promoObj.saleProdPktQty[j] + "~" + promoObj.saleProdAmtRs[j] + "~" + promoObj.saleProdWtKg[j] + "~" + promoObj.discountTotalAmt;
                         }
                         }
                         }
                         }

                         }
}%>

                
            <input name = "discountStr" id="discountStr" type = "hidden" value= "<%= discountStr.trim() %>"> 

        </table>
        <%}%>
                    <% if ("PIList".equals(request.getParameter("command")))  
        {
        %>
        <table width="100%" border="0" cellpadding="1" cellspacing="1" id="PIListTab">
            <tr >
                <td>
                    <table width="93%" border="0" cellpadding="1" cellspacing="1" ondblclick="" >
                        <tr class="specialRow">
                            <td width="25%">&nbsp;Invoice No</td>
                            <td width="25%">Date</td>                            
                            <td width="20%" align = "right">Amount</td>
                            <td width="5%"></td>
                            <td width="25%">&nbsp;Status</td>
                        </tr>
                    </table> 
                </td>
            </tr>
            <tr >
                <td>
                    <div style="valign:top;z-index:1000; cursor:pointer;">
                        <table id="piListTab" name="piListTab" width="93%" border="0" cellpadding="1" cellspacing="0"  >
                                                        <% 
                                String currClassStyle = "" ;
                                ResultSet rs1 = (ResultSet)request.getAttribute("rsPIList");
                                if (rs1!=null){
                                while (rs1.next()) {
                                String invoiceNo = rs1.getString("pih_number");
                                String invDate = rs1.getString("inv_date");
                                String invStatus = rs1.getString("status");
                                DecimalFormat df9= new DecimalFormat("############0.00");
                                String invAmount = df9.format(rs1.getDouble("pih_net_amount"));
                                String invRID = rs1.getString("pih_rid");

                                if(currClassStyle.equals("tableBodyColor"))
                                currClassStyle = "" ;
                                else
                                currClassStyle = "" ;
                        
                            %>
                            <tr  onclick="loadInvoice(this)" height="20">
                                <td width="25%">&nbsp;<%= invoiceNo %></td>
                                <td width="25%"><%= invDate %></td>
                                <td width="20%" align = "right"><%= invAmount %></td>
                                <td  width="5%"></td>
                                <td width="25%">&nbsp;<%= invStatus %></td>
                                <td ><input name="pihRID" id ="pihRID" type ="hidden" value="<%= invRID %>" ></td>
                            </tr> 
                                                            <% }
                            rs1.close(); }%>
                        </table> 
                    </div>
                </td>
            </tr>
            <tr class="label">
                <td align="center" valign="top" >
                <!--    <input name="Ok" id="Ok" type ="button" value=" Close " onclick="loadInvoice()"> -->
                </td>
            </tr>
        </table> 
        <%}%>
 