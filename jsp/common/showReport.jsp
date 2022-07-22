<%--
	/*
	 * This file is handling requests to get the reports. All the inputs to this file given 
	 * as Query String. This file requires inputs like ReportFileName, Format, Parameters to the Report.
	 * A typical URL will be like as follows
	 * http://localhost:8080/show_report.jsp?ReportFileName=patient_details&Format=PDF&pt_id=1001&visit_id=OP0001&...
	 *
	  * Deploy all the reports .jasper file into the reports folder
          
	String reportFileName = (String)request.getAttribute("ReportFileName");
	String outputFormat = (String)request.getAttribute("Format");

	 
     */
--%>

<%@ page import="java.net.*,java.io.*,java.sql.*,java.lang.*" %>
<%@ page import="java.util.*" %>
<%@ page import="net.sf.jasperreports.engine.*" %>
<%@ page import="net.sf.jasperreports.engine.util.*" %>
<%@ page import="net.sf.jasperreports.engine.export.*" %>
<%@ page import="ubq.base.*" %>
<%@ page import="net.sf.jasperreports.engine.fill.*"%>


<% 	
        String reportFileName =(String)request.getAttribute("ReportFileName");
        String outputFormat = (String)request.getAttribute("Format");    
        java.util.Map param = (HashMap)request.getAttribute("reportParam");    
        //String viewOrPrint = (String)request.getAttribute("viewOrPrint"); 
        URequestContext reqContext = (URequestContext)request.getAttribute("ctxt");    
	
        Connection conn;
        
	if ( outputFormat == null ||  outputFormat == "" || reportFileName == null || reportFileName == "" ) 
	{
		out.println("Format Parameter or ReportFileName Parameter not given");
		return;
	}
        
	String reportFilePath = "reports/" + reportFileName + ".jasper";
	File reportFile = new File(application.getRealPath(reportFilePath));
	System.out.println(reportFileName + ".jasper found ==> " + reportFile.exists());
        String subReportPath = reportFile.getParent() + "\\AW_profile_subreport.jasper";
        param.put("subReportPath",subReportPath);
        String subAWReportPath = reportFile.getParent() + "\\AW_profile_subreport.jasper";
        param.put("subAWReportPath",subAWReportPath);
        String addSubReport = (String)request.getAttribute("addSubReportPath");
        if ("YES".equals(addSubReport)) // add report path additional sub report
        {
            String addSubReportName = (String) request.getAttribute("addSubReportName");
            String addSubReportParam = (String) request.getAttribute("addSubReportParamName");
            String addSubReportPath = reportFile.getParent() + "\\" + addSubReportName + ".jasper";
            param.put(addSubReportParam,addSubReportPath);
        }
        
	if (!reportFile.exists())
	{
		out.println("Given Report File " + application.getRealPath(reportFilePath) + " not found in the path");
		return;
	}

	try
	{
            // need to use the ctxt to get the connection. and everybody has to pass the ctxt...
            //UQueryEngine qe = new UQueryEngine();
            
            UQueryEngine qe = reqContext.getQueryEngine();
            conn = qe.getConnection();
	
	}
	catch(Exception e)
	{
		e.printStackTrace();
		System.out.println("Datasource Exception occured!!! ==> " + e);
		return;
	}

	try
	{
		
            if (outputFormat.equals("PDF")) 
		{
			byte[] bytes = JasperRunManager.runReportToPdf(reportFile.getPath(), param, conn);
		
			out.clear();
			out = pageContext.pushBody();
			response.setContentType("application/pdf");
			response.setContentLength(bytes.length);
			ServletOutputStream ouputStream = response.getOutputStream();
			ouputStream.write(bytes, 0, bytes.length);
			ouputStream.flush();
			ouputStream.close();
            }
		else if (outputFormat.equals("HTML")) 
		{	
                        File imageDir = new File(application.getRealPath("images") );
			
			JasperReport jasperReport = (JasperReport)JRLoader.loadObject(reportFile.getPath());
			JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, param, conn);
			//JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, param, new JREmptyDataSource());
                        JRHtmlExporter exporter = new JRHtmlExporter();
                        exporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
                        exporter.setParameter(JRExporterParameter.OUTPUT_WRITER, out);
                        exporter.setParameter(JRHtmlExporterParameter.IMAGES_DIR, imageDir);
                        exporter.setParameter(JRHtmlExporterParameter.IMAGES_URI, "images/");
                        exporter.setParameter(JRHtmlExporterParameter.IS_OUTPUT_IMAGES_TO_DIR, Boolean.TRUE);
                        exporter.exportReport(); 
  		}
		else
		{
			out.println("The given Format parameter value : " + outputFormat );
		}

		reqContext.close(); 
	}
	catch(Exception e)
                {e.printStackTrace();
		System.out.println("Jasper Exception occured!!!..." + e.toString());
	}

%>

