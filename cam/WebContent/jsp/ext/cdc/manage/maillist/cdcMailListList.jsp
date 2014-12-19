<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>基层政权与社区建设通讯录</title>
<next:ScriptManager/>
<script type="text/javascript" src="cdcMailListList.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<jsp:include page="../util/cdcOrgan.jsp" flush="true"/>
</head>
<body>
<model:datasets>
	<model:dataset id="cdcMailListDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcMailListQueryCmd" method="queryList" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcMailList"/>
	</model:dataset>
	<!-- 行政区划 -->
	<model:dataset id="OrgCodeDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="false">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='COM_EXT_USER'></model:param>
			<model:param name="value" value='AREA_CODE'></model:param>
			<model:param name="text" value='AREA_NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="sexDataSet" enumName="COMM.SEX" autoLoad="true" global="true"/>
</model:datasets>
<next:Panel width="100%" border="0">
	<next:Html>
	<fieldset style="overflow:visible;" class="GroupBox">
	<legend class="GroupBoxTitle">查询条件</legend>
		<form class="L5form">
			<table border="1" width="100%" id ="sq">
				<tr>
					<td class="FieldLabel" style="width:10%">姓名：</td>
					<td class="FieldInput" style="width:12%"><input type="text" id="name"/></td>
					<td class="FieldLabel" style="width:10%">单位：</td>
					<td class="FieldInput" style="width:12%"><input type="text" id="organ"/></td>
					<td class="FieldLabel" style="width:10%">部门：</td>
					<td class="FieldInput" style="width:12%"><input type="text" id="dept"/></td>
					<td class="FieldLabel" style="width:10%;text-align: center"><button onclick="query()">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;<button type="reset">重置</button></td>
				</tr>
			</table>
			<table border="1" width="100%" id = "other">
				<tr>
					<td class="FieldLabel" style="width:10%">姓名：</td>
					<td class="FieldInput" style="width:12%"><input type="text" id="name"/></td>
					<td class="FieldLabel" style="width:10%">单位：</td>
					<td class="FieldInput" style="width:12%"><input type="text" id="organ"/></td>
					<td class="FieldLabel" style="width:10%;text-align: center"><button id ="Queryself" onclick="selfQuery()">本单位查询</button></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width:10%">部门：</td>
					<td class="FieldInput" style="width:12%"><input type="text" id="dept"/></td>
					<td class="FieldLabel" style="width:10%"id = "xzqh1">填写单位：</td>
					<td class="FieldInput" style="width:12%" id = "xzqh2"> <input type="text" id="domicileName" onclick="func_ForDomicileSelect()" readonly="readonly"/>
					<input type="hidden" id="domicileCode"/><input type="hidden" id="leve"/></td>
					<td class="FieldInput" style="width:12%" id = "xzqh4"><select id = "SQdomicileCode"><option dataset = "OrgCodeDataset"></option> </select> </td>
					<td class="FieldLabel" style="width:10%;text-align: center"><button onclick="query()">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;<button type="reset">重置</button></td>
				</tr>
			</table>
		</form>
	</fieldset>
	</next:Html>
</next:Panel>
<next:EditGridPanel id="grid" dataset="cdcMailListDataSet" width="100%" stripeRows="true" height="99.9%">
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
		<next:Column field="NAME" header="姓名" width="10%" sortable="false"/>
		<next:Column field="SEX" header="性别" width="5%" editable="true" sortable="false" align="center"><next:ComboBox dataset="sexDataSet"/></next:Column>
		<next:Column field="ORGAN" header="单位" width="20%" sortable="true"/>
		<next:Column field="DEPT" header="部门" width="13%" sortable="false"/>
		<next:Column field="DUTY" header="职务" width="10%" sortable="false"/>
		<next:Column field="MOBLEPHONE" header="手机" width="15%" sortable="false"/>
		<next:Column field="PHONE" header="办公电话" width="15%" sortable="false"/>
		<next:Column field="POSTADDS" header="通讯地址" width="30%" sortable="false"/>
		<next:Column field="ORGANNAME" header="填写单位" width="10%" sortable="true"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="cdcMailListDataSet"/>
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>