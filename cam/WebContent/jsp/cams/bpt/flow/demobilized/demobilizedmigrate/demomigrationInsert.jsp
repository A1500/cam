<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>添加跨省迁出人员信息</title>
<next:ScriptManager />
<script type="text/javascript" src="demomigrationInsert.js"></script>
<script type="text/javascript" src="../../../comm/bptComm.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>

</head>
<body>
<model:datasets>
	<!-- 人员信息 -->
	<model:dataset id="BaseinfoPeopleDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BptBaseinfoPeopleQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoPeople"></model:record>
	</model:dataset>
	<!-- 伤残审批信息 -->
	<model:dataset id="DisabilityApproveDataset" cmd="com.inspur.cams.bpt.manage.cmd.BptApplyDisabilityQueryCommand" method="queryDisabilityApproveHeader" global="true">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptApplyDisability">
			<!-- 人员信息 字段 -->
			<model:field name="familyId" type="string"/>
			<model:field name="name" type="string"/>
			<model:field name="sex" type="string"/>
			<model:field name="idCard" type="string"/>
			<model:field name="nation" type="string"/>
			<model:field name="birthday" type="string"/>
			<model:field name="address" type="string"/>
			<model:field name="demobilizedNo" type="string"/>
			<!-- 行政区划 字段 -->
			<model:field name="apanageName" type="string"/>
			<!-- 在乡复员信息 字段 -->
			<model:field name="conscriptDate" type="string"/>
			<model:field name="isKoeanwar" type="string"/>
			<model:field name="position" type="string"/>
			<model:field name="decruitmentDate" type="string"/>
			<model:field name="belongDate" type="string"/>
			<model:field name="ingoingAddress" type="string"/>
			<model:field name="allowanceMonth" type="string"/>
			<model:field name="townCheckPhone" type="string"/>
			<model:field name="ingoingCode" type="string"/>

		</model:record>
	</model:dataset>
	<!-- 性别 -->
	<model:dataset id="SexDataset" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
	<!-- 民族 -->
	<model:dataset id="NationDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset> 
	
	<!-- 是否抗美援朝 -->
	<model:dataset id="isKoeanwar" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 所属时期 -->
	<model:dataset id="warDate" enumName="WAR.CODE" autoLoad="true" global="true"></model:dataset>
</model:datasets>

<next:Panel width="100%" height="100%" autoScroll="false">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="save"  text="保存" handler="save"/>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="disable" text="关闭" handler="func_Close" />
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form id="approveForm" onsubmit="return false" style="padding: 5px;" class="L5form" dataset="DisabilityApproveDataset">
		<table border="1" width="99%">
			<tr>
				<td class="FieldLabel" style="width:15%">身份证号：</td>
				<td class="FieldInput" style="width:15%"><input readonly="readonly" id="idCard" maxlength="18" type="text" name="idCard" field="idCard" style="width:135"/>
								<img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>" style="cursor:hand" onclick="getIdCard()"/>
				</td>
				<td class="FieldLabel" style="width:15%">姓名：</td>
				<td class="FieldInput" style="width:15%"><label id="name" name="name" field="name"/></td>
				<td class="FieldLabel" style="width:15%">性别：</td>
				<td class="FieldInput" style="width:15%"><label id="sex" name="sex" field="sex" dataset="SexDataset"></label></td>
	   		</tr>
	   		
	   		<tr>
	   			<td class="FieldLabel">民族：</td>
				<td class="FieldInput"><label id="nation" name="nation" field="nation" dataset="NationDataset"></label></td>
	   			<td class="FieldLabel">出生年月：</td>
				<td class="FieldInput" colspan="3"><label id="birthday" name="birthday" field="birthday"/></td>
	   		</tr>
	   		
	   		<tr>
	   			<td class="FieldLabel" nowrap="nowrap">入伍（参加工作）时间：</td>
				<td class="FieldInput"><label id="conscriptDate" name="conscriptDate" field="conscriptDate"/></td>
				<td class="FieldLabel" nowrap="nowrap">退伍（离退休）时间：</td>
				<td class="FieldInput"><label id="decruitmentDate" name=decruitmentDate field="decruitmentDate"/></td>
				<td class="FieldLabel">是否抗美援朝：</td>
				<td class="FieldInput"><label id="isKoeanwar" name="isKoeanwar" field="isKoeanwar" dataset="isKoeanwar"></label></td>					
			</tr>
			
	   		<tr>
	   			<td class="FieldLabel">职位：</td>
				<td class="FieldInput"><label id="position" name="position" field="position" ></label></td>
				<td class="FieldLabel">所属时期：</td>
				<td class="FieldInput"><label id="belongDate" name="belongDate" field="belongDate" dataset="warDate"></label></td>
				<td class="FieldLabel">原残疾证件编号：</td>
				<td class="FieldInput"><label id="demobilizedNo" name="demobilizedNo" field="demobilizedNo"/></td>
			</tr>
			
	   		<tr>
	   			<td class="FieldLabel">住址行政区划：</td>
				<td class="FieldInput"><label id="apanageName" name="apanageName" field="apanageName"/></td>
				<td class="FieldLabel">地址：</td>
				<td class="FieldInput" colspan="3"><label id="address" name="address" field="address"/></td>
			</tr>
			<tr>
				<td class="FieldLabel" nowrap="nowrap">迁入地民政局：</td>
				<td class="FieldInput"><input type="hidden" id="ingoingCode" name="ingoingCode" field="ingoingCode"/>
									   <input type="text" id="ingoingAddress" name="ingoingAddress" field="ingoingAddress" onclick="getCodeAndName()"/>
									   <font color="red">*</font></td>
				<td class="FieldLabel" nowrap="nowrap">在乡复员抚恤金已发至：</td>
				<td class="FieldInput"><input type="text" id="allowanceMonth" readonly="readonly"  format="Y-12" style="width: 100px;" maxlength="10" name="allowanceMonth" field="allowanceMonth"  /><img  src="../../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ><font color="red">*</font></td>
				<td class="FieldLabel" nowrap="nowrap">迁出地民政部门联系电话：</td>
				<td class="FieldInput"><input type="text" name="townCheckPhone" field="townCheckPhone"/></td>
			</tr>
			
			<input type="hidden" id="peopleId" field="peopleId">
			<input type="hidden" id="familyId" field="familyId">
	
		</table>
		</form>
   </next:Html>
</next:Panel>	

</body>
</html>
