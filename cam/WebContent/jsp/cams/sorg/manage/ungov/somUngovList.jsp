<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next" %>
<%@ taglib uri="/tags/next-model" prefix="model" %>
<%@ page import="org.loushang.next.skin.SkinUtils;"%>
<html>
<head>
<title>民办非企业单位列表</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="somUngovList.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
</head>
<body>

<%--定义dataset--%>
<model:datasets>
	<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.manage.cmd.SomUngovOrganQueryCmd" method="queryOrgan">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan"></model:record>
	</model:dataset>
	
	<model:dataset id="sorgStatusSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SORG_STATUS'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="sorgKindSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_UNGOV_KIND'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>	

<%--定义界面--%>
<next:Panel  width="100%" border="0" >	
	<next:Html>			
	<fieldset style="overflow: visible;" class="GroupBox">
		<legend class="GroupBoxTitle">查询条件</legend>
		<form class="L5form">
				<table  border="1" width="100%">
					<tr>
						<td class="FieldLabel" style="width:15%"><label>登记证号：</label></td>
						<td class="FieldInput" style="width:40%"><input type="text" id="sorgCode" style="width:100%"/></td>
						<td class="FieldLabel" style="width:15%"><label>单位状态：</label></td>
						<td class="FieldInput" style="width:20%">
							<select id="sorgStatus" style="width:100%">
								<option dataset="sorgStatusSelect"></option>
							</select>
						</td>
						<td class="FieldButton" style="width:10%"><button onclick="queryItem()" >查询</button> </td>
					</tr>
					<tr>
						<td class="FieldLabel"><label>单位名称：</label></td>
						<td class="FieldInput"><input type="text" id="cnName" style="width:100%"/></td>
						<td class="FieldLabel"><label>民非企业类别：</label></td>
						<td class="FieldInput">
							<select id="sorgKind" style="width:100%">
								<option dataset="sorgKindSelect"></option>
							</select>
						</td>
						<td class="FieldButton"><button onclick="reset()" >重置</button> </td>
					</tr>
				</table>
		</form>
	</fieldset>
	</next:Html>
</next:Panel>	
<next:EditGridPanel id="grid" dataset="somOrganDataSet" width="100%" stripeRows="true" height="99.9%">
	<next:TopBar>
		<next:ToolBarItem symbol="民办非企业单位列表"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="add" text="录入" handler="insert"></next:ToolBarItem>
		<next:ToolBarItem iconCls="edit" text="修改" handler="update"></next:ToolBarItem>
		<next:ToolBarItem iconCls="remove" text="注销" handler="cancel"></next:ToolBarItem>
		<next:ToolBarItem iconCls="delete" text="撤销" handler="repeal"></next:ToolBarItem>
		<next:ToolBarItem iconCls="detail" text="明细查看" handler="detail"></next:ToolBarItem>
		
	</next:TopBar>
	
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column field="sorgCode" header="登记证号" width="22%" sortable="true"></next:Column>
		<next:Column field="cnName" header="单位名称" width="35%" sortable="true"></next:Column>
		<next:Column field="sorgKind" header="民非企业类别" dataset="sorgKindSelect" width="12%" sortable="true"></next:Column>
		<next:Column field="sorgStatus" header="单位状态" width="13%" sortable="true" dataset="sorgStatusSelect"></next:Column>
		<next:Column field="morgName" header="登记管理机关" width="18%" sortable="true"></next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="somOrganDataSet" />
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>