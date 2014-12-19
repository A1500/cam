<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<%@page import="com.inspur.cams.comm.extuser.util.ExtBspInfo"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<title>福利企业审批</title>
<%
	String taskCode = (String) request.getParameter("taskCode");
	String method = (String) request.getParameter("method");
	if (taskCode == null) {
		taskCode = IdHelp.getUUID32();
	}
%>
<next:ScriptManager />
<script type="text/javascript" src="../../../common/js/float.js"></script>
<link href="css/welfareapply2.css" type="text/css" rel="stylesheet" />
<script type="text/javascript">
//初始化
 	var taskCode='<%=taskCode%>';
 	var method='<%=method%>';
	function init(){
		if(method=="INSERT"){
			var wealUnitApplyDataSet = L5.DatasetMgr.lookup("wealUnitApplyDataSet");
			wealUnitApplyDataSet.setParameter("TASK_CODE@=", taskCode);
			wealUnitApplyDataSet.load();
			wealUnitApplyDataSet.on('load',function(ds){
				if(ds.getCount()==0){
					var wealUnitApplyDataSet = L5.DatasetMgr.lookup("wealUnitApplyDataSet");
					wealUnitApplyDataSet.newRecord({"taskCode":taskCode,"applyType":"1"});
				}
			});
		}else{
			var wealUnitApplyDataSet = L5.DatasetMgr.lookup("wealUnitApplyDataSet");
			wealUnitApplyDataSet.setParameter("TASK_CODE@=", taskCode);
			wealUnitApplyDataSet.load();
		}
	}
	function save(){
		var wealUnitApplyDataSet = L5.DatasetMgr.lookup("wealUnitApplyDataSet");
		var unitInfoValidate = wealUnitApplyDataSet.isValidate();
		if(unitInfoValidate != true){
			L5.Msg.alert("提示",unitInfoValidate);
			return "break";
		}
		var unitApplyRecord=wealUnitApplyDataSet.getCurrent();
		var command = new L5.Command("com.inspur.cams.welfare.welfarecorp.apply.cmd.UnitApplyCmd");
		command.setParameter("record", unitApplyRecord);
		command.execute("saveUnitApply");
		if (!command.error) {
			alert("保存成功！");	
		}else{
			L5.Msg.alert('提示',"保存时出现错误！"+commandA.error+command.error);
		}
	}
</script>
</head>
<model:datasets>
	<!-- 业务表 -->
	<model:dataset id="wealUnitApplyDataSet"
		cmd="com.inspur.cams.welfare.base.cmd.WealUnitApplyQueryCommand">
		<model:record
			fromBean="com.inspur.cams.welfare.base.data.WealUnitApply"></model:record>
	</model:dataset>
</model:datasets>
<body>
<div id="float"><input type="button" value="下一页"
	style="height: 25px; width: 80px; position: absolute; margin-left: 20px;"
	onclick="nextPage('5')" /> <input type="button" value="上一页"
	style="height: 25px; width: 80px; position: absolute; margin-left: 120px;"
	onclick="lastPage('3')" /> <input type="button" value="保存"
	style="height: 25px; width: 80px; position: absolute; margin-left: 220px;" />
<input type="button" value="返回"
	style="height: 25px; width: 80px; position: absolute; margin-left: 320px;"
	onclick="backPage();" /></div>

<form method="post" onsubmit="return false">
<TABLE height=629 cellSpacing=0 cellPadding=0 width=800 align=center
	border=0>
	<TBODY>
		<TR>
			<TD class=title1 align=middle height=67>&nbsp;</TD>
		</TR>
		<TR>
			<TD align="middle" height=40 class="title3"><br>
			<br>
			</TD>
		</TR>
		<TR vAlign=top align=center>
			<TD vAlign=top height=322>
			<TABLE class=unnamed1 align=center cellSpacing=0 cellPadding=0
				width=800 border=0 dataset="wealUnitApplyDataSet">
				<TBODY>
				
				<TBODY>
			</TABLE>
			</TD>
		</TR>
		<tr align="center">
			<td align="center">4</td>
		</tr>
	</TBODY>
</TABLE>
</form>
</body>
</html>