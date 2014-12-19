
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>应急生活救助明细</title>
<next:ScriptManager />
<script type="text/javascript">
			var infoId = '<%=request.getParameter("infoId")%>';
		</script>
<script type="text/javascript" src="approve_yj_info_detail.js"></script>
</head>
<body>
<model:datasets>
	<model:dataset id="infoDs"
		cmd="com.inspur.cams.dis.base.cmd.DisReliefInfoQueryCommand"
		global="true">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisReliefInfo"></model:record>
	</model:dataset>

	<model:dataset id="workflowStateDs"
		enumName="DIS.RELIEFINFO_WORKFLOW_STATE" autoLoad="true" global="true">
	</model:dataset>

	<model:dataset id="grantTypeDs" enumName="DIS.GRANT_TYPE"
		autoLoad="true" global="true">
	</model:dataset>
</model:datasets>
<next:TabPanel width="100%" height="100%">
	<next:Tabs>
		<next:Panel id="infoGrid" width="100%" height="100%"
			collapsible="true" title="救助信息">
			<next:Html>
				<form id="editForm" dataset="infoDs" onsubmit="return false" class="L5form">
				<table border="1" width="100%">
					<tr>

						<td class="FieldLabel">需口粮救助（公斤）</td>
						<td class="FieldInput"><label field="requiredForFood" /></td>

						<td class="FieldLabel">需衣被救助（件）</td>
						<td class="FieldInput"><label field="requiredForClothes" /></td>
					</tr>
					<tr>

						<td class="FieldLabel">需取暖救助（元）</td>
						<td class="FieldInput"><label field="requiredForHeat" /></td>

						<td class="FieldLabel">需伤病救助（元）</td>
						<td class="FieldInput"><label field="requiredForDisease" /></td>
					</tr>
					<tr>
						<td class="FieldLabel">需其他救助（元）</td>
						<td class="FieldInput"><label field="requiredForOthers" /></td>
						<td class="FieldLabel"></td>
						<td class="FieldInput"></td>
					</tr>
					<tr>
						<td class="FieldLabel">核准救助人口</td>
						<td class="FieldInput"><label field="approvalFamilyNum" /></td>

						<td class="FieldLabel">核准救助粮食（公斤）</td>
						<td class="FieldInput"><label field="approvalFood" /></td>

					</tr>
					<tr>
						<td class="FieldLabel">核准救助衣被（件）</td>
						<td class="FieldInput"><label field="approvalClothes" /></td>

						<td class="FieldLabel">核准救助资金（元）</td>
						<td class="FieldInput"><label field="approvalMonry" /></td>
					</tr>
					<tr>
						<td class="FieldLabel">村级行政区划名称</td>
						<td class="FieldInput"><label field="acceptAreaName" /></td>

						<td class="FieldLabel">村级行政区划</td>
						<td class="FieldInput"><label field="acceptAreaCode" /></td>

					</tr>
					<tr>
						<td class="FieldLabel">村级填报人姓名</td>
						<td class="FieldInput"><label field="acceptPeopleName" /></td>

						<td class="FieldLabel">村级填报日期</td>
						<td class="FieldInput"><label field="acceptDate" /></td>
					</tr>
					<tr>
						<td class="FieldLabel">备注</td>
						<td class="FieldInput" colspan="3"><label field="note" /></td>
					</tr>
				</table>
				</form>
			</next:Html>
		</next:Panel>
		<next:Panel title="审批信息" width="100%" height="100%">
			<next:Html>
				<form id="editForm3" dataset="infoDs" onsubmit="return false" class="L5form">
				<table border="1" width="100%">
					<tr>
						<td class="FieldLabel">填报单位名称</td>
						<td class="FieldInput" colspan="3"><label name="organName"
							field="organName" /></td>
					</tr>
					<tr>
						<td class="FieldLabel">行政村名称</td>
						<td class="FieldInput" colspan="3"><label
							name="acceptAreaName" field="acceptAreaName" /></td>

					</tr>
					<tr>
						<td class="FieldLabel">村级填报人</td>
						<td class="FieldInput" style="width: 350"><label
							name="acceptPeopleName" field="acceptPeopleName" /></td>
						<td class="FieldLabel">填报日期</td>
						<td class="FieldInput" style="width: 250"><label
							name="acceptDate" field="acceptDate" /></td>


					</tr>
					<tr>
						<td class="FieldLabel">乡镇（街道）名称</td>
						<td class="FieldInput" colspan="3"><label
							name="checkOrganName" field="checkOrganName" /></td>

					</tr>
					<tr>
						<td class="FieldLabel">乡镇（街道）审核人</td>
						<td class="FieldInput"><label name="checkPeopleName"
							field="checkPeopleName" /></td>

						<td class="FieldLabel">审核日期</td>
						<td class="FieldInput"><label name="checkDate"
							field="checkDate" /></td>
					</tr>
					<tr>
						<td class="FieldLabel">县级名称</td>
						<td class="FieldInput" colspan="3"><label
							name="auditOrganName" field="auditOrganName" /></td>

					</tr>
					<tr>

						<td class="FieldLabel">县级批准人名称</td>
						<td class="FieldInput"><label name="auditPeopleName"
							field="auditPeopleName" /></td>
						<td class="FieldLabel">批准日期</td>
						<td class="FieldInput"><label name="auditDate"
							field="auditDate" /></td>


					</tr>
					<tr>
						<td class="FieldLabel">发放单位名称</td>
						<td class="FieldInput" colspan="3"><label
							name="grantOrganName" field="grantOrganName" /></td>

					</tr>
					<tr>
						<td class="FieldLabel">发放人名称</td>
						<td class="FieldInput"><label name="grantPeopleName"
							field="grantPeopleName" /></td>

						<td class="FieldLabel">发放日期</td>
						<td class="FieldInput"><label name="grantTime"
							field="grantTime" /></td>
					</tr>
				</table>
				</form>
			</next:Html>
		</next:Panel>
	</next:Tabs>
</next:TabPanel>
</body>
</html>
