<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@page import="org.loushang.ws.extend.DynamicServiceMgrImpl"%>
<%@page import="org.loushang.ws.context.ConfigurationContext"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Hashtable"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.loushang.ws.description.AxisService"%>
<%@page import="org.loushang.ws.description.AxisOperation"%>
<%@page import="java.util.Collection"%>

<html>
<head>
	<style>
    .box_tb_out{
        border-top:1px solid #AECEF6;
        border-left:1px solid #AECEF6;        
    }
    .box_tb_header{
        text-align:center;
        line-height:26px;
        border-right:1px solid #AECEF6;
        border-bottom:1px solid #AECEF6;
        background:url(img/box_tb.gif) repeat-x left top;
        font-family:"Tahoma","Verdana","宋体";
        font-size:12px;
        white-space:nowrap;
    }
    .box_tb_odd{
        text-align:center;
        height:26px;
        padding:0px 4px 0px 4px;
        border-right:1px solid #AECEF6;
        border-bottom:1px solid #AECEF6;
        font-family:"Tahoma","Verdana","宋体";
        font-size:12px;
        white-space:nowrap;
    }
    .box_tb_even{
        text-align:center;
        height:26px;
        background-color:#F3F7FA;
        padding:0px 4px 0px 4px;
        border-right:1px solid #AECEF6;
        border-bottom:1px solid #AECEF6;
        font-family:"Tahoma","Verdana","宋体";
        font-size:12px;
        white-space:nowrap;
    }
    .btn_dsp{
    	z-index: 10;
    	border:1px solid #A1A2FF;
    	text-align:left;
    	padding-top:1px !important;
    	padding-right:20px !important;
    	padding-bottom:1px !important;
    	padding-left:5px !important;
    	background-image:url(img/arrow_right.gif);
    	background-repeat: no-repeat;
    	background-position: 65px 4px;
    	color:#0000CC;
    	cursor: pointer;
    	text-decoration: underline;
    }
    .btn_hid{
    	z-index: -1;
    	border-top:1px solid #A1A2FF;
    	border-bottom:1px solid #A1A2FF;
    	border-left:1px solid #A1A2FF;
    	text-align:left;
    	padding-top:1px !important;
    	padding-right:27px !important;
    	padding-bottom:1px !important;
    	padding-left:5px !important;
    	background-image:url(img/arrow_left.gif);
    	background-repeat: no-repeat;
    	background-position: 72px 4px;
    	color:#007700;
    	cursor: pointer;
    	text-decoration: underline;
    }
    </style>
	<title>List Services</title>  
</head>
<body style="background-color:#FAFAFA;text-align:center;">
<table style="height:100%;width:824px;table-layout:fixed;border-left:1px solid #599CD4;border-right:1px solid #599CD4;" align="center"><tr><td style="width:32px;"></td>
<td style="width:760px;" valign="top">
<table cellspacing="0" cellpadding="0" align="center" class="box_tb_out">
	<caption style="font-size:18px;">
		<b>Available services</b>
	</caption>
	<tr>
    	<td class="box_tb_header">序号</td>
    	<td class="box_tb_header">服务信息</td>
    	<td class="box_tb_header" style="width:586px;">操作</td>
	</tr>
<% 
    ConfigurationContext configCtx = DynamicServiceMgrImpl.getConfigurationContext();
	String prefix = getUrl(request) + configCtx.getServicePath() + "/";
	// 
    HashMap serviceMap = configCtx.getAxisConfiguration().getServices();    
    if (serviceMap != null && !serviceMap.isEmpty()) {
        String serviceName;     // serviceName
        Iterator opItr;         // HashMap operations;
        // Collection operationsList;
        Collection servicecol = serviceMap.values();
        int rows = 1;
        for (Iterator iterator = servicecol.iterator(); iterator.hasNext();) {
            AxisService axisService = (AxisService) iterator.next();
            // serviceName
            serviceName = axisService.getName();
            // operationsList = operations.values();
            opItr = axisService.getOperations();
            String operDivId = serviceName + "_oper_div";
            // 
            out.print("<tr>");
            if(rows%2 == 0){
                // 偶数行
                out.print("<td class=\"box_tb_even\">");
                out.print(rows);
                out.print("</td>");
                out.print("<td class=\"box_tb_even\">");
                out.print("<a href=\"" + prefix + serviceName +"?wsdl\" " + "target=\"_blank\">");
                out.print(serviceName);
                out.print("</a>");
                out.print("</td>");
                out.print("<td class=\"box_tb_even\" style='text-align:left;'>");
                out.print("<span title='显示操作信息' class='btn_dsp' onclick='expand(this,\""+operDivId+"\")'>");
                out.print("显示操作");
                out.print("</span>");
                // 
                out.print("<br/>");
                out.print("<div id="+operDivId+" style='display:none;width:574px;padding-right:20px;overflow-x:scroll;scrollbar-face-color:#66BBE8;scrollbar-shadow-color:#66BBE8;'>");
                out.print("<ul>");
                while (opItr.hasNext()) {
        			AxisOperation axisOperation = (AxisOperation) opItr.next();
        			String info = getOperationInfo(axisOperation);
        			out.print("<li style='white-space:nowrap;'>" + info + "</li>");
                }
                out.print("</ul>");
                out.print("</div>");
                // 
                out.print("</td>");
            }else{
                // 奇数行
                out.print("<td class=\"box_tb_odd\">");
                out.print(rows);
                out.print("</td>");
                out.print("<td class=\"box_tb_odd\">");
                out.print("<a href=\"" + prefix + serviceName +"?wsdl\" " + "target=\"_blank\">");
                out.print(serviceName);
                out.print("</a>");
                out.print("</td>");
                out.print("<td class=\"box_tb_odd\" style='text-align:left;'>");
                out.print("<span title='显示操作信息' class='btn_dsp' onclick='expand(this,\""+operDivId+"\")'>");
                out.print("显示操作");
                out.print("</span>");
                // 
                out.print("<br/>");
                out.print("<div id="+operDivId+" style='display:none;width:574px;padding-right:20px;overflow-x:scroll;scrollbar-face-color:#66BBE8;scrollbar-shadow-color:#66BBE8;'>");
                out.print("<ul>");
                while (opItr.hasNext()) {
        			AxisOperation axisOperation = (AxisOperation) opItr.next();
        			String info = getOperationInfo(axisOperation);
        			out.print("<li style='white-space:nowrap;'>" + info + "</li>");
                }
                out.print("</ul>");
                out.print("</div>");
                // 
                out.print("</td>");
            }
            out.print("</tr>");
            rows++;            
        }// end for services
    }// end if serviceMap
%>    
</table>
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
public String getOperationInfo(AxisOperation oper){
    StringBuffer sb = new StringBuffer();
    sb.append(oper.getName().getLocalPart());
    sb.append("(");
    String[] pns = oper.getMethodParameterNames();
    Class[] pts = oper.getMethodParameterTypes();
    Class crtype = oper.getMethodReturnType();
    if(pns != null && pts != null){
        int size = (pns.length < pts.length) ? pns.length:pts.length;
        for(int i=0;i<size;i++){
            sb.append(pns[i] + ":" + pts[i].getSimpleName());
            if(i < size - 1){
                sb.append(",");
            }
        }
    }
    sb.append(")");
    sb.append(":");
    String rtype = "void";
    if(crtype != null){
        rtype = crtype.getSimpleName();
    }
    sb.append(rtype);
    return sb.toString();
}
%>
<script type="text/javascript">
function expand(ele,operId){
	var operDiv = document.getElementById(operId);
	if(ele.innerHTML == "显示操作"){
		ele.innerHTML = "隐藏操作"
		ele.title = "";
		ele.className = "btn_hid";
		operDiv.style.display = "inline";			
	}else{
		ele.innerHTML = "显示操作"
		ele.title = "显示操作信息";
		ele.className = "btn_dsp";
		operDiv.style.display = "none";	
	}
}
</script>
</html>
