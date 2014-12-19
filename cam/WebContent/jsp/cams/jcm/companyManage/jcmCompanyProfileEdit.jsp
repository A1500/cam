<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="com.inspur.cams.comm.util.IdHelp"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>单位信息编辑</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="jcmCompanyProfile.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var companyId='<%=request.getParameter("companyId")%>';
	var organCode = '<%=BspUtil.getOrganCode()%>';
	var organName = '<%=BspUtil.getOrganName()%>';
	var organType= '<%=request.getParameter("organType")%>';
	var newCompanyId = '<%=IdHelp.getUUID32()%>';
</script>
</head>
<body>
<model:datasets>
	<!-- 单位信息 -->
	<model:dataset id="jcmCompanyProfileDataSet" cmd="com.inspur.cams.jcm.cmd.JcmCompanyProfileQueryCmd" pageSize="200" global="true">
		<model:record fromBean="com.inspur.cams.jcm.data.JcmCompanyProfile"/>
	</model:dataset>
	<!-- 办公设备 -->
	<model:dataset id="jcmOfficeEquipmentDataSet" cmd="com.inspur.cams.jcm.cmd.JcmOfficeEquipmentQueryCmd" pageSize="200">
		<model:record fromBean="com.inspur.cams.jcm.data.JcmOfficeEquipment"/>
	</model:dataset>
	<!-- 工作经费 -->
	<model:dataset id="jcmCompanyMoneyDataSet" cmd="com.inspur.cams.jcm.cmd.JcmCompanyMoneyQueryCmd" pageSize="200">
		<model:record fromBean="com.inspur.cams.jcm.data.JcmCompanyMoney"/>
	</model:dataset>
	<!-- 办公设备 -->
	<model:dataset id="jcmOfficeEquipmentDataSet" cmd="com.inspur.cams.jcm.cmd.JcmOfficeEquipmentQueryCmd" pageSize="200">
		<model:record fromBean="com.inspur.cams.jcm.data.JcmOfficeEquipment">
		</model:record>
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
<next:Panel width="100%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"/>
		<next:ToolBarItem iconCls="save" text="保存" handler="save"/>
		<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
	</next:TopBar>
	<next:TabPanel id="tabPanel" width="100%" height="100%">
	<next:Tabs>
		<next:Panel id="frofile" title="单位基本信息" width="100%" height="100%" autoScroll="true">
			<next:Html>
			<form id="form1" method="post" dataset="jcmCompanyProfileDataSet" onsubmit="return false" class="L5form">
			<fieldset>
			<legend>单位信息</legend>
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width:10%">单位名称：</td>
					<td class="FieldInput" style="width:16%"><input type="text" name="单位名称" id="companyName" field="companyName" maxlength="50" style="width:90%"/></td>
					<td class="FieldLabel" style="width:10%">单位性质：</td>
					<td class="FieldInput" style="width:16%"><input type="text" name="单位性质" id="companyNature" field="companyNature" maxlength="50" style="width:90%"/></td>
					<td class="FieldLabel" style="width:10%">批准文号：</td>
					<td class="FieldInput" style="width:16%"><input type="text" name="批准文号" id="companyNo" field="companyNo" maxlength="50" style="width:90%"/></td>
					<td class="FieldLabel" style="width:10%">法人：</td>
					<td class="FieldInput" style="width:16%"><input type="text" name="法人" id="companyPeopleName" field="companyPeopleName" maxlength="50" style="width:90%"/></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width:10%">住所：</td>
					<td class="FieldInput" style="width:16%"><input type="text" name="住所" id="companyAdress" field="companyAdress" maxlength="50" style="width:90%"/></td>
					<td class="FieldLabel" style="width:10%">邮编：</td>
					<td class="FieldInput" style="width:16%"><input type="text" name="邮编" id="companyPostCode" field="companyPostCode" maxlength="50" style="width:90%"/></td>
					<td class="FieldLabel" style="width:10%">从业人数：</td>
					<td class="FieldInput" style="width:16%"><input type="text" name="从业人数" id="companyJobNum" field="companyJobNum" maxlength="50" style="width:90%"/></td>
					<td class="FieldLabel" style="width:10%">编制人数：</td>
					<td class="FieldInput" style="width:16%"><input type="text" name="编制人数" id="companyEstNum" field="companyEstNum" maxlength="50" style="width:90%"/></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width:10%">联系电话：</td>
					<td class="FieldInput" style="width:16%"><input type="text" name="联系电话" id="companyPhone" field="companyPhone" maxlength="50" style="width:90%"/></td>
					<td class="FieldLabel" style="width:10%">主管部门名称：</td>
					<td class="FieldInput" style="width:16%"><input type="text" name="主管部门名称" id="companyBorgName" field="companyBorgName" maxlength="50" style="width:90%"/></td>
					<td class="FieldLabel" style="width:10%">单位所属业务类别：</td>
					<td class="FieldInput" style="width:16%"><select type="text" id="companyType"
											class="TextEditor" title="companyType" field="companyType"/>
											<option dataset="comDS1"/>
										</select></td>
					<td class="FieldLabel" style="width:10%">固定总资产：</td>
					<td class="FieldInput" style="width:16%"><input type="text" name="固定总资产" id="companyMon" field="companyMon" maxlength="50" style="width:90%"/></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width:10%">状态：</td>
					<td class="FieldInput" style="width:16%"><input type="text" name="状态" id="companyStatus" field="companyStatus" maxlength="50" style="width:90%"/></td>
					<td class="FieldLabel" style="width:10%">建筑面积：</td>
					<td class="FieldInput" style="width:16%"><input type="text" name="建筑面积" id="grossArea" field="grossArea" maxlength="50" style="width:90%"/></td>
					<td class="FieldLabel" style="width:10%">办公地址：</td>
					<td class="FieldInput" style="width:16%"><input type="text" name="办公地址" id="officeAdress" field="officeAdress" maxlength="50" style="width:90%"/></td>
					<td class="FieldLabel" style="width:10%">房间间数：</td>
					<td class="FieldInput" style="width:16%"><input type="text" name="房间间数" id="roomsNum" field="roomsNum" maxlength="50" style="width:90%"/></td>
				</tr>
				</table>
			</fieldset>
			<fieldset>	
				<legend>负责人信息</legend>
				<table width="100%">
				<tr>
					<td class="FieldLabel" style="width:10%">负责人姓名：</td>
					<td class="FieldInput" style="width:16%"><input type="text" onclick="selectPep()" name="负责人姓名" id="principalName" field="principalName" maxlength="50" style="width:90%"/></td>
					<td class="FieldLabel" style="width:10%">负责人职务：</td>
					<td class="FieldInput" style="width:16%"><input type="text" name="负责人职务" id="principalDuty" field="principalDuty" maxlength="50" style="width:90%"/></td>
					<td class="FieldLabel" style="width:10%">负责人移动电话：</td>
					<td class="FieldInput" style="width:16%"><input type="text" name="负责人移动电话" id="principalMobile" field="principalMobile" maxlength="50" style="width:90%"/></td>
					<td class="FieldLabel" style="width:10%">负责人办公电话：</td>
					<td class="FieldInput" style="width:16%"><input type="text" name="负责人办公电话" id="principalPhone" field="principalPhone" maxlength="50" style="width:90%"/></td>
				</tr>
			</table>
		</fieldset>
		</form>
	</next:Html>
</next:Panel>
<next:EditGridPanel title="工作经费信息" id="gridMoney" dataset="jcmCompanyMoneyDataSet" width="100%" stripeRows="true" height="99.9%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="add" text="增加" handler="addMoney"></next:ToolBarItem>
		<next:ToolBarItem iconCls="delete" text="删除" handler="removeMoney"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column field="companyId" header="单位主键" width="30%" sortable="false" hidden="true">
			<next:TextField></next:TextField>
		</next:Column>
		<next:Column field="companyMoneyId" header="工作经费主键" width="30%" sortable="false" hidden="true">
			<next:TextField></next:TextField>
		</next:Column>
		<next:Column field="year" header="年度" width="130" sortable="false">
			<next:DateField  format="Y" ></next:DateField>
		</next:Column>
		<next:Column field="moneyType" header="工作经费类别" width="130" sortable="false">
			<next:ComboBox dataset="moneyDS1" valueField="value" displayField="text"></next:ComboBox>
		</next:Column>
		<next:Column field="moneyCost" header="工作经费金额(元)" width="130" sortable="false">
			<next:TextField></next:TextField>
		</next:Column>
		<next:Column field="note" header="备注" width="380" sortable="false">
			<next:TextField></next:TextField>
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="jcmCompanyMoneyDataSet"/>
	</next:BottomBar>
</next:EditGridPanel>
<next:EditGridPanel title="办公设备信息" id="gridEquipment" dataset="jcmOfficeEquipmentDataSet" width="100%" stripeRows="true" height="99.9%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="add" text="增加" handler="insertE"></next:ToolBarItem>
		<next:ToolBarItem iconCls="delete" text="删除" handler="delE"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column field="officeId" header="主键" width="30%" sortable="false" hidden="true">
			<next:TextField></next:TextField>
		</next:Column>
		<next:Column field="companyId" header="单位主键" width="30%" sortable="false" hidden="true">
			<next:TextField></next:TextField>
		</next:Column>
		<next:Column id="deviceType" field="deviceType" header="设备类型" width="130"  sortable="false">
			<next:ComboBox triggerAction="all"  valueField="value" displayField="text"  dataset="typeDS1"/>
		</next:Column>
		<next:Column field="deviceNum" header="设备个数" width="130" sortable="false">
			<next:TextField></next:TextField>
		</next:Column>
		<next:Column field="buyYear" header="购买年份" width="130" sortable="false">
			<next:DateField  format="Y-m-d" ></next:DateField>
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="jcmOfficeEquipmentDataSet"/>
	</next:BottomBar>
</next:EditGridPanel>
<next:Panel id="policyInfo" title="政策法规信息" width="100%" height="100%" autoScroll="true">
	<next:Html>
	
	
	</next:Html>
</next:Panel>
	</next:Tabs>
</next:TabPanel>
</next:Panel>
</body>
</html>