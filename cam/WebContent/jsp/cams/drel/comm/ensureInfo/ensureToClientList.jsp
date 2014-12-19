<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>核查业务反馈列表</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="ensureToClientList.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
</head>
<body>
<model:datasets>
	<model:dataset id="ensureToClientDataSet" cmd="com.inspur.cams.drel.ensureInfo.cmd.EnsureToClientQueryCmd" pageSize="200">
		<model:record fromBean="com.inspur.cams.drel.ensureInfo.data.EnsureToClient"/>
	</model:dataset>
</model:datasets>
<next:Panel width="100%" border="0">
	<next:Html>
	<fieldset style="overflow:visible;" class="GroupBox">
	<legend class="GroupBoxTitle">查询条件</legend>
		<form class="L5form">
			<table border="1" width="100%">
				<tr>
					<td class="FieldLabel" style="width:18%">反馈时间：</td>
					<td class="FieldInput" style="width:36%"><input id="feedBackTime"/></td>
					<td class="FieldButton" style="width:20%">
					<button onclick="query()">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;<button type="reset">重置</button></td>
				</tr>
			</table>
		</form>
	</fieldset>
	</next:Html>
</next:Panel>
<next:EditGridPanel id="grid" dataset="ensureToClientDataSet" width="100%" stripeRows="true" height="99.9%">
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column field="ensureId" header="业务主键" width="15%" hidden="true" sortable="false"/>
		<next:Column field="historyInfoId" header="历史信息主键" hidden="true" width="15%" sortable="false"/>
		<next:Column field="applyId" header="委托业务" hidden="true" width="15%" sortable="false"/>
		<next:Column field="commissionId" header="核查业务" hidden="true" width="15%" sortable="false"/>
		<next:Column field="acceptUnitId" header="接收单位主键" hidden="true" width="15%" sortable="false"/>
		<next:Column field="acceptUnit" header="接收单位" width="15%" sortable="false"/>
		<next:Column field="areaCode" header="所属行政区划代码" hidden="true" width="15%" sortable="false"/>
		<next:Column field="areaName" header="所属行政区划名称" width="15%" sortable="false"/>
		<next:Column field="familyName" header="户主姓名" width="15%" sortable="false"/>
		<next:Column field="familyIdCard" header="户主身份证号" width="15%" sortable="false"/>
		<next:Column field="ensureUnitId" header="核查单位主键" hidden="true" width="15%" sortable="false"/>
		<next:Column field="ensureUnit" header="核查单位" width="15%" sortable="false"/>
		<next:Column field="ensureIncome" header="核查收入" width="15%" sortable="false"/>
		<next:Column field="ensureExpend" header="核查支出" width="15%" sortable="false"/>
		<next:Column field="ensureProperty" header="核查财产" width="15%" sortable="false"/>
		<next:Column field="feedbackTime" header="反馈时间" width="15%" sortable="false"/>
		<next:Column field="feedbackResult" header="反馈结果" width="15%" sortable="false"/>
		<next:Column field="readStatus" header="查看标示" width="15%" sortable="false"/>
		<next:Column field="inOutStatus" header="导入导出标识" width="15%" sortable="false"/>
		<next:Column field="currentStatus" header="当前标识" width="15%" sortable="false"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ensureToClientDataSet"/>
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>