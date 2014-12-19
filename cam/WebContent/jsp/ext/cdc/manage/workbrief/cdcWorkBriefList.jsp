<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>工作简报</title>
<next:ScriptManager/>
<script type="text/javascript" src="cdcWorkBriefList.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<jsp:include page="../util/cdcOrgan.jsp" flush="true"/>
</head>
<body>
<model:datasets>
	<model:dataset id="cdcWorkInfoDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcWorkInfoQueryCmd" method="queryList" pageSize="20">
	</model:dataset>
	<model:dataset id="workBreifDataSet" enumName="CDC.WORK_BREIF_TYPE" autoLoad="true" global="true"/>
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
			<table border="1" width="100%" id = "sqcx">
				<tr>
					<td class="FieldLabel" style="width:10%">主题：</td>
					<td class="FieldInput" style="width:12%"><input type="text" id="name"/></td>
					<td class="FieldLabel" style="width:10%">上报日期：</td>
					<td class="FieldInput" style="width:12%"><input type="text" id="reportDate" format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly" /></td>
					<td class="FieldInput" colspan="2" ><button onclick="query()">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;<button type="reset">重置</button></td>
				</tr>
			</table>
			<table border="1" width="100%" id = "jdcx" style="display: none;">
				<tr>
					<td class="FieldLabel" style="width:10%">主题：</td>
					<td class="FieldInput" style="width:12%"><input type="text" id="name"/></td>
					<td class="FieldLabel" style="width:10%">上报日期：</td>
					<td class="FieldInput" style="width:12%"><input type="text" id="reportDate" format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly" /></td>
					<td class="FieldLabel" style="width:10%">填写单位：</td>
					<td class="FieldInput" style="width:20%" ><select id = "SQdomicileCode"><option dataset = "OrgCodeDataset"></option> </select> </td>
					<td class="FieldInput" ><button onclick="query()">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;<button type="reset">重置</button></td>
					<td class="FieldInput"  ><button onclick="selfQuery()" >本单位查询</button></td>
				</tr>
			</table>
			<table border="1" width="100%" id = "qtcx" style="display: none;">
				<tr>
					<td class="FieldLabel" style="width:10%">主题：</td>
					<td class="FieldInput" style="width:12%"><input type="text" id="name"/></td>
					<td class="FieldLabel" style="width:10%">上报日期：</td>
					<td class="FieldInput" style="width:12%"><input type="text" id="reportDate" format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly" /></td>
					<td class="FieldLabel" style="width:10%">填写单位：</td>
					<td class="FieldInput" style="width:20%"> <input type="text" id="domicileName" onclick="func_ForDomicileSelect()" style="width: 99%" readonly="readonly"/>
					<input type="hidden" id="domicileCode"/><input type="hidden" id="leve"/></td>
					<td class="FieldInput" ><button onclick="query()">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;<button type="reset">重置</button></td>
					<td class="FieldInput" ><button onclick="selfQuery()" >本单位查询</button></td>
				</tr>
			</table>
		</form>
	</fieldset>
	</next:Html>
</next:Panel>
<next:EditGridPanel id="grid" dataset="cdcWorkInfoDataSet" width="100%" stripeRows="true" height="99.9%" >
	<next:TopBar>
		<next:ToolBarItem symbol="->"/>
		<next:ToolBarItem iconCls="add" text="增加" handler="insert"/>
		<next:ToolBarItem iconCls="edit" text="修改" handler="update"/>
		<next:ToolBarItem iconCls="delete" text="删除" handler="del"/>
		<next:ToolBarItem iconCls="detail" text="明细" handler="detail"/>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn/>
		<next:RadioBoxColumn/>
		<next:Column field="NAME" header="主题" width="30%" sortable="false"/>
		<next:Column field="REPORTDATE" header="上报日期" width="10%" sortable="true" align="center"/>
		<next:Column field="ORGANNAME" header="填写单位" width="20%" sortable="true"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="cdcWorkInfoDataSet"/>
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>