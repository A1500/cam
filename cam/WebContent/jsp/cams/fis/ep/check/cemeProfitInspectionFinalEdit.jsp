<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.IdHelp"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>经营性公墓年检表单</title>
<next:ScriptManager />
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="../ep.js"></script>
<script type="text/javascript" src="cemeProfitInspectionFinalEdit.js"></script>
<script>
		var cemeId = '<%=request.getParameter("cemeId")%>';
		var wfId = '<%=request.getParameter("wfId")%>';
		var isEdit = '<%=request.getParameter("isEdit")%>';
		var endApplyId = '<%=request.getParameter("endApplyId")%>';
		var newWfId = '<%=IdHelp.getUUID32()%>';
		var newApplyId = '<%=IdHelp.getUUID32()%>';
		var newAuditId = '<%=IdHelp.getUUID32()%>';
		var newScoreId = '<%=IdHelp.getUUID32()%>';
		var newResultId = '<%=IdHelp.getUUID32()%>';
		var checkYear = '<%=request.getParameter("checkYear")%>';
		var checkNumber = '<%=request.getParameter("checkNum")%>';
		var orgCode ='<%=BspUtil.getCorpOrgan().getOrganCode()%>';
		var orgName ='<%=BspUtil.getCorpOrgan().getOrganName()%>';
</script>
</head>
<body>
<model:datasets>
<!--公墓基本信息-->
	<model:dataset id="infoDataSet"
		cmd="com.inspur.cams.fis.ep.base.cmd.FisCemeCheckQueryCmd"
		global="true" method="queryForCemeInfo">
		<model:record
			fromBean="com.inspur.cams.fis.ep.base.data.FisCemeCheckInfo">
			<model:field name="directorMobile" type="string" rule="require" />
			<model:field name="address" type="string" rule="require" />
			<model:field name="postalcode" type="string" rule="require" />
			<model:field name="totalStaff" type="int" rule="require" />
			<model:field name="officePhone" type="string" rule="require" />
			<model:field name="fixeDassets" type="float" rule="require" />
			<model:field name="totalInvestment" type="float" rule="require" />
			<model:field name="totalArea" type="float" rule="require" />
			<model:field name="builtArea" type="float" rule="require" />
			<model:field name="builtTotalArea" type="float" rule="require" />
			<model:field name="yearHoleNum" type="int" rule="require" />
			<model:field name="sinceHoleNum" type="int" rule="require" />
			<model:field name="singleHole" type="int" rule="require" />
			<model:field name="doubleHole" type="int" rule="require" />
			<model:field name="moreHole" type="int" rule="require" />
			<model:field name="yearSingleHole" type="int" rule="require" />
			<model:field name="yearDoubleHole" type="int" rule="require" />
			<model:field name="yearMoreHole" type="int" rule="require" />
			<model:field name="yearPeopleNum" type="int" rule="require" />
			<model:field name="sincePeopleNum" type="int" rule="require" />
			<model:field name="yearSellNum" type="int" rule="require" />
			<model:field name="sellSingleHole" type="int" rule="require" />
			<model:field name="sellDoubleHole" type="int" rule="require" />
			<model:field name="sellMoreHole" type="int" rule="require" />
			<model:field name="yearOutNum" type="int" rule="require" />
			<model:field name="outSingleHole" type="int" rule="require" />
			<model:field name="outDoubleHole" type="int" rule="require" />
			<model:field name="outMoreHole" type="int" rule="require" />
		</model:record>
	</model:dataset>
	
<!--公墓工作流信息-->
	<model:dataset id="wfDs"
		cmd="com.inspur.cams.fis.ep.base.cmd.FisCemeCheckWfQueryCommand"
		global="true">
		<model:record
			fromBean="com.inspur.cams.fis.ep.base.data.FisCemeCheckWf">
		</model:record>
	</model:dataset>
<!--公墓审批事项-->
	<model:dataset id="itemDs"
		cmd="com.inspur.cams.fis.ep.base.cmd.FisCemeItemsCmd" global="true">
		<model:record fromBean="com.inspur.cams.fis.ep.base.data.FisCemeItems">
		</model:record>
	</model:dataset>
	<!--政府部门批准文号-->
	<model:dataset id="govAppDs"
		cmd="com.inspur.cams.fis.ep.base.cmd.FisCemeGovApprovalCmd"
		global="true">
		<model:record
			fromBean="com.inspur.cams.fis.ep.base.data.FisCemeGovApproval">
		</model:record>
	</model:dataset>
	<!--土地证-->
	<model:dataset id="landcardDs"
		cmd="com.inspur.cams.fis.ep.base.cmd.FisCemeLandcardCmd" global="true">
		<model:record
			fromBean="com.inspur.cams.fis.ep.base.data.FisCemeLandcard">
		</model:record>
	</model:dataset>	
<!--公墓年检结果信息-->
	<model:dataset id="resultDs"
		cmd="com.inspur.cams.fis.ep.base.cmd.FisCemeCheckResultQueryCommand"
		global="true" autoLoad="true">
		<model:record
			fromBean="com.inspur.cams.fis.ep.base.data.FisCemeCheckResult">
		</model:record>
	</model:dataset>

	<model:dataset id="scoreDataSet"
		cmd="com.inspur.cams.fis.ep.base.cmd.FisCemeCheckQueryCmd"
		method="queryScore" global="true">
		<model:record
			fromBean="com.inspur.cams.fis.ep.base.data.FisCemeCheckScore">
			<model:field name="businesscertificateScore" type="int" rule="require" />
			<model:field name="businesslicenseScore" type="int" rule="require" />
			<model:field name="taxcertificateScore" type="int" rule="require" />
			<model:field name="feeScore" type="int" rule="require" />
			<model:field name="purchasegravesScore" type="int" rule="require" />
			<model:field name="pledgeScore" type="int" rule="require" />
			<model:field name="staffresponsibilitiesScore" type="int" rule="require" />
			<model:field name="officeTimeScore" type="int" rule="require" />
			<model:field name="provincialdocumentsScore" type="int" rule="require" />
			<model:field name="departmentchargesScore" type="int" rule="require" />
			<model:field name="nooffenseScore" type="int" rule="require" />
			<model:field name="propergraveScore" type="int" rule="require" />
			<model:field name="boxesandbagsScore" type="int" rule="require" />
			<model:field name="deathcertificateScore" type="int" rule="require" />
			<model:field name="ashescontractScore" type="int" rule="require" />
			<model:field name="contractorssignatureScore" type="int" rule="require" />
			<model:field name="contractoridScore" type="int" rule="require" />
			<model:field name="addcontractScore" type="int" rule="require" />
			<model:field name="othermaterialsScore" type="int" rule="require" />
			<model:field name="tombstoneTwentyScore" type="int" rule="require" />
			<model:field name="tombstoneFiftyScore" type="int" rule="require" />
			<model:field name="tombstoneoverfiftyScore" type="int" rule="require" />
			<model:field name="operatingareaScore" type="int" rule="require" />
			<model:field name="archivesareaScore" type="int" rule="require" />
			<model:field name="officeareaScore" type="int" rule="require" />
			<model:field name="roadsafetyScore" type="int" rule="require" />
			<model:field name="civilizationMemorialScore" type="int" rule="require" />
			<model:field name="fireMemorialScore" type="int" rule="require" />
			<model:field name="ecologyScore" type="int" rule="require" />
			<model:field name="greenCoverageScore" type="int" rule="require" />
			<model:field name="greenareaRatioScore" type="int" rule="require" />
			<model:field name="burialTombScore" type="int" rule="require" />
			<model:field name="burialConformScore" type="int" rule="require" />
			<model:field name="acceptanceComplianceScore" type="int" rule="require" />
			<model:field name="changeComplianceScore" type="int" rule="require" />
			<model:field name="paymentCertificateScore" type="int" rule="require" />
			<model:field name="agenciesScore" type="int" rule="require" />
			<model:field name="businessTrainingScore" type="int" rule="require" />
			<model:field name="systemSoundScore" type="int" rule="require" />
			<model:field name="contingencyPlansScore" type="int" rule="require" />
			<model:field name="informationScore" type="int" rule="require" />
			<model:field name="tombstoneTwentyNum" type="int" rule="require" />
			<model:field name="tombstoneFiftyNum" type="int" rule="require" />
			<model:field name="tombstoneoverfiftyNum" type="int" rule="require" />
			<model:field name="operatingareaNum" type="float" rule="require" />
			<model:field name="archivesareaNum" type="float" rule="require" />
			<model:field name="officeareaNum" type="float" rule="require" />
			<model:field name="ecologyNum" type="float" rule="require" />
			<model:field name="greenCoverageNum" type="float" rule="require" />
			<model:field name="greenareaRatioNum" type="float" rule="require" />
		</model:record>
	</model:dataset>

	<model:dataset id="auditDataSet"
		cmd="com.inspur.cams.fis.ep.base.cmd.FisCemeCheckQueryCmd"
		method="queryAudit" global="true">
		<model:record
			fromBean="com.inspur.cams.fis.ep.base.data.FisCemeCheckAudit">
		</model:record>
	</model:dataset>

	<model:dataset id="accessoriesDataSet"
		cmd="com.inspur.cams.fis.ep.base.cmd.FisCemeCheckQueryCmd"
		method="queryAccessories" global="true">
		<model:record
			fromBean="com.inspur.cams.fis.ep.base.data.FisCemeAccessories">
		</model:record>
	</model:dataset>

	<model:dataset id="accessoriesItemDataSet"
		cmd="com.inspur.cams.fis.ep.base.cmd.FisCemeCheckQueryCmd"
		method="queryAccessoriesItem" global="true">
		<model:record
			fromBean="com.inspur.cams.fis.ep.base.data.FisCemeAccessories"></model:record>
	</model:dataset>
	<model:dataset id="accessoriesType"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CEME_ACCESSORIES_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
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
	<model:dataset id="inspectionDataSet" enumName="FIS.CEME.RESULT"
		autoLoad="true" global="true"></model:dataset>
	<%--
	<model:dataset id="danweixingzhiDataSet"
		enumName="FIS.CEME.UNITPROPERTIES" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="gongmuxingzhiDataSet" enumName="FIS.CEME.PROP"
		autoLoad="true" global="true"></model:dataset>
	<model:dataset id="tudishiyongxsDataSet"
		enumName="FIS.CEME.LANDUSEFORM" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="zhanyongtudiDataSet" enumName="FIS.CEME.LANDPROP"
		autoLoad="true" global="true"></model:dataset>
	<model:dataset id="tudiyongtuDataSet" enumName="FIS.CEME.LANDUSE"
		autoLoad="true" global="true"></model:dataset>
	<model:dataset id="jiliangdanweiDataSet" enumName="FIS.CEME.AREAUNITS"
		autoLoad="true" global="true"></model:dataset>
	--%>
</model:datasets>
<next:ViewPort>
	<next:AnchorLayout>
		<next:Panel width="100%" height="100%">
			<next:TopBar>
				<next:ToolBarItem symbol="经营性公墓年检"></next:ToolBarItem>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="save" text="保存" handler="saveClick" />
				<next:ToolBarItem iconCls="export" text="上报" handler="reportClick" />
				<next:ToolBarItem iconCls="return" text="返回" handler="returnClick" />
			</next:TopBar>

			<next:TabPanel width="100%" height="100%" id="tab">
				<next:Tabs>
					<!-- 公墓基本信息 -->
					<next:Panel title="公墓信息" width="100%" height="100%" id="info"
						autoScroll="true">
						<next:Panel>
						<next:Html>
							<form id="InspectionForm" method="post" dataset="infoDataSet"
								onsubmit="return false" class="L5form">
							<fieldset><legend>公墓基本信息</legend>
							<table width="100%">
								<tr>
									<td class="FieldLabel" style="width: 20%">公墓名称</td>
									<td class="FieldInput"><label  id="cemeName"
										name="公墓名称" field="cemeName" title="补录公墓的全称"
										style="width: 200px;" /></td>
									<td class="FieldLabel">主管单位</td>
									<td class="FieldInput"><label  name="主管单位"
										id="manaLevel" field="manaLevel"/> </td>
								</tr>
								<tr>
									<td class="FieldLabel">单位性质</td>
									<td class="FieldInput">
										<label  name="单位性质"
										id="unitProperties" field="unitProperties" dataset="unitPropertiesDataSet"/>
									</td>
									<td class="FieldLabel" style="width: 20%">公墓编号</td>
									<td class="FieldInput" style="width: 31%">
									<label id="cemeId" name="公墓编号" field="cemeId" /></td>
								</tr>
								<tr>
									<td class="FieldLabel">主办/联办单位</td>
									<td class="FieldInput"><label name="主办单位"
										field="organizer" style="width: 200px;" />
									<td class="FieldLabel">公墓性质</td>
									<td class="FieldInput"><label title="公墓性质">经营性</label></td>
								</tr>
								<tr>
									<td class="FieldLabel">法人代表</td>
									<td class="FieldInput"><input type="text" name="法人代表"
										field="legalPerson" maxlength="20" /></td>
									<td class="FieldLabel">职工总数</td>
									<td class="FieldInput"><input type="text" name="职工总数"
										id="totalStaff" field="totalStaff" maxlength="9"
										onchange="checkNum(this.id)" />人</td>
								</tr>
								<tr>
									<td class="FieldLabel">公墓负责人</td>
									<td class="FieldInput"><input type="text" name="公墓负责人"
										id="directorMobile" field="directorMobile" maxlength="11" /></td>
									<td class="FieldLabel">联系电话</td>
									<td class="FieldInput"><input type="text" name="联系电话"
										field="officePhone" id="officePhone" maxlength="15"
										onchange="checkTel(this.id)" /></td>
								</tr>
								<tr>
									<td class="FieldLabel">固定资产</td>
									<td class="FieldInput"><input type="text" name="固定资产"
										style="text-align: right" field="fixeDassets" id="fixeDassets"
										onchange="checkAssMon(this.id)" maxlength="12" />万元</td>
									<td class="FieldLabel">总投资额</td>
									<td class="FieldInput"><input type="text" name="总投资额"
										style="text-align: right" field="totalInvestment"
										id="totalInvestment" onchange="checkAssMon(this.id)"
										maxlength="12" />万元</td>
								</tr>
								<tr>
									<td class="FieldLabel">正式营业时间</td>
									<td class="FieldInput"><label name="正式营业时间"
										field="gestionTime" /></td>
									<td class="FieldLabel">邮编</td>
									<td class="FieldInput"><input type="text" name="邮政编码"
										field="postalcode" id="postalcode" maxlength="6"
										onchange="checkNum(this.id)" /></td>
								</tr>
								<tr>
									<td class="FieldLabel">公墓占地面积</td>
									<td class="FieldInput"><input type="text"
										style="text-align: right" name="公墓占地面积" field="totalArea"
										id="totalArea" onchange="checkAssMon(this.id)" maxlength="12" />亩<!--
									&nbsp; <select name="公墓占地面积计量单位" id="totalAreaUnits"
										field="totalAreaUnits" style="width: 60px">
										<option dataset="AreaUnitsDataSet"></option>
									</select>--></td>
									<td class="FieldLabel">墓区建成面积</td>
									<td class="FieldInput"><input type="text"
										style="text-align: right" name="墓区建成面积" field="builtArea"
										id="builtArea" onchange="checkAssMon(this.id)" maxlength="12" />亩<!--
									&nbsp; <select name="墓区建成面积计量单位" id="builtAreaUnits"
										field="builtAreaUnits" style="width: 60px">
										<option dataset="AreaUnitsDataSet"></option>
									</select>
									--></td>
								</tr>
								<tr>
									<td class="FieldLabel">建筑面积</td>
									<td class="FieldInput"><input type="text"
										style="text-align: right" name="建筑总面积" field="builtTotalArea"
										id="builtTotalArea" onchange="checkAssMon(this.id)"
										maxlength="12" />㎡</td>
									<td class="FieldLabel">所属行政区</td>
									<td class="FieldInput"><label name="所属行政区"
										id="areaLevel" field="areaLevel"/> </td>
								</tr>
								<tr>
									<td class="FieldLabel">公墓所在位置</td>
									<td class="FieldInput" colspan="3"><input type="text"
										name="公墓所在位置" field="address" style="width: 280px"
										maxlength="50" /></td>
								</tr>
								<tr>
									<td class="FieldLabel">服务范围</td>
									<td class="FieldInput" colspan="5"><textarea
										onpropertychange="if(value.length>49) value=value.substr(0,49)"
										rows="3" maxlength="49" name='服务范围' field="serviceScope"
										style="width: 90%"></textarea></td>
								</tr>
							</table>
							</fieldset>
							</form>
						</next:Html>
						</next:Panel>
						<next:Panel >
		<next:TabPanel id="tabpanel" name="tabpanel-div" autoWidth="true">
			<next:Tabs>
				<next:GridPanel title="历史记录" id="itemGridPanel" name="itemGridPanel"
					stripeRows="true" height="300" dataset="itemDs" width="98%" 
					notSelectFirstRow="true">
					<next:Columns>
					<next:Column id="cemeId" header="公墓ID" field="cemeId" width="160"
							sortable="false" editable="false" hidden="true">
							<next:TextField />
						</next:Column>
						<next:Column id="itemId" header="编号" field="itemId"
							sortable="false" hidden="true">
							<next:TextField />
						</next:Column>
						<next:Column id="itemDic" header="事项" field="itemDic"
							width="160" sortable="false" dataset="itemTypeDs">
							<next:TextField />
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
					<next:BottomBar>
						<next:PagingToolBar dataset="itemDs" />
					</next:BottomBar>
				</next:GridPanel>
				
				<next:GridPanel title="土地证信息" id="landcardPanel"
					name="landcardPanel" stripeRows="true" height="300"
					dataset="landcardDs" notSelectFirstRow="true" width="98%" >
					<next:Columns>
						<next:Column id="cemeId" header="公墓ID" field="cemeId" width="160"
							sortable="false" editable="false" hidden="true">
							<next:TextField />
						</next:Column>
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
					<next:BottomBar>
						<next:PagingToolBar dataset="landcardDs" />
					</next:BottomBar>
				</next:GridPanel>

				<next:GridPanel title="政府部门批准文号" id="govAppGridPanel"
					name="govAppGridPanel" stripeRows="true" height="300"
					dataset="govAppDs" notSelectFirstRow="true" width="98%" >
					<next:Columns>
						<next:Column id="cemeId" header="公墓ID" field="cemeId" width="160"
							sortable="false" editable="false" hidden="true">
							<next:TextField />
						</next:Column>
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
					<next:BottomBar>
						<next:PagingToolBar dataset="govAppDs" />
					</next:BottomBar>
				</next:GridPanel>
			</next:Tabs>
		</next:TabPanel>
	</next:Panel>
						<next:Panel>
						<next:Html>
							<form id="InspectionForm2" method="post" dataset="infoDataSet"
								onsubmit="return false" class="L5form">
							<fieldset><legend>公墓安葬信息</legend>
							<table width="100%">
								<tr>
									<td class="FieldLabel" style="width: 26%">本年安葬总人数:</td>
									<td class="FieldInput" colspan="3" style="width: 19%"><input type="text" name="本年安葬总人数" style="text-align:right"
										maxlength="10" field="yearPeopleNum" id="yearPeopleNum"  onchange="checkNum(this.id)"/></td>
									<td class="FieldLabel" colspan="2" style="width: 21%">自开业至今安葬总人数:</td>
									<td class="FieldInput" colspan="3" style="width: 35%"><input type="text" style="text-align:right"
										name="自开业至今安葬总人数" maxlength="10" field="sincePeopleNum" id="sincePeopleNum"
										 onchange="checkNum(this.id)"/></td>
								</tr>
								<tr>
									<td class="FieldLabel">本年销售墓穴数:</td>
									
									<td class="FieldLabel" style="width: 15%">单穴:</td>
									<td class="FieldInput"><input type="text" name="单穴销售数(本年)" style="text-align:right" onblur="getNum()"
										field="sellSingleHole" id="sellSingleHole"  maxlength="10" onchange="checkNum(this.id)" style="width: 80px"/></td>
									<td class="FieldLabel" style="width: 15%">双穴:</td>
									<td class="FieldInput"><input type="text" name="双穴销售数(本年)" style="text-align:right" onblur="getNum()"
										field="sellDoubleHole" id="sellDoubleHole"  maxlength="10" onchange="checkNum(this.id)" style="width: 80px"/></td>
									<td class="FieldLabel" style="width: 15%">多穴:</td>
									<td class="FieldInput"><input type="text" name="多穴销售数(本年)" style="text-align:right" onblur="getNum()"
										field="sellMoreHole" id="sellMoreHole"  maxlength="10" onchange="checkNum(this.id)" style="width: 80px"/></td>
									<td class="FieldLabel" style="width: 15%">合计:</td>
									<td class="FieldInput"><input type="text" name="本年销售墓穴数合计" style="text-align:right" onblur="getNum()"
										field="yearSellNum" id="yearSellNum"  maxlength="16" onchange="checkNum(this.id)" style="width: 80px"/></td>
								</tr>
								<tr>
									<td class="FieldLabel">本年安葬墓穴数:</td>
									
									<td class="FieldLabel" style="width: 15%">单穴:</td>
									<td class="FieldInput"><input type="text" name="单穴安葬数(本年)" style="text-align:right" onblur="getNum()"
										field="yearSingleHole" id="yearSingleHole"  maxlength="10" onchange="checkNum(this.id)" style="width: 80px"/></td>
									<td class="FieldLabel" style="width: 15%">双穴:</td>
									<td class="FieldInput"><input type="text" name="双穴安葬数(本年)" style="text-align:right" onblur="getNum()"
										field="yearDoubleHole" id="yearDoubleHole"  maxlength="10" onchange="checkNum(this.id)" style="width: 80px"/></td>
									<td class="FieldLabel" style="width: 15%">多穴:</td>
									<td class="FieldInput"><input type="text" name="多穴安葬数(本年)" style="text-align:right" onblur="getNum()"
										field="yearMoreHole" id="yearMoreHole"  maxlength="10" onchange="checkNum(this.id)" style="width: 80px"/></td>
									<td class="FieldLabel" style="width: 15%">合计:</td>
									<td class="FieldInput"><input type="text" name="本年安葬墓穴数合计" style="text-align:right"
										field="yearHoleNum" id="yearHoleNum"  maxlength="16" onchange="checkNum(this.id)" style="width: 80px"/></td>
								</tr>
								<tr>
									<td class="FieldLabel">本年迁出墓穴数:</td>
									
									<td class="FieldLabel" style="width: 15%">单穴:</td>
									<td class="FieldInput"><input type="text" name="单穴迁出数(本年)" style="text-align:right" onblur="getNum()"
										field="outSingleHole" id="outSingleHole"  maxlength="10" onchange="checkNum(this.id)" style="width: 80px"/></td>
									<td class="FieldLabel" style="width: 15%">双穴:</td>
									<td class="FieldInput"><input type="text" name="双穴迁出数(本年)" style="text-align:right" onblur="getNum()"
										field="outDoubleHole" id="outDoubleHole"  maxlength="10" onchange="checkNum(this.id)" style="width: 80px"/></td>
									<td class="FieldLabel" style="width: 15%">多穴:</td>
									<td class="FieldInput"><input type="text" name="多穴迁出数(本年)" style="text-align:right" onblur="getNum()"
										field="outMoreHole" id="outMoreHole"  maxlength="10" onchange="checkNum(this.id)" style="width: 80px"/></td>
									<td class="FieldLabel" style="width: 15%">合计:</td>
									<td class="FieldInput"><input type="text" name="本年迁出墓穴数合计" style="text-align:right" 
										field="yearOutNum" id="yearOutNum"  maxlength="16" onchange="checkNum(this.id)" style="width: 80px"/></td>
								</tr>
								<tr>
									<td class="FieldLabel">自开业至今安葬穴位数:</td>
									
									<td class="FieldLabel" style="width: 15%">单穴:</td>
									<td class="FieldInput"><input type="text" name="单穴安葬数(自开业至今)" style="text-align:right" onblur="getNum()"
										field="singleHole" id="singleHole"
										 maxlength="10" onchange="checkNum(this.id)" style="width: 80px"/></td>
									<td class="FieldLabel" style="width: 15%">双穴:</td>
									<td class="FieldInput"><input type="text" name="双穴安葬数(自开业至今)" style="text-align:right" onblur="getNum()"
										field="doubleHole" id="doubleHole"
										 maxlength="10" onchange="checkNum(this.id)" style="width: 80px"/></td>
									<td class="FieldLabel" style="width: 15%">多穴:</td>
									<td class="FieldInput"><input type="text" name="多穴安葬数(自开业至今)" style="text-align:right" onblur="getNum()"
										field="moreHole" id="moreHole" 
										maxlength="10" onchange="checkNum(this.id)" style="width: 80px"/></td>
									<td class="FieldLabel" style="width: 15%">合计:</td>
									<td class="FieldInput"><input type="text" name="自开业至今安葬穴位数合计" style="text-align:right"
										field="sinceHoleNum" id="sinceHoleNum"  maxlength="16" onchange="checkNum(this.id)" style="width: 80px"/></td>
								</tr>
							</table>
							</fieldset>
							</form>
						</next:Html>
						</next:Panel>
						<next:Panel>
						<next:Html>
							<form id="InspectionForm3" method="post" dataset="infoDataSet"
								onsubmit="return false" class="L5form">
							<fieldset><legend>未营业原因：</legend>
							<table width="100%">
								<tr>
									<td class="FieldInput" colspan="5"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="5" maxlength="49"
										name='未营业原因' field="notReasons" style="width: 99%"></textarea></td>
								</tr>
							</table>
							</fieldset>
							</form>
						</next:Html>
					</next:Panel>
					</next:Panel>
					<!-- 公墓年检标准 -->
					<next:Panel title="公墓年检标准" height="100%" width="100%"
						autoScroll="true">
						<next:Html>
							<form id="editForm" method="post" dataset="scoreDataSet"
								onsubmit="return false" class="L5form">
							<fieldset><legend>公墓年检标准(满分：100)</legend>
							<table width="100%">

								<tr>
									<td class="FieldButton" colspan="3">检查项目</td>
									<td class="FieldButton" width="5%">分值</td>
									<td class="FieldButton" >得分</td>
									<td class="FieldButton" width="25%">扣分或加分原因</td>
								</tr>
								<tr>
									<td class="FieldLabel" rowspan="8" width="20%" style="text-align:left">在销售服务场所公开展示内容
									(10分)</td>
									<td class="FieldLabel" width="30%" style="text-align:left"  colspan="2">《经营性公墓合格证》</td>
									<td class="FieldLabel" style="text-align: center" width="15%">1</td>
									<td class="FieldInput"  ><input type="text"
										name="经营性合格证得分" field="businesscertificateScore" style="text-align:right"
										id="businesscertificateScore"    style="width: 50px" 
										maxlength="5" onchange="checkNum(this.id)"  /></td>
									<td class="FieldInput" width="35%"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
										name="经营性合格证原因" style="width: 400px" id="businesscertificateReason"
										field="businesscertificateReason" maxlength="50" ></textarea></td>
								</tr>
								<tr>
									<td class="FieldLabel"  style="text-align:left"  colspan="2">营业执照</td>
									<td class="FieldLabel" style="text-align: center">1</td>
									<td class="FieldInput" ><input type="text"
										name="营业执照得分" field="businesslicenseScore" style="text-align:right"
										id="businesslicenseScore"   style="width: 50px"
										maxlength="5"  onchange="checkNum(this.id)"/></td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
										name="营业执照原因" style="width: 400px" id="businesslicenseReason"
										field="businesslicenseReason" maxlength="50"></textarea></td>
								</tr>
								<tr>
									<td class="FieldLabel" style="text-align:left"  colspan="2">税务登记证</td>
									<td class="FieldLabel" style="text-align: center">1</td>
									<td class="FieldInput" ><input type="text" name="税务登记证得分" style="text-align:right"
										field="taxcertificateScore" id="taxcertificateScore"  style="width: 50px"
										 maxlength="5"  onchange="checkNum(this.id)"/></td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="税务登记证原因"
										style="width: 400px" field="taxcertificateReason" maxlength="50" id="taxcertificateReason"></textarea> </td>

								</tr>
								<tr>
									<td class="FieldLabel" style="text-align:left"  colspan="2">收费项目、收费标准、收费依据等价格公示内容</td>
									<td class="FieldLabel" style="text-align: center">2</td>
									<td class="FieldInput" ><input type="text" name="收费得分" style="text-align:right"
										field="feeScore" id="feeScore"   style="width: 50px"
										maxlength="5"  onchange="checkNum(this.id)"/></td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="收费原因"
										style="width: 400px" field="feeReason" maxlength="50" id="feeReason"></textarea> </td>

								</tr>
								<tr>
									<td class="FieldLabel" style="text-align:left"  colspan="2">购置墓穴(格位)的条件和程序</td>
									<td class="FieldLabel" style="text-align: center">1</td>
									<td class="FieldInput" ><input type="text" style="text-align:right"
										name="购置墓穴/安葬程序得分" field="purchasegravesScore"
										id="purchasegravesScore"   style="width: 50px"
										maxlength="5"  onchange="checkNum(this.id)"/></td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
										name="购置墓穴/安葬程序原因" style="width: 400px"
										field="purchasegravesReason" maxlength="50" id="purchasegravesReason"></textarea></td>
								</tr>
								<tr>
									<td class="FieldLabel" style="text-align:left"  colspan="2">服务承诺</td>
									<td class="FieldLabel" style="text-align: center">2</td>
									<td class="FieldInput" ><input type="text" name="服务承诺得分" style="text-align:right"
										field="pledgeScore" id="pledgeScore"  style="width: 50px"
										 maxlength="5"  onchange="checkNum(this.id)"/> </td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="服务承诺原因"
										style="width: 400px" field="pledgeReason" maxlength="50" id="pledgeReason"></textarea></td>

								</tr>
								<tr>
									<td class="FieldLabel" style="text-align:left"  colspan="2">工作人员职责及照片、编号</td>
									<td class="FieldLabel" style="text-align: center">1</td>
									<td class="FieldInput" ><input type="text" name="工作人员职责及照片、编号得分" style="text-align:right"
										field="staffresponsibilitiesScore"
										id="staffresponsibilitiesScore"  style="width: 50px"
										 maxlength="5"  onchange="checkNum(this.id)"/></td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="工作人员职责原因"
										style="width: 400px" field="staffresponsibilitiesReason" maxlength="50" id="staffresponsibilitiesReason"></textarea></td>

								</tr>
								<tr>
									<td class="FieldLabel" style="text-align:left"  colspan="2">办公时间、服务电话和监督电话</td>
									<td class="FieldLabel" style="text-align: center">1</td>
									<td class="FieldInput" ><input type="text"
										name="办公时间、服务电话、监督电话得分" field="officeTimeScore" style="text-align:right"
										id="officeTimeScore"   style="width: 50px"
										maxlength="5"  onchange="checkNum(this.id)"/></td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
										name="办公时间、服务电话、监督电话原因" style="width: 400px"
										field="officeTimeReason" maxlength="50" id="officeTimeReason"></textarea></td>

								</tr>
								<tr>
									<td rowspan="4" class="FieldLabel" style="text-align:left">墓穴(格位)销售管理(5分)</td>
									<td class="FieldLabel" style="text-align:left"  colspan="2">使用全省统一的《公墓安葬证》、《骨灰安放证》和《墓穴（格位）使用协议》</td>
									<td class="FieldLabel" style="text-align: center">1</td>
									<td class="FieldInput" ><input type="text" name="使用全省统一的《公墓安葬证》、《骨灰安放证》和《墓穴（格位）使用协议》得分"
										field="provincialdocumentsScore" id="provincialdocumentsScore"  style="width: 50px"
										 maxlength="5"  onchange="checkNum(this.id)" style="text-align:right"/></td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="全省统一证原因"
										style="width: 400px" field="provincialdocumentsReason" maxlength="50" id="provincialdocumentsReason"></textarea></td>

								</tr>
								<tr>
									<td class="FieldLabel" style="text-align:left"  colspan="2">物价部门核定收费标准</td>
									<td class="FieldLabel" style="text-align: center">1</td>
									<td class="FieldInput" ><input type="text" name="物价部门收费标准得分" style="text-align:right"
										field="departmentchargesScore" id="departmentchargesScore"  style="width: 50px"
										 maxlength="5"  onchange="checkNum(this.id)"/></td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
										name="物价部门收费标准原因" style="width: 400px"
										field="departmentchargesReason" maxlength="50" id="departmentchargesReason"></textarea></td>

								</tr>
								<tr>
									<td class="FieldLabel" style="text-align:left"  colspan="2">无违法出租或买卖墓穴(格位)现象</td>
									<td class="FieldLabel" style="text-align: center">2</td>
									<td class="FieldInput" ><input type="text" name="无违法出租或买卖墓穴（格位）现象得分"
										field="nooffenseScore" id="nooffenseScore"  style="width: 50px" style="text-align:right"
										 maxlength="5"  onchange="checkNum(this.id)"/></td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="无违法出租原因"
										style="width: 400px" field="nooffenseReason" maxlength="50" id="nooffenseReason"></textarea> </td>

								</tr>
								<tr>
									<td class="FieldLabel" style="text-align:left"  colspan="2">对超过20年的墓穴能够妥善处理</td>
									<td class="FieldLabel" style="text-align: center">1</td>
									<td class="FieldInput" ><input type="text"
										name="对超过20年的墓穴能够妥善处理得分" field="propergraveScore" style="text-align:right"
										id="propergraveScore"   style="width: 50px"
										maxlength="5"  onchange="checkNum(this.id)"/> </td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
										name="墓穴妥善处理原因" style="width: 400px"
										field="propergraveReason" maxlength="50" id="propergraveReason"></textarea> </td>

								</tr>
								<tr>
									<td rowspan="7" class="FieldLabel" style="text-align:left">墓穴(格位)销售档案管理(7分)</td>
									<td class="FieldLabel" style="text-align:left"  colspan="2">使用全省统一的卷盒和卷袋</td>
									<td class="FieldLabel" style="text-align: center">1</td>
									<td class="FieldInput" ><input type="text" name="使用全省统一的卷盒和卷袋得分" style="text-align:right"
										field="boxesandbagsScore" id="boxesandbagsScore"  style="width: 50px"
										 maxlength="5"  onchange="checkNum(this.id)"/> </td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="统一卷盒原因"
										style="width: 400px" field="boxesandbagsReason" maxlength="50" id="boxesandbagsReason"></textarea></td>

								</tr>
								<tr>
									<td class="FieldLabel" style="text-align:left"  colspan="2">有死亡证明或火化证明的复印件</td>
									<td class="FieldLabel" style="text-align: center">1</td>
									<td class="FieldInput" ><input type="text" name="有死亡证明或火化证明的复印件得分" style="text-align:right"
										field="deathcertificateScore" id="deathcertificateScore"  style="width: 50px"
										 maxlength="5"  onchange="checkNum(this.id)"/> </td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="死亡证明复印件原因"
										style="width: 400px" field="deathcertificateReason" maxlength="50" id="deathcertificateReason"></textarea></td>

								</tr>
								<tr>
									<td class="FieldLabel" style="text-align:left"  colspan="2">有骨灰安放(葬)合同</td>
									<td class="FieldLabel" style="text-align: center">1</td>
									<td class="FieldInput" ><input type="text"
										name="骨灰安放合同得分" field="ashescontractScore" style="text-align:right"
										id="ashescontractScore"   style="width: 50px"
										maxlength="5"  onchange="checkNum(this.id)"/></td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
										name="骨灰安放合同原因" style="width: 400px"
										field="ashescontractReason" maxlength="50" id="ashescontractReason"></textarea> </td>

								</tr>
								<tr>
									<td class="FieldLabel" style="text-align:left"  colspan="2">有丧事承办人签名的骨灰安放(葬)处理表、业务流程单等</td>
									<td class="FieldLabel" style="text-align: center">1</td>
									<td class="FieldInput" ><input type="text" name="有丧事承办人签名的骨灰安放（葬）处理表、业务流程单等得分"
										field="contractorssignatureScore" style="text-align:right"
										id="contractorssignatureScore"   style="width: 50px"
										maxlength="5"  onchange="checkNum(this.id)"/></td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="承办人签名原因"
										style="width: 400px" field="contractorssignatureReason" maxlength="50" id="contractorssignatureReason"></textarea> </td>

								</tr>
								<tr>
									<td class="FieldLabel" style="text-align:left"  colspan="2">有丧事承办人的有效身份证件复印件</td>
									<td class="FieldLabel" style="text-align: center">1</td>
									<td class="FieldInput" ><input type="text" name="有丧事承办人的有效身份证件复印件得分" style="text-align:right"
										field="contractoridScore" id="contractoridScore"  style="width: 50px"
										 maxlength="5"  onchange="checkNum(this.id)"/></td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="承办人身份证原因"
										style="width: 400px" field="contractoridReason" maxlength="50" id="contractoridReason"></textarea> </td>

								</tr>
								<tr>
									<td class="FieldLabel" style="text-align:left"  colspan="2">有补充签订的合同或者协议</td>
									<td class="FieldLabel" style="text-align: center">1</td>
									<td class="FieldInput" ><input type="text" name="有补充签订的合同或者协议得分" style="text-align:right"
										field="addcontractScore" id="addcontractScore"  style="width: 50px"
										 maxlength="5"  onchange="checkNum(this.id)"/></td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="补充合同协议原因"
										style="width: 400px" field="addcontractReason" maxlength="50" id="addcontractReason"></textarea> </td>

								</tr>
								<tr>
									<td class="FieldLabel" style="text-align:left"  colspan="2">有其他应当归档的材料</td>
									<td class="FieldLabel" style="text-align: center">1</td>
									<td class="FieldInput" ><input type="text" name="有其他应当归档的材料得分" style="text-align:right"
										field="othermaterialsScore" id="othermaterialsScore"  style="width: 50px"
										 maxlength="5"  onchange="checkNum(this.id)"/> </td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="其他材料原因"
										style="width: 400px" field="othermaterialsReason" maxlength="50" id="othermaterialsReason"></textarea> </td>

								</tr>
								<tr>
									<td rowspan="3" class="FieldLabel" style="text-align:left">墓穴建设(9分)</td>
									<td class="FieldLabel" style="text-align:left" style="width: 30%">墓穴面积或墓碑高度超过规定标准20%以下的个数</td>
									<td class="FieldLabel"><input type="text" name="墓穴面积或墓碑高度超过规定标准20%以下的个数" style="text-align:right"
									field="tombstoneTwentyNum" id="tombstoneTwentyNum" onchange="checkNum(this.id)" maxlength="10" style="width: 70px"/>
									<td class="FieldLabel" style="text-align: center">2</td>
									<td class="FieldInput" ><input type="text" name="墓穴面积或墓碑高度超过规定标准20%以下的个数得分" style="text-align:right"
										field="tombstoneTwentyScore" id="tombstoneTwentyScore"  style="width: 50px"
										 maxlength="5"  onchange="checkNum(this.id)"/></td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="墓碑20%以下原因"
										style="width: 400px" field="tombstoneTwentyReason" maxlength="50" id="tombstoneTwentyReason"></textarea> </td>

								</tr>
								<tr>
									<td class="FieldLabel" style="text-align:left">墓穴面积或墓碑高度超过规定标准20%至50%的个数</td>
									<td class="FieldLabel"><input type="text" name="墓穴面积或墓碑高度超过规定标准20%至50%的个数" style="text-align:right"
									field="tombstoneFiftyNum" id="tombstoneFiftyNum" onchange="checkNum(this.id)" maxlength="10" style="width: 70px"/>
									<td class="FieldLabel" style="text-align: center">3</td>
									<td class="FieldInput" ><input type="text"
										name="墓穴面积或墓碑高度超过规定标准20%至50%的个数得分" field="tombstoneFiftyScore"  style="width: 50px" style="text-align:right"
										id="tombstoneFiftyScore" 
										maxlength="5"  onchange="checkNum(this.id)"/></td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
										name="墓碑20%到50%原因" style="width: 400px"
										field="tombstoneFiftyReason" maxlength="50" id="tombstoneFiftyReason"></textarea> </td>

								</tr>
								<tr>
									<td class="FieldLabel" style="text-align:left">墓穴面积或墓碑高度超过规定标准50%以上的个数</td>
									<td class="FieldLabel"><input type="text" name="墓穴面积或墓碑高度超过规定标准50%以上的个数" style="text-align:right"
									field="tombstoneoverfiftyNum" id="tombstoneoverfiftyNum" onchange="checkNum(this.id)" maxlength="10" style="width: 70px"/>
									<td class="FieldLabel" style="text-align: center">4</td>
									<td class="FieldInput" ><input type="text" name="墓穴面积或墓碑高度超过规定标准50%以上的个数得分" field="tombstoneoverfiftyScore"
										id="tombstoneoverfiftyScore"  maxlength="5"  style="width: 50px"  onchange="checkNum(this.id)" style="text-align:right"/></td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="墓碑50%以上原因"
										style="width: 400px" field="tombstoneoverfiftyReason" maxlength="50" id="tombstoneoverfiftyReason"></textarea> </td>

								</tr>
								<tr>
									<td rowspan="10" class="FieldLabel" style="text-align:left">墓区管理(30分)</td>
									<td class="FieldLabel" style="text-align:left">营业室面积</td>
									<td class="FieldLabel"><input type="text" name="营业室面积" style="text-align:right"
									field="operatingareaNum" id="operatingareaNum" onchange="checkAssMon(this.id)" maxlength="12" style="width: 70px"/>㎡</td>
									<td class="FieldLabel" style="text-align: center">1</td>
									<td class="FieldInput" ><input type="text" name="营业室面积得分" style="text-align:right"
										field="operatingareaScore" id="operatingareaScore"  style="width: 50px"
										 maxlength="5"  onchange="checkNum(this.id)"/></td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="营业室面积原因"
										style="width: 400px" field="operatingareaReason" maxlength="50" id="operatingareaReason"></textarea> </td>

								</tr>
								<tr>
									<td class="FieldLabel" style="text-align:left">档案室面积</td>
									<td class="FieldLabel"><input type="text" name="档案室面积" style="text-align:right"
									field="archivesareaNum" id="archivesareaNum" onchange="checkAssMon(this.id)" maxlength="12" style="width: 70px"/>㎡</td>
									<td class="FieldLabel" style="text-align: center">1</td>
									<td class="FieldInput" ><input type="text" name="档案室面积得分" style="text-align:right"
										field="archivesareaScore" id="archivesareaScore"  style="width: 50px"
										 maxlength="5"  onchange="checkNum(this.id)"/></td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="档案室面积原因"
										style="width: 400px" field="archivesareaReason" maxlength="50" id="archivesareaReason"></textarea> </td>

								</tr>
								<tr>
									<td class="FieldLabel" style="text-align:left">办公室面积</td>
									<td class="FieldLabel"><input type="text" name="办公室面积" style="text-align:right"
									field="officeareaNum" id="officeareaNum" onchange="checkAssMon(this.id)" maxlength="12" style="width: 70px"/>㎡</td>
									<td class="FieldLabel" style="text-align: center">1</td>
									<td class="FieldInput" ><input type="text" name="办公室面积得分" style="text-align:right"
										field="officeareaScore" id="officeareaScore"  style="width: 50px"
										 maxlength="5"  onchange="checkNum(this.id)"/></td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="办公室面积原因"
										style="width: 400px" field="officeareaReason" maxlength="50" id="officeareaReason"></textarea> </td>

								</tr>
								<tr>
									<td class="FieldLabel"  style="text-align:left"  colspan="2">道路、供水、供电畅通，安全防护措施到位</td>
									<td class="FieldLabel" style="text-align: center">3</td>
									<td class="FieldInput" ><input type="text" name="道路、供水、供电畅通，安全防护措施到位得分"
										field="roadsafetyScore" id="roadsafetyScore"  style="width: 50px" style="text-align:right"
										 maxlength="5"  onchange="checkNum(this.id)"/> </td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="道路供水原因"
										style="width: 400px" field="roadsafetyReason" maxlength="50" id="roadsafetyReason"></textarea> </td>

								</tr>
								<tr>
									<td class="FieldLabel"  style="text-align:left"  colspan="2">有文明祭奠举措，无封建迷信活动</td>
									<td class="FieldLabel" style="text-align: center">3</td>
									<td class="FieldInput" ><input type="text" name="有文明祭奠举措，无封建迷信活动得分" style="text-align:right"
										field="civilizationMemorialScore"  style="width: 50px"
										id="civilizationMemorialScore" 
										maxlength="5"  onchange="checkNum(this.id)"/></td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="文明祭奠原因"
										style="width: 400px" field="civilizationMemorialReason" maxlength="50" id="civilizationMemorialReason"></textarea> </td>

								</tr>
								<tr>
									<td class="FieldLabel"  style="text-align:left"  colspan="2">允许明火祭奠的，设立固定明火祭奠设施、开设防火隔离带等措施，并经县（市、区）以上林业部门审批</td>
									<td class="FieldLabel" style="text-align: center">2</td>
									<td class="FieldInput" ><input type="text" name="允许明火祭奠的，设立固定明火祭奠设施、开设防火隔离带等措施，并经县（市、区）以上林业部门审批得分"
										field="fireMemorialScore" id="fireMemorialScore"  style="width: 50px" style="text-align:right"
										 maxlength="5"  onchange="checkNum(this.id)"/> </td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="明火祭奠原因"
										style="width: 400px" field="fireMemorialReason" maxlength="50" id="fireMemorialReason"></textarea> </td>

								</tr>
								<tr>
									<td class="FieldLabel"  style="text-align:left">生态(卧碑、树葬、花葬、草坪葬、艺术葬等)墓穴占墓穴总数的比例(%)</td>
									<td class="FieldLabel"><input type="text" name="生态(卧碑、树葬、花葬、草坪葬、艺术葬等)墓穴占墓穴总数的比例" style="text-align:right"
									field="ecologyNum" id="ecologyNum" onchange="checkAssMon(this.id)" maxlength="7" style="width: 70px"/>
									<td class="FieldLabel" style="text-align: center">6</td>
									<td class="FieldInput" ><input type="text" name="生态（卧碑、树葬、花葬、草坪葬、艺术葬等）墓穴占墓穴总数的比例得分" style="text-align:right"
										field="ecologyScore" id="ecologyScore"  style="width: 50px"
										 maxlength="5"  onchange="checkNum(this.id)"/></td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="生态原因"
										style="width: 400px" field="ecologyReason" maxlength="50" id="ecologyReason"></textarea> </td>

								</tr>
								<tr>
									<td class="FieldLabel" style="text-align:left">绿化覆盖率(%)</br>(注：指绿化植物的垂直投影面积占总用地面积的比值)</td>
									<td class="FieldLabel"><input type="text" name="绿化覆盖率"
									field="greenCoverageNum" id="greenCoverageNum" onchange="checkAssMon(this.id)" maxlength="7" style="width: 70px" style="text-align:right"/>
									<td class="FieldLabel" style="text-align: center">6</td>
									<td class="FieldInput" ><input type="text" name="绿化覆盖率得分" style="text-align:right"
										field="greenCoverageScore" id="greenCoverageScore"  style="width: 50px"
										 maxlength="5"  onchange="checkNum(this.id)"/> </td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="绿化率原因"
										style="width: 400px" field="greenCoverageReason" maxlength="50" id="greenCoverageReason"></textarea> </td>

								</tr>
								<tr>
									<td class="FieldLabel" style="text-align:left">绿地面积和占总面积的比例(%)</td>
									<td class="FieldLabel"><input type="text" name="绿地面积和占总面积的比例" style="text-align:right"
									field="greenareaRatioNum" id="greenareaRatioNum" onchange="checkAssMon(this.id)" maxlength="7" style="width: 70px"/>
									<td class="FieldLabel" style="text-align: center">6</td>
									<td class="FieldInput" ><input type="text" name="绿地面积和占总面积的比例得分" style="text-align:right"
										field="greenareaRatioScore" id="greenareaRatioScore"  style="width: 50px" style="text-align:right"
										 maxlength="5"  onchange="checkNum(this.id)"/> </td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="绿地面积比率原因"
										style="width: 400px" field="greenareaRatioReason" maxlength="50" id="greenareaRatioReason"></textarea> </td>

								</tr>
								<tr>
									<td class="FieldLabel"  style="text-align:left"  colspan="2">按照所购墓穴(格位)标准进行安葬或安放，无自行改建墓穴(格位)</td>
									<td class="FieldLabel" style="text-align: center">1</td>
									<td class="FieldInput" ><input type="text" name="按照所购墓穴（格位）标准进行安葬或安放，无自行改建墓穴（格位）得分" style="text-align:right"
										field="burialTombScore" id="burialTombScore"  style="width: 50px"
										 maxlength="5"  onchange="checkNum(this.id)"/></td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="标准安葬墓穴原因"
										style="width: 400px" field="burialTombReason" maxlength="50" id="burialTombReason"></textarea> </td>

								</tr>
								<tr>
									<td rowspan="9" class="FieldLabel" style="text-align:left">公墓管理(39分)</td>
									<td class="FieldLabel"  style="text-align:left"  colspan="2">墓区建设地点和规模与申报材料相符</td>
									<td class="FieldLabel" style="text-align: center">6</td>
									<td class="FieldInput" ><input type="text" name="墓区建设地点和规模与申报材料相符得分" style="text-align:right"
										field="burialConformScore" id="burialConformScore"  style="width: 50px"
										 maxlength="5"  onchange="checkNum(this.id)"/></td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="墓区相符原因"
										style="width: 400px" field="burialConformReason" maxlength="50" id="burialConformReason"></textarea></td>
								</tr>
								<tr>
									<td class="FieldLabel"  style="text-align:left"  colspan="2">新建和扩建墓区的审批验收手续符合《山东省公墓管理办法》规定</td>
									<td class="FieldLabel" style="text-align: center">6</td>
									<td class="FieldInput" ><input type="text" name="新建和扩建墓区的审批验收手续符合《山东省公墓管理办法》规定得分" style="text-align:right"
										field="acceptanceComplianceScore"  style="width: 50px"
										id="acceptanceComplianceScore" 
										maxlength="5"  onchange="checkNum(this.id)"/> </td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="手续符合规定原因"
										style="width: 400px" field="acceptanceComplianceReason" maxlength="50" id="acceptanceComplianceReason"></textarea> </td>
								</tr>
								<tr>
									<td class="FieldLabel"  style="text-align:left"  colspan="2">公墓更名、变更法人代表,改变性质或改变合作(合资)单位符合《山东省公墓管理办法》规定</td>
									<td class="FieldLabel" style="text-align: center">3</td>
									<td class="FieldInput" ><input type="text"
										name="公墓更名、变更法人代表，改变性质或改变合作（合资）单位符合《山东省公墓管理办法》规定得分" field="changeComplianceScore" style="text-align:right"
										id="changeComplianceScore"   style="width: 50px"
										maxlength="5"  onchange="checkNum(this.id)"/> </td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
										name="改变符合规定/公墓更名符合规定原因" style="width: 400px"
										field="changeComplianceReason" maxlength="50" id="changeComplianceReason"></textarea> </td>

								</tr>
								<tr>
									<td class="FieldLabel"  style="text-align:left"  colspan="2">公墓根据销售墓穴的数量和使用年限，有不低于6%的税后收入预留，有交款凭证
									</td>
									<td class="FieldLabel" style="text-align: center">7</td>
									<td class="FieldInput" ><input type="text" name="公墓根据销售墓穴的数量和使用年限，有不低于6%的税后收入预留，有交款凭证得分" style="text-align:right"
										field="paymentCertificateScore" id="paymentCertificateScore"  style="width: 50px"
										 maxlength="5"  onchange="checkNum(this.id)" /></td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="有交款凭证原因"
										style="width: 400px" field="paymentCertificateReason" maxlength="50" id="paymentCertificateReason"></textarea> </td>
								</tr>
								<tr>
									<td class="FieldLabel"  style="text-align:left"  colspan="2">墓区管理机构的组建与申报报告相符</td>
									<td class="FieldLabel" style="text-align: center">4</td>
									<td class="FieldInput" ><input type="text"
										name="墓区管理机构的组建与申报报告相符得分" field="agenciesScore" id="agenciesScore"  style="width: 50px" style="text-align:right"
										 maxlength="5"  onchange="checkNum(this.id)"/> </td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3"
										name="管理机构组建相符原因" style="width: 400px" field="agenciesReason" maxlength="50" id="agenciesReason"></textarea> </td>
								</tr>
								<tr>
									<td class="FieldLabel" style="text-align:left"  colspan="2">工作人员参加省或设区的市人民政府民政部门组织的业务培训</td>
									<td class="FieldLabel" style="text-align: center">1</td>
									<td class="FieldInput" ><input type="text" name="工作人员参加省或设区的市人民政府民政部门组织的业务培训得分" style="text-align:right"
										field="businessTrainingScore" id="businessTrainingScore"  style="width: 50px"
										 maxlength="5"  onchange="checkNum(this.id)"/></td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="业务培训原因"
										style="width: 400px" field="businessTrainingReason" maxlength="50" id="businessTrainingReason"></textarea> </td>
								</tr>
								<tr>
									<td class="FieldLabel" style="text-align:left"  colspan="2">公墓管理的各项规章制度健全</td>
									<td class="FieldLabel" style="text-align: center">3</td>
									<td class="FieldInput"  ><input type="text" name="公墓管理的各项规章制度健全得分" style="text-align:right"
										field="systemSoundScore" id="systemSoundScore"  style="width: 50px"
										 maxlength="5"  onchange="checkNum(this.id)"/></td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="规章制度健全原因"
										style="width: 400px" field="systemSoundReason" maxlength="50" id="systemSoundReason"></textarea> </td>
								</tr>
								<tr>
									<td class="FieldLabel" style="text-align:left"  colspan="2">有高峰应急预案</td>
									<td class="FieldLabel" style="text-align: center">3</td>
									<td class="FieldInput"  ><input type="text" name="有高峰应急预案得分" style="text-align:right"
										field="contingencyPlansScore" id="contingencyPlansScore"  style="width: 50px"
										 maxlength="5"  onchange="checkNum(this.id)"/></td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="应急预案原因"
										style="width: 400px" field="contingencyPlansReason" maxlength="50" id="contingencyPlansReason"></textarea> </td>
								</tr>
								<tr>
									<td class="FieldLabel" style="text-align:left"  colspan="2">实行信息化管理，使用省厅研制的软件信息系统</td>
									<td class="FieldLabel" style="text-align: center">6</td>
									<td class="FieldInput" ><input type="text" name="实行信息化管理，使用省厅研制的软件信息系统得分" style="text-align:right"
										field="informationScore" id="informationScore"  style="width: 50px"
										 maxlength="5"  onchange="checkNum(this.id)"/></td>
									<td class="FieldInput"><textarea  onpropertychange="if(value.length>49) value=value.substr(0,49)"   rows="3" name="信息化原因"
										style="width: 400px" field="informationReason" maxlength="50" id="informationReason"></textarea> </td>
								</tr>
							</table>
							</fieldset>
							</form>
						</next:Html>
					</next:Panel>
					<!-- 分数合计及年检报告 -->
					<next:Panel title="分数合计及年检报告" height="100%" width="100%"
						autoScroll="true" id="statisticalScore">
						<next:Html>
							<form id="editForm" method="post" dataset="auditDataSet"
								onsubmit="return false" class="L5form">
							<fieldset><legend>分数合计</legend>
							<table width="100%" align="center">
								<tr>
									<td class="FieldLabel" width="23%">总得分:</td>
									<td class="FieldInput" colspan="3" width="77%"><input  style="text-align:right"
										type="text" readonly="readonly" name="总得分" field="totalScore" /></td>
								</tr>
							</table>
							</fieldset>
							
							<fieldset><legend>县级检查记录</legend>
							<div id="first">
							<table width="100%">
								<tr>
									<td class="FieldLabel" rowspan="2" width="100px;">检<br>
									查</td>
									<td class="FieldLabel" width="8%">检查时间</td>
									<td class="FieldInput"><label name="检查时间"
										id="firstTime" field="firstTime"/></td>
									
									<td class="FieldLabel">县级评分</td>
									<td class="FieldInput"><label id="firstTotalScore" style="width: 100px"></td>
								</tr>
								<tr>
									<td class="FieldLabel" width="8%">检查意见</td>
									<td class="FieldInput" colspan="3"><textarea  onpropertychange="if(value.length>1000) value=value.substr(0,1000)"   rows="30"
										name="检查意见" id="firstOpinion" field="firstOpinion" maxlength="1500"
										style="width: 80%" readonly="readonly" disabled="disabled"> </textarea><font color="red">*可输入1000字</font></td>
								</tr>
							</table>
							</div>
							</fieldset>
							<fieldset id="second"><legend>市级年检记录</legend>
							<div >
							<table width="100%">
								<tr>
									<td class="FieldLabel" rowspan="2" width="100px;">年<br>
									检</td>
									<td class="FieldLabel">年检时间</td>
									<td class="FieldInput"><input type="text" name="年检时间"
										field="secondTime" readonly="readonly" format="Y-m-d"
										onclick="LoushangDate(this)" /></td>
									<td class="FieldLabel">年检结果</td>
									<td class="FieldInput"><select  name="年检结果"
										field="secondResult">
										<option dataset="inspectionDataSet"></option></select></td>
								</tr>
								<tr>
									<td class="FieldLabel" width="100px;">年检报告:</td>
									<td class="FieldInput" colspan="3"><textarea  onpropertychange="if(value.length>250) value=value.substr(0,250)"   rows="20" maxlength="49"
										style="width: 80%" name="年检报告" field="annuareport" id="annuareport"></textarea><font color="red">*可输入240字</font></td>
								</tr>

							</table>
							</div>
							
							</fieldset>
							</form>
						</next:Html>
					</next:Panel>

					<!-- 业务材料 -->

					<next:Panel title="业务材料">
						<next:EditGridPanel id="uploadGrid" width="99.9%"
							stripeRows="true" height="100%" dataset="accessoriesDataSet">
							<next:TopBar>
								<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
								<next:ToolBarItem symbol="->"></next:ToolBarItem>
								<next:ToolBarItem iconCls="add" text="附件管理"  id="upFile" handler="clickUploadFile"></next:ToolBarItem>
								<next:ToolBarItem iconCls="detail" text="查看下载附件" id="downFile"  handler="clickUploadFile" hidden="true"></next:ToolBarItem>
							</next:TopBar>

							<next:Columns>
								<next:RowNumberColumn />
								<next:RadioBoxColumn></next:RadioBoxColumn>
								<next:Column header="材料类型" field="code" width="40%"
									editable="false" dataset="accessoriesType">
									<next:TextField />
								</next:Column>
								<next:Column header="附件名称" field="accessoriesName" width="30%"
									editable="false">
									<next:TextField />
								</next:Column>
								<next:Column header="附件描述" field="note" width="28%"
									editable="false">
									<next:TextField />
								</next:Column>
							</next:Columns>
							<next:BottomBar>
								<next:PagingToolBar dataset="accessoriesDataSet" />
							</next:BottomBar>
						</next:EditGridPanel>
					</next:Panel>

				</next:Tabs>
			</next:TabPanel>
		</next:Panel>
	</next:AnchorLayout>
</next:ViewPort>


<!-- 上传附件窗口 -->
<next:Window id="uploadWin" closeAction="hide" title="上传附件" height="230"
	width="600" modal="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="yes" text="上传" handler="click_upload"></next:ToolBarItem>
		<next:ToolBarItem xtype="tbseparator" />
	</next:TopBar>
	<next:Html>
		<form id="form_content" onsubmit="return false" style="padding: 5px;"
			class="L5form">
		<table border="1" width="100%">

			<tr>
				<td class="FieldLabel">附件上传：</td>
				<td class="FieldInput" colspan="5"><input class="file"
					type="file" id="files" name="files" style="width: 95%; height: 40" /></br>
				<span style="color: red">上传文件最大不能超过5M</span></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 20%">附件描述</td>
				<td class="FieldInput" colspan="5" style="width: 80%"><textarea
					id="fileMess" rows="5" style="width: 95%" onpropertychange="if(value.length>49) value=value.substr(0,49)" ></textarea></td>
			</tr>
		</table>
		</form>
	</next:Html>
</next:Window>
<!-- 下载附件列表 -->
<next:Window id="uploadList" closeAction="hide" title="附件管理"
	width="666" height="300" autoScroll="true" modal="true"
	closable="false">
	<next:EditGridPanel id="uploadListGrid" width="98%" stripeRows="true"
		height="88%" dataset="accessoriesItemDataSet">
		<next:TopBar>
			<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="upload" text="增加上传附件"
				handler="addUploadFile"></next:ToolBarItem>
			<next:ToolBarItem iconCls="return" text="关闭"
				handler="closeUploadList"></next:ToolBarItem>
		</next:TopBar>
		<next:Columns>
			<next:RowNumberColumn />
			<next:RadioBoxColumn></next:RadioBoxColumn>
			<next:Column header="附件名称" width="18%" field="accessoriesName"
				editable="false">
				<next:TextField />
			</next:Column>
			<next:Column header="附件描述" width="15%" field="note" editable="false">
				<next:TextField />
			</next:Column>
			<next:Column header="删除附件" field="" width="10%" editable="false"
				renderer="delUploadFile">
				<next:TextField />
			</next:Column>
			<next:Column header="下载附件" field="" width="10%" editable="false"
				renderer="downloadUploadFile">
				<next:TextField />
			</next:Column>
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="accessoriesItemDataSet" />
		</next:BottomBar>
	</next:EditGridPanel>
</next:Window>
</body>
</html>
