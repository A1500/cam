<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next" %>
<%@ taglib uri="/tags/next-model" prefix="model" %>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>基金会分支/代表机构列表</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="fundBranchQueryList.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
var struId='<%=BspUtil.getStruId()%>';
var rootPath="<%=SkinUtils.getRootUrl(request)%>";	
</script>
</head>
<body>

<%--定义dataset--%>
<model:datasets>
	<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" method="totalQueryBranch">
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
					<td class="FieldLabel" style="width:15%"><label>基金会名称：</label></td>
					<td class="FieldInput" style="width:20%"><input type="text" id="m_cnName" style="width:100%"/></td>						
					<td class="FieldLabel" style="width:15%"><label>基金会登记证号：</label></td>
					<td class="FieldInput" style="width:20%"><input type="text" id="m_sorgCode" style="width:100%"/></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label>分支/代表机构名称：</label></td>
					<td class="FieldInput"><input type="text" id="cnName" style="width:100%"/></td>
					<td class="FieldLabel" style="width:15%"><label>分支/代表机构登记证号：</label></td>
					<td class="FieldInput" style="width:20%"><input type="text" id="sorgCode" style="width:100%"/></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label>登记管理机关：</label></td>
					<td class="FieldInput">
						<input type="text" style="width:80%"  id="morgName" readonly />
						<input type="text" style="display: none;"  id="morgArea" />
						<img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>"  style="cursor:hand" onclick="forHelp()" />
					</td>
					<td class="FieldLabel" style="width:15%"><label>分支/代表机构状态：</label></td>
					<td class="FieldInput" style="width:20%">
						<select id="sorgStatus" style="width:100%">
							<option dataset="sorgStatusSelect"></option>
						</select>
					</td>
				</tr>
				<tr>
					<td colspan="4" align="right" style="width:10%">
						<button onclick="queryItem()" >查询</button>
						&nbsp;&nbsp;<button onclick="reset()" >重置</button>
					</td>
				</tr>
			</table>
		</form>
	</fieldset>
	</next:Html>
</next:Panel>	
<next:EditGridPanel id="grid" dataset="somOrganDataSet" width="100%" stripeRows="true" height="99.9%">
	<next:TopBar>
		<next:ToolBarItem symbol="基金会分支/代表机构列表"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="detail" text="明细查看" handler="detail"></next:ToolBarItem>		
	</next:TopBar>	
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column field="SORG_ID" header="分支/代表机构社会组织Id" hidden="true"></next:Column>
		<next:Column field="SORG_CODE" header="分支/代表机构登记证号" width="22%" sortable="false"></next:Column>
		<next:Column field="CN_NAME" header="分支/代表机构名称" width="25%" sortable="false"></next:Column>
		<next:Column field="SORG_STATUS" header="分支/代表机构状态" width="13%" sortable="false" dataset="sorgStatusSelect"></next:Column>
		<next:Column field="M_CN_NAME" header="基金会名称" width="25%"></next:Column>
		<next:Column field="M_MORG_NAME" header="登记管理机关" width="15%" sortable="false"></next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="somOrganDataSet" />
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>