<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<html>
<head>
<title>社区建设图片展示</title>
<next:ScriptManager/>
<script type="text/javascript" src="mrmPhotoInfoShowDetail.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">var rootPath='<%=SkinUtils.getRootUrl(request)%>';</script>
<script type="text/javascript" src="<%=SkinUtils.getRootUrl(request)%>skins/js/ISEditPhoto.js"></script>
<script type="text/javascript">
	var note=decodeURIComponent('<%=request.getParameter("note")%>');
	var photoId='<%=request.getParameter("photoId")%>';
	var organNameThis=decodeURIComponent('<%=request.getParameter("organName")%>');
	var createTime='<%=request.getParameter("createTime")%>';
	var id='<%=request.getParameter("id")%>';
	var deptCode = '<%=request.getParameter("deptCode")%>';
	var	userName='<%=GetBspInfo.getBspInfo(request).getUserName()%>';
	var organCodeOld = '<%=request.getParameter("organCode")%>';
	var organCode = '<%=BspUtil.getOrganCode()%>';
</script>
</head>
<body>

<next:Panel width="100%" height="100%" border="0" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"></next:ToolBarItem>
	<%
		String organType = BspUtil.getOrganType();
		if(!"11".equals(organType)){
	%>
	<next:ToolBarItem iconCls="remove" text="删除" handler="del"></next:ToolBarItem>
	<%
		}
	%>
</next:TopBar>

<next:Html>
<form class="L5form">
<center>
	<table cellpadding="0" cellspacing="0" border="0">
		<tr>
			<td>
			<div id="photoDiv" width="80%" >
				
			</div>
			</td>
		</tr>
	</table>
</center>
</form>
</next:Html>
</next:Panel>
</body>
</html>