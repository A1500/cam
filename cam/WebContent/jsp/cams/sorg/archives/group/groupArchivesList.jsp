<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="java.net.URLDecoder" %>
<%@page import="org.loushang.next.data.ParameterSet"%>
<html>
<head>
<%
	
	String searchSorgCode=request.getParameter("searchSorgCode");
	if(searchSorgCode == null){
		searchSorgCode = "";
	}
	String searchTaskCode=(String)request.getParameter("searchTaskCode");
	if(searchTaskCode == null){
		searchTaskCode = "";
	}
	String searchCnName=(String)request.getParameter("searchCnName");
	if(searchCnName == null){
		searchCnName = "";
	}else{
		searchCnName = URLDecoder.decode((String)searchCnName, "UTF-8");
	}
%>	
<script type="text/javascript">
	var searchTaskCode='<%=searchTaskCode%>';
	var searchSorgCode='<%=searchSorgCode%>';
	var searchCnName='<%=searchCnName%>';
</script>
<title>社会团体归档列表</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="groupArchivesList.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
</head>
<body>
<model:datasets>
	<model:dataset id="somOrganDataset" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" method="queryOrganWithAreaCodeSearchCondition" pageSize="15">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan"></model:record>
	</model:dataset>
	<!-- 社会组织状态 -->
	<model:dataset id="sorgStatusSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SORG_STATUS'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 所属行（事）业 -->
	<model:dataset id="busScopeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BUS_SCOPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>	
	<!-- 业务主管单位 -->
	<model:dataset id="businessOrganSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_BUSINESS_ORGAN'></model:param>
			<model:param name="value" value='BORG_CODE'></model:param>
			<model:param name="text" value='BORG_NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="yesornoDataSet" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
</model:datasets>

<next:Panel width="100%" border="0">
	<next:Html>
	<fieldset style="overflow:visible;" class="GroupBox">
	<legend class="GroupBoxTitle">查询条件</legend>
		<form class="L5form">
			<table border="1" width="100%">
				<tr>
					<td class="FieldLabel" style="width:15%">社会团体名称：</td>
					<td class="FieldInput" style="width:25%"><input type="text" id="cnName" style="width:80%"/></td>
					<td class="FieldLabel" style="width:15%">登记证号：</td>
					<td class="FieldInput" style="width:25%"><input type="text" id="sorgCode" style="width:80%"/></td>
					<td class="FieldInput" style="width:25%">
						<button onclick="queryItem()">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;
						<button type="reset">重 置</button>
					</td>
				</tr>
			</table>
		</form>
	</fieldset>
	</next:Html>
</next:Panel>
<next:EditGridPanel title="社会组织列表" id="organGrid" dataset="somOrganDataset" height="99.9%"  >
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="add" text="材料归档" handler="archives"></next:ToolBarItem>
		</next:TopBar>
		<next:Columns>
			<next:RowNumberColumn/>
			<next:RadioBoxColumn></next:RadioBoxColumn>
			<next:Column header="社会组织内码" field="sorgId" sortable="true" editable="false" width="15%" hidden="true"><next:TextField />	</next:Column>
			<next:Column header="社会组织名称"  field="cnName" sortable="true" editable="false" width="20%"><next:TextField></next:TextField></next:Column>
			<next:Column header="登记证号" field="sorgCode" sortable="true" editable="false" width="10%"><next:TextField/></next:Column>
			<next:Column header="是否为分支" field="ifBranch" sortable="true" dataset="yesornoDataSet" width="10%" editable="false"><next:TextField /></next:Column>
			<next:Column header="社会组织状态" field="sorgStatus" sortable="true" editable="false" width="12%" dataset="sorgStatusSelect"><next:TextField/></next:Column>
			<next:Column header="所属行(事)业" field="busScope" sortable="true" editable="false" width="12%" dataset="busScopeSelect"><next:TextField /></next:Column>
			<next:Column header="业务主管单位" field="borgName" sortable="true" editable="false"  width="20%" dataset="businessOrganSelect"><next:TextField /></next:Column>
			<next:Column header="登记管理机关" field="morgName" sortable="true" editable="false" width="20%"><next:TextField /></next:Column>
			<next:Column header="住所" field="residence" sortable="true" editable="false" width="20%"><next:TextField /></next:Column>
			<next:Column header="活动地域" field="actArea" sortable="true" editable="false" width="20%"><next:TextField /></next:Column>
			<next:Column header="法定代表人" field="legalPeople" sortable="true" editable="false" width="10%"><next:TextField /></next:Column>
			<next:Column header="社会组织电话" field="sorgPhone" sortable="true" editable="false" width="15%"><next:TextField />	</next:Column>
		</next:Columns> 
		<next:BottomBar>
			<next:PagingToolBar dataset="somOrganDataset" />
		</next:BottomBar>
	</next:EditGridPanel>
</body>
</html>