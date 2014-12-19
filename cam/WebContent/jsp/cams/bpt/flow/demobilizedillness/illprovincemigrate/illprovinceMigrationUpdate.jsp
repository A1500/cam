<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="com.inspur.cams.comm.util.IdHelp"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>

<html>
<head>
<title>带病回乡退伍军人信息</title>
<next:ScriptManager />
<script type="text/javascript">
	var peopleId='<%=request.getParameter("peopleId")%>';
	var idCard='<%=request.getParameter("idCard")%>';
	var applyId='<%=request.getParameter("applyId")%>';
</script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="illprovinceMigrationUpdate.js"></script>
<script type="text/javascript" src="../../../comm/bptComm.js"></script>
</head>
<body>
<model:datasets>

	<!-- 带病回乡退伍军人 -->
	<model:dataset id="ProvinceMigrationDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BptProvinceMigrateQueryCommand" method="queryIllDemoInfo" global="true">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptProvinceMigrate">
			<model:field name="demobilizedStateCode" type="string"  />
			<model:field name="demobilizedNo" type="string"  />
			<model:field name="idCard" type="string"  />
			<model:field name="name" type="string"/>
			<model:field name="sex" type="string"/>
			<model:field name="nation" type="string"/>
			<model:field name="birthday" type="string"/>
			<model:field name="allowanceMonth" type="string"/>
			<model:field name="outTownCheckPhone" type="string"/>
			<model:field name="ingoingName" type="string"/>
			<model:field name="domicileName" type="string"  />
			<model:field name="apanageName" type="string"  />
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
	<!-- 身体状况 -->
	<model:dataset id="PhysiclalStatusEnum" enumName="PHYSICLAL.STATUS" autoLoad="true" global="true"></model:dataset>
	<!-- 是否精神病标志 -->
	<model:dataset id="InsanityFlagEnum" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 孤老标志 -->
	<model:dataset id="OldLonelyFlagEnum" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 孤儿标志 --> 
	<model:dataset id="OrphanFlagEnum" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 劳动能力代码 -->
	<model:dataset id="WorkAbilityCodeEnum" enumName="WORK.ABILITY.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 优抚生活能力代码 -->
	<model:dataset id="ViabilityCodeEnum" enumName="VIABILITY.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 优抚供养方式 -->
	<model:dataset id="SupportPatternEnum" enumName="SUPPORT.PATTERN" autoLoad="true" global="true"></model:dataset>
	<!-- 家庭经济状况 -->
	<model:dataset id="FamilyEconomicsEnum" enumName="FAMILY.ECONOMICS" autoLoad="true" global="true"></model:dataset>
	<!-- 开户银行代码 -->
	<model:dataset id="BankEnum" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BANK'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 是否参战 -->
	<model:dataset id="isWarEnum" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 是否涉核 -->
	<model:dataset id="isInnuclearEnum" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 优抚对象状态 -->
	<model:dataset id="ObjectStateDataset" enumName="OBJECT.STATE" autoLoad="true" global="true"></model:dataset>
</model:datasets>

<next:Panel height="100%" width="100%">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="print"  text="生成" handler="print"/>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="save"  text="保存" handler="save"/>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="disable" text="关闭" handler="func_Close" />
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
					<form id="editForm" dataset="ProvinceMigrationDataSet" onsubmit="return false" style="padding: 5px;" class="L5form">
					<table border="1" border="0" width="98%">
				<tr>
							<td class="FieldLabel" style="width:20%">身份证号:</td>
							<td class="FieldInput" style="width:15%"><label id ="idCard" name="idCard" field="idCard" style="width:135" readonly="true"  />
											
							</td>
							<td class="FieldLabel" style="width:15%">姓名:</td>
							<td class="FieldInput" style="width:15%"><label id="name" name="name" field="name"/></td>
							<td class="FieldLabel" style="width:15%">性别:</td>
							<td class="FieldInput" style="width:15%"><label id="sex" name="sex" field="sex" dataset="SexDataset"></label></td>
				   		</tr>
				   		
				   		<tr>
				   			<td class="FieldLabel">民族:</td>
							<td class="FieldInput"><label id="nation" name="nation" field="nation" dataset="NationDataset"></label></td>
				   			<td class="FieldLabel">出生年月:</td>
							<td class="FieldInput" colspan="3"><label id="birthday" name="birthday" field="birthday"/></td>
				   		</tr>
				   		
						<tr>
							<td class="FieldLabel">优抚对象状态:</td>
							<td class="FieldInput"><label id = "demobilizedStateCode" name="demobilizedStateCode" field="demobilizedStateCode" dataset="ObjectStateDataset" title="优抚对象状态"></label></td>
							<td class="FieldLabel">生活补助证编号:</td>
							<td class="FieldInput" colspan="3"><label id="demobilizedNo" name="demobilizedNo" field="demobilizedNo" title="生活补助证编号"></label></td>
							
						</tr>
                        <tr>
								<input type="hidden" id="peopleId" field="peopleId"/>
								<input type="hidden" id="familyId" field="familyId"/>
								<input type="hidden" id="applyId" field="applyId"/>
								<!-- 打印相关 -->
								<input type="hidden" id="applyId" name="printQuery" queryData="queryData" value="<%=request.getParameter("applyId")%>"/>
								<input type="hidden" id="docpath" value="jsp/cams/bpt/flow/comm/print/e_migration_table.doc"/>
								<input type="hidden" id="peopleId" name="printQuery" queryData="queryData" value="<%=request.getParameter("peopleId")%>"/>
								<input type="hidden" id="scaconfPath" value="migrationApp/migrationAppPrintDao"/>
								<input type="hidden" id="serviceType" name="printQuery" queryData="queryData" value="47"/>
						</tr>
						<tr>
				<td class="FieldLabel" nowrap="nowrap">迁入地民政局:</td>
				<td class="FieldInput"><input type="hidden" id="ingoingCode" name="ingoingCode" field="ingoingCode"/>
									   <input type="text" id="ingoingName" readonly="readonly" name="ingoingName" field="ingoingName" onclick="func_Ingoing()"/>
				<font color="red">*</font></td>
				<td class="FieldLabel" nowrap="nowrap">残疾抚恤金已发至:</td>
				<td class="FieldInput"><input type="text" id="allowanceMonth" name="allowanceMonth" field="allowanceMonth"  onblur="setMoth(this)" format="Y" style="width: 100px;" maxlength="10"/><img  src="../../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ><font color="red">*</font></td>
				<td class="FieldLabel" nowrap="nowrap">迁出地民政部门联系电话:</td>
				<td class="FieldInput" ><input type="text" name="outTownCheckPhone" field="outTownCheckPhone"/></td>
			</tr>
			<tr>
				
				<td class="FieldLabel" >迁入地户口薄(行政区划):</td>
						   <td class="FieldInput" colspan="5" >
						       <input type="text" id="domicileName" style="width:300px;" name="domicileName" field="domicileName" title="属地行政区划" onclick="func_ForInDomicileSelect()" readonly="readonly"/><font color="red">*</font>
						       <input type="hidden" id="domicileCode" name="domicileCode" field="inDomicileCode" title="迁入地户口薄(行政区划)"/> 
				  			&nbsp;&nbsp;&nbsp;地址: 
						    <input type="text" style="width:300px;" id="inDomicileAddress" name="inDomicileAddress" field="inDomicileAddress" title="户口薄住址" ></td>      
			</tr>
			<tr>
				<td class="FieldLabel">迁入地实际居住(行政区划):</td> 
							<td class="FieldInput" colspan="5"><input type="text" style="width:300px;" id="apanageName" name="apanageName" field="apanageName" title="行政区划" readonly="readonly" onclick="func_ForInApanageSelect()"/><font color="red">*</font>
							<input type="hidden" name="apanageCode" field="inApanageCode" title="迁入地实际居住(行政区划)"/>       
				         &nbsp;&nbsp;&nbsp;地址: 
							 <input type="text" style="width:300px;" id="inApanageAddress" name="inApanageAddress" field="inApanageAddress" title="实际居住地址"  ></td>  
			</tr>
						
				</table>
			</form>
		</next:Html>
</next:Panel>
</body>
<script type="text/javascript">
	
function print() {
		var url="../../../../comm/print/jspcommonprint.jsp?";
		var width = 1024;
		var height = 768;
	    window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	}
</script>
</html>
