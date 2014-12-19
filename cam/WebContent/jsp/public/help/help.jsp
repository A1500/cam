<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/jsp/public/resources_jspdir.jsp" %>
<%@page import="org.loushang.util.help.HelpWindowRegistry"%>
<%
	String url = HelpWindowRegistry.getUrl(request.getParameter("helpCode"));
	
	StringBuffer sb = new StringBuffer("");
	if(!url.startsWith("http://") && !url.startsWith("https://")){
		if(!url.startsWith("/")){
			url = "/" + url;
		}
		url = request.getContextPath() + url;
	}
	
	String queryString = request.getQueryString();
	int index = queryString.indexOf("&");
	if(index >= 0){
		if(url.indexOf("?") >= 0){
			url = url + queryString.substring(index);
		} else {
			url = url + "?" + queryString.substring(index + 1);
		}
	}
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><%=res.get("HELP.TITLE")%></title>
</head>
<body style="background-color:#DFE8F6;overflow-y:scroll;scrollbar-face-color:DFE8F6;margin:0px 0px 0px 0px;">
<%  // redirect to the target page
	response.sendRedirect(url);
%>
</body>
<%--Example:
    var url = "<%=request.getContextPath()%>/jsp/public/help/help.jsp";  
    var params = "?helpCode=001&name=zhangsan&age=23";
    var win = showModalDialog(url + params,window,"scroll:yes;status:no;dialogLeft:500px;dialogTop:200px;dialogWidth:500px;dialogHeight:350px");
--%>
</html>