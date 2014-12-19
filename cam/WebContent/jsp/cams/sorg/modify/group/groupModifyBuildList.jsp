<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.sorg.util.ApplyType"%>
<html>
<head>
<title>社会团体数据修订列表</title>
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
<script type="text/javascript" src="groupModifyBuildList.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript">
	<%
		String morgArea=BspUtil.getOrganCode();
	%>
	var morgArea='<%=morgArea%>';
	var searchCnName='<%=searchCnName%>';
	var searchSorgCode='<%=searchSorgCode%>';
</script>
</head>
<body>

<model:datasets>
	<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan"/>
	</model:dataset>
	<model:dataset id="yesornoDataSet" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
</model:datasets>

<next:Panel width="100%" border="0">
	<next:Html>
		<form class="L5form">
	<fieldset style="overflow:visible;" class="GroupBox">
	<legend class="GroupBoxTitle">查询条件</legend>
			<table border="1" width="100%">
				<tr>
					<td class="FieldLabel" style="width:15%">社团名称：</td>
					<td class="FieldInput" style="width:25%"><input type="text" id="cnName" style="width:80%"/></td>
					<td class="FieldLabel" style="width:15%">登记证号：</td>
					<td class="FieldInput" style="width:25%"><input type="text" id="sorgCode" style="width:80%"/></td>
					<td class="FieldButton" style="width:20%">
						<button onclick="queryItem()">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;
						<button type="reset">重置</button>
					</td>
				</tr>
			</table>
	</fieldset>
		</form>
	</next:Html>
</next:Panel>
<next:EditGridPanel id="grid" dataset="somOrganDataSet" width="100%" stripeRows="true" height="99.9%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="edit" text="修改" handler="update"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column field="sorgId" header="sorgId" width="30%" sortable="false" hidden="true"></next:Column>
		<next:Column field="cnName" header="社会团体名称" width="30%" sortable="false"></next:Column>
		<next:Column field="sorgCode" header="登记证号" width="30%" sortable="false"></next:Column>
		<next:Column field="ifBranch" header="是否为分支" width="18%" sortable="false" hidden="true"></next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="somOrganDataSet"/>
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>