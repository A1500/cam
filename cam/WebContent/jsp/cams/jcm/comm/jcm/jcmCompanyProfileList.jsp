<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>单位信息列表</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="jcmCompanyProfileList.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
</head>
<body>
<model:datasets>
	<model:dataset id="jcmCompanyProfileDataSet" cmd="com.inspur.cams.jcm.cmd.JcmCompanyProfileQueryCmd" pageSize="200">
		<model:record fromBean="com.inspur.cams.jcm.data.JcmCompanyProfile"/>
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
<next:EditGridPanel id="grid" dataset="jcmCompanyProfileDataSet" width="100%" stripeRows="true" height="99.9%">
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
		<next:Column field="companyId" header="主键" width="30%" sortable="false"/>
		<next:Column field="companyCode" header="组织机构代码" width="30%" sortable="false"/>
		<next:Column field="companyName" header="单位名称" width="30%" sortable="false"/>
		<next:Column field="companyNature" header="单位性质" width="30%" sortable="false"/>
		<next:Column field="companyPeopleName" header="法人" width="30%" sortable="false"/>
		<next:Column field="companyNo" header="批准文号" width="30%" sortable="false"/>
		<next:Column field="companyAdress" header="住所" width="30%" sortable="false"/>
		<next:Column field="companyPostCode" header="邮编" width="30%" sortable="false"/>
		<next:Column field="companyJobNum" header="从业人数" width="30%" sortable="false"/>
		<next:Column field="companyEstNum" header="编制人数" width="30%" sortable="false"/>
		<next:Column field="companyPhone" header="联系电话" width="30%" sortable="false"/>
		<next:Column field="companyBorgName" header="主管部门名称" width="30%" sortable="false"/>
		<next:Column field="companyType" header="单位所属业务类别" width="30%" sortable="false"/>
		<next:Column field="companyMon" header="固定总资产" width="30%" sortable="false"/>
		<next:Column field="companyStatus" header="状态" width="30%" sortable="false"/>
		<next:Column field="grossArea" header="建筑面积" width="30%" sortable="false"/>
		<next:Column field="officeAdress" header="办公地址" width="30%" sortable="false"/>
		<next:Column field="roomsNum" header="房间间数" width="30%" sortable="false"/>
		<next:Column field="principalName" header="负责人姓名" width="30%" sortable="false"/>
		<next:Column field="principalDuty" header="负责人职务" width="30%" sortable="false"/>
		<next:Column field="principalMobile" header="负责人移动电话" width="30%" sortable="false"/>
		<next:Column field="principalPhone" header="负责人办公电话" width="30%" sortable="false"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="jcmCompanyProfileDataSet"/>
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>