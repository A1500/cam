<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>公益性公墓信息</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script>
		var idField='<%=request.getParameter("dataBean")%>';
		var method='<%=request.getParameter("method")%>';
</script>
<script type="text/javascript" src="../ep.js"></script>
<script type="text/javascript" src="cemeNoprofitInformationDetails.js"></script>
</head>
<body>

<model:datasets>
	<model:dataset id="ds"
		cmd="com.inspur.cams.fis.ep.base.cmd.FisCemeQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.fis.ep.base.data.FisCeme">
			<model:field name="cemeName" type="string" rule="require" />
			<model:field name="cemeId" type="string" rule="require" />
			<model:field name="organizer" type="string" rule="require" />
			<model:field name="manaLevel" type="string" rule="require" />
			<model:field name="legalPerson" type="string" rule="require" />
			<model:field name="directorMobile" type="string" rule="require" />
			<model:field name="gestionTime" type="string" rule="require" />
			<model:field name="address" type="string" rule="require" />
			<model:field name="caDeptBuildNum" type="string" rule="require" />
			<model:field name="caDeptBuildTime" type="string" />
			<model:field name="caDeptGestionNum" type="string" rule="require" />
			<model:field name="caDeptGestionTime" type="string" />
			<model:field name="totalArea" type="string" rule="require" />
			<model:field name="totalAreaUnits" type="string" rule="require" />
			<model:field name="serviceScope" type="string" rule="require" />
			<model:field name="fundSources" type="string" rule="require" />
		</model:record>
	</model:dataset>

	<!--政府部门批准文号-->
	<model:dataset id="govAppDs"
		cmd="com.inspur.cams.fis.ep.base.cmd.FisCemeGovApprovalCmd"
		global="true" pageSize="-1">
		<model:record
			fromBean="com.inspur.cams.fis.ep.base.data.FisCemeGovApproval">
		</model:record>
	</model:dataset>

	<model:dataset id="propDataSet" enumName="FIS.CEME.PROP"
		autoLoad="true" global="true"></model:dataset>
	<model:dataset id="AreaUnitsDataSet" enumName="FIS.CEME.AREAUNITS"
		autoLoad="true" global="true"></model:dataset>
</model:datasets>

<next:ViewPort>
	<next:AnchorLayout>
		<next:Panel width="100%" autoScroll="true">
			<next:Panel autoScroll="false">
				<next:TopBar>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>
					<next:ToolBarItem iconCls="print" text="打印" handler="print"
						id="printBtn" />
					<next:ToolBarItem iconCls="return" text="返回" handler="back"
						id="return" hidden="true" />
					<next:ToolBarItem iconCls="detail" text="补录说明" handler="detail"
						hidden="true" />
				</next:TopBar>
				<next:Html>
					<form id="editForm" method="post" dataset="ds"
						onsubmit="return false" class="L5form">
					<fieldset><legend>单位信息</legend>
					<table width="100%">
						<tr>
							<td class="FieldLabel" style="width: 20%">公墓名称</td>
							<td class="FieldInput"><label id="cemeName" name="公墓名称"
								field="cemeName" title="补录公墓的全称"
								style="width: 200px;" /></td>
							<td class="FieldLabel">主管单位</td>
							<td class="FieldInput"><label name="主管单位" id="manaLevel"
								field="manaLevel" readonly="readonly" /> <input type="text"
								id="manaLevelId" field="manaLevelId" style="display: none;" />
						</tr>
						<tr>
							<td class="FieldLabel">主办单位</td>
							<td class="FieldInput"><label name="主办单位"
								style="width: 200px;" field="organizer"/>
							<td class="FieldLabel" style="width: 20%">公墓编号</td>
							<td class="FieldInput" style="width: 31%"><label id="cemeId"
								name="公墓编号" field="cemeId"
								title="省厅民政部门授予的组织编码，全省唯一\n请按主管单位的批准时间编写公墓顺序号"/></td>
						</tr>
						<tr>
							<td class="FieldLabel">公墓负责人</td>
							<td class="FieldInput"><label name="公墓负责人"
								field="legalPerson" /></td>
							<td class="FieldLabel">公墓性质</td>
							<td class="FieldInput"><label title="公墓性质">公益性</label> <input
								type="hidden" name="prop" field="prop" title="公墓性质"></input></td>
						</tr>
						<tr>
							<td class="FieldLabel">公墓负责人手机</td>
							<td class="FieldInput"><label name="公墓负责人手机"
								id="directorMobile" field="directorMobile"/></td>
							<td class="FieldLabel">正式使用时间</td>
							<td class="FieldInput"><label name="正式使用时间"
								field="gestionTime"/></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width: 20%">公墓占地面积</td>
							<td class="FieldInput"><label name="公墓占地面积(亩)" renderer="muRender"
								style="text-align: right" field="totalArea" id="totalArea" /><!--&nbsp;&nbsp;<select name="公墓占地面积计量单位" id="totalAreaUnits"
							field="totalAreaUnits" style="width: 80px;">
							<option dataset="AreaUnitsDataSet"></option>
						</select>
						--></td>
							<td class="FieldLabel">资金来源</td>
							<td class="FieldInput"><input type="checkbox" name="资金来源"
								value="1" id="fundSources" field="fundSources"
								disabled="disabled"> <label>财政拨款</label> <input
								type="checkbox" name="资金来源" value="2" id="fundSources"
								field="fundSources" disabled="disabled"> <label>上级部门拨款</label>
							<input type="checkbox" name="资金来源" value="3" id="fundSources"
								field="fundSources" disabled="disabled"> <label>自筹</label>
							<br />
							<input type="checkbox" name="资金来源" value="4" id="fundSources"
								field="fundSources" disabled="disabled"> <label>福彩资助</label>
							<input type="checkbox" name="资金来源" value="5" id="fundSources"
								field="fundSources" disabled="disabled"> <label>其他</label></td>

						</tr>
						<tr>
							<td class="FieldLabel">所属行政区</td>
							<td class="FieldInput"><label name="所属行政区" id="areaLevel"
								field="areaLevel" /></td>
							<td class="FieldLabel">公墓所在位置</td>
							<td class="FieldInput"><label name="公墓所在位置"
								field="address" style="width: 300px" /></td>
						</tr>
						<tr>
							<td class="FieldLabel">服务范围</td>
							<td class="FieldInput" colspan="5"><textarea rows="3"
								name='服务范围' field="serviceScope" style="width: 90%"
								readonly="readonly"></textarea></td>

						</tr>
						<input type="hidden" name="prop" id="prop" field="prop" value="2"></input>
					</table>
					</fieldset>
					</form>
				</next:Html>
			</next:Panel>
			<next:GridPanel title="政府部门批准文号" id="govAppGridPanel"
				name="govAppGridPanel" stripeRows="true" height="100%" width="99%"
				dataset="govAppDs" notSelectFirstRow="true">
				<next:Columns>
					<next:Column id="deptId" header="文号类型" field="deptId" width="160"
						sortable="false" editable="false">
						<next:TextField />
					</next:Column>
					<next:Column id="deptNum" header="文号" field="deptNum" width="220"
						sortable="false">
						<next:TextField />
					</next:Column>
					<next:Column id="deptTime" header="批准时间" field="deptTime"
						width="110" sortable="false">
						<next:DateField allowBlank="false" format="Y-m-d" />
					</next:Column>
				</next:Columns>
			</next:GridPanel>
		</next:Panel>
	</next:AnchorLayout>
</next:ViewPort>
</body>
</html>
