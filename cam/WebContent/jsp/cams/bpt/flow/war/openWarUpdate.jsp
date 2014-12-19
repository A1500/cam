<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>公式书——参战人员</title>
<next:ScriptManager />
		<script>
			var peopleId='<%=request.getParameter("peopleId")%>';
			var applyId='<%=request.getParameter("applyId")%>';
			var organId='<%=BspUtil.getCorpOrgan().getOrganCode()%>';
			var struId = '<%=BspUtil.getStruId()%>';
			var adjust = '<%=request.getParameter("adjust")%>'
		</script>
<script type="text/javascript" src="openWarUpdate.js"></script>
<script type="text/javascript" src="../../comm/bptComm.js"></script>
</head>
<body>
<model:datasets>
	<!-- 公示书信息 -->
	<model:dataset id="BptOpenLetterDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BptOpenLetterQueryCommand" method="queryOpenLetter" global="true">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptOpenLetter">
				<model:field name="applyId" type="string" rule="require"/>
				<model:field name="openstartDate" type="string" rule="require"/>
				<model:field name="openendDate" type="string" rule="require"/>
				<model:field name="openDate" type="string" rule="require"/>
				<model:field name="law" type="string" rule="require"/>
				<model:field name="toOrganId" type="string" rule="require"/>
				<model:field name="domicile" type="string" />
				<model:field name="organId" type="string" />
				<model:field name="name" type="string" />
				<model:field name="sex" type="string" />
				<model:field name="address" type="string" />
				<model:field name="workUnitName" type="string" />
				<model:field name="birthday" type="string" />
				<model:field name="openDays" type="string" />
		</model:record>
	</model:dataset>
	<!-- 性别 -->
	<model:dataset id="SexDataset" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>

	<!-- 伤残性质 -->
	<model:dataset id="DisabilityCaseDataset" enumName="CASE.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 伤残等级 -->
	<model:dataset id="DisabilityLevelDataset" enumName="LEVEL.CODE" autoLoad="true" global="true"></model:dataset>
	
</model:datasets>
			<next:Panel height="100%" autoScroll="true" width="100%" id="typeInfo">
				<next:TopBar>
					<next:ToolBarItem symbol="->" ></next:ToolBarItem>
					<next:ToolBarItem iconCls="print" text="生成" handler="print" />
					<next:ToolBarItem symbol="-" ></next:ToolBarItem>
					<next:ToolBarItem iconCls="save" text="保存" handler="save" />
				</next:TopBar>
				<next:Html>
					<fieldset>
					<form id="BptOpenLetterForm" method="post"
						dataset="BptOpenLetterDataSet" onsubmit="return false"
						style="padding: 5px;" class="L5form">
					<table border="1" width="98%">
						<tr>
							<td class="FieldLabel" >公示时间(起)：</td>
							<td class="FieldInput"><input
								format="Y-m-d" maxlength="10" style="width: 100px;" type="text" id="openstartDate"
								name="openstartDate" field="openstartDate" title="公示时间(起)" onblur="getDateDiff(this)" onpropertychange="changeDateStyle(this)" /><img  src="../../../../../skins/images/default/rl.gif" align="middle"  onclick="getTimes(this)"  ><font color="red">*</font></td>
							<td class="FieldLabel" >公示时间(止)：</td>
							<td class="FieldInput" ><input
								format="Y-m-d" maxlength="10" style="width: 100px;" type="text" id="openendDate"
								name="openendDate" field="openendDate" title="公示时间(止)" onblur="getDateDiff(this)" onpropertychange="changeDateStyle(this)" /><img  src="../../../../../skins/images/default/rl.gif" align="middle"  onclick="getTimes(this)"  ><font color="red">*</font></td>
							<td class="FieldLabel" >公示时间(天)：</td>
							<td class="FieldInput" >
								<input type="text" value="7"  id="openDays" readonly="readonly" 
								name="openDays" field="openDays"  title="公示时间(天)"/></td>
						</tr>
						<tr>
							 <td class="FieldLabel" >依据法规：</td>
							<td class="FieldInput"  colspan="3"><textarea
								rows="2" name="law"
								field="law" style="width:94%" title="依据法规"></textarea><font color="red">*</font></td>
								<td class="FieldLabel" >投诉部门：</td>
							<td class="FieldInput" ><input type="text" 
								name="toOrganId" field="toOrganId"  title="投诉部门"/><font color="red">*</font></td>
						</tr>
					    <tr>
					       <td class="FieldLabel" >姓名：</td>
							<td class="FieldInput" ><label 
								name="name" field="name"  title="姓名"/></td>
							<td class="FieldLabel" >性别：</td>
							<td class="FieldInput" width="15%"><label 
								name="sex" field="sex"  dataset="SexDataset" title="性别"/></label></td>
							<td class="FieldLabel" >出生年月：</td>
							<td class="FieldInput"><label 
								name="birthday" field="birthday" title="出生年月"/></td>
					    </tr>
						<tr>
							<td class="FieldLabel" >工作单位：</td>
							<td class="FieldInput" ><label
								name="workUnitName" field="workUnitName"  title="工作单位"/></td>
							<td class="FieldLabel" >住址：</td>
							<td class="FieldInput" colspan="3"><label
								name="address" field="address" style="width:89%" title="住址"/></td>
						</tr>
						<tr>
						    <td class="FieldLabel" >入伍时间：</td>
							<td class="FieldInput" ><input 
								format="Y-m-d" maxlength="10"  type="text" id="conscriptcDate"
								name="conscriptcDate" field="conscriptcDate" style="width: 100px;" title="入伍时间" onpropertychange="changeDateStyle(this)"/><img  src="../../../../../skins/images/default/rl.gif" align="middle"  onclick="getTimes(this)"  ></td>
						
							<td class="FieldLabel" >退伍时间：</td>
							<td class="FieldInput" colspan="3"><input 
								format="Y-m-d" maxlength="10"  type="text" id="decruitmentDate"
								name="decruitmentDate" field="decruitmentDate" style="width: 100px;" title="退伍时间"  onpropertychange="changeDateStyle(this)"/><img  src="../../../../../skins/images/default/rl.gif" align="middle"  onclick="getTimes(this)"  ></td>
						</tr>
						
						<tr>
							<td class="FieldLabel" >在部队情况：</td>
							<td class="FieldInput"  colspan="5"><textarea
								rows="2" name="armyCondition"
								field="armyCondition" style="width:94%" title="在部队情况"></textarea></td>
						</tr>
						<tr>
							<td class="FieldLabel" >将享受待遇：</td>
							<td class="FieldInput"  colspan="5"><textarea
								rows="2" name="treatment"
								field="treatment" style="width:94%" title="将享受待遇"></textarea></td>
						</tr>
						<tr>
							<td class="FieldLabel" >公示书出具单位：</td>
							<td class="FieldInput"  colspan="5">
							<label id="domicile" name="domicile" class="TextEditor" field="domicile" title="公示书出具单位"  />
							</td>
						</tr>
						<tr>
							<td class="FieldLabel" >公示书出具时间：</td>
							<td class="FieldInput"  colspan="5"><input
								format="Y-m-d" style="width: 100px;" maxlength="10" type="text"
								name="openDate" field="openDate" title="公示书出具时间" onpropertychange="changeDateStyle(this)" /><img  src="../../../../../skins/images/default/rl.gif" align="middle"  onclick="getTimes(this)"  ><font color="red">*</font></td>
						</tr>
						
						<input type="hidden" id="docpath" value="jsp/cams/bpt/flow/war/table/warOpenLetter.doc"/>
						<input type="hidden" id="peopleId" name="printQuery" queryData="queryData" value="<%=request.getParameter("peopleId")%>"/>
						<input type="hidden" id="applyId" name="printQuery" queryData="queryData" value="<%=request.getParameter("applyId")%>"/>
						<input type="hidden" id="organId" name="printQuery" queryData="queryData" value="<%=BspUtil.getCorpOrgan().getOrganCode()%>"/>
						<input type="hidden" id="scaconfPath" value="openLetterPrintdao/openLetterPrintdao"/>
					</table>
					</form>
					</fieldset>
				</next:Html>
			</next:Panel>
</body>
</html>
