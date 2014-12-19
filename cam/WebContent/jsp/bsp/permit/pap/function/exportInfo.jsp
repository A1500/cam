<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ include file="/jsp/public/resources_jspdir.jsp"%>
<html>
<head>
<next:ScriptManager/>
<script type="text/javascript" src="exportInfo.js"></script>
<title>导出</title>
<script type="text/javascript">
	var treeId='<%=request.getParameter("treeId")%>';
	treeId = decodeURI(treeId);
	var treeType='<%=request.getParameter("treeType")%>';
	treeType = decodeURI(treeType);
	var path='<%=request.getParameter("path")%>';
	path = decodeURI(path);
	var menuStruId='<%=request.getParameter("menuStruId")%>';
	menuStruId = decodeURI(menuStruId);
	var menuTypeId='<%=request.getParameter("menuTypeId")%>';
	menuTypeId = decodeURI(menuTypeId);
	var struTypeId='<%=request.getParameter("struTypeId")%>';
	struTypeId = decodeURI(struTypeId);
	var dataType="<%=request.getParameter("dataType")%>";
	var struId='<%=request.getParameter("struId")%>';
	struId = decodeURI(struId);
</script>
</head>
<body> 
</body>
</html>
