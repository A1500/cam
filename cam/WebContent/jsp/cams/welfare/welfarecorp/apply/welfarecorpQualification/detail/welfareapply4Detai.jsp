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
					<tr>
						<TD class=unnamed4 align=middle height=100 width=140>
						<p align="center">市</p>
						<p align="center">民</p>
						<p align="center">政</p>
						<p align="center">局</p>
						<p align="center">意</p>
						<p align="center">见</p>
						</TD>
						<td class=unnamed4 align=middle height=100 width=160>局领导</td>
						<TD valign="top"><textarea name='市民政局意见局领导意见' COLS='80'
							rows='10' id="cityChiefBaseOpinion" field="cityChiefBaseOpinion">
							</textarea>
						<table width="200" border="0" cellspacing="0" cellpadding="0"
							align="right">
							<tr>
								<td colspan="2">签字：</td>
								<td colspan="2">
								<div align="center"><input type="text" name="市民政局意见局领导签字"
									id="cityChief" field="cityChief" size=18 /></div>
								</td>
								<td colspan="2"></td>
							</tr>
							<tr>
								<td colspan="4">(公 章）</td>
								<td colspan="2"></td>
							</tr>
							<tr>
								<td colspan="2">申请日期：</td>
								<td colspan="4"><input type="text" name="市民政局意见局领导时间"
									id="cityChiefTime" field="cityChiefTime" size=18
									format="Y年m月d日" onclick="LoushangDate(this)"
									readonly="readonly" style="text-align: center" /></td>
							</tr>
							<tr>
								<td colspan="2">&nbsp;</td>
								<td colspan="4">年 月 日</td>
							</tr>
						</table>
						</TD>
					</tr>
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