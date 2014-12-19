<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>临时救助查看</title>
<next:ScriptManager />
<script>
			var peopleId='<%=request.getParameter("peopleId")%>';
			var organCode = '<%=BspUtil.getOrganCode()%>';
</script>
<script type="text/javascript" src="temporaryHelpEdit.js"></script>
<script type="text/javascript" src = "../comm/bptComm.js"></script>
</head>
<body>
<model:datasets>
	<model:dataset id="ds"
		cmd="com.inspur.cams.bpt.manage.cmd.BptTemporaryHelpQueryCommand"
		global="true" method="queryTemporaryHelp">
		<model:record
			fromBean="com.inspur.cams.bpt.base.data.BptTemporaryHelp">
			</model:record>
	</model:dataset>
	<!--救助类别-->
	<model:dataset id="dsHelp" enumName="HELP.TYPE" autoLoad="true"></model:dataset>
	<!-- 优抚对象类别-->
	<model:dataset id="objectDs"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BPT_OBJECT_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 民族 -->
	<model:dataset id="NationDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 性别 -->
	<model:dataset id="SexDataset" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
</model:datasets>

<next:GridPanel id="editGridPanel" name="temporaryHelpDetail" width="100%" stripeRows="true" height="20%" dataset="ds" >
	<next:Columns>
	    <next:RowNumberColumn header="序号" width="45"/>
	    <next:RadioBoxColumn></next:RadioBoxColumn>
	    <next:Column id="VERIFY_DATE" header="批准日期" field="VERIFY_DATE" width="130"></next:Column>
	    <next:Column id="HELP_TYPE" header="救助类型" field="HELP_TYPE" width="130" dataset="dsHelp"></next:Column>
	    <next:Column id="APPLY_MON" header="申请救助金额" field="APPLY_MON" width="130"></next:Column>
	</next:Columns>
</next:GridPanel>

<next:Panel autoHeight="true" autoWidth="true" autoScroll="true">
	<next:Html>
		<form id="editForm" dataset="ds" onsubmit="return false"
			style="padding: 5px;" class="L5form">
		<table border="1" width="99%">
			<tr>
				<td class="FieldLabel" colspan="2" nowrap style="width:25%;">姓名:</td>
				<td class="FieldInput"><label name="NAME" field="NAME" style="width:25%;"/></td>
				<td class="FieldLabel" nowrap style="width:25%;">性别:</td>
				<td class="FieldInput" style="width:25%;"><label id="SEX" name="SEX" field="SEX" dataSet="SexDataset"></td>
			</tr>
			<tr>
				<td class="FieldLabel" colspan="2" nowrap>年龄:</td>
				<td class="FieldInput"><label type="text" name="AGE" field="AGE" /></td>
				<td class="FieldLabel" nowrap>民族:</td>
				<td class="FieldInput"><label id="NATION" name="NATION" dataSet="NationDataset" field="NATION"></td>
			</tr>
			<tr>
				<td class="FieldLabel" colspan="2" nowrap>优抚对象类别:</td>
				<td class="FieldInput"><label id="objectType"
					name="objectType" field="OBJECT_TYPE"  dataSet="objectDs"></td>
				<td class="FieldLabel" nowrap>家庭人口:</td>
				<td class="FieldInput"><label type="text" name="FAMILY_NUM" field="FAMILY_NUM"/></td>
			</tr>
			<tr>
				<td class="FieldLabel" colspan="2" nowrap>身份证号码:</td>
				<td class="FieldInput"><label type="text" name="ID_CORD"
					field="ID_CORD" /><font color="red">*</font></td>
                <td class="FieldLabel"  nowrap>家庭住址:</td>
				<td class="FieldInput"><label name="ADDRESS" field="ADDRESS"
					rows="2" cols="40" ></label></td>
			</tr>
			<tr>
				<td class="FieldLabel" colspan="2" nowrap>救助类别:</td>
				<td class="FieldInput"><label id="HELP_TYPE" name="HELP_TYPE"
					field="HELP_TYPE" dataSet="dsHelp"></label></td>
				<td class="FieldLabel" nowrap>申请救助金额:</td>
				<td class="FieldInput"><label name="APPLY_MON" field="APPLY_MON" /></td>
			</tr>
			<tr>
				<td class="FieldLabel" colspan="2" nowrap>申请事由:</td>
				<td colspan="3"><label id="applySubject" name="APPLY_SUBJECT" field="APPLY_SUBJECT"></label></td>
			</tr>
			<tr>
				<td class="FieldLabel" colspan="2">备注</td>
				<td class="FieldInput" colspan="3"><label id="note" name="NOTE" field="NOTE"></label></td>
			</tr>
			
			
			<tr>
				<td class="FieldLabel" rowspan="2" nowrap>村（居）意见:</td>
				<td class="FieldLabel" width="8%" nowrap>负责人:</td>
				<td class="FieldInput" width="30%"><label name="CHECK_INCHARGE" field="CHECK_INCHARGE" /></td>
			    <td  class="FieldLabel" nowrap>审核时间:</td>
				<td class="FieldInput"><label name="CHECK_DATE" id="CHECK_DATE"field="CHECK_DATE"  format="Y-m-d" style="width: 100px;" align="middle"  ><font color="red">*</font> </td>
			</tr>
			<tr>
				<td class="FieldLabel" nowrap>审核意见:</td>
				<td colspan="3"><label name="CHECK_ADVICE" field="CHECK_ADVICE"></label></td>
			</tr>
			<tr>
				<td class="FieldLabel" rowspan="2" nowrap>乡镇（街道办）意见:</td>
				<td class="FieldLabel" width="8%" nowrap>责任人:</td>
				<td class="FieldInput" width="30%"><label name="AUDIT_INCHARGE" field="AUDIT_INCHARGE" /></td>
				<td  class="FieldLabel" nowrap>审核时间:</td>
				<td class="FieldInput"><label name="auditDate"id="AUDIT_DATE" field="AUDIT_DATE" format="Y-m-d"> </td>
			</tr>
			<tr>
				<td class="FieldLabel" nowrap>审核意见:</td>
				<td colspan="3"><label name="AUDIT_ADVICE" field="AUDIT_ADVICE"></label></td>
			</tr>
			<tr>
				<td class="FieldLabel" rowspan="2" nowrap>县级民政部门意见:</td>
				<td class="FieldLabel" width="8%" nowrap>负责人:</td>
				<td class="FieldInput" width="30%"><label name="VERIFY_INCHARGE" field="VERIFY_INCHARGE" /></td>
				<td  class="FieldLabel" nowrap>审批时间:</td>
				<td class="FieldInput"><label name="VERIFY_DATE" id="VERIFY_DATE" field="VERIFY_DATE"  format="Y-m-d"></td>
			</tr>
			<tr>
				<td class="FieldLabel" nowrap>审批意见:</td>
				<td colspan="3"><label name="VERIFY_ADVICE" field="VERIFY_ADVICE"></label></td>
			</tr>
			
		</table>
		</form>
	</next:Html>
</next:Panel>

</body>

<script type="text/javascript">
	function init(){
		var ds = L5.DatasetMgr.lookup("ds");
		ds.setParameter("peopleId",peopleId);
		ds.setParameter("organCode",organCode);	
		ds.load();
		ds.on("load",function(){
			var count = ds.getCount();
			if(count==0){
				ds.newRecord();
			}
		});
	}
</script>
</html>