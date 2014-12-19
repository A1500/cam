<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>公式书——60岁退役士兵人员</title>
<next:ScriptManager />
		<script>
			var peopleId='<%=request.getParameter("peopleId")%>';
			var applyId='<%=request.getParameter("applyId")%>';
			var organId='<%=BspUtil.getCorpOrgan().getOrganCode()%>';
			var struId = '<%=BspUtil.getStruId()%>';
			var adjust = '<%=request.getParameter("adjust")%>'
		</script>
<script type="text/javascript" src="openSoldierUpdate.js"></script>
<script type="text/javascript" src="../../comm/bptComm.js"></script>
</head>
<body>
<model:datasets>
	<!-- 公示书信息 -->
	<model:dataset id="BptOpenLetterDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BptOpenLetterQueryCommand" method="querySoldierOpenLetter" global="true">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptOpenLetter">
				<model:field name="applyId" type="string" rule="require"/>
				<model:field name="openstartDate" type="string" rule="require"/>
				<model:field name="openendDate" type="string" rule="require"/>
				<model:field name="openDate" type="string" rule="require"/>
				<model:field name="law" type="string" />
				<model:field name="toOrganId" type="string" />
				<model:field name="domicile" type="string" />
				<model:field name="organId" type="string" />
				<model:field name="name" type="string" />
				<model:field name="sex" type="string" />
				<model:field name="address" type="string" />
				<model:field name="workUnitName" type="string" />
				<model:field name="birthday" type="string" />
				<model:field name="openDays" type="string" />
				<model:field name="soldierYears" type="string" />
				<model:field name="conscriptDate" type="string" />
				<model:field name="decruitmentDate" type="string" />
		</model:record>
	</model:dataset>
	<!-- 性别 -->
	<model:dataset id="SexDataset" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
	<!-- 身份类别 -->
	<model:dataset id="StatusTypeEnum" enumName="STATUS.TYPE" autoLoad="true" global="true"></model:dataset>
	
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
							<td class="FieldInput"><label 
								name="conscriptDate" field="conscriptDate" title="入伍时间"/></td>
							<td class="FieldLabel" >退役时间：</td>
							<td class="FieldInput" width="15%" colspan="3"><label 
								name="decruitmentDate" field="decruitmentDate"   title="退役时间"/></label></td>
					    </tr>
					    <tr>
							<td class="FieldLabel" >所服义务兵折算年限：</td>
							<td class="FieldInput"  colspan="5">
							<label id="soldierYears" name="soldierYears"  class="TextEditor" field="soldierYears" title="所服义务兵折算年限" ></label>年
							</td>
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
						
						<input type="hidden" id="docpath" value="jsp/cams/bpt/flow/countretiredsoldier/print/soldierOpen.doc"/>
						<input type="hidden" id="peopleId" name="printQuery" queryData="queryData" value="<%=request.getParameter("peopleId")%>"/>
						<input type="hidden" id="applyId" name="printQuery" queryData="queryData" value="<%=request.getParameter("applyId")%>"/>
						<input type="hidden" id="organId" name="printQuery" queryData="queryData" value="<%=BspUtil.getCorpOrgan().getOrganCode()%>"/>
						<input type="hidden" id="method" name="queryData" queryData="queryData" value="querySoldierData"/>
						<input type="hidden" id="scaconfPath" value="openLetterPrintdao/openLetterPrintdao"/>
					</table>
					</form>
					</fieldset>
				</next:Html>
			</next:Panel>
</body>
</html>
