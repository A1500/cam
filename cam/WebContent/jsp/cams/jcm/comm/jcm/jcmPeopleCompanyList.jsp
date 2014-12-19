<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>人员工作单位信息（多条记录过程）列表</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="jcmPeopleCompanyList.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
</head>
<body>
<model:datasets>
	<model:dataset id="jcmPeopleCompanyDataSet" cmd="com.inspur.cams.jcm.cmd.JcmPeopleCompanyQueryCmd" pageSize="200">
		<model:record fromBean="com.inspur.cams.jcm.data.JcmPeopleCompany"/>
	</model:dataset>
</model:datasets>
<next:Panel width="100%" border="0">
	<next:Html>
	<fieldset style="overflow:visible;" class="GroupBox">
	<legend class="GroupBoxTitle">查询条件</legend>
		<form class="L5form">
			<table border="1" width="100%">
				<tr>
					<td class="FieldButton" style="width:20%"><button onclick="query()">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;<button type="reset">重置</button></td>
				</tr>
			</table>
		</form>
	</fieldset>
	</next:Html>
</next:Panel>
<next:EditGridPanel id="grid" dataset="jcmPeopleCompanyDataSet" width="100%" stripeRows="true" height="99.9%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="add" text="增加" handler="insert"></next:ToolBarItem>
		<next:ToolBarItem iconCls="edit" text="修改" handler="update"></next:ToolBarItem>
		<next:ToolBarItem iconCls="detail" text="明细" handler="detail"></next:ToolBarItem>
		<next:ToolBarItem iconCls="delete" text="删除" handler="del"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column field="peopleCompanyId" header="人员工作单位主键" width="30%" sortable="false"/>
		<next:Column field="peopleId" header="人员主键" width="30%" sortable="false"/>
		<next:Column field="companyId" header="单位主键" width="30%" sortable="false"/>
		<next:Column field="peopleDepartment" header="部门" width="30%" sortable="false"/>
		<next:Column field="companyDuty" header="职务" width="30%" sortable="false"/>
		<next:Column field="jobTitle" header="职称" width="30%" sortable="false"/>
		<next:Column field="roomsNum" header="房间号" width="30%" sortable="false"/>
		<next:Column field="establishment" header="人员编制性质" width="30%" sortable="false"/>
		<next:Column field="dutyTime" header="任职时间" width="30%" sortable="false"/>
		<next:Column field="jobStatus" header="岗位状态" width="30%" sortable="false"/>
		<next:Column field="molible" header="手机" width="30%" sortable="false"/>
		<next:Column field="phone" header="联系电话" width="30%" sortable="false"/>
		<next:Column field="qualification" header="专业资格" width="30%" sortable="false"/>
		<next:Column field="rpRecord" header="奖惩记录" width="30%" sortable="false"/>
		<next:Column field="changeTime" header="变更时间" width="30%" sortable="false"/>
		<next:Column field="dutyNum" header="任职文号" width="30%" sortable="false"/>
		<next:Column field="dutyStatus" header="任职状态" width="30%" sortable="false"/>
		<next:Column field="dutySection" header="人员所属部门" width="30%" sortable="false"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="jcmPeopleCompanyDataSet"/>
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>