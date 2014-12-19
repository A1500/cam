<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next" %>
<%@ taglib uri="/tags/next-model" prefix="model" %>
<%@ page import="com.inspur.cams.comm.util.StrUtil,org.loushang.next.skin.SkinUtils;"%>
<html>
<head>
<title>社团分支/代表列表</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="somGroupBranchList.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var mainSorgId = '<%=StrUtil.n2b(request.getParameter("mainSorgId"))%>';
</script>
</head>
<body>

<%--定义dataset--%>
<model:datasets>
	<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" method="queryBranch">
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
</model:datasets>	

<%--定义界面--%>
<next:Panel  width="100%" border="0" >	
	<next:Html>			
	<fieldset style="overflow: visible;" class="GroupBox">
		<legend class="GroupBoxTitle">查询条件</legend>
		<form class="L5form">
				<table  border="1" width="100%">
					<tr>
						<td class="FieldLabel" style="width:15%"><label>机构登记证号：</label></td>
						<td class="FieldInput" style="width:40%"><input type="text" id="sorgCode" style="width:100%"/></td>
						<td class="FieldLabel" style="width:15%"><label>机构状态：</label></td>
						<td class="FieldInput" style="width:20%">
							<select id="sorgStatus" style="width:100%">
								<option dataset="sorgStatusSelect"></option>
							</select>
						</td>
						<td class="FieldButton" style="width:10%"><button onclick="queryItem()" >查询</button> </td>
					</tr>
					<tr>
						<td class="FieldLabel"><label>机构名称：</label></td>
						<td class="FieldInput"><input type="text" id="cnName" style="width:100%"/></td>
						<td class="FieldLabel"><label>登记管理机关：</label></td>
						<td class="FieldInput"><input type="text" id="morgName" style="width:100%"/></td>
						<td class="FieldButton"><button onclick="reset()" >重置</button> </td>
					</tr>
				</table>
		</form>
	</fieldset>
	</next:Html>
</next:Panel>	
<next:EditGridPanel id="grid" dataset="somOrganDataSet" width="100%" stripeRows="true" height="99.9%">
	<next:TopBar>
		<next:ToolBarItem symbol="社团分支/代表列表"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="add" text="录入" handler="insert"></next:ToolBarItem>
		<next:ToolBarItem iconCls="edit" text="修改" handler="update"></next:ToolBarItem>
		<next:ToolBarItem iconCls="remove" text="注销" handler="cancel"></next:ToolBarItem>
		<next:ToolBarItem iconCls="delete" text="撤销" handler="repeal"></next:ToolBarItem>
		<next:ToolBarItem iconCls="detail" text="查询社团主体" handler="sorgMain"></next:ToolBarItem>
		<next:ToolBarItem iconCls="detail" text="明细查看" handler="detail"></next:ToolBarItem>
		
	</next:TopBar>
	
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column field="sorgCode" header="机构登记证号" width="22%" sortable="true"></next:Column>
		<next:Column field="cnName" header="分支/代表机构名称" width="25%" sortable="true"></next:Column>
		<next:Column field="sorgStatus" header="机构状态" width="13%" sortable="true" dataset="sorgStatusSelect"></next:Column>
		<next:Column field="name" header="社团主体名称" width="25%"></next:Column>
		<next:Column field="morgName" header="登记管理机关" width="15%" sortable="true"></next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="somOrganDataSet" />
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>