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
		<script type="text/javascript" src="cbptcountretiredsoldierEdit.js"></script>
		<script type="text/javascript" src="../comm/bptComm.js"></script>
	</head>
<body>
<model:datasets>
	<model:dataset id="RetiredSoldierDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BptCountRetiredSoldierQueryCommand" global="true" method="queryBptRetiredSoldierCollection">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptCountRetiredSoldier">
		   <model:field name="accountName" type="string" />
			<model:field name="accountCode" type="string" />
			
			<model:field name="workAbilityCode" type="string" rule="require"/>
			<model:field name="bank" type="string" />
			<model:field name="oldLonelyFlag" type="string" rule="require"/>
			
			<model:field name="pretiredNo" type="string" rule="require"/> 
			<model:field name="retiredStateCode" type="string" rule="require"/> 
		</model:record>
	</model:dataset>
	<!-- 优抚对象状态 -->
	<model:dataset id="ObjectStateDataset" enumName="OBJECT.STATE"
		autoLoad="true" global="true"></model:dataset>
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

<next:Panel height="100%" width="100%"  autoScroll="true">
    <next:TopBar >
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存" handler="saveClick"/>
		<next:ToolBarItem iconCls="disable" text="关闭" handler="func_Close"/>
	</next:TopBar>
	<next:Html>
		<form id="editForm"   dataset="RetiredSoldierDataSet" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="99%" >
		<tr>
				<td class="FieldLabel">优抚对象状态：</td>
				<td class="FieldInput"><select name="retiredStateCode"
					field="retiredStateCode" title="优抚对象状态">
					<option dataset="ObjectStateDataset"></option>
				</select><font color="red">*</font></td>

				<td class="FieldLabel">证书编号：</td>
				<td class="FieldInput"><input type="text" name="pretiredNo"
					field="pretiredNo" title="证书编号" /><font color="red">*</font></td>

				<td class="FieldLabel">批准日期：</td>
				<td class="FieldInput"><input type="text" title="批准日期" id="approvalDate"
					name="approvalDate" field="approvalDate" format="Y-m-d"maxlength="10"style="width: 100px;"  onpropertychange="changeDateStyle(this)" 
					 /><img  src="../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this)" ><font color="red">*</font></td>
			</tr>
		     <tr> 
	   		    <td  class="FieldLabel" >是否具有其他优抚对象身份：</td>
				<td class="FieldInput" colspan="5">
				    <select id ="isOtherBptobject" name="isOtherBptobject" field="isOtherBptobject" title="是否具有其他优抚对象身份" onchange="func_show()">
					     <option dataset="OtherBptObjectEnum"></option>
				     </select>
				</td>
	   		</tr>
			<tr id="objectType">
			   <td class="FieldLabel" >优抚对象类别：</td>
			   <td colspan="5" class="FieldLabel">
			       
			       <table border="0" width="99%" >
			          <tr>
			            <td class="FieldInput" > 
			               <input type="checkbox" id="disabilityCivil" name="disabilityCivil" field="disabilityCivil"/>伤残公务员&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			               <input type="checkbox" id="disabilityPolice" name="disabilityPolice" field="disabilityPolice"/>伤残人民警察&nbsp;&nbsp;&nbsp;&nbsp;
			               <input type="checkbox" id="disabilityMigrant" name="disabilityMigrant" field="disabilityMigrant"/>伤残民兵民工&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			               <input type="checkbox" id="disabilitySoldier" name="disabilitySoldier" field="disabilitySoldier"/>残疾军人&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			               <input type="checkbox" id="dependMartyrs" name="dependMartyrs" field="dependMartyrs"/>烈属&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			               <input type="checkbox" id="dependDied" name="dependDied" field="dependDied"/>病故军人遗属
			            </td>
			          </tr>
			          <tr>
			            <td class="FieldInput" >
			               <input type="checkbox" id="dependPublic" name="dependPublic" field="dependPublic"/>因公牺牲军人遗属
			               <input type="checkbox" id="demobilizedSoldier" name="demobilizedSoldier" field="demobilizedSoldier"/>在乡老复员军人
			               <input type="checkbox" id="demobilizedIllnessPeople" name="demobilizedIllnessPeople" field="demobilizedIllnessPeople"/>带病回乡退伍军人
			               <input type="checkbox" id="warPeople" name="warPeople" field="warPeople"/>参战退役人员
			               <input type="checkbox" id="testedPeople" name="testedPeople" field="testedPeople"/>参试退役人员
			            </td>
			          </tr>
			       </table>
			   </td>
			</tr>
			
			<tr>
	   		    <td class="FieldLabel" >入伍时间：</td>
				<td class="FieldInput"><input type="text" name="conscriptDate" field="conscriptDate"  onpropertychange="changeDateStyle(this)" 
				format="Y-m-d"style="width: 100px;" maxlength="10" title="入伍时间"/><img  src="../../../../../skins/images/default/rl.gif" align="middle"  onclick="getTimes(this)"  ><font color="red">*</font></td>
	   		    <td class="FieldLabel" >退役时间：</td>
				<td class="FieldInput"><input type="text" name="decruitmentDate" field="decruitmentDate" format="Y-m-d"  onpropertychange="changeDateStyle(this)" 
				style="width: 100px;" maxlength="10" title="退役时间"/><img  src="../../../../../skins/images/default/rl.gif" align="middle"  onclick="getTimes(this)"  ><font color="red">*</font></td>
				<td class="FieldLabel" >退役证件号：</td>
				<td class="FieldInput"><input type="text" name="retiredNo" field="retiredNo" title="退役证件号"/></td>
			</tr>
			<tr>
		        <td class="FieldLabel" >服役部队名称(番号)：</td>
				<td class="FieldInput"><input type="text" name="forcesName" field="forcesName" title="服役部队名称(番号)"/><font color="red">*</font></td>
				<td class="FieldLabel" >服役部队代号：</td>
				<td class="FieldInput" colspan="3"><input type="text" name="forcesNo" field="forcesNo" title="服役部队代号"/><font color="red">*</font></td>
		    </tr>
	   		<tr>
	   		    <td  class="FieldLabel" >服义务兵(开始时间)：</td>
				<td class="FieldInput"><input type="text" name="soldierStartDate" field="soldierStartDate" format="Y-m-d"style="width: 100px;" maxlength="10" title="服义务兵开始时间" onpropertychange="changeDateStyle(this)" 
				 onblur="func_StartDate()"/><img  src="../../../../../skins/images/default/rl.gif" align="middle"  onclick="getTimes(this)"  ><font color="red">*</font></td>
				<td  class="FieldLabel" >服义务兵(结束时间)：</td>
				<td class="FieldInput"><input type="text" name="soldierEndDate" field="soldierEndDate" format="Y-m-d" style="width: 100px;"maxlength="10" title="服义务兵结束时间"  onpropertychange="changeDateStyle(this)" 
				onblur="func_EndDate()"/><img  src="../../../../../skins/images/default/rl.gif" align="middle"  onclick="getTimes(this)"  ><font color="red">*</font></td>
	   		    <td  class="FieldLabel" >所服义务兵役折算年限：</td>
				<td class="FieldInput"><input type="text" id="soldierYears" name="soldierYears" field="soldierYears" title="所服义务兵役折算年限"/> </td>
	   		</tr>
		    <tr>
				<td  class="FieldLabel" >家庭人口：</td>
				<td class="FieldInput"><input type="text" name="familyNum" field="familyNum" title="家庭人口"/> </td>
				<td  class="FieldLabel" >18岁(含)以下：</td>
				<td class="FieldInput"><input type="text" name="youngNum" field="youngNum" title="18岁(含)以下"/> </td>
			    <td  class="FieldLabel" >60岁(含)以上：</td>
				<td class="FieldInput"><input type="text" name="oldNum" field="oldNum" title="60岁(含)以上"/> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >是否孤老：</td>
				<td class="FieldInput">
				    <select name="oldLonelyFlag" field="oldLonelyFlag" title="是否孤老">
					     <option dataset="OldLonelyFlagEnum"></option>
				     </select><font color="red">*</font>
				 </td>
			    <td  class="FieldLabel" >劳动能力：</td>
				<td class="FieldInput">
				    <select name="workAbilityCode" field="workAbilityCode" title="劳动能力">
					     <option dataset="workAbilityEnum"></option>
				     </select><font color="red">*</font>
				</td>
				<td  class="FieldLabel" >生活状况：</td>
				<td class="FieldInput">
				     <select name="lifeStateCode" field="lifeStateCode" title="生活状况">
					     <option dataset="lifeStateEnum"></option>
				     </select><font color="red">*</font>
				</td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >是否享受低保待遇：</td>
				<td class="FieldInput">
				     <select name="isGuarant" field="isGuarant" title="是否享受低保待遇">
					     <option dataset="dsGuarant"></option>
				     </select>
				</td>
			    <td  class="FieldLabel" >是否享受五保待遇：</td>
				<td class="FieldInput">
				     <select name="isFiveGuarant" field="isFiveGuarant" title="是否享受五保待遇">
					     <option dataset="dsFiveGuarant"></option>
				     </select>
				</td>
				<td class="FieldLabel" nowrap>身份认定依据：</td>
				<td class="FieldInput">
				    <select name="identityBasis" field="identityBasis" title="身份认定依据">
					     <option dataset="identityEnum"></option>
				     </select>
				</td>
			</tr>
			<tr>
				<td class="FieldLabel">开户银行：</td>
				<td class="FieldInput">
				    <select name="bank" field="bank" title="开户银行">
					<option dataset="BankEnum"></option>
				</select> </td>
				<td class="FieldLabel">开户名称：</td>
				<td class="FieldInput"><input type="text" name="accountName" field="accountName" title="开户名称"/></td>

				<td class="FieldLabel">银行账号：</td>
				<td class="FieldInput"><input type="text" name="accountCode" field="accountCode" title="银行账号" style="width: 200"></input></td>
			</tr>
			<tr>
				<td  class="FieldLabel" >备注(类别信息)：</td>
				<td class="FieldInput" class="FieldInput" colspan="5"><textarea rows="3" cols="155" name="note" field="note" title="备注(类别信息)"></textarea></td>
			</tr>				
		</table>
		</form>
   </next:Html>
</next:Panel>
</body>
</html>
