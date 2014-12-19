<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>社区建设图片展示</title>
<next:ScriptManager/>
<script type="text/javascript" src="cdcPicInfoShowDetail.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<jsp:include page="../util/cdcOrgan.jsp" flush="true"/>
<jsp:include page="../util/cdcSum.jsp" flush="true"/>
<script type="text/javascript">var rootPath='<%=SkinUtils.getRootUrl(request)%>';</script>
<script type="text/javascript" src="<%=SkinUtils.getRootUrl(request)%>skins/js/ISEditPhoto.js"></script>
<script type="text/javascript">
	var note=decodeURIComponent('<%=request.getParameter("note")%>');
	var photoId='<%=request.getParameter("photoId")%>';
	var organNameThis=decodeURIComponent('<%=request.getParameter("organName")%>');
	var createTime='<%=request.getParameter("createTime")%>';
	var id='<%=request.getParameter("id")%>';
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="cdcPicInfoDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcPicInfoQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcPicInfo"/>
	</model:dataset>
</model:datasets>
<next:Panel width="100%" height="100%" border="0" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"></next:ToolBarItem>
	<next:ToolBarItem iconCls="remove" text="删除" handler="del"></next:ToolBarItem>
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