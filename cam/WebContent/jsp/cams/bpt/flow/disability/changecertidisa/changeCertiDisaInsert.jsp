<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>添加证件变更信息</title>
<next:ScriptManager />
<script type="text/javascript" src="changeCertiDisaInsert.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="../../../comm/bptComm.js"></script>
</head>
<body>
<model:datasets>
	<!-- 人员信息 -->
	<model:dataset id="BaseinfoPeopleDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BptBaseinfoPeopleQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoPeople"></model:record>
	</model:dataset>
	<!-- 伤残审批信息 -->
	<model:dataset id="DisabilityApproveDataset" cmd="com.inspur.cams.bpt.manage.cmd.BptPeopleDisabilityQueryCommand" method="queryDisabilityByIdCard" global="true">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptApplyDisability">
			<!-- 人员信息 字段 -->
			<model:field name="familyId" type="string"/>
			<model:field name="name" type="string"/>
			<model:field name="sex" type="string"/>
			<model:field name="idCard" type="string"/>
			<model:field name="nation" type="string"/>
			<model:field name="birthday" type="string"/>
			<model:field name="address" type="string"/>
			<model:field name="domicileAddress" type="string"/>
			<model:field name="disabilityNo" type="string"/>
			<!-- 行政区划 字段 -->
			<model:field name="apanageName" type="string"/>
			<model:field name="domicileName" type="string"/>
			<!-- 伤残信息 字段 -->
			<model:field name="conscriptDate" type="string"/>
			<model:field name="veteransDate" type="string"/>
			<model:field name="retiredDate" type="string"/>
			<model:field name="disabilityGenusCode" type="string"/>
			<model:field name="uinitOfDisability" type="string"/>
			<model:field name="disabilityCaseCode" type="string"/>
			<model:field name="disabilityLevelCode" type="string"/>
			<model:field name="disabilityWarCode" type="string"/>
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
	<!-- 伤残性质 -->
	<model:dataset id="DisabilityCaseDataset" enumName="CASE.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 伤残等级 -->
	<model:dataset id="DisabilityLevelDataset" enumName="LEVEL.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 伤残属别 -->
	<model:dataset id="DisabilityGenusDataset" enumName="GENUS.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 伤残时期 -->
	<model:dataset id="BptWarDataset" enumName="WAR.CODE" autoLoad="true" global="true"></model:dataset>
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
				<td class="FieldInput" style="width:15%"><input readonly="readonly" id="idCard" type="text" name="idCard" field="idCard" maxlength="18" style="width:135" onchange="queryDisbilityByIdCard(this)"/>
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
	   			<td class="FieldLabel">出生日期：</td>
				<td class="FieldInput" colspan="3"><label id="birthday" name="birthday" field="birthday"/></td>
	   		</tr>
	   		<tr>
				<td class="FieldLabel" >户口薄(行政区划)：</td>
				<td class="FieldInput" ><label id="domicileName" name="domicileName" field="domicileName"/></td>
						       
				<td class="FieldLabel">户口薄住址:</td>
				<td class="FieldInput" colspan="3"><label id="domicileAddress" name="domicileAddress" field="domicileAddress"/></td>      
			</tr> 
			<tr>
	   			<td class="FieldLabel">实际居住（行政区划）：</td>
				<td class="FieldInput"><label id="apanageName" name="apanageName" field="apanageName"/></td>
				<td class="FieldLabel">实际居住地址：</td>
				<td class="FieldInput" colspan="3"><label id="address" name="address" field="address"/></td>
			</tr>
	   		<tr>
	   			<td class="FieldLabel" nowrap="nowrap">入伍（参加工作）时间：</td>
				<td class="FieldInput"><label id="conscriptDate" name="conscriptDate" field="conscriptDate"/></td>
				<td class="FieldLabel" nowrap="nowrap">退伍时间：</td>
				<td class="FieldInput" ><label id="veteransDate" name="veteransDate" field="veteransDate"/></td>
				<td class="FieldLabel" nowrap="nowrap">离退休时间：</td>
				<td class="FieldInput" ><label id="retiredDate" name="retiredDate" field="retiredDate"/></td>				
			</tr>
			<tr>
				<td class="FieldLabel">原残疾证件编号：</td>
				<td class="FieldInput" ><label id="disabilityNo" name="disabilityNo" field="disabilityNo"/></td>	
				<td class="FieldLabel">批准日期：</td>
				<td class="FieldInput"><label  field="approveDate"></label></td> 
				<td class="FieldLabel">伤残等级：</td>
				<td class="FieldInput"><label id="disabilityLevelCode" name="disabilityLevelCode" field="disabilityLevelCode" dataset="DisabilityLevelDataset"></label></td>
			</tr>
	   		<tr>
	   			<td class="FieldLabel">伤残性质：</td>
				<td class="FieldInput"><label id="disabilityCaseCode" name="disabilityCaseCode" field="disabilityCaseCode" dataset="DisabilityCaseDataset"></label></td>
	   			<td class="FieldLabel">伤残时期：</td>
				<td class="FieldInput"><label  field="disabilityWarCode" dataset="BptWarDataset"></label></td>
				<td class="FieldLabel">伤残属别：</td>
				<td class="FieldInput" > <label  field="disabilityGenusCode" dataset="DisabilityGenusDataset"></label></td>
	   		</tr>
	   		<tr>
	   			<td class="FieldLabel">致残时所在单位：</td>
				<td class="FieldInput"><label id="uinitOfDisability" name="uinitOfDisability" field="uinitOfDisability"/></td>
				<td class="FieldLabel">致残时间：</td>
				<td class="FieldInput" colspan="3"><input type="text" name="disabilityDate" field="disabilityDate" format="Y-m-d" style="width: 100px;" maxlength="10" onpropertychange="changeDateStyle(this)" /><img  src="../../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ></td>
			</tr>
			<tr>	
				<td class="FieldLabel">证件变更原因：</td>
				<td class="FieldInput" colspan="5"><textarea id="exchangeReason" name="exchangeReason" field="exchangeReason" rows="3" style="width:95%"></textarea><font color="red">*</font></td>
			</tr>
			<tr>
				<td class="FieldLabel">致残地点：</td>
				<td class="FieldInput" colspan="5"><textarea name="disabilityAdd" field="disabilityAdd" style="width:90%"></textarea></td>
			</tr>
			
			<tr>	
				<td class="FieldLabel">致残情况：</td>
				<td class="FieldInput" colspan="5"><textarea name="disabilityBody" field="disabilityBody" style="width:90%"/></textarea></td>
			</tr>

			<tr>
				<td class="FieldLabel">致残原因：</td>
				<td class="FieldInput" colspan="5"><textarea name="disabilityReason" field="disabilityReason" style="width:90%"></textarea></td>	
			</tr>
			<input type="hidden" id="peopleId" field="peopleId">
			<input type="hidden" id="familyId" field="familyId">
		</table>
		</form>
   </next:Html>
</next:Panel>	

</body>
</html>
