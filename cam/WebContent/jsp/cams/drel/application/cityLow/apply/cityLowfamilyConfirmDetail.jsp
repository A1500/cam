<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.*"%>

<html>
<head>
<title>城市低收入申请明细页面</title>
<next:ScriptManager />
<script type="text/javascript">
	<%
		String familyId=request.getParameter("familyId");//业务主键
	%>
	var familyId="<%=familyId%>";
</script>
<script type="text/javascript" src="cityLowfamilyConfirmDetail.js"></script>

</head>
<body>
<model:datasets>
	<!-- 家庭基本信息 -->
	<model:dataset id="familyDataSet"
		cmd="com.inspur.cams.drel.sam.cmd.BaseinfoFamilyQueryCmd"
		global="true">
		<model:record
			fromBean="com.inspur.cams.drel.application.cityLow.data.BaseinfoFamily">
		</model:record>
	</model:dataset>
	
	<!-- 家庭成员信息 只用作展示，rule可以不需定义 -->
	<model:dataset id="peopleListDataSet"
		cmd="com.inspur.cams.drel.application.cityLow.cmd.SamCityLowConfirmQueryCmd" global="true" method="queryPeopleAll">
		<model:record
			fromBean="com.inspur.cams.drel.application.cityLow.data.BaseinfoPeople">
			<model:field name="familyId" mapping="FAMILY_ID" />
			<model:field name="peopleId" mapping="PEOPLE_ID" />
			<model:field name="name" mapping="NAME" rule="require"/>
			<model:field name="birthday" mapping="BIRTHDAY" rule="require"/>
			<model:field name="idCard" mapping="ID_CARD" rule="require"/>
			<model:field name="relationshipType" mapping="RELATIONSHIP_TYPE" rule="require"/>
			<model:field name="healthCode" mapping="HEALTH_CODE" rule="require"/>
			<model:field name="disabilityLevelCode" mapping="DISABILITY_LEVEL_CODE" rule="require"/>
			<model:field name="employmentCode" mapping="EMPLOYMENT_CODE" rule="require"/>
			<model:field name="workUnitCharacter" mapping="WORK_UNIT_CHARACTER" rule="require"/>
			
			<model:field name="domicileCode" mapping="DOMICILE_CODE" />
			<model:field name="domicileName" mapping="DOMICILE_NAME" />
			<model:field name="regId" mapping="REG_ID" />
			<model:field name="regTime" mapping="REG_TIME" />
			<model:field name="regOrg" mapping="REG_ORG" />
			<model:field name="regOrgArea" mapping="REG_ORG_AREA" />
			<model:field name="regOrgName" mapping="REG_ORG_NAME" />
			<model:field name="regPeople" mapping="REG_PEOPLE" />
							
			<model:field name="incomeId" mapping="INCOME_ID" rule="require"/>
			<model:field name="salaryIncome" mapping="SALARY_INCOME" rule="require"/>
			<model:field name="manageIncome" mapping="MANAGE_INCOME" rule="require"/>
			<model:field name="propertyIncome" mapping="PROPERTY_INCOME" rule="require"/>
			<model:field name="transferIncome" mapping="TRANSFER_INCOME" rule="require"/>
			<model:field name="otherIncome" mapping="OTHER_INCOME" rule="require"/>
			
			<model:field name="propertyId" mapping="PROPERTY_ID" rule="require"/>
			<model:field name="bankStockProperty" mapping="BANK_STOCK_PROPERTY" rule="require"/>
			<model:field name="bondProperty" mapping="BOND_PROPERTY" rule="require"/>
			<model:field name="otherProperty" mapping="OTHER_PROPERTY" rule="require"/>
		</model:record>
	</model:dataset>
	
	<!-- 家庭成员信息 只用作展示，rule可以不需定义,弹出窗口用 -->
	<model:dataset id="peopleListDataSetWin"
		cmd="com.inspur.cams.drel.application.cityLow.cmd.SamCityLowConfirmQueryCmd" global="true" method="queryPeopleAll">
		<model:record
			fromBean="com.inspur.cams.drel.application.cityLow.data.BaseinfoPeople">
			<model:field name="familyId" mapping="FAMILY_ID" />
			<model:field name="peopleId" mapping="PEOPLE_ID" />
			<model:field name="name" mapping="NAME" rule="require"/>
			<model:field name="birthday" mapping="BIRTHDAY" rule="require"/>
			<model:field name="idCard" mapping="ID_CARD" rule="require"/>
			<model:field name="relationshipType" mapping="RELATIONSHIP_TYPE" rule="require"/>
			<model:field name="healthCode" mapping="HEALTH_CODE" rule="require"/>
			<model:field name="disabilityLevelCode" mapping="DISABILITY_LEVEL_CODE" rule="require"/>
			<model:field name="employmentCode" mapping="EMPLOYMENT_CODE" rule="require"/>
			<model:field name="workUnitCharacter" mapping="WORK_UNIT_CHARACTER" rule="require"/>
			
			<model:field name="domicileCode" mapping="DOMICILE_CODE" />
			<model:field name="domicileName" mapping="DOMICILE_NAME" />
			<model:field name="regId" mapping="REG_ID" />
			<model:field name="regTime" mapping="REG_TIME" />
			<model:field name="regOrg" mapping="REG_ORG" />
			<model:field name="regOrgArea" mapping="REG_ORG_AREA" />
			<model:field name="regOrgName" mapping="REG_ORG_NAME" />
			<model:field name="regPeople" mapping="REG_PEOPLE" />
							
			<model:field name="incomeId" mapping="INCOME_ID" rule="require"/>
			<model:field name="salaryIncome" mapping="SALARY_INCOME" rule="require"/>
			<model:field name="manageIncome" mapping="MANAGE_INCOME" rule="require"/>
			<model:field name="propertyIncome" mapping="PROPERTY_INCOME" rule="require"/>
			<model:field name="transferIncome" mapping="TRANSFER_INCOME" rule="require"/>
			<model:field name="otherIncome" mapping="OTHER_INCOME" rule="require"/>
			
			<model:field name="propertyId" mapping="PROPERTY_ID" rule="require"/>
			<model:field name="bankStockProperty" mapping="BANK_STOCK_PROPERTY" rule="require"/>
			<model:field name="bondProperty" mapping="BOND_PROPERTY" rule="require"/>
			<model:field name="otherProperty" mapping="OTHER_PROPERTY" rule="require"/>
		</model:record>
	</model:dataset>

	<!-- 赡养人信息 -->
	<model:dataset id="lowSupportDataset"
		cmd="com.inspur.cams.drel.application.cityLow.cmd.SamLowSupportPeopleQueryCmd"
		global="true">
		<model:record
			fromBean="com.inspur.cams.drel.application.cityLow.data.SamLowSupportPeople"></model:record>
	</model:dataset>
	<!-- 赡养人信息，弹窗用 -->
	<model:dataset id="lowSupportDatasetWin"
		cmd="com.inspur.cams.drel.application.cityLow.cmd.SamLowSupportPeopleQueryCmd"
		global="true">
		<model:record
			fromBean="com.inspur.cams.drel.application.cityLow.data.SamLowSupportPeople"></model:record>
	</model:dataset>
	<!-- 可支配收入信息 -->
	<model:dataset id="lowPeopleIncomeDs"
		cmd="com.inspur.cams.drel.application.cityLow.cmd.SamLowPeopleIncomeQueryCmd"
		global="true">
		<model:record
			fromBean="com.inspur.cams.drel.application.cityLow.data.SamLowPeopleIncome"></model:record>
	</model:dataset>
	<!-- 家庭成员财产信息 -->
	<model:dataset id="lowPeoplePropertyDs"
		cmd="com.inspur.cams.drel.application.cityLow.cmd.SamLowPeoplePropertyQueryCmd"
		global="true">
		<model:record
			fromBean="com.inspur.cams.drel.application.cityLow.data.SamLowPeopleProperty"></model:record>
	</model:dataset>
	<!-- 审批信息 -->
	<model:dataset id="lowApplyInfoDs"
		cmd="com.inspur.cams.drel.application.cityLow.cmd.SamLowApplyInfoQueryCmd"
		global="true">
		<model:record
			fromBean="com.inspur.cams.drel.application.cityLow.data.SamLowApplyInfo"></model:record>
	</model:dataset>
	<!-- 数据源区域 -->
	<!-- 与户主关系 -->
	<model:dataset id="relationshipTypeDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_RELATIONSHIP_TYPE'></model:param>
		</model:params>
	</model:dataset>
	<!-- 民族 -->
	<model:dataset id="NationDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 性别代码-->
	<model:dataset id="sexDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SEX'></model:param>
		</model:params>
	</model:dataset>
	
	<!-- 同意不同意 -->
	<model:dataset id="agreeDataset" enumName="COMM.AGREEORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 房屋属性 -->
	<model:dataset id="houseStatusDataset" enumName="SAM_FAMILY.HOUSEINGSTATETYPE" autoLoad="true" global="true"></model:dataset>
	
	<!-- 健康状况 -->
	<model:dataset id="healthCodeDataset" enumName="SAM_HEALTH_CODE" autoLoad="true" global="true"></model:dataset>
	
	<!-- 残疾类别 -->
	<model:dataset id="disabilityTypeDataset"cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_DISABILITY_TYPE'></model:param>
		</model:params>
	</model:dataset>
	<!-- 残疾等级 -->
	<model:dataset id="DmCjdjDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_HANDICAP_LEVEL'></model:param>
		</model:params>
	</model:dataset>
	<!-- 职业状况 -->
	<model:dataset id="employmentDataset" enumName="EMPLOYMENT.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 单位性质 -->
	<model:dataset id="unitNatureDataset" enumName="SAM_UNIT_NATURE" autoLoad="true" global="true"></model:dataset>

	<!-- 字典项区域 -->

</model:datasets>
<next:Panel height="100%" autoScroll="true" id="tab">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="undo" text="关闭" handler="returnBack" />
	</next:TopBar>
	<next:Panel title="家庭基本信息" titleCollapse="true" collapsible="true"
		autoHeight="true" autoScroll="true">

		<next:Html>
			<form method="post" onsubmit="return false" class="L5form"
				dataset="familyDataSet">
			<table width="100%">
				<input type="hidden" field="familyId" value="1" id="familyId" />

				<tr>
					<td class="FieldLabel" style="width: 15%">户主姓名</td>
					<td class="FieldInput" style="width: 18%"><label
						maxlength="25" id="familyName" title="户主姓名" 
						field="familyName" /></td>
					<td class="FieldLabel" style="width: 15%">性別</td>
					<td class="FieldInput" style="width: 18%">
					<label id="sex" title="性別"  field="sex" dataset="sexDataset"></label>
					<input type="hidden" id="sex" title="性別"  /></td>

					<td class="FieldLabel" style="width: 15%">身份证号</td>
					<td class="FieldInput" style="width: 18%"><label
						maxlength="18" id="familyCardNo" name="身份证号" title="身份证号"
						field="familyCardNo"  /></td>

				</tr>
				<tr>
					<td class="FieldLabel" style="width: 15%">民族</td>
					<td class="FieldInput" style="width: 18%">
					<label id="nation" title="民族" field="nation"  dataset="NationDataset"></label>
					
					<td class="FieldLabel" style="width: 15%">年龄</td>
					<td class="FieldInput" style="width: 18%"><label id="age"
						 name="年龄" field="age" title="年龄"></label></td>
					<td class="FieldLabel" style="width: 15%">联系电话</td>
					<td class="FieldInput" style="width: 18%"><label
						name="familyMobile" title="联系电话" 
						field="familyMobile" /></td>

				</tr>
				<tr>
					<td class="FieldLabel" style="width: 15%">户口所在地</td>
					<td class="FieldInput" style="width: 18%" colspan="5">
						<label title="户口所在地" name="apanageName" id="apanageName" field="apanageName" />
						<label style="display: none;"  name="apanageCode" id="apanageCode" field="apanageCode" />
						
						</td>

				</tr>
				<tr>
					<td class="FieldLabel" style="width: 15%">现居住地</td>
					<td class="FieldInput" style="width: 18%" colspan="5"><label id="juzhudi" name="juzhudi" title="现居住地" 
						field="address" /></td>

				</tr>

				<tr>
					<td class="FieldLabel" style="width: 15%">工作单位</td>
					<td class="FieldInput" style="width: 18%" colspan="5"><label name="note" title="工作单位" 
						field="note" /></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width: 15%">房屋属性</td>
					<td class="FieldInput" style="width: 18%">
					<label name="houseStatus" title="房屋属性" field="houseStatus" dataset="houseStatusDataset"></label>
					
					<td class="FieldLabel" style="width: 15%">住房面积</td>
					<td class="FieldInput" style="width: 18%"><label
						name="buildArea" title="住房面积"  field="buildArea" ></label></td>
					<td class="FieldLabel" style="width: 15%" ></td>
					<td class="FieldInput" style="width: 18%"></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width: 15%">车辆情况</td>
					<td class="FieldInput" style="width: 18%"><label
						name="车辆情况" title="车辆情况"  value="品牌"
						field="checkOrgName" /></td>
					<td class="FieldLabel" style="width: 15%">价值</td>
					<td class="FieldInput" style="width: 18%"><label
						name="价值" title="价值"  field="checkOrgArea"/></td>
					<td class="FieldLabel" style="width: 15%"></td>
					<td class="FieldInput" style="width: 18%"></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width: 15%">家庭人口</td>
					<td class="FieldInput" style="width: 18%"><label
						name="peopleNum" title="家庭人口"  field="peopleNum" /></td>
					<td class="FieldLabel" style="width: 15%">年可支配收入（元）</td>
					<td class="FieldInput" style="width: 18%"><label
						name="yearIncome" field="yearIncome" title="年可支配收入"
						 /></td>
					<td class="FieldLabel" style="width: 15%">年人均可支配收入（元）</td>
					<td class="FieldInput" style="width: 18%"><label
						name="yearAverageIncome" field="yearAverageIncome"
						title="年人均可支配收入"  /></td>
				</tr>
				<input type="hidden" field="assistanceType" value="D2" />
				<input type="hidden" field="assistanceTypeName" value="城市低收入救助" />
			</table>
			</form>
		</next:Html>
	</next:Panel>

	<next:GridPanel id="peoplePanel" titleCollapse="true"
		dataset="peopleListDataSet" collapsible="true" stripeRows="true"
		autoHeight="true" autoScroll="true" autoWidth="true" title="家庭成员基本信息">
		
		<next:Columns>
			<next:RowNumberColumn />
			<next:RadioBoxColumn></next:RadioBoxColumn>
			<next:Column id="familyId" header="xxx姓名" width="100" field="familyId" hidden="TRUE">
				<next:TextField editable="false" />
			</next:Column>
			<next:Column id="peopleId" header="xx姓名" width="100" field="peopleId" hidden="true">
				<next:TextField editable="false" />
			</next:Column>
			<next:Column id="name" header="姓名" width="100" field="name" renderer="showPeopleMsg()">
				<next:TextField editable="false" />
			</next:Column>
			<next:Column header="与户主关系" width="80" field="relationshipType">
				<next:ComboBox dataset="relationshipTypeDataset"></next:ComboBox>
			</next:Column>
			<next:Column header="出生日期" width="80" field="birthday">
				<next:TextField editable="false" />
			</next:Column>
			<next:Column header="身份证号码" width="80" field="idCard">
				<next:TextField editable="false" />
			</next:Column>
			<next:Column header="健康状况" width="80" field="healthCode">
				<next:ComboBox dataset="healthCodeDataset"></next:ComboBox>
			</next:Column>
			<next:Column header="残废等级" width="80" field="disabilityLevelCode">
				<next:ComboBox dataset="DmCjdjDataSet"></next:ComboBox>
			</next:Column>
			<next:Column header="职业状况" width="80" field="employmentCode">
				<next:ComboBox dataset="employmentDataset"></next:ComboBox>
			</next:Column>
			<next:Column header="单位性质" width="80" field="workUnitCharacter">
				<next:ComboBox dataset="unitNatureDataset"></next:ComboBox>
			</next:Column>
			<next:Column header="工资性收入" width="80" field="salaryIncome">
				<next:TextField editable="false" />
			</next:Column>
			<next:Column header="经营性收入" width="80" field="manageIncome">
				<next:TextField editable="false" />
			</next:Column>
			<next:Column header="财产性收入" width="80" field="propertyIncome">
				<next:TextField editable="false" />
			</next:Column>
			<next:Column header="转移性收入" width="80" field="transferIncome">
				<next:TextField editable="false" />
			</next:Column>
			<next:Column header="其他收入" width="80" field="otherIncome">
				<next:TextField editable="false" />
			</next:Column>
			<next:Column header="银行存款和有价证券" width="80" field="bankStockProperty">
				<next:TextField editable="false" />
			</next:Column>
			<next:Column header="债券" width="80" field="bondProperty">
				<next:TextField editable="false" />
			</next:Column>
			<next:Column header="其他财产" width="80" field="otherProperty">
				<next:TextField editable="false" />
			</next:Column>
		</next:Columns>
	</next:GridPanel>

	<next:GridPanel id="supportPanel" titleCollapse="true"
		dataset="lowSupportDataset" collapsible="true" stripeRows="true"
		autoHeight="true" title="赡养（抚养、义务）人员信息">
		<next:Columns>
			<next:RowNumberColumn />
			<next:RadioBoxColumn></next:RadioBoxColumn>
			<next:Column header="姓名xxxx" width="100" field="supportId" hidden="true">
				<next:TextField />
			</next:Column>
			<next:Column header="姓名xxxx" width="100" field="familyId" hidden="true">
				<next:TextField />
			</next:Column>
			<next:Column header="姓名" width="100" field="supportName" renderer="showSupportMsg()">
				<next:TextField />
			</next:Column>
			<next:Column header="与户主关系" width="149" field="releationType">
				<next:ComboBox dataset="relationshipTypeDataset"></next:ComboBox>
			</next:Column>
			<next:Column header="身份证号码" width="149" field="supportCardNo">
				<next:TextField />
			</next:Column>
			<next:Column header="家庭人口" width="140" field="supportFamilyNum">
				<next:TextField />
			</next:Column>
			<next:Column header="职业状况" width="178" field="occupationCondition">
				<next:ComboBox dataset="employmentDataset"></next:ComboBox>
			</next:Column>
			<next:Column header="月总收入（元）" width="178" field="monthIncome">
				<next:TextField />
			</next:Column>
			<next:Column header="月人均收入（元）" width="178" field="monthAveIncome">
				<next:TextField />
			</next:Column>
		</next:Columns>
	</next:GridPanel>


	<next:Panel title="审核信息" id="checkDetailPanel" titleCollapse="true"
		collapsible="true" autoHeight="true" autoScroll="true">
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			
			<next:ToolBarItem iconCls="undo" text="关闭" handler="returnBack" />

		</next:TopBar>
		<next:Html>
			<form method="post" onsubmit="return false" class="L5form"
				dataset="lowApplyInfoDs">
			<fieldset><legend>申请理由</legend>
			<table width="100%">
				<tr>
					<td class="FieldLabel" width="15%">申请理由</td>
					<td class="FieldInput" width="35%" colspan="3">
					<label field="applyNote" /></td>
				</tr><tr>
					<td class="FieldLabel" width="15%">申请人</td>
					<td class="FieldInput" width="35%" ><label
						field="applyName"/></td>
					<td class="FieldLabel" width="15%">申请日期</td>
					<td class="FieldInput" width="35%" ><label
						field="applyDate" /></td>

				</tr>
			</table>
			</fieldset>
			</form>
			<form method="post" onsubmit="return false" class="L5form"
				dataset="lowApplyInfoDs">
			<fieldset><legend>乡镇人民政府（街道办事处）初审意见</legend>
			<table width="100%">
				<tr>
					<td class="FieldLabel" width="15%">初审意见</td>
					<td class="FieldInput" width="35%" colspan="3"><label
						field="townOpinion" dataset="agreeDataset"></label></td>
				</tr><tr>
					<td class="FieldLabel" width="15%">负责人</td>
					<td class="FieldInput" width="35%" ><label
						field="townPeople"/></td>
					<td class="FieldLabel" width="15%">日期</td>
					<td class="FieldInput" width="35%" ><label
						field="townDate"/></td>

				</tr>
			</table>
			</fieldset>
			</form>
			<form method="post" onsubmit="return false" class="L5form"
				dataset="lowApplyInfoDs">
			<fieldset><legend>县（市）区住房保障部门审核意见</legend>
			<table width="100%">
				<tr>
					<td class="FieldLabel" width="15%">审核意见</td>
					<td class="FieldInput" width="35%" colspan="3"><label
						field="houseCheckOpinion" dataset="agreeDataset"></label></td>
				</tr><tr>
					<td class="FieldLabel" width="15%">审核人</td>
					<td class="FieldInput" width="35%" ><label
						field="houseCheckPeople"/></td>
					<td class="FieldLabel" width="15%"></td>
					<td class="FieldInput" width="35%" ></td>

				</tr>
			</table>
			</fieldset>
			</form>
			<form method="post" onsubmit="return false" class="L5form"
				dataset="lowApplyInfoDs">
			<fieldset><legend>县市区民政部门家庭收入核定意见</legend>
			<table width="100%">
				<tr>
					<td class="FieldLabel" width="15%">核定意见</td>
					<td class="FieldInput" width="35%" colspan="3"><label
						field="incomeAppraiseOpinion" dataset="agreeDataset"></label></td>
				</tr><tr>
					<td class="FieldLabel" width="15%">区民政局</td>
					<td class="FieldInput" width="35%" ><label
						field="incomeAppraisePeople"/></td>
					<td class="FieldLabel" width="15%">日期</td>
					<td class="FieldInput" width="35%" ><label
						field="incomeAppraiseDate" /></td>

				</tr>
			</table>
			</fieldset>
			</form>
			<form method="post" onsubmit="return false" class="L5form"
				dataset="lowApplyInfoDs">
			<fieldset><legend>县（市）区住房保障部门审批意见</legend>
			<table width="100%">
				<tr>
					<td class="FieldLabel" width="15%">审批意见</td>
					<td class="FieldInput" width="35%" colspan="3" ><label
						field="houseApproveOpinion" dataset="agreeDataset"></label></td>
				</tr><tr>

					<td class="FieldLabel" width="15%">负责人</td>
					<td class="FieldInput" width="35%" ><label
						field="houseApprovePeople"></label></td>
					<td class="FieldLabel" width="15%">日期</td>
					<td class="FieldInput" width="35%" ><label
						field="houseApproveDate" /></td>

				</tr>
			</table>
			</fieldset>
			</form>

		</next:Html>
	</next:Panel>
</next:Panel>
<next:Window id="peopleWin" closeAction="hide" title="家庭成员明细" width="850" modal="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="关闭" handler="closePeopleWin"></next:ToolBarItem>		
	</next:TopBar>
	<next:Html>
		<form id="BaseinfoPeopleForm" method="post" onsubmit="return false" dataset="peopleListDataSetWin"
			 class="L5form">
		<table border="0" width="100%">
			<tr>
				<td class="FieldLabel" width="15%">姓名</td>
				<td class="FieldInput" width="18%">
				<input type="hidden"  field="familyId" name="familyId">
				<input type="hidden" field="peopleId" name="peopleId">
				
				<label name="name" title="姓名" field="name" /></td>
				<td class="FieldLabel">身份证号</td>
				<td class="FieldInput"><input name="idCard" title="身份证号" id='idCard'  field="idCard" onblur="getBirthday(this.value)"></td>
				
				<td class="FieldLabel" width="15%">出生日期</td>
				<td class="FieldInput" width="18%"><label field="birthday"
							name="birthday" title="出生日期"   format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly" />
			</tr>
		
			<tr><td class="FieldLabel" width="15%">与户主的关系</td>
				<td class="FieldInput" width="18%">
					<label title="与户主的关系" name="relationshipType" id="relationshipType" field="relationshipType" dataset="relationshipTypeDataset"></label>
					<input type="hidden" title="与户主的关系" name="relationshipType"/>
				
				<td class="FieldLabel">健康状况</td>
				<td class="FieldInput">
					<label name="healthCode" title="健康状况" id='healthCode'  field="healthCode" onchange="isdisablity(this)" dataset="healthCodeDataset"></label>
				</td>
			   	<td class="FieldLabel">残疾等级</td>
				<td class="FieldInput">
					<label name="disabilityLevelCode" title="残疾等级" id="disabilityLevel" field="disabilityLevelCode" disabled="disabled" dataset="DmCjdjDataSet"></label>
				</td>
			
			</tr>
			<tr>
				<td class="FieldLabel">职业状况</td>
				<td class="FieldInput">
					<label name="employmentCode" title="职业状况"  field="employmentCode" onchange="iswork(this)" dataset="employmentDataset"></label>
				</td>
				<td class="FieldLabel">单位性质</td>
				<td class="FieldInput">
					<label name="workUnitCharacter" title="单位性质"  field="workUnitCharacter" id="workUnitCharacter"  dataset="unitNatureDataset"></label>
				</td>
				<td class="FieldLabel"></td>
				<td class="FieldInput"><input type="hidden" field="nation" name="nation">
				<input type="hidden" field="sex" name="sex"></td>
            </tr>
            <tr>
				<td class="FieldLabel">工资性收入</td>
				<td class="FieldInput">
				<input type="hidden" id="salaryId" field="salaryId"/>
				<label name="salaryIncome" title="工资性收入" id="salaryIncome" field="salaryIncome" /> </td>
			
				<td class="FieldLabel">经营性净收入</td>
				<td class="FieldInput"><label name="manageIncome" title="经营性净收入" id="manageIncome" field="manageIncome" /></td>
				<td class="FieldLabel">财产性收入</td>
				<td class="FieldInput"><label name="propertyIncome" title="财产性收入"  id="propertyIncome" field="propertyIncome"	/></td>
            </tr>
             <tr>
				<td class="FieldLabel">转移性收入</td>
				<td class="FieldInput"><label name="transferIncome" title="转移性收入" id="transferIncome" field="transferIncome" onkeypress="var k=event.keyCode; if (((k==46)||(k <=57 && k>=48)) &&(k!=102)) return true;else return false"> </td>
			
				<td class="FieldLabel">其他收入</td>
				<td class="FieldInput"><label name="otherIncome" title="其他收入"  id="otherIncome" field="otherIncome" onkeypress="var k=event.keyCode; if (((k==46)||(k <=57 && k>=48)) &&(k!=102)) return true;else return false"></td>
				<td class="FieldLabel"></td>
				<td class="FieldInput"></td>
            </tr>
              <tr>
				<td class="FieldLabel">银行存款和有价证券</td>
				<td class="FieldInput">
				<input type="hidden" id="propertyId" field="propertyId"/>
				<label name="bankStockProperty" title="银行存款和有价证券" id="bankStockProperty" field="bankStockProperty" onkeypress="var k=event.keyCode; if (((k==46)||(k <=57 && k>=48)) &&(k!=102)) return true;else return false"> </td>
			
				<td class="FieldLabel">债权</td>
				<td class="FieldInput"><label name="bondProperty" title="债权" id="bondProperty" field="bondProperty" onkeypress="var k=event.keyCode; if (((k==46)||(k <=57 && k>=48)) &&(k!=102)) return true;else return false"></td>
				<td class="FieldLabel">其他财产</td>
				<td class="FieldInput"><label name="otherProperty" title="其他财产" id="otherProperty" field="otherProperty" onkeypress="var k=event.keyCode; if (((k==46)||(k <=57 && k>=48)) &&(k!=102)) return true;else return false"></td>
            </tr>
		</table>
		</form>
   </next:Html>
</next:Window>	
<next:Window id="supportWin" closeAction="hide" title="赡养人信息" width="850" modal="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="关闭" handler="closeSupportWin"></next:ToolBarItem>		
	</next:TopBar>
	<next:Html>
		<form id="form_content" method="post" onsubmit="return false" class="L5form" dataset="lowSupportDatasetWin">
		<table width="100%">
			<tr>
				<td class="FieldLabel" style="width: 15%">姓名</td>
				<td class="FieldInput" style="width: 35%"><label field="supportName" title="姓名" /> </td>
				<td class="FieldLabel" style="width: 15%">身份证号</td>
				<td class="FieldInput" style="width: 35%">
				<label field="supportCardNo" title="身份证号"/> </td>
						
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%">与户主关系</td>
				<td class="FieldInput" style="width: 35%">
				<label title="与户主的关系" name="releationType" field="releationType" dataset="relationshipTypeDataset"></label>				
				</td>
				<td class="FieldLabel" style="width: 15%">家庭人口数</td>
				<td class="FieldInput" style="width: 35%">
				<label id="supportFamilyNum" field="supportFamilyNum" title="赡养人家庭人口数" /></td>
				
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%">职业状况</td>
				<td class="FieldInput" style="width: 35%">
					<label name="employmentCode" title="职业状况"  field="occupationCondition" dataset="employmentDataset"></label>
				</td>
				<td class="FieldLabel" style="width: 15%"></td>
				<td class="FieldInput" style="width: 35%"></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%">月总收入（元）</td>
				<td class="FieldInput" style="width: 35%">
				<label field="monthIncome" id="monthIncome" title="月总收入（元）" /></td>
				<td class="FieldLabel" style="width: 15%">月人均收入（元）</td>
				<td class="FieldInput" style="width: 35%"><label field="monthAveIncome" id="monthAveIncome" title="月人均收入（元）" /></td>
			</tr>
				
		</table>
		</form>
   </next:Html>
</next:Window>	

</body>
</html>
