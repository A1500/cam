<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>基金会负责人备案管理</title>
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
<script type="text/javascript" src="fundManagePeopleList.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
</head>
<body>

<model:datasets>
	<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan"/>
	</model:dataset>
	<model:dataset id="somSessionQueryDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomSessionQueryCmd" global="true"  sortField="CREATE_TIME" sortDirection="DESC">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomSession"></model:record>
	</model:dataset>
	<model:dataset id="yesornoDataSet" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:TabPanel id="tab" activeTab="0" width="100%"  height="100%">
	<next:Tabs>
			<next:Panel title="办理新的备案" width="100%" height="100%">
				<next:Panel width="100%" border="0" >
					<next:Html>
					<fieldset style="overflow:visible;" class="GroupBox">
					<legend class="GroupBoxTitle">查询条件</legend>
						<form class="L5form" onkeydown="EnterKeyDown('queryItem()','13')">
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
				<next:GridPanel id="grid" dataset="somOrganDataSet" width="100%" stripeRows="true" height="99.9%">
					<next:TopBar>
						<next:ToolBarItem iconCls="detail" text="查看当前届次负责人信息" handler="detail"></next:ToolBarItem>
						<next:ToolBarItem iconCls="detail" text="查看历史届次负责人信息" handler="his"></next:ToolBarItem>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						<next:ToolBarItem iconCls="add" text="换届备案" handler="manage"></next:ToolBarItem>
						
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn></next:RowNumberColumn>
						<next:CheckBoxColumn></next:CheckBoxColumn>
						<next:Column field="sorgId" header="社会组织内码" width="20%" hidden="true" sortable="false"></next:Column>
						<next:Column field="cnName" header="基金会名称" width="30%" sortable="false"></next:Column>
						<next:Column field="sorgCode" header="登记证号" width="15%" sortable="false"></next:Column>
						<next:Column field="ifBranch" header="是否分支机构" width="15%" sortable="false" editable="false"><next:ComboBox dataset="yesornoDataSet"/></next:Column>
						<next:Column field="morgName" header="登记管理机关" width="30%" sortable="false"></next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="somOrganDataSet"/>
					</next:BottomBar>
				</next:GridPanel>
				</next:Panel>
			<next:Panel title="办理过的备案信息" width="100%" height="100%">
				<next:EditGridPanel id="grid2" dataset="somSessionQueryDataSet" width="100%" stripeRows="true" height="99.9%">
					<next:TopBar>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						<next:ToolBarItem iconCls="detail" text="查看" handler="hisDetail"></next:ToolBarItem>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn></next:RowNumberColumn>
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column field="sessionName" header="社会团体名称" width="30%" sortable="false"></next:Column>
						<next:Column field="seq" header="社会团体登记证号" width="30%" sortable="false"></next:Column>
						<next:Column field="morgName" header="受理单位名称" width="30%" sortable="false"></next:Column>
						<next:Column field="createPeople" header="受理人" width="18%" sortable="false"></next:Column>
						<next:Column field="createTime" header="受理时间" width="20%" sortable="false"></next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="somSessionQueryDataSet"/>
					</next:BottomBar>
				</next:EditGridPanel>
			</next:Panel>
	</next:Tabs>
</next:TabPanel>
</body>
</html>