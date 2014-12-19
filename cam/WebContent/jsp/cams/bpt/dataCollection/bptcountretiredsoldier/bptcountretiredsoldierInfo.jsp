<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
	<head>
		<title>60周岁以上农村籍退役士兵信息</title>
		<next:ScriptManager/>
		<script>
			var peopleId=<%=request.getParameter("peopleId")%>;
		</script>
		<script type="text/javascript" src="bptcountretiredsoldierInfo.js"></script>
	</head>
<body>
<model:datasets>
	<model:dataset id="RetiredSoldierDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BptCountRetiredSoldierQueryCommand" global="true" method="queryBptRetiredSoldier">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptCountRetiredSoldier">
		    <model:field name="accountName" type="string" />
			<model:field name="accountCode" type="string" />
			
			<model:field name="workAbilityCode" type="string" rule="require"/>
			<model:field name="bank" type="string" />
			<model:field name="oldLonelyFlag" type="string" rule="require"/>
		</model:record>
	</model:dataset>
	
	<!-- 是否享受低保待遇-->
	<model:dataset id="dsGuarant" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 是否享受五保待遇-->
	<model:dataset id="dsFiveGuarant" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 孤老标志 -->
	<model:dataset id="OldLonelyFlagEnum" enumName="COMM.YESORNO"  autoLoad="true" global="true"></model:dataset>
	<!-- 是否具有其他优抚对象身份 -->
	<model:dataset id="OtherBptObjectEnum" enumName="COMM.YESORNO"  autoLoad="true" global="true"></model:dataset>
	<!-- 优抚对象类型 -->
	<model:dataset id="ObjectTypeDataset" enumName="OBJECT.TYPE.PART" autoLoad="true" global="true"></model:dataset>
	<!-- 劳动能力-->
	<model:dataset id="workAbilityEnum" enumName="WORK.ABILITY.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 生活状况-->
    <model:dataset id="lifeStateEnum" enumName="LIFE.LIFE_STATE_CODE" autoLoad="true" global="true"></model:dataset>
    <!-- 身份认定依据-->
    <model:dataset id="identityEnum" enumName="IDENTITY.CODE" autoLoad="true" global="true"></model:dataset>
    <!-- 开户银行代码 -->
	<model:dataset id="BankEnum" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BANK'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>

<next:Panel height="100%" width="100%">
	<next:Html>
		<form id="editForm"   dataset="RetiredSoldierDataSet" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="100%" >
		    <tr> 
	   		    <td class="FieldLabel" nowrap>是否具有其他优抚对象身份：</td>
				<td class="FieldInput" colspan="5">
				    <label id ="isOtherBptobject" name="isOtherBptobject" field="isOtherBptobject" dataset="OtherBptObjectEnum"></label>
				</td>
	   		</tr>
			<tr id="objectType">
			   <td class="FieldLabel" nowrap>优抚对象类别：</td>
			   <td colspan="5" class="FieldLabel">
			       <table border="0" width="100%">
			          <tr>
			            <td class="FieldInput"> 
			               <input type="checkbox" id="disabilityCivil" name="disabilityCivil" field="disabilityCivil" disabled="disabled"/>伤残公务员&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			               <input type="checkbox" id="disabilityPolice" name="disabilityPolice" field="disabilityPolice" disabled="disabled"/>伤残人民警察&nbsp;&nbsp;&nbsp;&nbsp;
			               <input type="checkbox" id="disabilityMigrant" name="disabilityMigrant" field="disabilityMigrant" disabled="disabled"/>伤残民兵民工&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			               <input type="checkbox" id="disabilitySoldier" name="disabilitySoldier" field="disabilitySoldier" disabled="disabled"/>残疾军人&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			               <input type="checkbox" id="dependMartyrs" name="dependMartyrs" field="dependMartyrs" disabled="disabled"/>烈属&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			               <input type="checkbox" id="dependDied" name="dependDied" field="dependDied" disabled="disabled"/>病故军人遗属
			            </td>
			          </tr>
			          <tr>
			            <td class="FieldInput" >
			               <input type="checkbox" id="dependPublic" name="dependPublic" field="dependPublic" disabled="disabled"/>因公牺牲军人遗属
			               <input type="checkbox" id="demobilizedSoldier" name="demobilizedSoldier" field="demobilizedSoldier" disabled="disabled"/>在乡老复员军人
			               <input type="checkbox" id="demobilizedIllnessPeople" name="demobilizedIllnessPeople" field="demobilizedIllnessPeople" disabled="disabled"/>带病回乡退伍军人
			               <input type="checkbox" id="warPeople" name="warPeople" field="warPeople" disabled="disabled"/>参战退役人员
			               <input type="checkbox" id="testedPeople" name="testedPeople" field="testedPeople" disabled="disabled"/>参试退役人员
			            </td>
			          </tr>
			       </table>
			   </td>
			</tr>
			<tr>
	   		    <td class="FieldLabel" nowrap style="width:16%">入伍时间：</td>
				<td class="FieldInput" style="width:16%">
				    <label name="conscriptDate" field="conscriptDate" format="Y-m-d">
				</td>
	   		    <td class="FieldLabel" nowrap style="width:16%">退役时间：</td>
				<td class="FieldInput" style="width:16%">
				    <label name="decruitmentDate" field="decruitmentDate" format="Y-m-d">
				</td>
				<td class="FieldLabel" nowrap style="width:16%">退役证件号：</td>
				<td class="FieldInput" style="width:16%">
				     <label name="retiredNo" field="retiredNo"></label>
				</td>
			</tr>
			<tr>
		        <td class="FieldLabel" nowrap>服役部队名称(番号)：</td>
				<td class="FieldInput">
				    <label name="forcesName" field="forcesName">
				</td>
				<td class="FieldLabel" nowrap>服役部队代号：</td>
				<td class="FieldInput" colspan="3">
				    <label name="forcesNo" field="forcesNo">
				</td>
		    </tr>
	   		<tr>
	   		    <td class="FieldLabel" nowrap>服义务兵(开始时间)：</td>
				<td class="FieldInput">
				    <label name="soldierStartDate" field="soldierStartDate" format="Y-m-d">
				</td>
				<td class="FieldLabel" nowrap>服义务兵(结束时间)：</td>
				<td class="FieldInput">
				    <label name="soldierEndDate" field="soldierEndDate" format="Y-m-d">
				</td>
	   		    <td class="FieldLabel" nowrap>所服义务兵役折算年限：</td>
				<td class="FieldInput">
				    <label id="soldierYears" name="soldierYears" field="soldierYears">
				 </td>
	   		</tr>
		    <tr>
				<td class="FieldLabel" nowrap>家庭人口：</td>
				<td class="FieldInput">
				     <label name="familyNum" field="familyNum">
				</td>
				<td class="FieldLabel" nowrap>18岁(含)以下：</td>
				<td class="FieldInput">
				    <label name="youngNum" field="youngNum">
				 </td>
			    <td class="FieldLabel" nowrap>60岁(含)以上：</td>
				<td class="FieldInput">
				    <label name="oldNum" field="oldNum">
				 </td>
			</tr>
	   		<tr>
				<td class="FieldLabel" nowrap>是否孤老：</td>
				<td class="FieldInput">
				    <label name="oldLonelyFlag" field="oldLonelyFlag" dataset="OldLonelyFlagEnum">
				</td>
			    <td class="FieldLabel" nowrap>劳动能力：</td>
				<td class="FieldInput">
				    <label name="workAbilityCode" field="workAbilityCode" dataset="workAbilityEnum">
				</td>
				<td class="FieldLabel" nowrap>生活状况：</td>
				<td class="FieldInput">
				     <label name="lifeStateCode" field="lifeStateCode" dataset="lifeStateEnum">
				</td>
			</tr>
	   		<tr>
				<td class="FieldLabel" nowrap>是否享受低保待遇：</td>
				<td class="FieldInput">
				     <label  name="isGuarant" field="isGuarant" dataset="dsGuarant"></label>
				</td>
			    <td class="FieldLabel" nowrap>是否享受五保待遇：</td>
				<td class="FieldInput">
				     <label  name="isFiveGuarant" field="isFiveGuarant" dataset="dsFiveGuarant"></label>
			    </td>
				<td class="FieldLabel" nowrap>身份认定依据：</td>
				<td class="FieldInput">
				    <label  name="identityBasis" field="identityBasis" dataset="identityEnum"></label>
				</td>
			</tr>
			<tr>
				<td class="FieldLabel">开户银行：</td>
				<td class="FieldInput">
				    <label name="bank" field="bank" title="开户银行" dataset="BankEnum" /> </td>
				<td class="FieldLabel">开户名称：</td>
				<td class="FieldInput"><label name="accountName" field="accountName" title="开户名称" /></td>

				<td class="FieldLabel">银行账号：</td>
				<td class="FieldInput"><label name="accountCode" field="accountCode" title="银行账号"></label></td>
			</tr>
			<tr>
				<td class="FieldLabel" nowrap>备注(类别信息)：</td>
				<td class="FieldInput" class="FieldInput" colspan="5">
				    <label  name="note" field="note"></label>
				</td>
			</tr>				
		</table>
		</form>
   </next:Html>
</next:Panel>
</body>
</html>
