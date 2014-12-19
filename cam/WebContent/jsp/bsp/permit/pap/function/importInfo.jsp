<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ include file="/jsp/public/resources_jspdir.jsp"%>
<next:ScriptManager/>
<html>
<head>
<script type="text/javascript" src="importInfo.js"></script>
<title>导入</title>
<script type="text/javascript">
var treeId='<%=request.getParameter("treeId")%>';
	treeId = decodeURI(treeId);
	var treeType='<%=request.getParameter("treeType")%>';
	treeType = decodeURI(treeType);
	var path='<%=request.getParameter("path")%>';
	path = decodeURI(path);
	var isLeafModule='<%=request.getParameter("isLeafModule")%>';
	isLeafModule=decodeURI(isLeafModule);
	var menuTypeId='<%=request.getParameter("menuTypeId")%>';
	menuTypeId = decodeURI(menuTypeId);
	var dataType="<%=request.getParameter("dataType")%>";
	
</script>
</head>
<body> 
</body>
</html>
