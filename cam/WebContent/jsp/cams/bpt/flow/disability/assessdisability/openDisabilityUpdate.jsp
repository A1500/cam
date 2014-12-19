<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>公式书——伤残人员</title>
<next:ScriptManager />
		<script>
			var peopleId='<%=request.getParameter("peopleId")%>';
			var applyId='<%=request.getParameter("applyId")%>';
			var organId='<%=BspUtil.getCorpOrgan().getOrganCode()%>';
			var struId = '<%=BspUtil.getStruId()%>';
			var adjust = '<%=request.getParameter("adjust")%>'
		</script>
<script type="text/javascript" src="openDisabilityUpdate.js"></script>
<script type="text/javascript" src="../../../comm/bptComm.js"></script>
</head>
<body>
<model:datasets>
	<!-- 公示书信息 -->
	<model:dataset id="BptDisabilityOpenDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BptDisabilityOpenQueryCommand" method="queryDisabilityOpen" global="true">
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoPeople">
				<model:field name="applyId" type="string" rule="require"/>
				<model:field name="openstartDate" type="string" />
				<model:field name="openendDate" type="string" />
				<model:field name="disabilityDate" type="string" rule="require"/>
				<model:field name="disabilityAdd" type="string" />
				<model:field name="disabilityReason" type="string" />
				<model:field name="disabilityCondition" type="string" />
				<model:field name="openDate" type="string" rule="require"/>
				<model:field name="domicile" type="string" />
				<model:field name="organId" type="string" />
				<model:field name="disabilityCaseCode" type="string" />
				<model:field name="disabilityLevelCode" type="string" />
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
					<form id="BptDisabilityOpenForm" method="post"
						dataset="BptDisabilityOpenDataSet" onsubmit="return false"
						style="padding: 5px;" class="L5form">
					<table border="1" width="98%">
						<tr>
							<td class="FieldLabel" >公示时间(起)：</td>
							<td class="FieldInput"><input
								format="Y-m-d" maxlength="10" style="width: 100px;" type="text"
								name="openstartDate" field="openstartDate" title="公示时间(起)" onpropertychange="changeDateStyle(this)" /><img  src="../../../../../../skins/images/default/rl.gif" align="middle"  onclick="getTimes(this)"  ></td>
							<td class="FieldLabel" >公示时间(止)：</td>
							<td class="FieldInput" colspan="3"><input
								format="Y-m-d" maxlength="10" style="width: 100px;" type="text"
								name="openendDate" field="openendDate" title="公示时间(止)" onpropertychange="changeDateStyle(this)" /><img  src="../../../../../../skins/images/default/rl.gif" align="middle"  onclick="getTimes(this)"  ></td>
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
							<td class="FieldInput" ><input type="text"
								name="workUnitName" field="workUnitName"  title="工作单位"/></td>
							<td class="FieldLabel" >住址：</td>
							<td class="FieldInput" colspan="3"><input type="text"
								name="address" field="address" style="width:89%" title="住址"/></td>
						</tr>
						<tr>
						    <td class="FieldLabel" >致残时间：</td>
							<td class="FieldInput" colspan="5"><input
								format="Y-m-d" maxlength="10"  type="text"
								name="disabilityDate" field="disabilityDate" style="width: 100px;" title="致残时间" onpropertychange="changeDateStyle(this)" /><img  src="../../../../../../skins/images/default/rl.gif" align="middle"  onclick="getTimes(this)"  ><font
								color="red">*</font></td>
						</tr>
						<tr>
							<td class="FieldLabel" >致残地点：</td>
							<td class="FieldInput" colspan="5"><input type="text"
								name="disabilityAdd" field="disabilityAdd" style="width:94%"  title="致残地点"/><font color="red">*</font></td>
						</tr>
						
						<tr>
							<td class="FieldLabel" >致残原因：</td>
							<td class="FieldInput"  colspan="5"><textarea
								rows="2" name="disabilityReason"
								field="disabilityReason" style="width:94%" title="致残原因"></textarea><font color="red">*</font></td>
						</tr>
						<tr>
							<td class="FieldLabel" >伤残等级：</td>
							<td class="FieldInput"><select 
								name="disabilityLevelCode" field="disabilityLevelCode"  title="伤残等级">
									<option dataset="DisabilityLevelDataset"></option>
								</select>
								</td>
							<td class="FieldLabel" >伤残性质：</td>
							<td class="FieldInput" colspan="3"><select 
								name="disabilityCaseCode" field="disabilityCaseCode"  title="伤残性质">
								<option dataset="DisabilityCaseDataset"></option>
								</select>
								</td>
						</tr>
						<tr>		
							<td class="FieldLabel" >致残情况：</td>
							<td class="FieldInput" colspan="5"><input type="text"
								name="disabilityCondition" field="disabilityCondition" style="width:94%" title="致残情况"/></td>
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
								name="openDate" field="openDate" title="公示书出具时间" onpropertychange="changeDateStyle(this)" /><img  src="../../../../../../skins/images/default/rl.gif" align="middle"  onclick="getTimes(this)"  ><font color="red">*</font></td>
						</tr>
						
						<input type="hidden" id="docpath" value="jsp/cams/bpt/flow/disability/assessdisability/table/open_disability_apptable.doc"/>
						<input type="hidden" id="peopleId" name="printQuery" queryData="queryData" value="<%=request.getParameter("peopleId")%>"/>
						<input type="hidden" id="applyId" name="printQuery" queryData="queryData" value="<%=request.getParameter("applyId")%>"/>
						<input type="hidden" id="organId" name="printQuery" queryData="queryData" value="<%=BspUtil.getCorpOrgan().getOrganCode()%>"/>
						<input type="hidden" id="method" name="queryData" queryData="queryData" value="queryOpenNotice"/>
						<input type="hidden" id="scaconfPath" value="assDisdislityApp/assDisdislityAppPrintDao"/>
					</table>
					</form>
					</fieldset>
				</next:Html>
			</next:Panel>
</body>
</html>
