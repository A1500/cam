<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.*"%>

<html>
<head>
<title>城市低收入新申请录入页面</title>
<next:ScriptManager />
<script type="text/javascript">
		<%
		String method=request.getParameter("method");//新增还是修改
		String familyId=request.getParameter("familyId");//业务主键
		String from =request.getParameter("from");//
		
		%>
		<%
	    String organArea=BspUtil.getCorpOrgan().getOrganCode();
		String organName=DicUtil.getTextValueFromDic("DIC_CITY","ID",organArea,"NAME");
	    %>
	    var organCode="<%=BspUtil.getCorpOrgan().getOrganCode()%>";
		var organArea='<%=organArea%>';
		var organName='<%=organName%>';
		var method="<%=method%>";
		var familyId="<%=familyId%>";
		var from="<%=from%>";
		var nowDate=getNowDate();
	function getNowDate(){
		var date = new Date();
		var year = date.getFullYear();
		var month = date.getMonth()+1;
		if(month<10){
			month="0"+month;
		}
		var dateOfMonth = date.getDate();
		return nowDate =year+"-"+month+"-"+dateOfMonth;
	}
		
</script>
<script type="text/javascript" src="cityLowfamilyConfirm.js"></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
	<script type="text/javascript" src="<%=SkinUtils.getJS(request,"cams.js") %>"></script>


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
								
				<model:field name="incomeId" mapping="INCOME_ID" type="string"/>
				<model:field name="salaryIncome" mapping="SALARY_INCOME" rule="require"  type="string"/>
				<model:field name="manageIncome" mapping="MANAGE_INCOME" rule="require"  type="string"/>
				<model:field name="propertyIncome" mapping="PROPERTY_INCOME" rule="require"  type="string"/>
				<model:field name="transferIncome" mapping="TRANSFER_INCOME" rule="require" type="string"/>
				<model:field name="otherIncome" mapping="OTHER_INCOME" rule="require"  type="string"/>
				<model:field name="totalIncome" mapping="TOTAL_INCOME" rule="require"  type="string"/>
				
				<model:field name="propertyId" mapping="PROPERTY_ID"   type="string"/>
				<model:field name="bankStockProperty" mapping="BANK_STOCK_PROPERTY" rule="require" type="string"/>
				<model:field name="bondProperty" mapping="BOND_PROPERTY" rule="require" type="string"/>
				<model:field name="otherProperty" mapping="OTHER_PROPERTY" rule="require" type="string"/>
				<model:field name="totalProperty" mapping="TOTAL_PROPERTY" rule="require" type="string"/>
			</model:record>
		</model:dataset>
	

	<!-- 赡养人信息 -->
	<model:dataset id="lowSupportDataset"
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
	<!-- 房屋属性 -->
	<model:dataset id="houseStatusDataset" enumName="SAM_FAMILY.HOUSEINGSTATETYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 同意不同意 -->
	<model:dataset id="agreeDataset" enumName="COMM.AGREEORNO" autoLoad="true" global="true"></model:dataset>
	
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
		<next:ToolBarItem id="saveId" iconCls="save" text="保存" disabled=""
			handler="saveFamily" />
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
					<td class="FieldInput" style="width: 18%"><input type="text"
						maxlength="25" id="familyName" title="户主姓名" style="width: 80%"
						field="familyName" /></td>
					<td class="FieldLabel" style="width: 15%">性別</td>
					<td class="FieldInput" style="width: 18%">
					<select id="sex" title="性別" style="width: 80%" field="sex" >
						<option dataset="sexDataset"></option>
					</select>
					<input type="hidden" id="sex" title="性別" style="width: 80%" /></td>

					<td class="FieldLabel" style="width: 15%">身份证号</td>
					<td class="FieldInput" style="width: 18%"><input type="text"
						maxlength="18" id="familyCardNo" name="身份证号" title="身份证号" 
						field="familyCardNo" style="width: 80%" onblur="getHuzhuAge()"/></td>

				</tr>
				<tr>
					<td class="FieldLabel" style="width: 15%">民族</td>
					<td class="FieldInput" style="width: 18%">
					
					<select id="nation" title="民族" field="nation" style="width: 80%" >
						<option dataset="NationDataset"></option>
					</select>
					
					<td class="FieldLabel" style="width: 15%">年龄</td>
					<td class="FieldInput" style="width: 18%"><label id="age"
						 name="年龄" field="age" title="年龄"></label></td>
					<td class="FieldLabel" style="width: 15%">联系电话</td>
					<td class="FieldInput" style="width: 18%"><input type="text"
						name="familyMobile" title="联系电话" style="width: 80%"
						field="familyMobile" /></td>

				</tr>
				<tr>
					<td class="FieldLabel" style="width: 15%">户口所在地</td>
					<td class="FieldInput" style="width: 18%" colspan="5">
						<input type="text" readonly title="户口所在地" name="apanageName" id="apanageName" field="apanageName" />
						<input type="text" style="display: none;"  name="apanageCode" id="apanageCode" field="apanageCode" />
						<img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>"  style="cursor:hand" onclick="func_ForDomicileSelect()" />
						<font color="red">*</font> 
						</td>

				</tr>
				<tr>
					<td class="FieldLabel" style="width: 15%">现居住地</td>
					<td class="FieldInput" style="width: 18%" colspan="5"><input
						type="text" id="juzhudi" name="juzhudi" title="现居住地" style="width: 80%"
						field="address" /></td>

				</tr>

				<tr>
					<td class="FieldLabel" style="width: 15%">工作单位</td>
					<td class="FieldInput" style="width: 18%" colspan="5"><input
						type="text" name="note" title="工作单位" style="width: 80%"
						field="note" /></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width: 15%">房屋属性</td>
					<td class="FieldInput" style="width: 18%">
					<select name="houseStatus" title="房屋属性" field="houseStatus">
						<option dataset="houseStatusDataset"></option>
					</select>
					
					<input type="hidden"
						name="houseStatus" title="房屋属性" style="width: 80%"
						field="houseStatus" /></td>
					<td class="FieldLabel" style="width: 15%">住房面积</td>
					<td class="FieldInput" style="width: 18%"><input type="text"
						name="buildArea" title="住房面积" style="width: 80%" field="buildArea" 
						onkeypress="var k=event.keyCode; if (((k==46)||(k <=57 && k>=48)) &&(k!=102)) return true;else return false"/></td>
					<td class="FieldLabel" style="width: 15%" >人均住房面积</td>
					<td class="FieldInput" style="width: 18%"><label id="buildAverageArea" field="buildAverageArea"></label></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width: 15%">车辆情况</td>
					<td class="FieldInput" style="width: 18%"><input type="text"
						name="车辆情况" title="车辆情况,请输入品牌" style="width: 80%" value="品牌"
						field="checkOrgName" /></td>
					<td class="FieldLabel" style="width: 15%">价值</td>
					<td class="FieldInput" style="width: 18%"><input type="text"
						name="价值" title="价值" style="width: 80%" field="checkOrgArea" 
						onkeypress="var k=event.keyCode; if (((k==46)||(k <=57 && k>=48)) &&(k!=102)) return true;else return false" /></td>
					<td class="FieldLabel" style="width: 15%"></td>
					<td class="FieldInput" style="width: 18%"></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width: 15%">家庭人口</td>
					<td class="FieldInput" style="width: 18%"><label
						name="peopleNum" title="家庭人口" style="width: 80%" field="peopleNum" /></td>
					<td class="FieldLabel" style="width: 15%">年可支配收入（元）</td>
					<td class="FieldInput" style="width: 18%"><label
						name="yearIncome" field="yearIncome" title="年可支配收入"
						style="width: 80%" /></td>
					<td class="FieldLabel" style="width: 15%">年人均可支配收入（元）</td>
					<td class="FieldInput" style="width: 18%"><label
						name="yearAverageIncome" field="yearAverageIncome"
						title="年人均可支配收入" style="width: 80%" /></td>
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
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="add" text="新增" handler="newPeople" id="newPeople"/>
			<next:ToolBarItem iconCls="edit" text="修改" handler="editPeople" />
			<next:ToolBarItem iconCls="remove" text="删除" handler="delPeople" />
		</next:TopBar>

		<next:Columns>
			<next:RowNumberColumn />
			<next:RadioBoxColumn></next:RadioBoxColumn>
			<next:Column id="familyId" header="xxx姓名" width="100" field="familyId" hidden="TRUE">
				<next:TextField editable="false" />
			</next:Column>
			<next:Column id="peopleId" header="xx姓名" width="100" field="peopleId" hidden="true">
				<next:TextField editable="false" />
			</next:Column>
			<next:Column id="name" header="姓名" width="100" field="name">
				<next:TextField editable="false" />
			</next:Column>
			<next:Column header="与户主关系" width="80" field="relationshipType">
				<next:ComboBox dataset="relationshipTypeDataset"></next:ComboBox>
			</next:Column>
			<next:Column header="出生日期" width="80" field="birthday">
				<next:TextField editable="false" />
			</next:Column>
			<next:Column header="身份证号码" width="180" field="idCard">
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
			<next:Column header="总收入" width="80" field="totalIncome" align="right">
				<next:TextField editable="false" />
			</next:Column>
			<next:Column header="工资性收入" width="80" field="salaryIncome" hidden="true">
				<next:TextField editable="false" />
			</next:Column>
			<next:Column header="经营性收入" width="80" field="manageIncome" hidden="true">
				<next:TextField editable="false" />
			</next:Column>
			<next:Column header="财产性收入" width="80" field="propertyIncome" hidden="true">
				<next:TextField editable="false" />
			</next:Column>
			<next:Column header="转移性收入" width="80" field="transferIncome" hidden="true">
				<next:TextField editable="false" />
			</next:Column>
			<next:Column header="其他收入" width="80" field="otherIncome" hidden="true">
				<next:TextField editable="false" />
			</next:Column>
			<next:Column header="总收资产" width="80" field="totalProperty" align="right">
				<next:TextField editable="false" />
			</next:Column>
			<next:Column header="银行存款和有价证券" width="80" field="bankStockProperty"hidden="true">
				<next:TextField editable="false" />
			</next:Column>
			<next:Column header="债券" width="80" field="bondProperty" hidden="true">
				<next:TextField editable="false" />
			</next:Column>
			<next:Column header="其他财产" width="80" field="otherProperty" hidden="true">
				<next:TextField editable="false" />
			</next:Column>
		</next:Columns>
	</next:GridPanel>

	<next:GridPanel id="supportPanel" titleCollapse="true"
		dataset="lowSupportDataset" collapsible="true" stripeRows="true"
		autoHeight="true" title="赡养（抚养、义务）人员信息">
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="add" text="新增" handler="newSupport" id="newSupport" />
			<next:ToolBarItem iconCls="edit" text="修改" handler="editSupport" />
			<next:ToolBarItem iconCls="remove" text="删除" handler="delSupport" />

		</next:TopBar>

		<next:Columns>
			<next:RowNumberColumn />
			<next:RadioBoxColumn></next:RadioBoxColumn>
			<next:Column header="姓名" width="100" field="supportName">
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
		
		<next:Html>
			<form method="post" onsubmit="return false" class="L5form"
				dataset="lowApplyInfoDs">
			<fieldset><legend>申请理由</legend>
			<table width="100%">
				<tr>
					<td class="FieldLabel" width="15%">申请理由</td>
					<td class="FieldInput" width="35%" colspan="3">
						<textarea cols="150" rows="3" field="applyNote" ></textarea>
					</td>
				</tr><tr>
					<td class="FieldLabel" width="15%">申请人</td>
					<td class="FieldInput" width="35%" >
					<input type="text"	field="applyName"></td>
					<td class="FieldLabel" width="15%">申请日期</td>
					<td class="FieldInput" width="35%" ><input type="text"
						field="applyDate" format="Y-m-d" onclick="LoushangDate(this)"
						readonly="readonly"></td>

				</tr>
			</table>
			</fieldset>
			</form>
			<form method="post" onsubmit="return false" class="L5form"
				dataset="lowApplyInfoDs">
			<fieldset><legend>乡镇人民政府（街道办事处）初审意见</legend>
			<table width="100%">
				<tr>
					<td class="FieldLabel" width="10%">初审意见</td>
					<td class="FieldInput" width="30%" colspan="3">
					<textarea cols="150" rows="3" field="townOpinion" ></textarea>
					</td>
				</tr><tr>
					<td class="FieldLabel" width="10%">负责人</td>
					<td class="FieldInput" width="20%" ><input type="text" field="townPeople"></td>
					<td class="FieldLabel" width="10%">日期</td>
					<td class="FieldInput" width="20%" >
					<input type="text"
						field="townDate" format="Y-m-d" onclick="LoushangDate(this)"
						readonly="readonly"></td>

				</tr>
			</table>
			</fieldset>
			</form>
			<form method="post" onsubmit="return false" class="L5form"
				dataset="lowApplyInfoDs">
			<fieldset><legend>县（市）区住房保障部门审核意见</legend>
			<table width="100%">
				<tr>
					<td class="FieldLabel" width="10%">审核意见</td>
					<td class="FieldInput" width="30%" colspan="3">
					<textarea cols="150" rows="3" field="houseCheckOpinion" ></textarea>
					</td>
			</tr><tr>
					<td class="FieldLabel" width="10%">审核人</td>
					<td class="FieldInput" width="20%" ><input type="text"
						field="houseCheckPeople"></td>
					<td class="FieldLabel" width="10%"></td>
					<td class="FieldInput" width="20%" ></td>

				</tr>
			</table>
			</fieldset>
			</form>
			<form method="post" onsubmit="return false" class="L5form"
				dataset="lowApplyInfoDs">
			<fieldset><legend>县市区民政部门家庭收入核定意见</legend>
			<table width="100%">
				<tr>
					<td class="FieldLabel" width="10%">核定意见</td>
					<td class="FieldInput" width="30%" colspan="3">
					<textarea cols="150" rows="3" field="incomeAppraiseOpinion" ></textarea>
					</td>
					</tr><tr>
					<td class="FieldLabel" width="10%">区民政局</td>
					<td class="FieldInput" width="20%" ><input type="text"
						field="incomeAppraisePeople"></td>
					<td class="FieldLabel" width="10%">日期</td>
					<td class="FieldInput" width="20%" ><input type="text"
						field="incomeAppraiseDate" format="Y-m-d"
						onclick="LoushangDate(this)" readonly="readonly"></td>

				</tr>
			</table>
			</fieldset>
			</form>
			<form method="post" onsubmit="return false" class="L5form"
				dataset="lowApplyInfoDs">
			<fieldset><legend>县（市）区住房保障部门审批意见</legend>
			<table width="100%">
				<tr>
					<td class="FieldLabel" width="10%">审批意见</td>
					<td class="FieldInput" width="30%"  colspan="3">
					<textarea cols="150" rows="3" field="houseApproveOpinion" ></textarea>
					</td>
				</tr><tr>
					<td class="FieldLabel" width="10%">负责人</td>
					<td class="FieldInput" width="20%" ><input type="text"
						field="houseApprovePeople"></td>
					<td class="FieldLabel" width="10%">日期</td>
					<td class="FieldInput" width="20%" ><input type="text"
						field="houseApproveDate" format="Y-m-d"
						onclick="LoushangDate(this)" readonly="readonly">
					</td>
				</tr>
			</table>
			</fieldset>
			</form>
		</next:Html>
	</next:Panel>
</next:Panel>

<jsp:include page="../../../comm/newIdCard.jsp" flush="true"></jsp:include>


</body>
</html>
