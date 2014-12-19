<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
	<head>
		<title>轮养修养情况</title>
		<next:ScriptManager/>
		<script language="javascript">
			var peopleId = '<%=request.getParameter("peopleId")%>';
		</script>
	</head>
<body>
<model:datasets>
	<model:dataset id="RecuperateDataSet" cmd="com.inspur.cams.bpt.bptrecuperate.cmd.BptRecuperateQueryCommand" global="true" method="queryPeopleRecuperateDetail">
	</model:dataset>
	<!-- 优抚对象类型 -->
	<model:dataset id="ObjectType" enumName="OBJECT.TYPE.PART" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel height="100%" width="100%">
<next:GridPanel id="gridPanel" name="RecuperateList" width="100%" height="21%" stripeRows="true" dataset="RecuperateDataSet" >
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
		<next:Column id="id" header="ID" field="id" width="90" hidden="true">
			<next:TextField allowBlank="false"/>
		</next:Column>
		<next:Column id="year" header="年度" field="YEAR" width="100">
			<next:TextField/>
		</next:Column>
		<next:Column id="batchName" header="批次" field="BATCH_NAME" width="150">
			<next:TextField/>
		</next:Column>
		<next:Column id="orgname" header="编制单位" field="DOMICILE_NAME" width="150">
			<next:TextField/>
		</next:Column>
		<next:Column id="createTime" header="编制时间" field="CREATE_TIME" width="80">
			<next:TextField/>
		</next:Column>
		<next:Column id="createTime" header="开始时间" field="BEGIN_TIME" width="90">
			<next:TextField/>
		</next:Column>
		<next:Column id="createTime" header="结束时间" field="END_TIME" width="90">
			<next:TextField/>
		</next:Column>
	</next:Columns>
</next:GridPanel>

<next:Panel  width="100%"  autoScroll="true" id="RecuperateDetailPanel">
				<next:Html>
					<fieldset>
					<form id="RecuperateDetailForm" method="post" dataset="RecuperateDataSet" onsubmit="return false" style="padding: 5px;" class="L5form">
					<table border="0" width="98%">
					    <tr>
							<td class="FieldLabel"  nowrap style="width:16%">姓名：</td>
							<td class="FieldInput" style="width:16%" nowrap="nowrap"><label id="NAME" field="NAME"></label></td>
						    <td class="FieldLabel" style="width:16%">身份证号：</td>
							<td class="FieldInput" style="width:16%"><label id="ID_CARD" field="ID_CARD"></label></td>
							<td class="FieldLabel" nowrap style="width:16%">优抚对象类型：</td>
							<td class="FieldInput"  style="width:16%"><label id="OBJECT_TYPE" field="OBJECT_TYPE" dataset="ObjectType"></label></td>
						</tr>
                       	<tr>
						    <td class="FieldLabel">轮养休养地点：</td>
							<td class="FieldInput"><label id="PLACE" field="PLACE"></label></td>
							<td class="FieldLabel">年度：</td>
							<td class="FieldInput"><label id="YEAR" field="YEAR"></label></td>
							<td class="FieldLabel">批次：</td>
							<td class="FieldInput"><label id="BATCH_NAME" field="BATCH_NAME"></label></td>
						</tr>
						<tr>
						    <td class="FieldLabel">编制单位：</td>
							<td class="FieldInput"><label id="DOMICILE_NAME" field="DOMICILE_NAME"></label></td>
							<td class="FieldLabel">编制日期：</td>
							<td class="FieldInput" colspan="3"><label id="CREATE_TIME" field="CREATE_TIME"></label></td>
						</tr>
						<tr>
							<td class="FieldLabel">轮养（休养）开始日期：</td>
							<td class="FieldInput"><label id="BEGIN_TIME" field="BEGIN_TIME"></label></td>
						    <td class="FieldLabel">轮养（休养）开始日期：</td>
							<td class="FieldInput" colspan="3"><label id="END_TIME" field="END_TIME"></label></td>
                      </table>
					</form>
				 </fieldset>
				</next:Html>
			</next:Panel>
</next:Panel>
</body>
<script type="text/javascript">
	function init(){
		var RecuperateDataSet = L5.DatasetMgr.lookup("RecuperateDataSet");
		RecuperateDataSet.setParameter("peopleId",peopleId);
		RecuperateDataSet.load();
		RecuperateDataSet.on("load",function(){
			var records = RecuperateDataSet.getAllRecords();
			if(records.length==0){
				RecuperateDataSet.newRecord();
			}
		});
		L5.QuickTips.init();
	}
</script>
</html>