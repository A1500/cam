<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>社区建设图片展示</title>
<next:ScriptManager/>
<script type="text/javascript">
//	var organCode = '<%=BspUtil.getOrganCode()%>';
//	var organName = '<%=BspUtil.getOrganName()%>';
	var deptCode = '<%=request.getParameter("deptCode")%>';
	var deptName = decodeURIComponent('<%=request.getParameter("deptName")%>');

</script>
<script type="text/javascript" src="mrmPhotoInfoShow.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">var rootPath='<%=SkinUtils.getRootUrl(request)%>';</script>
<script type="text/javascript" src="<%=SkinUtils.getRootUrl(request)%>skins/js/ISEditPhoto.js"></script>
<script type="text/javascript" src="../../../../cams/bpt/comm/bptComm.js"></script>
</head>
<body>
<model:datasets>
	<model:dataset id="mrmPhotoInfoDataSet" cmd="com.inspur.cams.marry.base.cmd.MrmPhotoInfoQueryCommand" method="queryPhotoInfo" pageSize="20" global="true">
		<model:record fromBean="com.inspur.cams.marry.base.data.MrmPhotoInfo"/>
	</model:dataset>
</model:datasets>
<next:Panel width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true" >
	<next:Html><center>
	<fieldset style="overflow: visible;" class="GroupBox"><legend
					class="GroupBoxTitle">查询条件 <img
					class="GroupBoxExpandButton"
					src="<%=SkinUtils.getImage(request,
									"groupbox_collapse.gif")%>"
					onclick="collapse(this)" /> </legend>
				<div>
					<form style="width: 95%; height: 100%;" class="L5form">
			<table border="1" width="100%">
				<tr>
					<td class="FieldLabel" style="width:20%">上传时间：</td>
					<td class="FieldInput" style="width:30%">
					<input id="createTime" field="createTime"  format="Y-m-d"><img  src="../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this)" />
					</td>
					<td class="FieldButton" style="width:50%">
					<button onclick="query()">查 询</button>&nbsp;&nbsp;&nbsp;&nbsp;<button type="reset">重 置</button></td>
				</tr>
			</table>
		</form>
				</div>
	</fieldset>
	</center></next:Html>
</next:Panel>
<next:Panel width="100%" height="100%" border="1" title="机关图片信息列表">
<next:TopBar>
	<next:ToolBarItem symbol="->"></next:ToolBarItem>
	<%
		String organType = BspUtil.getOrganType();
		if(!"11".equals(organType)){
	%>
	<next:ToolBarItem iconCls="add" text="增加" handler="upload"></next:ToolBarItem>
	<%
		}
	%>
</next:TopBar>

<next:Html>
<form class="L5form">
	<table>
		<tr>
			<td>
			<div id="photoDiv" width="98%" >
				
			</div>
			</td>
		</tr>
	</table>
</form>
</next:Html>
<next:BottomBar>
	<next:PagingToolBar dataset="mrmPhotoInfoDataSet"/>
</next:BottomBar>

</next:Panel>
</body>
</html>