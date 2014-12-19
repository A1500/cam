<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>单位信息明细</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="jcmCompanyProfile.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var companyId='<%=request.getParameter("companyId")%>';
</script>
</head>
<body>
<model:datasets>
	<!-- 单位信息 -->
	<model:dataset id="jcmCompanyProfileDataSet" cmd="com.inspur.cams.jcm.cmd.JcmCompanyProfileQueryCmd" pageSize="200">
		<model:record fromBean="com.inspur.cams.jcm.data.JcmCompanyProfile"/>
	</model:dataset>
	<!-- 工作资金 -->
	<model:dataset id="jcmCompanyMoneyDataSet" cmd="com.inspur.cams.jcm.cmd.JcmCompanyMoneyQueryCmd" method="queryinfo" pageSize="200">
		<model:record fromBean="com.inspur.cams.jcm.data.JcmCompanyMoney"/>
	</model:dataset>
	<!-- 办公设备 -->
	<model:dataset id="jcmOfficeEquipmentDataSet" cmd="com.inspur.cams.jcm.cmd.JcmOfficeEquipmentQueryCmd"  pageSize="200">
		<model:record fromBean="com.inspur.cams.jcm.data.JcmOfficeEquipment"/>
	</model:dataset>
	<!-- 字典表的引用 办公设备 -->
	<model:dataset id="typeDS1" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value="DIC_JCM_DETAILS"></model:param>        <!-- 需要查询的表 -->
			<model:param name="value" value="CODE"></model:param>     <!-- 查询的内容 -->
			<model:param name="text" value="NAME"></model:param>    <!-- 输出查询的结果 -->
			<model:param name="filterSql" value='DIC_TYPE=003'></model:param>
		</model:params>
	</model:dataset>
	<!-- 工作经费类型 -->
	<model:dataset id="moneyDS1" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value="DIC_JCM_DETAILS"></model:param>        <!-- 需要查询的表 -->
			<model:param name="value" value="CODE"></model:param>     <!-- 查询的内容 -->
			<model:param name="text" value="NAME"></model:param>    <!-- 输出查询的结果 -->
			<model:param name="filterSql" value='DIC_TYPE=002'></model:param>
		</model:params>

	</model:dataset>
	<!-- 单位所属业务类别 -->
	<model:dataset id="comDS1" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value="DIC_JCM_DETAILS"></model:param>        <!-- 需要查询的表 -->
			<model:param name="value" value="CODE"></model:param>     <!-- 查询的内容 -->
			<model:param name="text" value="NAME"></model:param>    <!-- 输出查询的结果 -->
			<model:param name="filterSql" value='DIC_TYPE=001'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>
<next:Panel width="100%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="jcmCompanyProfileDataSet" onsubmit="return false" class="L5form">
<fieldset>
	<legend>单位信息</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:12%">单位名称：</td>
			<td class="FieldInput" style="width:13%"><label field="companyName"/></td>
			<td class="FieldLabel" style="width:12%">单位性质：</td>
			<td class="FieldInput" style="width:13%"><label field="companyNature"/></td>
			<td class="FieldLabel" style="width:12%">批准文号：</td>
			<td class="FieldInput" style="width:13%"><label field="companyNo"/></td>
			<td class="FieldLabel" style="width:12%">法人：</td>
			<td class="FieldInput" style="width:13%"><label field="companyPeopleName"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:12%">住所：</td>
			<td class="FieldInput" style="width:13%"><label field="companyAdress"/></td>
			<td class="FieldLabel" style="width:12%">邮编：</td>
			<td class="FieldInput" style="width:13%"><label field="companyPostCode"/></td>
			<td class="FieldLabel" style="width:12%">从业人数：</td>
			<td class="FieldInput" style="width:13%"><label field="companyJobNum"/></td>
			<td class="FieldLabel" style="width:12%">编制人数：</td>
			<td class="FieldInput" style="width:13%"><label field="companyEstNum"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:12%">联系电话：</td>
			<td class="FieldInput" style="width:13%"><label field="companyPhone"/></td>
			<td class="FieldLabel" style="width:12%">主管部门名称：</td>
			<td class="FieldInput" style="width:13%"><label field="companyBorgName"/></td>
			<td class="FieldLabel" style="width:12%">单位所属业务类别：</td>
			<td class="FieldInput" style="width:13%"><label field="companyType" dataSet="comDS1"/></td>
			<td class="FieldLabel" style="width:12%">固定总资产：</td>
			<td class="FieldInput" style="width:13%"><label field="companyMon"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:12%">状态：</td>
			<td class="FieldInput" style="width:13%"><label field="companyStatus"/></td>
			<td class="FieldLabel" style="width:12%">建筑面积：</td>
			<td class="FieldInput" style="width:13%"><label field="grossArea"/></td>
			<td class="FieldLabel" style="width:12%">办公地址：</td>
			<td class="FieldInput" style="width:13%"><label field="officeAdress"/></td>
			<td class="FieldLabel" style="width:12%">房间间数：</td>
			<td class="FieldInput" style="width:13%"><label field="roomsNum"/></td>
		</tr>
	</table>
</fieldset>
<fieldset>
	<legend>负责人信息</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:12%">负责人姓名：</td>
			<td class="FieldInput" style="width:13%"><label field="principalName"/></td>
			<td class="FieldLabel" style="width:12%">负责人职务：</td>
			<td class="FieldInput" style="width:13%"><label field="principalDuty"/></td>
			<td class="FieldLabel" style="width:12%">负责人移动电话：</td>
			<td class="FieldInput" style="width:13%"><label field="principalMobile"/></td>
			<td class="FieldLabel" style="width:12%">负责人办公电话：</td>
			<td class="FieldInput" style="width:13%"><label field="principalPhone"/></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
<next:Panel title="工作经费信息" width="100%" height="100%">
<next:EditGridPanel id="grid" dataset="jcmCompanyMoneyDataSet" width="100%" stripeRows="true" height="99.9%">
	<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="return" text="年度经费统计图" handler="showP"/>
</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column field="companyId" header="单位主键" width="130" sortable="false" hidden="true"/>
		<next:Column field="companyMoneyId" header="工作经费主键" width="130" sortable="false" hidden="true"/>
		<next:Column field="year" header="年度" width="130" sortable="false"/>
		<next:Column field="moneyType" header="工作经费类别" width="130" sortable="false" dataset="moneyDS1"/>
		<next:Column field="moneyCost" header="工作经费金额" width="130" sortable="false"/>
		<next:Column field="note" header="备注" width="330" sortable="false"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="jcmCompanyMoneyDataSet"/>
	</next:BottomBar>
</next:EditGridPanel>
</next:Panel>
<next:Panel title="办公设备信息" width="100%" height="100%">
<next:EditGridPanel id="gridE" dataset="jcmOfficeEquipmentDataSet" width="100%" stripeRows="true" height="99.9%">
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column field="officeId" header="主键" width="130" sortable="false" hidden="true"/>
		<next:Column field="companyId" header="单位主键" width="130" sortable="false" hidden="true"/>
		<next:Column field="deviceType" header="设备类型" width="130" sortable="false" dataset="typeDS1"/>
		<next:Column field="deviceNum" header="设备个数" width="130" sortable="false"/>
		<next:Column field="buyYear" header="购买年份" width="130" sortable="false"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="jcmOfficeEquipmentDataSet"/>
	</next:BottomBar>
</next:EditGridPanel>
</next:Panel>
</body>
</html>