<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>供养对象入出院信息列表</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="samInOutInfoManager.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
</head>
<body>
<model:datasets>
	<model:dataset id="samGeroKeptPersonDataSet" cmd="com.inspur.cams.drel.samu.cmd.SamGeroKeptPersonQueryCmd" autoLoad="true" pageSize="200">
		<model:record fromBean="com.inspur.cams.drel.samu.data.SamGeroKeptPerson"/>
	</model:dataset>
	<!-- yes or no -->
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO"
		autoLoad="true" global="true"></model:dataset>
	<!-- 性别 -->
	<model:dataset id="sex" enumName="COMM.SEX"
		autoLoad="true" global="true"></model:dataset>
	<!-- 民族 -->
	<model:dataset id="nation" autoLoad="true"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 政治面貌-->
	<model:dataset id="DmZzmmDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_POLITICAL'></model:param>
		</model:params>
	</model:dataset>
	<!-- 出院原因 -->
	<model:dataset id="reason" enumName="SAM_REASON"
		autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel width="100%" border="0">
	<next:Html>
	<fieldset style="overflow:visible;" class="GroupBox">
	<legend class="GroupBoxTitle">查询条件</legend>
		<form class="L5form">
			<table border="1" width="100%">
				<tr>
					<td class="FieldLabel" style="width:10%">敬老院名称</td>
					<td class="FieldInput" style="width:20%"><input type="text" id="gerocomiumName" style="width:80%"/>
					<td class="FieldLabel" style="width:10%">姓名</td>
					<td class="FieldInput" style="width:20%"><input type="text" id="personName" style="width:80%" />
					<td class="FieldLabel" style="width:10%">身份证号</td>
					<td class="FieldInput" style="width:20%"><input type="text" id="idCard" style="width:80%" />
				</tr>
				<tr>
					<td class="FieldLabel" style="width:10%">所在房间</td>
					<td class="FieldInput" style="width:20%"><input type="text" id="inRoom" style="width:80%"/>
					<td class="FieldLabel" style="width:10%">所在床位</td>
					<td class="FieldInput" style="width:20%"><input type="text" id="inBed" style="width:80%"/>
					<td class="FieldLabel" style="width:10%"></td>
					<td class="FieldButton" style="width:20%"><button onclick="query()">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;<button type="reset">重置</button></td>
				</tr>
			</table>
		</form>
	</fieldset>
	</next:Html>
</next:Panel>
<next:EditGridPanel id="grid" dataset="samGeroKeptPersonDataSet" width="100%" stripeRows="true" height="99.9%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="add" text="入院" handler="insert"></next:ToolBarItem>
		<next:ToolBarItem iconCls="edit" text="修改"></next:ToolBarItem>
		<next:ToolBarItem iconCls="delete" text="出院" handler="outGero"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column field="gerocomiumId" header="敬老院ID"  sortable="false"/>
		<next:Column field="personName" header="姓名"  sortable="false"/>
		<next:Column field="sex" header="性别"  sortable="false" dataset="sex"/>
		<next:Column field="idCard" header="身份证号"  sortable="false"/>
		<next:Column field="birthday" header="出生日期"  sortable="false"/>
		<next:Column field="nation" header="民族"  sortable="false" dataset="nation"/>
		<next:Column field="politicsStatus" header="政治面貌"  sortable="false" dataset="DmZzmmDataSet"/>
		<next:Column field="familyAdd" header="家庭住址"  sortable="false"/>
		<next:Column field="ifArchive" header="是否已建健康档案"  sortable="false" dataset="comm_yesorno"/>
		<next:Column field="inRoom" header="所在房间"  sortable="false"/>
		<next:Column field="inBed" header="所用床位"  sortable="false"/>
		<next:Column field="isStatus" header="在院状态"  sortable="false" dataset="comm_yesorno"/>
		<next:Column field="inoutDate" header="入/出院时间"  sortable="false"/>
		<next:Column field="reason" header="出院原因"  sortable="false" dataset="reason"/>
		<next:Column field="updatePerson" header="更新人"  sortable="false"/>
		<next:Column field="updateDate" header="更新时间"  sortable="false"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="samGeroKeptPersonDataSet"/>
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>