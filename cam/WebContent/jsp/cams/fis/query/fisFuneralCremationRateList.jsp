<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>火化率计算</title>
<next:ScriptManager />
<script type="text/javascript">
    var orgCode ='<%=BspUtil.getOrganCode()%>';
	var orgName ='<%=BspUtil.getOrganName()%>';
</script>
<script type="text/javascript" src="fisFuneralCremationRateList.js"></script>
<script type="text/javascript" src="../comm/common.js"></script>
<script type="text/javascript" src="../funeral/PublicTimeControl.js"></script>
<script type="text/javascript">
		</script>
</head>
<body>
<model:datasets>
	<!--火化率计算结果表-->
	<model:dataset id="ds"
		cmd="com.inspur.cams.fis.base.cmd.FisCremationRateQueryCmd"
		global="true" pageSize="-1">
		<model:record
			fromBean="com.inspur.cams.fis.base.data.FisCremationRate">
			<model:field name="areaCode" type="string" rule="require" />
			<model:field name="areaName" type="string" rule="require" />
			<model:field name="sumYear" type="int" rule="require" />
			<model:field name="totalNum" type="int" rule="require" />
			<model:field name="deadRate" type="float" rule="require" />
			<model:field name="deadNum" type="int" rule="require" />
			<model:field name="cremationNum" type="int" rule="require" />
			<model:field name="cremationRate" type="float" rule="require" />
		</model:record>
	</model:dataset>
	<!--火化率计算结果表-临时抽取-->
	<model:dataset id="dsTemp"
		cmd="com.inspur.cams.fis.base.cmd.FisCremationRateQueryCmd"
		global="true" pageSize="-1">
		<model:record
			fromBean="com.inspur.cams.fis.base.data.FisCremationRate">
		</model:record>
	</model:dataset>

	<!-- 获取本地区逝者火化数量信息 -->
	<model:dataset id="cremationNumDs"
		cmd="com.inspur.cams.fis.base.cmd.FisCremationRateQueryCmd"
		method="queryCremationSum" global="true" pageSize="-1">
		<model:record
			fromBean="com.inspur.cams.fis.base.data.FisCremationRate">
		</model:record>
	</model:dataset>
	
	<!--火化率计算结果表-->
	<model:dataset id="rateDs"
		cmd="com.inspur.cams.fis.base.cmd.FisCremationRateQueryCmd" method="queryCremationRateList"
		global="true" pageSize="-1">
		<model:record
			fromBean="com.inspur.cams.fis.base.data.FisCremationRate">
		</model:record>
	</model:dataset>
</model:datasets>
<next:Panel width="100%" border="0">
	<next:Panel id="countyPanel" name="countyPanel" width="100%" border="0"
		hidden="true">
		<next:TopBar>
			<next:ToolBarItem id="qrToolbar" text=""></next:ToolBarItem>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem text="保存" iconCls="save" handler="save" />
		</next:TopBar>
		<next:Html>
			<fieldset><legend>火化率计算</legend>
			<div>
			<form id="caForm" method="post" dataset="ds" onsubmit="return false"
				class="L5form">
			<table width="100%">
				<tr>
					<td class="FieldLabel" width="8%">区划名称:</td>
					<td class="FieldInput" width="25%"><label id="areaName"
						field="areaName" title="区划名称" style="width: 80%" /></td>
				</tr>
				<tr>
					<td class="FieldLabel" width="10%">年度:</td>
					<td class="FieldInput" width="23%"><input type="text"
						field="sumYear" title="年度" id="sumYear" name="sumYear" align="right" 
						style="text-align: right;" 
						onblur="onChange()"/ >年</td>
				</tr>
				<tr>
					<td class="FieldLabel" width="10%">总人口数:</td>
					<td class="FieldInput" width="23%"><input type="text"
						field="totalNum" title="总人口数" id="totalNum" align="right"
						style="text-align: right;"
						onblur="onComputeDead()" />人</td>
				</tr>
				<tr>
					<td class="FieldLabel" width="10%">死亡率:</td>
					<td class="FieldInput" width="23%"><input type="text"
						field="deadRate" title="死亡率" id="deadRate" align="right"
						onblur="onComputeDead()" style="text-align: right;"/>‰</td>
				</tr>
				<tr>
					<td class="FieldLabel" width="10%">死亡人口数:</td>
					<td class="FieldInput" width="23%"><input type="text" field="deadNum"
						title="死亡人口数" id="deadNum" align="right" 
						style="text-align: right;border-style: none;"
						disabled="disabled"/>人</td>
				</tr>
				<tr>
					<td class="FieldLabel" width="10%">火化数:</td>
					<td class="FieldInput" width="23%"><input type="text"
						field="cremationNum" title="火化数" id="cremationNum" align="right"
						style="text-align: right;"
						onblur="onComputeDead()" />具</td>
				</tr>
				<tr>
					<td class="FieldLabel" width="10%">火化率:</td>
					<td class="FieldInput" width="23%"><input type="text"
						field="cremationRate" title="火化率" id="cremationRate" align="right"
						style="text-align: right;border-style: none;" disabled="disabled" />%</td>
				</tr>
			</table>
			</form>
			</div>
			</fieldset>
		</next:Html>
	</next:Panel>
	<next:Panel id="noCountyPanel" name="noCountyPanel" width="99.9%"
		border="0" height="100%" hidden="false">
		<next:Panel name="form" width="99.9%" border="0" autoHeight="true">
			<next:Html>
				<fieldset style="overflow: visible;" class="GroupBox"><legend
					class="GroupBoxTitle">查询条件 <img
					class="GroupBoxExpandButton"
					src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>"
					onclick="collapse(this)" /> </legend>
				<div>
				<form style="width: 100%; height: 100%;" class="L5form">
				<table border="1" width="100%">
					<tr>
						<td class="FieldLabel">年度:</td>
						<td class="FieldInput"><input type="text" id="qYear" value="2012"/></td>
						<td class="FieldLabel" colspan="6">
						<button onclick="query()">查 询</button>
						&nbsp;
						<button onclick="reset">重 置</button>
						</td>
					</tr>
				</table>
				</form>
				</div>
				</fieldset>
			</next:Html>
		</next:Panel>
		<next:GridPanel id="editGridPanel" name="fiscemeGrid" width="99.9%"
			stripeRows="true" height="100%" dataset="rateDs"
			clickToSelectedForChkSM="true">
			<next:TopBar>
				<next:ToolBarItem id="qrToolbar" text="火化率统计"></next:ToolBarItem>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem text="测试" iconCls="save" handler="test" hidden="true"/>
				<next:ToolBarItem text="重新计算本年火化率" iconCls="save" handler="compute" />
				<next:ToolBarItem text="导出Excel" iconCls="export" id="check" handler="exportExcel"  />
			</next:TopBar>
			<next:Columns>
				<next:RowNumberColumn></next:RowNumberColumn>
				<next:RadioBoxColumn></next:RadioBoxColumn>

				<next:Column header="年度" field="SUM_YEAR" width="70" align="center">
					<next:TextField />
				</next:Column>
				<next:Column header="行政区" field="AREA_NAME" width="140">
					<next:TextField />
				</next:Column>
				<next:Column header="总人口数(人)" field="TOTAL_NUMS" width="80" align="right">
					<next:TextField />
				</next:Column>
				<next:Column header="死亡率(‰)" field="DEAD_RATE" width="80" align="right">
					<next:TextField />
				</next:Column>
				<next:Column header="死亡人口数(人)" field="DEAD_NUM" width="100" align="right">
					<next:TextField />
				</next:Column>
				<next:Column header="火化数(具)" field="CREMATION_NUM" width="100" align="right">
					<next:TextField />
				</next:Column>
				<next:Column header="火化率（％）" field="CREMATION_RATE" width="80" align="right">
					<next:TextField />
				</next:Column>
			</next:Columns>
		</next:GridPanel>
	</next:Panel>
</next:Panel>
</body>
</html>