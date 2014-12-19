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
<script type="text/javascript">
	var companyId='<%=request.getParameter("companyId")%>';
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="jcmPeopleInfoDataSet" cmd="com.inspur.cams.jcm.cmd.JcmPeopleInfoQueryCmd" pageSize="200">
		<model:record fromBean="com.inspur.cams.jcm.data.JcmPeopleInfo"/>
	</model:dataset>
	<!-- 政治面貌-->
	<model:dataset id="sorgPoliticsDS" autoLoad="true"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_POLITICAL'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>
<next:EditGridPanel id="grid" dataset="jcmPeopleInfoDataSet" width="100%" stripeRows="true" height="99.9%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="select" text="选择" handler="select"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column field="peopleId" header="主键" width="30%" sortable="false" hidden="true"/>
		<next:Column field="companyId" header="单位主键" width="30%" sortable="false" hidden="true"/>
		<next:Column field="peopleName" header="姓名" width="90" sortable="false" align="center"/>
		<next:Column field="peopleBirthday" header="出生年月" width="130" sortable="false" align="center"/>
		<next:Column field="peoplePolitics" header="政治面貌" width="130" sortable="false" dataset="sorgPoliticsDS"/>
		<next:Column field="jobStartTime" header="参加工作时间" width="130" sortable="false"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="jcmPeopleInfoDataSet"/>
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>