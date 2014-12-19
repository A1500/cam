<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>基金会组织机构代码备案列表</title>
<next:ScriptManager></next:ScriptManager>
<%	
	String searchCnName=(String)request.getParameter("searchCnName");
	if(searchCnName == null){
		searchCnName = "";
	}else{
		searchCnName = URLDecoder.decode((String)searchCnName, "UTF-8");
	}
	String searchSorgCode=request.getParameter("searchSorgCode");
	if(searchSorgCode == null){
		searchSorgCode = "";
	}
%>	
<script type="text/javascript">
	var searchCnName='<%=searchCnName%>';
	var searchSorgCode='<%=searchSorgCode%>';
	<%
		String morgArea=BspUtil.getOrganCode();
		String peopleName=BspUtil.getEmpOrgan().getOrganName();
	%>
	var morgArea='<%=morgArea%>';
	var peopleName='<%=peopleName%>';
</script>
<script type="text/javascript" src="fundOrganCodeList.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
</head>
<body>
<model:datasets>
	<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan"/>
	</model:dataset>
	<model:dataset id="somOrganCodeDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganCodeQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrganCode">
		</model:record>
	</model:dataset>
	<model:dataset id="yesornoDataSet" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:TabPanel id="tab" activeTab="0" width="100%"  height="100%">
	<next:Tabs>
		<next:Panel title="办理新的备案" width="100%" height="100%">
			<next:Panel width="100%" border="0">
				<next:Html>
				<fieldset style="overflow:visible;" class="GroupBox">
				<legend class="GroupBoxTitle">查询条件</legend>
					<form class="L5form">
						<table border="1" width="100%">
							<tr>
								<td class="FieldLabel" style="width:15%">基金会名称：</td>
								<td class="FieldInput" style="width:25%"><input type="text" id="cnName" style="width:80%"/></td>
								<td class="FieldLabel" style="width:15%">登记证号：</td>
								<td class="FieldInput" style="width:25%"><input type="text" id="sorgCode" style="width:80%"/></td>
								<td class="FieldButton" style="width:20%">
									<button onclick="queryItem()">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;
									<button type="reset">重置</button>
								</td>
							</tr>
						</table>
					</form>
				</fieldset>
				</next:Html>
			</next:Panel>
			<next:EditGridPanel id="grid" dataset="somOrganDataSet" width="100%" stripeRows="true" height="99.9%">
				<next:TopBar>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>
					<next:ToolBarItem iconCls="add" text="备案" handler="insert"></next:ToolBarItem>
					<next:ToolBarItem iconCls="detail" text="查看明细" handler="detail"></next:ToolBarItem>
				</next:TopBar>
				<next:Columns>
					<next:RowNumberColumn></next:RowNumberColumn>
					<next:RadioBoxColumn></next:RadioBoxColumn>
					<next:Column field="cnName" header="基金会名称" width="30%" sortable="false"></next:Column>
					<next:Column field="sorgCode" header="登记证号" width="15%" sortable="false"></next:Column>
					<next:Column field="ifBranch" header="是否分支机构" width="15%" sortable="false" editable="false"><next:ComboBox dataset="yesornoDataSet"/></next:Column>
					<next:Column field="morgName" header="登记管理机关" width="30%" sortable="false"></next:Column>
				</next:Columns>
				<next:BottomBar>
					<next:PagingToolBar dataset="somOrganDataSet"/>
				</next:BottomBar>
			</next:EditGridPanel>
			</next:Panel>
			<next:Panel title="办理过的组织机构代码备案" width="100%" height="100%">
				<next:EditGridPanel id="grid2" dataset="somOrganCodeDataSet" width="100%" stripeRows="true" height="99.9%">
					<next:TopBar>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						<next:ToolBarItem iconCls="detail" text="查看" handler="detailHis"></next:ToolBarItem>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn></next:RowNumberColumn>
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column field="organCode" header="基金会名称" width="30%" sortable="false"></next:Column>
						<next:Column field="regPeople" header="基金会登记证号" width="30%" sortable="false"></next:Column>
						<next:Column field="morgName" header="受理单位名称" width="30%" sortable="false"></next:Column>
						<next:Column field="createPeople" header="受理人" width="18%" sortable="false"></next:Column>
						<next:Column field="createTime" header="受理时间" width="20%" sortable="false"></next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="somOrganCodeDataSet"/>
					</next:BottomBar>
				</next:EditGridPanel>
			</next:Panel>
	</next:Tabs>
</next:TabPanel>
</body>
</html>