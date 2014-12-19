<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>人员基本信息列表</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="jcmPeopleInfoList.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
</head>
<body>
<model:datasets>
	<model:dataset id="jcmPeopleInfoDataSet" cmd="com.inspur.cams.jcm.cmd.JcmPeopleInfoQueryCmd" pageSize="200">
		<model:record fromBean="com.inspur.cams.jcm.data.JcmPeopleInfo"/>
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
<next:EditGridPanel id="grid" dataset="jcmPeopleInfoDataSet" width="100%" stripeRows="true" height="99.9%">
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
		<next:Column field="peopleId" header="主键" width="30%" sortable="false"/>
		<next:Column field="companyId" header="单位主键" width="30%" sortable="false"/>
		<next:Column field="photoId" header="人员照片ＩＤ" width="30%" sortable="false"/>
		<next:Column field="peopleName" header="姓名" width="30%" sortable="false"/>
		<next:Column field="peopleSex" header="性别" width="30%" sortable="false"/>
		<next:Column field="peopleCard" header="身份证号" width="30%" sortable="false"/>
		<next:Column field="peopleBirthday" header="出生年月" width="30%" sortable="false"/>
		<next:Column field="peoplePolitics" header="政治面貌" width="30%" sortable="false"/>
		<next:Column field="peopleNation" header="民族" width="30%" sortable="false"/>
		<next:Column field="peopleEdu" header="学历" width="30%" sortable="false"/>
		<next:Column field="peopleSchool" header="毕业院校" width="30%" sortable="false"/>
		<next:Column field="peopleAdress" header="家庭住址" width="30%" sortable="false"/>
		<next:Column field="jobStartTime" header="参加工作时间" width="30%" sortable="false"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="jcmPeopleInfoDataSet"/>
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>