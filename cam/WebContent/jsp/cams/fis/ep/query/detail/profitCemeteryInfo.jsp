<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>公墓信息</title>
<next:ScriptManager />
<script>
		var idField='<%=request.getParameter("dataBean")%>';
</script>
<script type="text/javascript" src="profitCemeteryInfo.js"></script>
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
		<!-- 公墓基本信息 -->
		<next:Panel width="100%" height="100%" autoScroll="true">
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
						<td class="FieldLabel" style="width: 21%">公墓编号：</td>
						<td class="FieldInput" style="width: 26%"><label name="公墓编号"
							field="cemeId" /></td>
						<td class="FieldLabel" style="width: 21%">公墓名称:</td>
						<td class="FieldInput" style="width: 32%"><label name="公墓名称"
							field="cemeName" /></td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width: 21%">主办/联办单位:</td>
						<td class="FieldInput"><label name="主办/联办单位"
							field="organizer" /></td>
						<td class="FieldLabel" style="width: 21%">法人代表:</td>
						<td class="FieldInput" style="width: 32%"><label name="法人代表"
							field="legalPerson" /></td>
					</tr>
					<tr>
						<td class="FieldLabel">公墓负责人:</td>
						<td class="FieldInput"><label type="text" name="公墓负责人"
							field="directorMobile" id="directorMobile" maxlength="11" /></td>
						<td class="FieldLabel">联系电话:</td>
						<td class="FieldInput"><label type="text" name="联系电话"
							maxlength="16" field="officePhone" id="officePhone"
							onchange="checkTel(this.id)" /></td>

					</tr>
					<tr>
						<td class="FieldLabel">公墓性质:</td>
						<td class="FieldInput"><label field="prop"
							dataset="gongmuxingzhiDataSet" /></td>
						<td class="FieldLabel">单位性质:</td>
						<td class="FieldInput"><select name="单位性质"
							id="unitProperties" field="unitProperties">
							<option dataset="danweixingzhiDataSet"></option>
						</select></td>

					</tr>
					<tr>
						<td class="FieldLabel">邮政编码:</td>
						<td class="FieldInput"><label type="text" name="邮政编码"
							maxlength="6" id="postalcode" field="postalcode"
							onchange="checkpostalcode(this.id)" /></td>
						<td class="FieldLabel">职工总数:</td>
						<td class="FieldInput"><label type="text" name="职工总数"
							maxlength="9" field="totalStaff" id="totalStaff"
							style="text-align: right" onchange="checkNum(this.id)" />人</td>
					</tr>
					<tr>
						<td class="FieldLabel">公墓所在位置:</td>
						<td class="FieldInput"><label type="text" name="公墓所在位置"
							id="address" field="address" style="width: 250px" maxlength="49" /></td>
						<td class="FieldLabel">使用年限:</td>
						<td class="FieldInput"><label name="使用年限" field="useAge" /></td>
					</tr>
					<tr>
						<td class="FieldLabel">土地证件号:</td>
						<td class="FieldInput"><label name="土地证件号" field="landNum" /></td>
						<td class="FieldLabel">土地使用性质:</td>
						<td class="FieldInput"><select name="土地使用性质" id="landProp"
							field="landProp">
							<option dataset="zhanyongtudiDataSet"></option>
						</select></td>
					</tr>
					<tr>
						<td class="FieldLabel">土地使用形式:</td>
						<td class="FieldInput"><select name="土地使用形式"
							field="landUseForm">
							<option dataset="tudishiyongxsDataSet"></option>
						</select></td>
						<td class="FieldLabel">土地用途:</td>
						<td class="FieldInput"><select name="土地用途" field="landUse">
							<option dataset="tudiyongtuDataSet"></option>
						</select></td>
					</tr>

					<tr>
						<td class="FieldLabel">固定资产:</td>
						<td class="FieldInput"><label type="text" name="固定资产"
							style="text-align: right" field="fixeDassets" maxlength="7"
							onchange="checkAssMon(this.id)" />万元</td>
						<td class="FieldLabel">总投资额:</td>
						<td class="FieldInput"><label type="text" name="总投资额"
							style="text-align: right" field="totalInvestment" maxlength="7"
							onchange="checkAssMon(this.id)" />万元</td>
					</tr>
					<tr>
						<td class="FieldLabel">正式营业时间:</td>
						<td class="FieldInput"><label name="正式营业时间"
							field="gestionTime" format="Y-m-d" onclick="LoushangDate(this)"
							readonly="readonly" /></td>
						<td class="FieldLabel">
						<td class="FieldInput">
					</tr>
				</table>
				</fieldset>

				<fieldset><legend>政府部门批准文号和时间</legend>
				<table width="100%">
					<tr>
						<td class="FieldLabel" style="width: 21%">民政厅批准建设文号:</td>
						<td class="FieldInput"><label field="caDeptBuildNum" /></td>
						<td class="FieldLabel" style="width: 21%">民政厅批准建设时间:</td>
						<td class="FieldInput" style="width: 32%"><label
							name="民政厅批准建设时间" field="caDeptBuildTime" readonly="readonly" /></td>
					</tr>
					<tr>
						<td class="FieldLabel">民政厅批准经营文号:</td>
						<td class="FieldInput"><label name="民政厅批准经营文号"
							field="caDeptGestionNum" /></td>
						<td class="FieldLabel">民政厅批准经营时间:</td>
						<td class="FieldInput"><label name="民政厅批准经营时间"
							field="caDeptGestionTime" readonly="readonly" /></td>
					</tr>
					<tr>
						<td class="FieldLabel">媒体公告合格证书编号</td>
						<td class="FieldInput"><label type="text" name="媒体公告合格证书编号"
							field="mediaNum" maxlength="25" style="width: 200px;" /></td>
						<td class="FieldLabel">媒体公告合格证书颁发时间</td>
						<td class="FieldInput"><label type="text" name="媒体公告合格证书颁发时间"
							field="mediaTime" format="Y-m-d" onclick="LoushangDate(this)"
							readonly="readonly" /></td>
					</tr>
					<tr>
						<td class="FieldLabel">国土部门批准文号:</td>
						<td class="FieldInput"><label name="国土部门批准文号"
							field="landDeptAllowedNum" /></td>
						<td class="FieldLabel">国土部门批准时间:</td>
						<td class="FieldInput"><label name="国土部门批准时间"
							field="landDeptAllowedTime" readonly="readonly" /></td>
					</tr>
					<tr>
						<td class="FieldLabel">规划部门批准文号:</td>
						<td class="FieldInput"><label name="规划部门批准文号"
							field="planningAllowedNum" /></td>
						<td class="FieldLabel">规划部门批准时间:</td>
						<td class="FieldInput"><label name="规划部门批准时间"
							field="planningAllowedTime" readonly="readonly" /></td>
					</tr>
					<tr>
						<td class="FieldLabel">环保部门批准文号:</td>
						<td class="FieldInput"><label name="环保部门批准文号"
							field="environmentAllowedNum" /></td>
						<td class="FieldLabel">环保部门批准时间:</td>
						<td class="FieldInput"><label name="环保部门批准时间"
							field="environmentAllowedTime" readonly="readonly" /></td>
					</tr>
					<tr>
						<td class="FieldLabel">住建部门批准文号</td>
						<td class="FieldInput"><label type="text" name="住建部门批准文号"
							field="liveAllowedNum" maxlength="25" /></td>
						<td class="FieldLabel">住建部门批准时间</td>
						<td class="FieldInput"><label type="text" name="住建部门批准时间"
							field="liveAllowedTime" format="Y-m-d"
							onclick="LoushangDate(this)" readonly="readonly" /></td>
					</tr>
					<tr>
						<td class="FieldLabel">工商部门批准文号:</td>
						<td class="FieldInput"><label name="工商部门批准文号"
							field="businessAllowedNum" /></td>
						<td class="FieldLabel">工商部门批准时间:</td>
						<td class="FieldInput"><label name="工商部门批准时间"
							field="businessAllowedTime" readonly="readonly" /></td>
					</tr>
					<tr>
						<td class="FieldLabel">林业部门批准文号:</td>
						<td class="FieldInput"><label name="林业部门批准文号"
							field="forestryAllowedNum" maxlength="25" /></td>
						<td class="FieldLabel">林业部门批准时间:</td>
						<td class="FieldInput"><label name="林业部门批准时间"
							field="forestryAllowedTime" readonly="readonly" /></td>
					</tr>
					<tr>
						<td class="FieldLabel">人事部门批准文号:</td>
						<td class="FieldInput"><label name="人事部门批准文号"
							field="personnelAllowedNum" maxlength="25" /></td>
						<td class="FieldLabel">人事部门批准时间:</td>
						<td class="FieldInput"><label name="人事部门批准时间"
							field="personnelAllowedTime" readonly="readonly" /></td>
					</tr>




					<tr>
						<td class="FieldLabel">水利部门批准文号:</td>
						<td class="FieldInput"><label name="水利部门批准文号"
							field="waterAllowedNum" maxlength="25" /></td>
						<td class="FieldLabel">水利部门批准时间:</td>
						<td class="FieldInput"><label name="水利部门批准时间"
							field="waterAllowedTime" readonly="readonly" /></td>
					</tr>
				</table>
				</fieldset>
				<fieldset><legend>公墓建设信息</legend>
				<table width="100%">

					<tr>
						<td class="FieldLabel" style="width: 26%">公墓占地总面积:</td>
						<td class="FieldInput" colspan="3" style="width: 19%"><label
							type="text" name="公墓占地总面积" field="totalArea" id="totalArea"
							maxlength="14" style="text-align: right"
							onchange="checkAssMon(this.id)" /></td>
						<td class="FieldLabel" colspan="2" style="width: 21%">公墓占地总面积计量单位:</td>
						<td class="FieldInput" style="width: 35%" colspan="3"><select
							name="公墓占地面积计量单位" field="totalAreaUnits">
							<option dataset="jiliangdanweiDataSet"></option>
						</select></td>
					</tr>
					<tr>
						<td class="FieldLabel">公墓建成面积:</td>
						<td class="FieldInput" colspan="3"><label type="text"
							style="text-align: right" name="公墓建成面积" field="builtArea"
							id="builtArea" maxlength="7" onchange="checkAssMon(this.id)" /></td>
						<td class="FieldLabel" colspan="2">公墓建成面积计量单位:</td>
						<td class="FieldInput" colspan="3"><select name="墓区建成面积计量单位"
							field="builtAreaUnits">
							<option dataset="jiliangdanweiDataSet"></option>
						</select></td>
					</tr>
					<tr>
						<td class="FieldLabel">建筑总面积(㎡):</td>
						<td class="FieldInput" colspan="3"><label type="text"
							name="建筑总面积" field="builtTotalArea" id="builtTotalArea"
							style="text-align: right" maxlength="7"
							onchange="checkAssMon(this.id)" /></td>
						<td class="FieldLabel" colspan="2">本年安葬总人数:</td>
						<td class="FieldInput" colspan="3"><label type="text"
							name="本年安葬总人数" style="text-align: right" maxlength="10"
							field="yearPeopleNum" id="yearPeopleNum"
							onchange="checkNum(this.id)" /></td>
					</tr>
					<tr>
						<td class="FieldLabel">自开业至今安葬总人数:</td>
						<td class="FieldInput" colspan="3"><label type="text"
							style="text-align: right" name="自开业至今安葬总人数" maxlength="10"
							field="sincePeopleNum" id="sincePeopleNum"
							onchange="checkNum(this.id)" /></td>
						<td class="FieldLabel" colspan="2">
						<td class="FieldInput" colspan="3">
					</tr>
					<tr>
						<td class="FieldLabel">本年销售墓穴数:</td>
						<td class="FieldLabel" style="width: 15%">合计:</td>
						<td class="FieldInput"><label type="text" name="本年销售墓穴数合计"
							style="text-align: right" field="yearSellNum" id="yearSellNum"
							maxlength="10" onchange="checkNum(this.id)" style="width: 80px" /></td>
						<td class="FieldLabel" style="width: 15%">单穴:</td>
						<td class="FieldInput"><label type="text" name="单穴销售数(本年)"
							style="text-align: right" field="sellSingleHole"
							id="sellSingleHole" maxlength="10" onchange="checkNum(this.id)"
							style="width: 80px" /></td>
						<td class="FieldLabel" style="width: 15%">双穴:</td>
						<td class="FieldInput"><label type="text" name="双穴销售数(本年)"
							style="text-align: right" field="sellDoubleHole"
							id="sellDoubleHole" maxlength="10" onchange="checkNum(this.id)"
							style="width: 80px" /></td>
						<td class="FieldLabel" style="width: 15%">多穴:</td>
						<td class="FieldInput"><label type="text" name="多穴销售数(本年)"
							style="text-align: right" field="sellMoreHole" id="sellMoreHole"
							maxlength="10" onchange="checkNum(this.id)" style="width: 80px" /></td>
					</tr>
					<tr>
						<td class="FieldLabel">本年安葬墓穴数:</td>
						<td class="FieldLabel" style="width: 15%">合计:</td>
						<td class="FieldInput"><label type="text" name="本年安葬墓穴数合计"
							style="text-align: right" field="yearHoleNum" id="yearHoleNum"
							maxlength="10" onchange="checkNum(this.id)" style="width: 80px" /></td>
						<td class="FieldLabel" style="width: 15%">单穴:</td>
						<td class="FieldInput"><label type="text" name="单穴安葬数(本年)"
							style="text-align: right" field="yearSingleHole"
							id="yearSingleHole" maxlength="10" onchange="checkNum(this.id)"
							style="width: 80px" /></td>
						<td class="FieldLabel" style="width: 15%">双穴:</td>
						<td class="FieldInput"><label type="text" name="双穴安葬数(本年)"
							style="text-align: right" field="yearDoubleHole"
							id="yearDoubleHole" maxlength="10" onchange="checkNum(this.id)"
							style="width: 80px" /></td>
						<td class="FieldLabel" style="width: 15%">多穴:</td>
						<td class="FieldInput"><label type="text" name="多穴安葬数(本年)"
							style="text-align: right" field="yearMoreHole" id="yearMoreHole"
							maxlength="10" onchange="checkNum(this.id)" style="width: 80px" /></td>
					</tr>
					<tr>
						<td class="FieldLabel">本年迁出墓穴数:</td>
						<td class="FieldLabel" style="width: 15%">合计:</td>
						<td class="FieldInput"><label type="text" name="本年迁出墓穴数合计"
							style="text-align: right" field="yearOutNum" id="yearOutNum"
							maxlength="10" onchange="checkNum(this.id)" style="width: 80px" /></td>
						<td class="FieldLabel" style="width: 15%">单穴:</td>
						<td class="FieldInput"><label type="text" name="单穴迁出数(本年)"
							style="text-align: right" field="outSingleHole"
							id="outSingleHole" maxlength="10" onchange="checkNum(this.id)"
							style="width: 80px" /></td>
						<td class="FieldLabel" style="width: 15%">双穴:</td>
						<td class="FieldInput"><label type="text" name="双穴迁出数(本年)"
							style="text-align: right" field="outDoubleHole"
							id="outDoubleHole" maxlength="10" onchange="checkNum(this.id)"
							style="width: 80px" /></td>
						<td class="FieldLabel" style="width: 15%">多穴:</td>
						<td class="FieldInput"><label type="text" name="多穴迁出数(本年)"
							style="text-align: right" field="outMoreHole" id="outMoreHole"
							maxlength="10" onchange="checkNum(this.id)" style="width: 80px" /></td>
					</tr>
					<tr>
						<td class="FieldLabel">自开业至今安葬穴位数:</td>
						<td class="FieldLabel" style="width: 15%">合计:</td>
						<td class="FieldInput"><label type="text" name="自开业至今安葬穴位数合计"
							style="text-align: right" field="sinceHoleNum" id="sinceHoleNum"
							maxlength="10" onchange="checkNum(this.id)" style="width: 80px" /></td>
						<td class="FieldLabel" style="width: 15%">单穴:</td>
						<td class="FieldInput"><label type="text" name="单穴安葬数(自开业至今)"
							style="text-align: right" field="singleHole" id="singleHole"
							maxlength="10" onchange="checkNum(this.id)" style="width: 80px" /></td>
						<td class="FieldLabel" style="width: 15%">双穴:</td>
						<td class="FieldInput"><label type="text" name="双穴安葬数(自开业至今)"
							style="text-align: right" field="doubleHole" id="doubleHole"
							maxlength="10" onchange="checkNum(this.id)" style="width: 80px" /></td>
						<td class="FieldLabel" style="width: 15%">多穴:</td>
						<td class="FieldInput"><label type="text" name="多穴安葬数(自开业至今)"
							style="text-align: right" field="moreHole" id="moreHole"
							maxlength="10" onchange="checkNum(this.id)" style="width: 80px" /></td>
					</tr>
				</table>
				</fieldset>
				<fieldset><legend>未营业原因：</legend>
				<table width="100%">
					<tr>
						<td class="FieldInput" colspan="5"><textarea
							onpropertychange="if(value.length>49) value=value.substr(0,49)"
							rows="5" maxlength="49" name='未营业原因' field="notReasons"
							style="width: 99%" disabled="disabled"></textarea></td>
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
