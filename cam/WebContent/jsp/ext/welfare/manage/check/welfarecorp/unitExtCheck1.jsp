<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<%@page import="com.inspur.cams.comm.extuser.util.ExtBspInfo"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>

<html>
<head>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<title>福利企业审批</title>
<%
String username = ExtBspInfo.getUserInfo(request).getUserName();
String peopleId= ExtBspInfo.getUserInfo(request).getUserId();
String peopleArea= ExtBspInfo.getUserInfo(request).getAreaCode();
	String taskCode = (String) request.getParameter("taskCode");
	String method = (String) request.getParameter("method");
	if (taskCode == null) {
		taskCode = IdHelp.getUUID32();
	}
%>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="js/welfarecorpGoto.js"></script>
<link href="css/welfareapply1.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
<script language="javascript">
	//初始化
 	var organArea='<%=username%>';
     var organName='<%=peopleArea%>';
 	var taskCode='<%=taskCode%>';
 	var method='<%=method%>';
	function init(){
		if(method=="INSERT"){
			var wealUnitInfoDataSet = L5.DatasetMgr.lookup("wealUnitInfoDataSet");
			wealUnitInfoDataSet.setParameter("TASK_CODE@=", taskCode);
			wealUnitInfoDataSet.load();
			wealUnitInfoDataSet.on('load',function(ds){
				if(ds.getCount()==0){
					var wealUnitInfoDataSet = L5.DatasetMgr.lookup("wealUnitInfoDataSet");
					wealUnitInfoDataSet.newRecord({"taskCode":taskCode,"applyType":"1"});
				}
			});
		}else{
			var wealUnitInfoDataSet = L5.DatasetMgr.lookup("wealUnitInfoDataSet");
			wealUnitInfoDataSet.setParameter("TASK_CODE@=", taskCode);
			wealUnitInfoDataSet.load();
		}
	}
	function save(){
		var wealUnitInfoDataSet = L5.DatasetMgr.lookup("wealUnitInfoDataSet");
		var unitInfoValidate = wealUnitInfoDataSet.isValidate();
		if(unitInfoValidate != true){
			L5.Msg.alert("提示",unitInfoValidate);
			return "break";
		}
		var unitInfoRecord=wealUnitInfoDataSet.getCurrent();
		var command = new L5.Command("com.inspur.cams.welfare.welfarecorp.apply.cmd.UnitApplyCmd");
		command.setParameter("unitInfoRecord", unitInfoRecord);
		command.setParameter("dataSource","ONLINE");//外网保存时，传入字段：值为 ONLINE
		command.execute("saveQualification");
		if (!command.error) {
			alert("保存成功！");	
		}else{
			L5.Msg.alert('提示',"保存时出现错误！"+command.error);
		}
	}
	function backPageY(){
		var url='jsp/ext/welfare/manage/check/welfarecorp/welfarecorpCheckList.jsp';
		L5.forward(url);
	}
</script>
</head>
<body>
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
<div id="float"><input type="button" value="下一页"
	style="height: 25px; width: 80px; position: absolute; margin-left: 20px;"
	onclick="nextPage('2')" /> <input type="button" value="保存"
	style="height: 25px; width: 80px; position: absolute; margin-left: 120px;"
	onclick="save()" /> <input type="button" value="返回"
	style="height: 25px; width: 80px; position: absolute; margin-left: 220px;"
	onclick="backPageY();" /></div>
<form method="post" onsubmit="return false">
<TABLE height=677 cellSpacing=0 cellPadding=0 width=800 align=center
	border=0>
	<TBODY>
		<TR>
			<TD width=671 height=80>&nbsp;</TD>
		</TR>
		<TR>
			<TD vAlign=top height=597>
			<TABLE height=677 cellSpacing=0 cellPadding=0 width=668 align=center
				dataset="wealUnitInfoDataSet" border=0>
				<TBODY>
					<TR>
						<TD width='668' height=34 align=right class=title3><STRONG>编号：鲁福企字第（
						<label field="serialNum" id='serialNum'
							style='font-size: 14.0pt; font-family: 宋体'></label> ）号 </STRONG></TD>
					</TR>
					<TR>
						<TD class=title1 vAlign=top align=middle height=150>
						<TABLE cellSpacing=0 cellPadding=0 width='100%' border=0>
							<TBODY>
								<TR>
									<TD height=150></TD>
								</TR>
							</TBODY>
						</TABLE>
						<DIV align=center></DIV>
						<TABLE cellSpacing=0 cellPadding=0 width='100%' border=0>
							<TBODY>
								<TR>
									<TD width='668' height=34 align=middle class=title1><STRONG>社会福利企业
									</STRONG></TD>
								</TR>
								<TR>
									<TD height=50></TD>
								</TR>
								<TR>
									<TD width='668' height=34 align=middle class=title1><label id="applyYear" field="applyYear" style="font-size:30px;font-weight:400"></label>&nbsp;&nbsp;<STRONG>年度检查表
									</STRONG></TD>
								</TR>
							</TBODY>
						</TABLE>
						</TD>
					</TR>
				</TBODY>
			</TABLE>
			</TD>
		</TR>
		<TR>
			<TD height=300>
			<TABLE cellSpacing=0 cellPadding=0 width='100%' border=0
				dataset="wealUnitInfoDataSet">
				<TBODY>
					<TR>
						<TD width="20%" align="left" height=150>&nbsp;</TD>
						<TD align="left" class=title3><STRONG>企业名称（章）： </STRONG></TD>
						<TD height=40 colspan='4'><input name='企业名称'
							field="companyName" ID='companyName' SIZE='70' MAXLENGTH='120' /></TD>
					</TR>
					<TR>
						<TD height=150 align="left">&nbsp;</TD>
						<TD class=title3 align="left"><br>
						<STRONG>法&nbsp; 人&nbsp;代&nbsp; 表：</STRONG></TD>
						<TD height=40 colspan='4'><input name='法人代表'
							field="legalPeople" ID='legalPeople' height=40 SIZE='70'
							MAXLENGTH='120' /></TD>
					</TR>
					<TR>
						<TD height=150 align="left">&nbsp;</TD>
						<TD class=title3 align="left"><STRONG>填&nbsp;
						表&nbsp;时&nbsp; 间：</STRONG></TD>
						<TD height=40 colspan='4'><input name='填表时间' field="regDate"
							ID='regDate' height=40 SIZE='70' MAXLENGTH='120' format="Y-m-d"
							onclick="WdatePicker()" readonly="readonly"
							style="text-align: center" /></TD>
					</TR>
				</TBODY>
			</TABLE>
			</TD>
		</TR>
		<TR>
			<TD align="middle" height=100 class="title3" style="font-size: 25px"><strong>山东省民政厅监制</strong>
			</TD>
		</TR>
		<tr valign=bottom>
			<td height='27' valign=bottom align=center>1</td>
			<TD height=20></TD>
		</tr>
	</TBODY>
</TABLE>
</form>
<div id="float"><input type="button" value="下一页"
	style="height: 25px; width: 80px; position: absolute; margin-left: 20px;"
	onclick="nextPage('2')" /> <input type="button" value="保存"
	style="height: 25px; width: 80px; position: absolute; margin-left: 120px;"
	onclick="save()" /> <input type="button" value="返回"
	style="height: 25px; width: 80px; position: absolute; margin-left: 220px;"
	onclick="backPageY();" /></div>
</body>
</html>