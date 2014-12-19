<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>公益性公墓信息</title>
<next:ScriptManager />
<script>
		var idField='<%=request.getParameter("dataBean")%>';
</script>
<script type="text/javascript" src="noProfitCemeteryInfo.js"></script>
</head>
<body>

<model:datasets>
	<model:dataset id="ds"
		cmd="com.inspur.cams.fis.ep.base.cmd.CemeInspectionQueryCmd"
		global="true">
		<model:record
			fromBean="com.inspur.cams.fis.ep.base.data.CemeInspection"></model:record>
	</model:dataset>
	<model:dataset id="danweixingzhiDataSet"
		enumName="FIS.CEME.UNITPROPERTIES" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="gongmuxingzhiDataSet" enumName="FIS.CEME.PROP"
		autoLoad="true" global="true"></model:dataset>
	<model:dataset id="tudishiyongxsDataSet"
		enumName="FIS.CEME.LANDUSEFORM" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="zhanyongtudiDataSet" enumName="FIS.CEME.LANDPROP"
		autoLoad="true" global="true"></model:dataset>
	<model:dataset id="tudiyongtuDataSet" enumName="FIS.CEME.LANDUSE"
		autoLoad="true" global="true"></model:dataset>
	<model:dataset id="jiliangdanweiDataSet" enumName="FIS.CEME.AREAUNITS"
		autoLoad="true" global="true"></model:dataset>
	<model:dataset id="inspectionDataSet" enumName="FIS.CEME.RESULT"
		autoLoad="true" global="true"></model:dataset>
</model:datasets>

<next:ViewPort>
	<next:AnchorLayout>
		<next:Panel title="公墓信息" width="100%" height="100%" autoScroll="true">
			<next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="return" text="返回" handler="back" />
			</next:TopBar>
			<next:Html>
				<form id="InspectionForm" method="post" dataset="ds"
					onsubmit="return false" class="L5form">
				<fieldset><legend>公墓基本信息</legend>
				<table width="100%">
					<tr>
									
									<td class="FieldLabel" style="width: 25%">公墓名称:</td>
									<td class="FieldInput"><label name="公墓名称"
										field="cemeName" /></td>
									<td class="FieldLabel" style="width: 25%">主办单位:</td>
									<td class="FieldInput" style="width: 32%"><label
										name="主办单位" field="organizer" /></td>
								</tr>
								<tr>
									<td class="FieldLabel">公墓所在位置:</td>
									<td class="FieldInput"><label type="text" name="公墓所在位置"
										id="address" field="address" style="width: 250px"
										maxlength="49" /></td>
									<td class="FieldLabel" style="width: 21%">公墓负责人:</td>
									<td class="FieldInput" style="width: 32%"><label
										name="公墓负责人" field="legalPerson" /></td>
								</tr>
								<tr>
									<td class="FieldLabel">公墓负责人电话:</td>
									<td class="FieldInput"><label type="text" name="公墓负责人电话"
										field="directorMobile" id="directorMobile"
										  /></td>
									<td class="FieldLabel">公墓性质:</td>
									<td class="FieldInput"><label field="prop"
										dataset="gongmuxingzhiDataSet" /></td>
								</tr>
								<tr>
									<td class="FieldLabel" style="width: 21%">县级民政部门批准建设文号:</td>
									<td class="FieldInput"><label field="caDeptBuildNum" /></td>
									<td class="FieldLabel" style="width: 21%">县级民政部门批准建设时间:</td>
									<td class="FieldInput" style="width: 32%"><label
										name="县级民政部门批准建设时间" field="caDeptBuildTime"
										readonly="readonly" /></td>
								</tr>
								<tr>
									<td class="FieldLabel" style="width: 21%">市级民政部门备案文号:</td>
									<td class="FieldInput"><label field="caDeptGestionNum" /></td>
									<td class="FieldLabel" style="width: 21%">市级民政部门备案时间:</td>
									<td class="FieldInput" style="width: 32%"><label
										name="市级民政部门备案时间" field="caDeptGestionTime"
										readonly="readonly" /></td>
								</tr>
								<tr>
								<tr>
									<td class="FieldLabel" style="width: 21%">正式使用时间:</td>
									<td class="FieldInput"><label name="正式使用时间"
										field="gestionTime" format="Y-m-d"
										onclick="LoushangDate(this)" readonly="readonly" /></td>
									<td class="FieldLabel" style="width: 21%">
									<td class="FieldInput" style="width: 32%">
								</tr>
							</table>
							</fieldset>

							<fieldset><legend>公墓建设信息</legend>
							<table width="100%">

								<tr>
									<td class="FieldLabel" style="width: 26%">公墓占地总面积:</td>
									<td class="FieldInput" colspan="3" ><label type="text"
										name="公墓占地总面积" field="totalArea" id="totalArea" maxlength="12" style="text-align:right"
										onchange="checkAssMon(this.id)" /></td>
									<td class="FieldLabel" colspan="2" style="width: 28%">公墓占地总面积计量单位:</td>
									<td class="FieldInput" style="width: 20%" colspan="3"><label type="text"
										name="公墓占地总面积计量单位" field="totalAreaUnits" id="totalAreaUnits"
										 /></td>
								</tr>

								<tr>
									<td class="FieldLabel" style="width: 21%">本年安葬总人数:</td>
									<td class="FieldInput" colspan="3"><label type="text"
										name="本年安葬总人数" maxlength="10" field="yearPeopleNum" style="text-align:right"
										id="yearPeopleNum"  /></td>
									<td class="FieldLabel" colspan="2" style="width: 21%">自使用至今安葬总人数:</td>
									<td class="FieldInput" style="width: 32%" colspan="3"><label
										type="text" name="自使用至今安葬总人数" maxlength="10" style="text-align:right"
										field="sincePeopleNum" id="sincePeopleNum"
										 /></td>
								</tr>
								<tr>
									<td class="FieldLabel">本年安葬墓穴数:</td>
									<td class="FieldLabel" style="width: 15%">合计:</td>
									<td class="FieldInput"><label type="text" name="本年安葬墓穴数合计" style="text-align:right"
										field="yearHoleNum" id="yearHoleNum"  maxlength="10"  style="width: 80px"/></td>
									<td class="FieldLabel"  style="width: 15%">单穴:</td>
									<td class="FieldInput"><label type="text" name="单穴安葬数(本年)" style="text-align:right"
										field="yearSingleHole" id="yearSingleHole"
										 maxlength="10" style="width: 80px"/></td>
									<td class="FieldLabel" style="width: 15%">双穴:</td>
									<td class="FieldInput" ><label type="text" name="双穴安葬数(本年)" style="text-align:right"
										field="yearDoubleHole" id="yearDoubleHole"
										 maxlength="10" style="width: 80px" /></td>
									<td class="FieldLabel" style="width: 15%">多穴:</td>
									<td class="FieldInput"><label type="text" name="多穴安葬数(本年)" style="text-align:right"
										field="yearMoreHole" id="yearMoreHole"
										 maxlength="10" style="width: 80px"/></td>
								</tr>
								<tr>
									<td class="FieldLabel">本年迁出墓穴数:</td>
									<td class="FieldLabel" style="width: 15%">合计:</td>
									<td class="FieldInput"><label type="text" name="本年迁出墓穴数合计" style="text-align:right"
										field="yearOutNum" id="yearOutNum"  maxlength="10"  style="width: 80px"/></td>
									<td class="FieldLabel" style="width: 15%">单穴:</td>
									<td class="FieldInput"><label type="text" name="单穴迁出数(本年)" style="text-align:right"
										field="outSingleHole" id="outSingleHole"  maxlength="10"  style="width: 80px"/></td>
									<td class="FieldLabel" style="width: 15%">双穴:</td>
									<td class="FieldInput"><label type="text" name="双穴迁出数(本年)" style="text-align:right"
										field="outDoubleHole" id="outDoubleHole"  maxlength="10"  style="width: 80px"/></td>
									<td class="FieldLabel" style="width: 15%">多穴:</td>
									<td class="FieldInput"><label type="text" name="多穴迁出数(本年)" style="text-align:right"
										field="outMoreHole" id="outMoreHole"  maxlength="10"  style="width: 80px"/></td>
								</tr>
								<tr>
									<td class="FieldLabel">自使用至今安葬穴数:</td>
									<td class="FieldLabel" style="width: 15%">合计:</td>
									<td class="FieldInput"><label type="text" name="自使用至今安葬穴位数合计" style="text-align:right"
										field="sinceHoleNum" id="sinceHoleNum"  maxlength="10"  style="width: 80px"/></td>
									<td class="FieldLabel" style="width: 15%">单穴:</td>
									<td class="FieldInput"><label type="text" name="单穴安葬数(自使用至今)" style="text-align:right"
										field="singleHole" id="singleHole"
										 maxlength="10" style="width: 80px"/></td>
									<td class="FieldLabel" style="width: 15%">双穴:</td>
									<td class="FieldInput"><label type="text" name="双穴安葬数(自使用至今)" style="text-align:right"
										field="doubleHole" id="doubleHole"
										   style="width: 80px"/></td>
									<td class="FieldLabel" style="width: 15%">多穴:</td>
									<td class="FieldInput"><label  name="多穴安葬数(自使用至今)" style="text-align:right"
										field="moreHole" id="moreHole"
										maxlength="10"  style="width: 80px"/></td>
								</tr>
				</table>
				</fieldset>
				</form>
			</next:Html>
		</next:Panel>
	</next:AnchorLayout>
</next:ViewPort>
</body>
</html>

