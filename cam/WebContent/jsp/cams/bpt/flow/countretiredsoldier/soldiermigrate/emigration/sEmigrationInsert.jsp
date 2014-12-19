<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>添加年满60周岁农村籍退役士兵定补关系跨省迁出</title>
<next:ScriptManager />
<script type="text/javascript" src="sEmigrationInsert.js"></script>
<script type="text/javascript" src="../../../../comm/bptComm.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
</head>
<body>
<model:datasets>
	<!-- 人员信息 -->
	<model:dataset id="BaseinfoPeopleDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BptApplyCountrySoldierQueryCommand" method="queryByIdCard" global="true">
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoPeople">
		</model:record>
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptApplyEmigration">
		</model:record>
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptCountRetiredSoldier">
		</model:record>
	</model:dataset>
	
	<!-- 性别 -->
	<model:dataset id="SexDataset" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
	
	 
	 
</model:datasets>

<next:Panel width="100%" height="100%" autoScroll="false">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="save"  text="保存" handler="save"/>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="disable" text="关闭" handler="func_Close"/>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
	</next:TopBar>     
	<next:Html>
		<form id="approveForm" onsubmit="return false" style="padding: 5px;" class="L5form" dataset="BaseinfoPeopleDataSet">
		<table border="1" width="99%">
			<tr>
				<td class="FieldLabel" style="width:15%">身份证号：</td>
				<td class="FieldInput" style="width:15%"><input readonly="readonly" type="text" id="idCard" name="idCard" field="idCard" maxlength="18" style="width:135"/>
								<img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>" style="cursor:hand" onclick="getIdCard()"/>
				</td>
				<td class="FieldLabel" style="width:15%">姓名：</td>
				<td class="FieldInput" style="width:15%"><label id="name" name="name" field="name"/></td>
				<td class="FieldLabel" style="width:15%">性别：</td>
				<td class="FieldInput" style="width:15%"><label id="sex" name="sex" field="sex" dataset="SexDataset"></label></td>
	   		</tr>
	   		<tr>
	   		    <td class="FieldLabel" nowrap>入伍时间：</td>
				<td class="FieldInput"><label name="conscriptDate" field="conscriptDate" format="Y-m-d" title="入伍时间"/></td>
	   		    <td class="FieldLabel" nowrap>退役时间：</td>
				<td class="FieldInput"><label name="decruitmentDate" field="decruitmentDate" format="Y-m-d"  title="退役时间"/></td>
				<td class="FieldLabel" nowrap>退役证件号：</td>
				<td class="FieldInput"><label name="retiredNo" field="retiredNo" title="退役证件号"/></td>
			</tr>
			<tr>
		        <td class="FieldLabel" nowrap>服役部队名称(番号)：</td>
				<td class="FieldInput"><label name="forcesName" field="forcesName" title="服役部队名称(番号)"/><font color="red">*</font></td>
				<td class="FieldLabel" nowrap>服役部队代号：</td>
				<td class="FieldInput" colspan="3"><label name="forcesNo" field="forcesNo" title="服役部队代号"/><font color="red">*</font></td>
		    </tr>
	   		<tr>
	   		    <td  class="FieldLabel" nowrap>服义务兵(开始时间)：</td>
				<td class="FieldInput"><label name="soldierStartDate" field="soldierStartDate" format="Y-m-d"style="width: 100px;"   title="服义务兵开始时间" /></td>
				<td  class="FieldLabel" nowrap>服义务兵(结束时间)：</td>
				<td class="FieldInput"><label name="soldierEndDate" field="soldierEndDate" format="Y-m-d"style="width: 100px;" maxlength="10"  title="服义务兵结束时间" /></td>
	   		    <td  class="FieldLabel" nowrap>所服义务兵役折算年限：</td>
				<td class="FieldInput"><label id="soldierYears" name="soldierYears" field="soldierYears" title="所服义务兵役折算年限"/> </td>
	   		</tr>
			<tr>
				<td class="FieldLabel" nowrap="nowrap">迁入地民政局：</td>
				<td class="FieldInput"><input type="hidden" id="ingoingCode" name="ingoingCode" field="ingoingCode"/>
										<input type="text" id="ingoingAddress" name="ingoingAddress" field="ingoingAddress" onclick="getCodeAndName()"/>
										<font color="red">*</font></td>
				<td class="FieldLabel" nowrap="nowrap">残疾抚恤金已发至：</td>
				<td class="FieldInput"><input type="text" id="allowanceMonth" format="Y-12" style="width: 100px;" maxlength="10" name="allowanceMonth" field="allowanceMonth" /><img  src="../../../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ><font color="red">*</font></td>
				<td class="FieldLabel" nowrap="nowrap">迁出地民政部门联系电话：</td>
				<td class="FieldInput"><input type="text" name="townCheckPhone" field="townCheckPhone" /></td>
			</tr>
			<input type="hidden" id="peopleId" field="peopleId" />
			<input type="hidden" id="familyId" field="familyId" />
		</table>
		</form>
   </next:Html>
</next:Panel>	

</body>
</html>
