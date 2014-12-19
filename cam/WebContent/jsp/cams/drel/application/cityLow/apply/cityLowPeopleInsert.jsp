<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<html>
<head>
<title>家庭成员基本信息</title>
<next:ScriptManager/>
<script type="text/javascript">
		<%
		String method=request.getParameter("method");//新增还是修改
		String peopleId=request.getParameter("peopleId");//业务主键
		String familyId=request.getParameter("familyId");//业务主键
		
		%>
		var method='<%=method%>' ;
		var peopleId='<%=peopleId%>';
		var familyId='<%=familyId%>' ;
</script>

<script type="text/javascript" src="cityLowPeopleInsert.js"></script>

</head>
<body>
<model:datasets>
	<!-- 家庭成员信息 -->
	<model:dataset id="peopleListDataSet" cmd="com.inspur.cams.drel.application.cityLow.cmd.SamCityLowConfirmQueryCmd" global="true" method="queryPeopleAll">
		<model:record fromBean="com.inspur.cams.drel.application.cityLow.data.BaseinfoPeople">
				<model:field name="familyId" mapping="FAMILY_ID" />
				<model:field name="peopleId" mapping="PEOPLE_ID" />
				<model:field name="name" mapping="NAME" rule="require"/>
				<model:field name="nation" mapping="NATION" rule="require"/>
				<model:field name="sex" mapping="SEX" rule="require"/>
				<model:field name="birthday" mapping="BIRTHDAY" rule="require"/>
				<model:field name="idCard" mapping="ID_CARD" rule="require"/>
				<model:field name="relationshipType" mapping="RELATIONSHIP_TYPE" rule="require"/>
				<model:field name="healthCode" mapping="HEALTH_CODE" rule="require"/>
				<model:field name="diseaseType" mapping="DISEASE_TYPE" />
				<model:field name="disabilityType" mapping="DISABILITY_TYPE" />
				
				<model:field name="disabilityLevelCode" mapping="DISABILITY_LEVEL_CODE" />
				<model:field name="employmentCode" mapping="EMPLOYMENT_CODE" rule="require"/>
				<model:field name="workUnitCharacter" mapping="WORK_UNIT_CHARACTER" rule="require"/>
				<!-- 系统相关信息 -->
				<model:field name="apanageName" mapping="APANAGE_NAME" />
				<model:field name="apanageCode" mapping="APANAGE_CODE" />
				<model:field name="idCardType" mapping="ID_CARD_TYPE" />
				<model:field name="regId" mapping="REG_ID" />
				<model:field name="regOrg" mapping="REG_ORG" />
				<model:field name="regTime" mapping="REG_TIME" />
				<model:field name="regPeople" mapping="REG_PEOPLE" />
				<model:field name="regOrgName" mapping="REG_ORG_NAME" />
				<model:field name="regOrgArea" mapping="REG_ORG_AREA" />
				
				
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
	<!-- 与户主关系 -->
	<model:dataset id="relationshipTypeDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_RELATIONSHIP_TYPE'></model:param>
					
		</model:params>
	</model:dataset>
	<!-- 健康状况 -->
	<model:dataset id="healthCodeDataset" enumName="SAM_HEALTH_CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 重病病种 -->
	<model:dataset id="diseaseTypeDataset"cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='dic_sam_disease_type'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
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
	
</model:datasets>

<next:Panel id="peopleWin" title="" height='100%' width="1000" autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		
		<next:ToolBarItem iconCls="save" id='confirmPeopleId' text="确定" handler="confirmPeople"></next:ToolBarItem>		
		<next:ToolBarItem iconCls="return" id='closePeopleId' text="关闭" handler="closePeople"></next:ToolBarItem>		
	</next:TopBar>
	<next:Panel title="家庭成员基本信息" titleCollapse="true" collapsible="true">
	<next:Html>
		<form id="BaseinfoPeopleForm" method="post" onsubmit="return false" dataset="peopleListDataSet"
			 class="L5form">
		<table border="0" width="100%">
			<tr>
			
				<td class="FieldLabel" width="15%">姓名</td>
				<td class="FieldInput" width="18%">
				<input type="hidden"  field="familyId" name="familyId">
				<input type="hidden" field="peopleId" name="peopleId">
				
				<input type="text" id="name" name="name" title="姓名" field="name" /></td>
				<td class="FieldLabel">身份证号</td>
				<td class="FieldInput">
				<input name="idCard" title="身份证号" id='idCard' maxlength="18"   style="width: 180" field="idCard" onblur="getBirthday(this.value)"></td>
				
				<td class="FieldLabel" width="15%">出生日期</td>
				<td class="FieldInput" width="18%"><input type="text" field="birthday" id="birthday" 
							name="birthday" title="出生日期"   format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly" />
				
				
			</tr>
		
			<tr><td class="FieldLabel" width="15%">与户主的关系</td>
				<td class="FieldInput" width="18%">
			
			<select title="与户主的关系" name="relationshipType" id="relationshipType"  field="relationshipType">
					<option dataset="relationshipTypeDataset"></option>
			</select>
		
				<input type="hidden" title="与户主的关系" name="relationshipType"/>
				
				<td class="FieldLabel">健康状况</td>
				<td class="FieldInput">
				<select name="healthCode" title="健康状况" id='healthCode'  field="healthCode" onchange="getDiseaseType()">
					<option dataset="healthCodeDataset"></option>
				</select>
				</td>
				 <td class="FieldLabel">重病病种</td>
                <td class="FieldInput" ><select name="重病病种" title="重病病种" disabled="disabled" id="diseaseType" field="diseaseType" style="width:90%" > <option dataset="diseaseTypeDataset"></option> </select></td>
			</tr>
			<tr>
				<td class="FieldLabel">残疾类别</td>
				<td class="FieldInput"><select name="残疾类别" title="残疾类别" id="disabilityType" field="disabilityType" style="width:90%" onchange='getDisabilityLevel()'> <option dataset="disabilityTypeDataset"></option> </select></td>
				
			   	<td class="FieldLabel">残疾等级</td>
				<td class="FieldInput">
				<select name="disabilityLevelCode" title="残疾等级" id="disabilityLevel" field="disabilityLevelCode" disabled="disabled">
					<option dataset="DmCjdjDataSet"></option>
				</select>
				</td>
				<td class="FieldLabel"></td>
				<td class="FieldInput"><input type="hidden" field="nation" name="nation">
				<input type="hidden" field="sex" name="sex"></td>
				
			</tr>
			<tr>
				<td class="FieldLabel">职业状况</td>
				<td class="FieldInput">
				<select name="employmentCode" title="职业状况"  field="employmentCode" onchange="iswork(this)">
					<option dataset="employmentDataset"></option>
				</select>
				
				<td class="FieldLabel">单位性质</td>
				<td class="FieldInput">
				<select name="workUnitCharacter" title="单位性质"  field="workUnitCharacter" id="workUnitCharacter" disabled="disabled">
					<option dataset="unitNatureDataset"></option>
				</select>
				<td class="FieldLabel">总收入(元)</td>
				<td class="FieldInput"><label id="toalIncome" field="totalIncome"></label></td>
            </tr>
            <tr>
				<td class="FieldLabel">工资性收入(元)</td>
				<td class="FieldInput">
				<input type="hidden" id="salaryId" field="salaryId"/>
				<input name="工资性收入" title="工资性收入" id="salaryIncome" field="salaryIncome" 
				onkeypress="var k=event.keyCode; if (((k==46)||(k <=57 && k>=48)) &&(k!=102)) return true;else return false" onkeyup="calcInc()"> </td>
			
				<td class="FieldLabel">经营性净收入(元)</td>
				<td class="FieldInput"><input name="经营性净收入" title="经营性净收入" id="manageIncome" field="manageIncome" onkeyup="calcInc()" 
				onkeypress="var k=event.keyCode; if (((k==46)||(k <=57 && k>=48)) &&(k!=102)) return true;else return false"  ></td>
				<td class="FieldLabel">财产性收入(元)</td>
				<td class="FieldInput"><input name="财产性收入" title="财产性收入"  id="propertyIncome" field="propertyIncome" onkeyup="calcInc()"
				onkeypress="var k=event.keyCode; if (((k==46)||(k <=57 && k>=48)) &&(k!=102)) return true;else return false"></td>
            </tr>
             <tr>
				<td class="FieldLabel">转移性收入(元)</td>
				<td class="FieldInput"><input name="转移性收入" title="转移性收入" id="transferIncome" field="transferIncome" onkeyup="calcInc()" onkeypress="var k=event.keyCode; if (((k==46)||(k <=57 && k>=48)) &&(k!=102)) return true;else return false"> </td>
			
				<td class="FieldLabel">其他收入(元)</td>
				<td class="FieldInput"><input name="其他收入" title="其他收入"  id="otherIncome" field="otherIncome" onkeyup="calcInc()" onkeypress="var k=event.keyCode; if (((k==46)||(k <=57 && k>=48)) &&(k!=102)) return true;else return false"></td>
				<td class="FieldLabel">总资产(元)</td>
				<td class="FieldInput"><label id="totalProperty" field="totalProperty"></td>
            </tr>
              <tr>
				<td class="FieldLabel">银行存款和有价证券(元)</td>
				<td class="FieldInput">
				<input type="hidden" id="propertyId" field="propertyId"/>
				<input name="银行存款和有价证券" title="银行存款和有价证券" id="bankStockProperty" field="bankStockProperty" onkeyup="calcPro()" onkeypress="var k=event.keyCode; if (((k==46)||(k <=57 && k>=48)) &&(k!=102)) return true;else return false"> </td>
			
				<td class="FieldLabel">债权(元)</td>
				<td class="FieldInput"><input name="债权" title="债权" id="bondProperty" field="bondProperty" onkeyup="calcPro()" onkeypress="var k=event.keyCode; if (((k==46)||(k <=57 && k>=48)) &&(k!=102)) return true;else return false"></td>
				<td class="FieldLabel">其他财产(元)</td>
				<td class="FieldInput"><input name="其他财产" title="其他财产" id="otherProperty" field="otherProperty" onkeyup="calcPro()" onkeypress="var k=event.keyCode; if (((k==46)||(k <=57 && k>=48)) &&(k!=102)) return true;else return false"></td>
            </tr>
          
            
            
		</table>
		</form>
	</next:Html>
	</next:Panel>
</next:Panel>
	
</body>
</html>