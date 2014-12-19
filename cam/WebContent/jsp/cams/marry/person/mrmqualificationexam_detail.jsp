
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>登记员资格考试信息表编辑</title>
<next:ScriptManager />
<script>
			var idField='<%=request.getParameter("dataBean")%>';
			var method='<%=request.getParameter("method")%>';
		</script>
<script type="text/javascript" src="mrmqualificationexam_edit.js"></script>
</head>
<body>
<model:datasets>
	<model:dataset id="ds"
		cmd="com.inspur.cams.marry.base.cmd.MrmQualificationExamQueryCommand"
		global="true">
		<model:record
			fromBean="com.inspur.cams.marry.base.data.MrmQualificationExam"></model:record>
	</model:dataset>
	<!-- 是否补证 -->
	<model:dataset id="yesornoDataset" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 考试结果 -->
	<model:dataset id="ksjgDataset" enumName="MRM.KSJG.TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 补考结果 -->
	<model:dataset id="bkjgDataset" enumName="MRM.BKJG.TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 初考复考标志 -->
	<model:dataset id="ckfkbzDataset" enumName="MRM.CKFKBZ.TYPE" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:ViewPort>
	<next:AnchorLayout>
		<next:Panel title="登记员资格考试信息表">
			<next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="undo" text="返回" handler="back" />
			</next:TopBar>
			<next:Html>
				<form id="editForm" dataset="ds" onsubmit="return false"
					style="padding: 5px;" class="L5form">
				<table border="1" width="100%">

					<tr>
						<td class="FieldLabel" style="width:25%">姓名</td>
						<td class="FieldInput" style="width:25%"><label field="NAME" /></td>
						
						<td class="FieldLabel"style="width:25%">考试信息编号</td>
						<td class="FieldInput" style="width:25%"><label field="KSXXID" /></td>
					</tr>
					<tr>
						<td class="FieldLabel">考试安排编号</td>
						<td class="FieldInput"><label field="KSAPID" /></td>
					
						<td class="FieldLabel">年度</td>
						<td class="FieldInput"><label field="NDYEAR" /></td>
					</tr>
					<tr>
						<td class="FieldLabel">考试期数</td>
						<td class="FieldInput"><label field="KSQS" /></td>
					
						<td class="FieldLabel">考试时间</td>
						<td class="FieldInput"><label field="KSSJ_TIME" /></td>
					</tr>
					<tr>
						<td class="FieldLabel">考试结果</td>
						<td class="FieldInput"><label field="KSJG" id="ksjg" dataset="ksjgDataset"/></td>
					
						<td class="FieldLabel">补考结果</td>
						<td class="FieldInput"><label field="BKJG" id="bkjg" dataset="bkjgDataset"/></td>
					</tr>
					<tr>
						<td class="FieldLabel">初考复考标志</td>
						<td class="FieldInput"><label field="CKFKBZ" id="bkjg" dataset="ckfkbzDataset" /></td>
					
						<td class="FieldLabel">资格证编号</td>
						<td class="FieldInput"><label field="CERTIFICATE_ID" /></td>
					</tr>
					<tr>
						<td class="FieldLabel">是否补证</td>
						<td class="FieldInput"><label field="FILL_CARD_TIME" id="fillCardTime" dataset="yesornoDataset"/></td>
					
						<td class="FieldLabel">发证时间</td>
						<td class="FieldInput"><label field="GIVE_OUT_TIME" /></td>
					</tr>
					<tr>
						<td class="FieldLabel">超期未参加考试自动失效时间</td>
						<td class="FieldInput"><label field="AUTOMATIC_FAILURE_TIME" /></td>
					
						<td class="FieldLabel">上级撤销资格证时间</td>
						<td class="FieldInput"><label field="BACKOUT_TIME" /></td>
					</tr>
				</table>
				</form>
			</next:Html>
		</next:Panel>
	</next:AnchorLayout>
</next:ViewPort>
</body>
</html>
