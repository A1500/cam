<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>单位信息列表</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="jcmCompanyList.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var organcode='<%=request.getParameter("organcode")%>';
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="jcmCompanyProfileDataSet" cmd="com.inspur.cams.jcm.cmd.JcmCompanyProfileQueryCmd" pageSize="200">
		<model:record fromBean="com.inspur.cams.jcm.data.JcmCompanyProfile"/>
	</model:dataset>
</model:datasets>
<next:EditGridPanel id="grid" dataset="jcmCompanyProfileDataSet" width="100%" stripeRows="true" height="99.9%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="select" text="选择" handler="select"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column field="companyId" header="主键" width="30%" sortable="false" hidden="true"/>
		<next:Column field="companyName" header="单位名称" width="30%" sortable="false"/>
		<next:Column field="companyPeopleName" header="法人" width="30%" sortable="false"/>
		<next:Column field="companyType" header="单位所属业务类别" width="30%" sortable="false"/>
		<next:Column field="officeAdress" header="办公地址" width="30%" sortable="false"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="jcmCompanyProfileDataSet"/>
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>