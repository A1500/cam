<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>经营性公墓信息</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script>
		var idField='<%=request.getParameter("dataBean")%>';
		var method='<%=request.getParameter("method")%>';
</script>
<script type="text/javascript" src="../ep.js"></script>
<script type="text/javascript" src="cemeProfitInformationDetails.js"></script>
</head>
<body>

<model:datasets>
	<!--公墓基本信息-->
	<model:dataset id="ds"
		cmd="com.inspur.cams.fis.ep.base.cmd.FisCemeQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.fis.ep.base.data.FisCeme">
		</model:record>
	</model:dataset>
	<!--公墓审批事项-->
	<model:dataset id="itemDs"
		cmd="com.inspur.cams.fis.ep.base.cmd.FisCemeItemsCmd" global="true"
		pageSize="-1">
		<model:record fromBean="com.inspur.cams.fis.ep.base.data.FisCemeItems">
		</model:record>
	</model:dataset>
	<!--政府部门批准文号-->
	<model:dataset id="govAppDs"
		cmd="com.inspur.cams.fis.ep.base.cmd.FisCemeGovApprovalCmd"
		global="true" pageSize="-1">
		<model:record
			fromBean="com.inspur.cams.fis.ep.base.data.FisCemeGovApproval">
		</model:record>
	</model:dataset>
	<!--土地证-->
	<model:dataset id="landcardDs"
		cmd="com.inspur.cams.fis.ep.base.cmd.FisCemeLandcardCmd" global="true"
		pageSize="-1">
		<model:record
			fromBean="com.inspur.cams.fis.ep.base.data.FisCemeLandcard">
		</model:record>
	</model:dataset>

	<!--公墓审批事项类型-->
	<model:dataset id="itemTypeDs" enumName="FIS.CEME.ITEMS"
		autoLoad="true" global="true"></model:dataset>
	<!--公墓建立时需要审批的政府部门-->
	<model:dataset id="govDeptDs" enumName="FIS.CEME.GOV.DEPARTMENT"
		autoLoad="true" global="true"></model:dataset>
	<!--单位性质-->
	<model:dataset id="unitPropertiesDataSet"
		enumName="FIS.CEME.UNITPROPERTIES" autoLoad="true" global="true"></model:dataset>
	<!--公墓性质-->
	<model:dataset id="propDataSet" enumName="FIS.CEME.PROP"
		autoLoad="true" global="true"></model:dataset>
	<!--计量单位-->
	<model:dataset id="AreaUnitsDataSet" enumName="FIS.CEME.AREAUNITS"
		autoLoad="true" global="true"></model:dataset>
	<!--土地证-占地性质-->
	<model:dataset id="landPropDataSet" enumName="FIS.CEME.LANDPROP"
		autoLoad="true" global="true"></model:dataset>
	<!--土地证-土地用途-->
	<model:dataset id="landUseDataSet" enumName="FIS.CEME.LANDUSE"
		autoLoad="true" global="true"></model:dataset>
	<!--土地证-土地使用形式-->
	<model:dataset id="landUseFormDataSet" enumName="FIS.CEME.LANDUSEFORM"
		autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel autoHeight="true" autoScroll="true" autoWidth="true">
	<next:Panel autoHeight="true" autoWidth="true" autoScroll="false">
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="print" text="打印" handler="print"
				id="printBtn" />
			<next:ToolBarItem iconCls="return" text="返回" handler="back"
				id="return" hidden="true"/>
			<next:ToolBarItem iconCls="detail" text="补录说明" handler="detail"
				hidden="true" />
		</next:TopBar>
		<next:Html>
			<form id="editForm" method="post" dataset="ds"
				onsubmit="return false" class="L5form">
			<fieldset><legend>单位信息</legend>
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width: 20%">公墓名称</td>
					<td class="FieldInput"><label id="cemeName" name="公墓名称"
						field="cemeName" title="补录公墓的全称" 
						style="width: 200px;" /></td>
					<td class="FieldLabel">主管单位</td>
					<td class="FieldInput"><label name="主管单位" id="manaLevel"
						field="manaLevel" readonly="readonly" /> <input type="text"
						id="manaLevelId" field="manaLevelId" style="display: none;" /></td>
				</tr>
				<tr>
					<td class="FieldLabel">单位性质</td>
					<td class="FieldInput"><label name="单位性质" id="unitProperties"
						field="unitProperties" dataset="unitPropertiesDataSet"/></td>
					<td class="FieldLabel" style="width: 20%">公墓编号</td>
					<td class="FieldInput" style="width: 31%"><label id="cemeId"
						name="公墓编号" field="cemeId"
						title="省厅民政部门授予的组织编码，全省唯一\n请按主管单位的批准时间录入公墓信息"/></td>
				</tr>
				<tr>
					<td class="FieldLabel">主办/联办单位</td>
					<td class="FieldInput"><label name="主办单位" field="organizer"
						style="width: 200px;" />
					<td class="FieldLabel">公墓性质</td>
					<td class="FieldInput"><label title="公墓性质">经营性</label> <input
						type="hidden" name="prop" field="prop" title="公墓性质"></input></td>
				</tr>
				<tr>
					<td class="FieldLabel">法人代表</td>
					<td class="FieldInput"><label name="法人代表" field="legalPerson"/></td>
					<td class="FieldLabel">职工总数</td>
					<td class="FieldInput"><label name="职工总数" id="totalStaff"
						field="totalStaff" renderer="renRender"/></td>
				</tr>
				<tr>
					<td class="FieldLabel">公墓负责人手机</td>
					<td class="FieldInput"><label name="公墓负责人手机" id="directorMobile"
						field="directorMobile" /></td>
					<td class="FieldLabel">联系电话</td>
					<td class="FieldInput"><label name="联系电话" field="officePhone"
						id="officePhone" /></td>
				</tr>
				<tr>
					<td class="FieldLabel">固定资产</td>
					<td class="FieldInput"><label name="固定资产" renderer="wanRender"
						style="text-align: right" field="fixeDassets" id="fixeDassets"/></td>
					<td class="FieldLabel">总投资额</td>
					<td class="FieldInput"><label name="总投资额" renderer="wanRender"
						style="text-align: right" field="totalInvestment"
						id="totalInvestment"/></td>
				</tr>
				<tr>
					<td class="FieldLabel">正式营业时间</td>
					<td class="FieldInput"><label name="正式营业时间"
						field="gestionTime" /></td>
					<td class="FieldLabel">邮编</td>
					<td class="FieldInput"><label name="邮政编码" field="postalcode"
						id="postalcode" /></td>
				</tr>
				<tr>
					<td class="FieldLabel">公墓占地面积</td>
					<td class="FieldInput"><label style="text-align: right" renderer="muRender"
						name="占地总面积" field="totalArea" id="totalArea"/><!--
					&nbsp; <select name="公墓占地面积计量单位" id="totalAreaUnits"
						field="totalAreaUnits" style="width: 60px">
						<option dataset="AreaUnitsDataSet"></option>
					</select>--></td>
					<td class="FieldLabel">墓区建成面积</td>
					<td class="FieldInput"><label style="text-align: right" renderer="muRender"
						name="墓区建成面积" field="builtArea" id="builtArea"/><!--
					&nbsp; <select name="墓区建成面积计量单位" id="builtAreaUnits"
						field="builtAreaUnits" style="width: 60px">
						<option dataset="AreaUnitsDataSet"></option>
					</select>
					--></td>
				</tr>
				<tr>
					<td class="FieldLabel">建筑面积</td>
					<td class="FieldInput"><label style="text-align: right" renderer="aRender"
						name="建筑总面积" field="builtTotalArea" id="builtTotalArea"/></td>
					<td class="FieldLabel">所属行政区</td>
					<td class="FieldInput"><label name="所属行政区"
						id="areaLevel" field="areaLevel" /></td>
				</tr>
				<tr>
					<td class="FieldLabel">公墓所在位置</td>
					<td class="FieldInput" colspan="3"><label name="公墓所在位置" field="address"
						style="width: 300px" /></td>
				</tr>
				<tr>
					<td class="FieldLabel">服务范围</td>
					<td class="FieldInput" colspan="5"><textarea
						rows="3" name='服务范围' field="serviceScope"
						style="width: 90%" readonly="readonly"></textarea></td>
				</tr>
			</table>
			</fieldset>
			</form>
		</next:Html>
	</next:Panel>
	<next:Panel height="300" autoWidth="true" >
		<next:TabPanel id="tabpanel" name="tabpanel-div" autoWidth="true">
			<next:Tabs>
				<next:GridPanel title="历史记录" id="itemGridPanel" name="itemGridPanel"
					stripeRows="true" height="300" dataset="itemDs" width="98%" 
					notSelectFirstRow="true">
					<next:Columns>
						<next:Column id="itemId" header="编号" field="itemId"
							sortable="false" hidden="true">
							<next:TextField />
						</next:Column>
						<next:Column id="itemDic" header="事项" field="itemDic"
							width="160" sortable="false">
							<next:ComboBox triggerAction="all" dataset="itemTypeDs"
								typeAble="false"></next:ComboBox>
						</next:Column>
						<next:Column id="itemTime" header="批准时间" field="itemTime"
							width="110" sortable="false">
							<next:DateField allowBlank="false" format="Y-m-d" />
						</next:Column>
						<next:Column id="itemLabel" header="简述" field="itemLabel"
							width="220" sortable="false">
							<next:TextField />
						</next:Column>
						<next:Column id="itemDesc" header="详细描述" field="itemDesc" width="50%"
							sortable="false">
							<next:TextField />
						</next:Column>
					</next:Columns>
				</next:GridPanel>
				
				<next:GridPanel title="土地证信息" id="landcardPanel"
					name="landcardPanel" stripeRows="true" height="300"
					dataset="landcardDs" notSelectFirstRow="true" width="98%" >
					<next:Columns>
						<next:Column id="itemId" header="事项" field="itemId" width="200"
							sortable="false" renderer="backValue">
							<next:ComboBox triggerAction="all" dataset="itemDs" mode="local"
								typeAble="false" displayField="itemLabel" valueField="itemId">
							</next:ComboBox>
						</next:Column>
						<next:Column id="landNum" header="土地证件号" field="landNum"
							width="180" sortable="false">
							<next:TextField />
						</next:Column>
						<next:Column id="landUse" header="土地用途" field="landUse"
							width="80" sortable="false">
							<next:ComboBox triggerAction="all" dataset="landUseDataSet"
								typeAble="false"></next:ComboBox>
						</next:Column>
						<next:Column id="landUseForm" header="土地使用形式" field="landUseForm"
							width="90" sortable="false">
							<next:ComboBox triggerAction="all" dataset="landUseFormDataSet"
								typeAble="false"></next:ComboBox>
						</next:Column>
						<next:Column id="landProp" header="土地使用权人" field="landProp"
							width="90" sortable="false">
							<next:ComboBox triggerAction="all" dataset="landPropDataSet"
								typeAble="false"></next:ComboBox>
						</next:Column>
						<next:Column id="landArea" header="土地面积(㎡)" field="landArea"
							width="90" sortable="false">
							<next:NumberField allowBlank="true" />
						</next:Column>
						<next:Column id="useAge" header="使用年限(年)" field="useAge"
							width="90" sortable="false">
							<next:NumberField allowBlank="true" />
						</next:Column>
					</next:Columns>
				</next:GridPanel>

				<next:GridPanel title="政府部门批准文号" id="govAppGridPanel"
					name="govAppGridPanel" stripeRows="true" height="300"
					dataset="govAppDs" notSelectFirstRow="true" width="98%" >
					<next:Columns>
						<next:Column id="itemId" header="事项" field="itemId" width="220"
							sortable="false" renderer="backValue">
							<next:ComboBox triggerAction="all" dataset="itemDs" mode="local"
								typeAble="false" displayField="itemLabel" valueField="itemId">
							</next:ComboBox>
						</next:Column>
						<next:Column id="deptId" header="文号类型" field="deptId" width="160"
							sortable="false">
							<next:ComboBox triggerAction="all" dataset="govDeptDs"
								typeAble="false"></next:ComboBox>
						</next:Column>
						<next:Column id="deptNum" header="批准文号" field="deptNum"
							width="200" sortable="false">
							<next:TextField />
						</next:Column>
						<next:Column id="deptTime" header="批准时间" field="deptTime"
							sortable="false">
							<next:DateField allowBlank="false" format="Y-m-d" />
						</next:Column>
					</next:Columns>
				</next:GridPanel>
			</next:Tabs>
		</next:TabPanel>
	</next:Panel>
</next:Panel>
</body>
</html>
