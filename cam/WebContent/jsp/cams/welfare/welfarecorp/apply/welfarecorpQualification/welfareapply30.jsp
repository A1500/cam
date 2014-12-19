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
<link href="css/welfareapply3.css" type="text/css" rel="stylesheet" />
<script type="text/javascript">
//初始化
 	var organArea='<%=BspUtil.getCorpOrgan().getOrganCode()%>';
    var organName='<%=BspUtil.getCorpOrgan().getOrganName()%>';
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
		var unitApplyRecord=wealUnitApplyDataSet.getCurrent();
		var command = new L5.Command("com.inspur.cams.welfare.welfarecorp.apply.cmd.UnitApplyCmd");
		command.setParameter("record", unitApplyRecord);
		command.execute("saveUnitApply");
		if (!command.error) {
			alert("保存成功！");	
		}else{
			L5.Msg.alert('提示',"保存时出现错误！"+command.error);
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
	<!-- 业务信息表 -->
	<model:dataset id="wealUnitInfoDataSet"
		cmd="com.inspur.cams.welfare.base.cmd.WealUnitInfoQueryCommand">
		<model:record
			fromBean="com.inspur.cams.welfare.base.data.WealUnitInfo">
			<model:field name="companyName" type="string" rule="require" />
			<model:field name="legalPeople" type="string" rule="require" />
			<model:field name="regDate" type="string" rule="require" />
		</model:record>
	</model:dataset>
</model:datasets>
<body>
<div id="float"><input type="button" value="下一页"
	style="height: 25px; width: 80px; position: absolute; margin-left: 20px;"
	onclick="nextPage('4')" /> <input type="button" value="上一页"
	style="height: 25px; width: 80px; position: absolute; margin-left: 120px;"
	onclick="lastPage('2')" /> <input type="button" value="保存"
	style="height: 25px; width: 80px; position: absolute; margin-left: 220px;" />
<input type="button" value="返回"
	style="height: 25px; width: 80px; position: absolute; margin-left: 320px;"
	onclick="backPage();" /></div>

<form method="post" onsubmit="return false">
<TABLE height=629 cellSpacing=0 cellPadding=0 width=800 align=center
	border=0 dataset="wealUnitApplyDataSet">
	<TBODY>
		<TR>
			<TD class=title1 align=middle height=67>&nbsp;</TD>
		</TR>
		<TR>
			<TD align="middle" height=40 class="title3"><br>
			<br>
			</TD>
		</TR>
		<tr>
			<td colspan="2">&nbsp;</td>
		</tr>
		<TR vAlign=top align=center>
			<TD vAlign=top height=322>
			<TABLE class=unnamed1 align=center cellSpacing=0 cellPadding=0
				width=800 border=0 >
				<TBODY>
					<TR>
						<TD class=unnamed2 align=middle height=200 width=140 rowspan="2">
						<p align="center">县</p>
						<p align="center">︵</p>
						<p align="center">区</p>
						<p align="center">︶</p>
						<p align="center">民</p>
						<p align="center">政</p>
						<p align="center">局</p>
						<p align="center">意</p>
						<p align="center">见</p>
						</TD>
						<td class=unnamed2 align=middle height=100 width=160>科长</td>
						<TD class=unnamed3 valign="top"><textarea
							name='县（区）民政局意见科长意见' COLS='80' rows='10'
							id="countyChargeBaseOpinion" field="countyChargeBaseOpinion">
							</textarea>
						<table width="200" border="0" cellspacing="0" cellpadding="0"
							align="right">
							<tr>
								<td colspan="2">签字：</td>
								<td colspan="2">
								<div align="center"><input type="text"
									name="县（区）民政局意见科长签字" id="countyCharge" field="countyCharge"
									size=18 /></div>
								</td>
								<td colspan="2"></td>
							</tr>
							<tr>
								<td colspan="4">(公 章）</td>
								<td colspan="2"></td>
							</tr>
							<tr>
								<td colspan="2">申请日期：</td>
								<td colspan="4"><input type="text" name="县（区）民政局意见科长时间"
									id="countyChargeTime" field="countyChargeTime" size=18
									format="Y年m月d日" onclick="LoushangDate(this)"
									readonly="readonly" style="text-align: center" /></td>
							</tr>
							<tr>
								<td colspan="2">&nbsp;</td>
								<td colspan="4">年 月 日</td>
							</tr>
						</table>
						</TD>
					</TR>
					<tr>
						<td class=unnamed2 align=middle height=100 width=160>局领导</td>
						<TD class=unnamed3 valign="top"><textarea name='县（区）民政局意见局领导意见' COLS='80'
							rows='10' CLASS='boder-0' id="countyChiefBaseOpinion"
							field="countyChiefBaseOpinion">
							</textarea>
						<table width="200" border="0" cellspacing="0" cellpadding="0"
							align="right">
							<tr>
								<td colspan="2">签字：</td>
								<td colspan="2">
								<div align="center"><input type="text"
									name="县（区）民政局意见局领导签字" id="countyChief" field="countyChief"
									size=18 /></div>
								</td>
								<td colspan="2"></td>
							</tr>
							<tr>
								<td colspan="4">(公 章）</td>
								<td colspan="2"></td>
							</tr>
							<tr>
								<td colspan="2">申请日期：</td>
								<td colspan="4"><input type="text" name="县（区）民政局意见局领导时间"
									id="countyChiefTime" field="countyChiefTime" size=18
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
					<tr>
						<TD class=unnamed4 align=middle height=200 width=140 rowspan="2">
						<p align="center">市</p>
						<p align="center">民</p>
						<p align="center">政</p>
						<p align="center">局</p>
						<p align="center">意</p>
						<p align="center">见</p>
						</TD>
						<td class=unnamed2 align=middle height=100 width=160>科(处)长</td>
						<TD class=unnamed3 valign="top"><textarea name='市民政局意见科（处）长意见' COLS='80'
							rows='10' id="cityChargeBaseOpinion"
							field="cityChargeBaseOpinion">
							</textarea>
						<table width="200" border="0" cellspacing="0" cellpadding="0"
							align="right">
							<tr>
								<td colspan="2">签字：</td>
								<td colspan="2">
								<div align="center"><input type="text"
									name="市民政局意见科（处）长签字" id="cityCharge" field="cityCharge" size=18 /></div>
								</td>
								<td colspan="2"></td>
							</tr>
							<tr>
								<td colspan="4">(公 章）</td>
								<td colspan="2"></td>
							</tr>
							<tr>
								<td colspan="2">申请日期：</td>
								<td colspan="4"><input type="text" name="市民政局意见科（处）长时间"
									id="cityChargeTime" field="cityChargeTime" size=18
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
					<tr>
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
			<td align="center">3</td>
		</tr>
	</TBODY>
</TABLE>
</form>
</body>
</html>