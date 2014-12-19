<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<script>
		var idField='<%=request.getParameter("dataBean")%>';
		var method='<%=request.getParameter("method")%>';
		var type='<%=request.getParameter("type")%>';
</script>
<html>
<head>
<next:ScriptManager />
<script type="text/javascript" src="../prsComm.js"></script>
<script type="text/javascript" src="prssoldiersplacement_edit.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'>
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="prsPlacementDataset"
		cmd="com.inspur.cams.prs.prssoldiersplacement.cmd.PrsSoldiersPlacementQueryCommand"
		global="true">
		<model:record 
		fromBean="com.inspur.cams.prs.prssoldiersplacement.dao.PrsSoldiersPlacement">
			<model:field name="employmentType" mapping="EMPLOYMENT_TYPE" type="string"/>
			<model:field name="employmentTime" mapping="EMPLOYMENT_TIME" type="string"/>
			<model:field name="employmentCompany" mapping="EMPLOYMENT_COMPANY" type="string"/>
			<model:field name="employmentGuidanceDescribe" mapping="EMPLOYMENT_GUIDANCE_DESCRIBE" type="string"/>
			<model:field name="resettlementSituation" mapping="RESETTLEMENT_SITUATION" type="string"/>
			<model:field name="transactDate" mapping="TRANSACT_DATE" type="string"/>
			<model:field name="applicationDate" mapping="APPLICATION_DATE" type="string"/>
			<model:field name="grantGrant" mapping="GRANT_GRANT" type="string"/>
			<model:field name="content" mapping="CONTENT" type="string"/>
			<model:field name="soldierId" mapping="SOLDIERS_ID" type="string"/>
			<model:field name="placementId" mapping="PLACEMENT_ID" type="string"/>
			<model:field name="archivesPerformanceScores" mapping="ARCHIVES_PERFORMANCE_SCORES" type="string"/>
			<model:field name="culturalStudiesTestScores" mapping="CULTURAL_STUDIES_TEST_SCORES" type="string"/>
			<model:field name="totalScore" mapping="TOTAL_SCORE" type="string"/>
			<model:field name="ranking" mapping="RANKING" type="string"/>
			</model:record>
	</model:dataset>
	<!-- 就业形式 -->
	<model:dataset id="EmploymentType" enumName="EMPLOYMENT.TYPE"
		autoLoad="true" global="true"></model:dataset>
	<!-- 安置形式 -->
	<model:dataset id="PlacementType" enumName="PLACEMENT.TYPE"
		autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:ViewPort>
	<next:AnchorLayout>
		<next:Panel >
			<next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="save" text="保存"
					handler="Evt_butsave_click" />
				<next:ToolBarItem symbol="-"></next:ToolBarItem>
				<next:ToolBarItem iconCls="print" text="打印安置信息" handler="print"></next:ToolBarItem>
			</next:TopBar>
			<next:Html>
				<fieldset>
				<form id="PrsSoldiersPlacementForm" method="post"
					dataset="prsPlacementDataset" onsubmit="return false"
					style="padding: 5px;" class="L5form">
				<table border="1" width="98%">
					<tr>
						<td class="FieldLabel" style="width: 10%" colspan="2">安置方式：</td>
						<td class="FieldInput" style="width: 30%">
						<div>
							<div style="float: left;">
							<select id="employmentType" name="employmentTypeCode" onchange="employmentTypeChanges()"
							field="employmentType" title="就业方式">
							<option dataset="EmploymentType"></option>
							</select>
							<font color="red">*</font>
							</div>
							<div id ="resettlement" style="display: none;float: left;"><select id="resettlementSituation"
								name="resettlementSituation" field="resettlementSituation"
								title="安置形式" onchange="fun_Type()">
								<option dataset="PlacementType"></option>
							</select><font color="red">*</font></div>
						</div>
						</td>

						<td class="FieldLabel" style="width: 10%">就业时间：</td>
						<td class="FieldInput" style="width: 30%"><input type="text"
							name="employmentTime" field="employmentTime" id="employmentTime"
							format="Y-m-d" maxlength="10"onpropertychange="changeDateStyle(this)" title="就业时间" /><img  src="../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" > <font
							color="red">*</font></td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width: 10%" colspan="2">档案考核成绩：</td>
						<td class="FieldInput" style="width: 30%"><input type="text" onblur="formatFloat(this)"
							name="档案考核成绩" field="archivesPerformanceScores" id="archivesPerformanceScores" /></td>

						<td class="FieldLabel" style="width: 10%">文化考试成绩：</td>
						<td class="FieldInput" style="width: 30%"><input type="text" onblur="formatFloat(this)"
							name="文化考试成绩" field="culturalStudiesTestScores" id="culturalStudiesTestScores" /></td>
					</tr>
					<tr>
						<td class="FieldLabel" colspan="2">总成绩：</td>
						<td class="FieldInput"><input type="text" name="总成绩" id ="totalScore" onblur="formatFloat(this)"
							field="totalScore" /></td>

						<td class="FieldLabel">名次：</td>
						<td class="FieldInput"><input type="text" name="名次" id="ranking" onblur="checkRank(this)"
							field="ranking" /></td>
					</tr>
					<tr>
						<td class="FieldLabel" colspan="2">就业单位：</td>
						<td class="FieldInput" colspan="3"><input type="text"
							style="width: 74%" name="EmpCom" field="employmentCompany"
							title="就业单位" /> <font color="red">*</font></td>
					</tr>
					<tr>
						<td class="FieldLabel" colspan="2">就业指导描述：</td>
						<td class="FieldInput" colspan="3"><textarea
							name="EmpGuidDESC" field="employmentGuidanceDescribe"
							style="width: 74%" title="就业指导描述"></textarea></td>
					</tr>
					<tr>
						<td class="FieldLabel" nowrap="nowrap" rowspan="2">
							<div id ="zmzyj" style="display: block;">自谋职业金</div>
							<div id ="jjbzj" style="display: none;">经济补助金</div>
						</td>
						<td class="FieldLabel" nowrap="nowrap" rowspan="2" >发放金额（元）：</td>
						<td class="FieldInput" rowspan="2"><input type="text" name="发放金额" onblur="formatFloat(this)"
							field="grantGrant" id="grantGrant" title="发放金额" /></td>
							<td class="FieldLabel" nowrap="nowrap" >申请时间：</td>
						<td class="FieldInput"><input type="text" name="applicationDate"
							field="applicationDate" id="applicationDate" title="申请时间"
							format="Y-m-d" maxlength="10"onpropertychange="changeDateStyle(this)" /><img id = "applicationDateimg" src="../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ></td>
						
					</tr>
					<tr>
						<td class="FieldLabel" nowrap="nowrap">发放时间：</td>
						<td class="FieldInput"><input type="text" name="transactDate"
							field="transactDate" id="transactDate" title="发放时间"
							format="Y-m-d" maxlength="10"onpropertychange="changeDateStyle(this)" /><img id = "transactDateimg" src="../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ></td>
					</tr>
					<tr>
						<td class="FieldLabel" colspan="2">备注：</td>
						<td class="FieldInput" colspan="3"><textarea name="content"
							field="content" style="width: 74%" title="备注"></textarea></td>
					</tr>
				</table>
				</form>
				</fieldset>
			</next:Html>
		</next:Panel>
	</next:AnchorLayout>
</next:ViewPort>
</body>
</html>
