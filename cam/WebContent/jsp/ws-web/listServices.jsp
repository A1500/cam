<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@page import="org.loushang.ws.extend.DynamicServiceMgrImpl"%>
<%@page import="org.loushang.ws.context.ConfigurationContext"%>
<%@page import="java.util.HashMap"%>

<%@page import="java.util.Hashtable"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Collection"%>
<%@page import="org.loushang.ws.description.AxisService"%>
<%@page import="org.loushang.ws.description.AxisOperation"%>
<%@page import="java.util.Enumeration"%>
<%@page import="org.loushang.ws.Constants"%>
<html>
<head>
	<title>List Services</title>  
</head>
<body style="background-color:#F3F7F6;text-align:center;">
<table style="width:824px;border-left:1px solid #599CD4;border-right:1px solid #599CD4;" align="center"><tr><td style="width:32px;"></td>
<td style="width:760px;">
	<h1>Available services</h1>
<% 
    ConfigurationContext configCtx = DynamicServiceMgrImpl.getConfigurationContext();
	String prefix = getUrl(request) + configCtx.getServicePath() + "/";
	// 
    HashMap serviceMap = configCtx.getAxisConfiguration().getServices();    
    Hashtable errornessservice = configCtx.getAxisConfiguration().getFaultyServices();
    boolean status = false;
    if (serviceMap != null && !serviceMap.isEmpty()) {
        String serviceName;     // serviceName
        Iterator opItr;         // HashMap operations;
        // Collection operationsList;
        Collection servicecol = serviceMap.values();
        for (Iterator iterator = servicecol.iterator(); iterator.hasNext();) {
            AxisService axisService = (AxisService) iterator.next();
            // serviceName
            serviceName = axisService.getName();
            // operationsList = operations.values();
            opItr = axisService.getOperations();
%>
			<h2>
				<font color="blue">
					<a href="<%=prefix + serviceName%>?wsdl" target="_blank"><%=serviceName%></a>
				</font>
		    </h2>
			<font color="blue">Service EPR : </font>
			<font color="black"><%=prefix + serviceName%></font>
			<br>
<%            
		    String serviceDescription = axisService.getServiceDescription();
    		if (serviceDescription == null || "".equals(serviceDescription)) {
        		serviceDescription = "No description available for this service";
    		}
%>
			<h4>Service Description : 
				<font color="black"><%=serviceDescription%></font>
			</h4>
			<i>
				<font color="blue">
					Service Status : <%=axisService.isActive() ? "Active" : "InActive"%>
				</font>
			</i>
			<br>
<%
    		if (opItr.hasNext()) {
%>
				<i>Available Operations</i>
<%
			} else {
%>
				<i> There are no Operations specified</i>
<%
    		}
    		opItr = axisService.getOperations();
%>
			<ul>
<%
    		while (opItr.hasNext()) {
        		AxisOperation axisOperation = (AxisOperation) opItr.next();
%>
				<li><%=axisOperation.getName().getLocalPart()%></li>
    <%--
    	<br>
    	Operation EPR : <%=prifix + axisService.getName().getLocalPart() + "/"+ axisOperation.getName().getLocalPart()%>
    --%>
<%
            }
%>
			</ul>
<%
            status = true;
        }// end for services
    }// end if serviceMap
    if (errornessservice != null) {
        if (errornessservice.size() > 0) {
            request.getSession().setAttribute(Constants.IS_FAULTY, Constants.IS_FAULTY);
%>
			<hr>
			<h3>
				<font color="blue">Faulty Services</font>
			</h3>
<%
    		Enumeration faultyservices = errornessservice.keys();
    		while (faultyservices.hasMoreElements()) {
        		String faultyserviceName = (String) faultyservices.nextElement();
%>
				<h3>
					<font color="blue">
						<a href="services/ListFaultyServices?serviceName=<%=faultyserviceName%>"><%=faultyserviceName%></a>
    				</font>
    			</h3>
<%
            }// end while faultServices
        }
        status = true;
    }
    if (!status) {
%> 
		No services listed! Try hitting refresh. 
<%
    }
%>
</td>
<td style="width:32px;"></td></tr></table>
</body>
<%!
/**
 * getUrl:http://localhost:8080/appName
 */
public String getUrl(HttpServletRequest aRequest){
    StringBuffer stringBuffer = new StringBuffer();
    String scheme = aRequest.getScheme();
    stringBuffer.append(scheme);
    stringBuffer.append("://");
    stringBuffer.append(aRequest.getServerName());
    if (("http".equalsIgnoreCase(scheme) && aRequest.getServerPort() != 80) || "https".equalsIgnoreCase(scheme) && aRequest.getServerPort() != 443)
    {
        stringBuffer.append(":");
        stringBuffer.append(aRequest.getServerPort());
    }
    // I think i saw web containers return null for root web context
    if (aRequest.getContextPath() != null) {
        stringBuffer.append(aRequest.getContextPath()); // start with '/'
    }
    // append / char if needed
    if (stringBuffer.charAt(stringBuffer.length() - 1) != '/') {
        stringBuffer.append("/");
    }
    String curentUrl = stringBuffer.toString();
    return curentUrl;
}
%>
</html>
