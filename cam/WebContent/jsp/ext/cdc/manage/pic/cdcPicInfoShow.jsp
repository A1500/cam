<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>社区建设图片展示</title>
<next:ScriptManager/>
<script type="text/javascript" src="cdcPicInfoShow.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<jsp:include page="../util/cdcOrgan.jsp" flush="true"/>
<jsp:include page="../util/cdcSum.jsp" flush="true"/>
<script type="text/javascript">var rootPath='<%=SkinUtils.getRootUrl(request)%>';</script>
<script type="text/javascript" src="<%=SkinUtils.getRootUrl(request)%>skins/js/ISEditPhoto.js"></script>

</head>
<body>
<model:datasets>
	<model:dataset id="cdcPicInfoDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcPicInfoQueryCmd" method="queryPicInfo" pageSize="30" global="true">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcPicInfo"/>
	</model:dataset>
		<!-- 行政区划 -->
	<model:dataset id="OrgCodeDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="false">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='COM_EXT_USER'></model:param>
			<model:param name="value" value='USER_ID'></model:param>
			<model:param name="text" value='USER_NAME'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>
<next:Panel width="100%" border="0">
	<next:Html>
	<fieldset style="overflow:visible;" class="GroupBox">
	<legend class="GroupBoxTitle">查询条件</legend>
		<form class="L5form">
			<table border="1" width="100%">
				<tr>
					<td class="FieldLabel" style="width:10%">上传时间：</td>
					<td class="FieldInput" style="width:12%">
					<input id="createTime" field="createTime"onclick="LoushangDate(this)"  format="Y-m-d" readonly="readonly">
					</td>
					<td class="FieldLabel" style="width:10%" id = "xzqh1">行政区划：</td>
					<td class="FieldInput" style="width:20%" id = "xzqh2"> <input type="text" id="domicileName" onclick="func_ForDomicileSelect()" style="width: 99%" readonly="readonly"/>
						<input type="hidden" id="domicileCode"/><input type="hidden" id="leve"/></td>
					<td class="FieldInput" style="width:20%" id = "xzqh4"><select id = "SQdomicileCode"><option dataset = "OrgCodeDataset"></option> </select> </td>
					<td class="FieldInput" style="width:37%">
					<button onclick="query()">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;
					<button type="reset">重置</button>&nbsp;&nbsp;&nbsp;&nbsp;
					<button onclick="querySelf()" id = "Selfquery">查询本级数据</button></td>
				</tr>
			</table>
		</form>
	</fieldset>
	</next:Html>
</next:Panel>
<next:Panel width="100%" height="100%" border="0">
<next:TopBar>
	<next:ToolBarItem symbol="->"></next:ToolBarItem>
	<next:ToolBarItem iconCls="add" text="增加" handler="upload"></next:ToolBarItem>
</next:TopBar>

<next:Html>
<form class="L5form">
	<table>
		<tr>
			<td>
			<div id="photoDiv" width="80%" >
				
			</div>
			</td>
		</tr>
	</table>
</form>
</next:Html>
<next:BottomBar>
	<next:PagingToolBar dataset="cdcPicInfoDataSet"/>
</next:BottomBar>

</next:Panel>
</body>
</html>