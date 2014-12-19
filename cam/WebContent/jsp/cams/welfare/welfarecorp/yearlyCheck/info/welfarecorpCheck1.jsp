 <%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<%@page import="com.inspur.cams.comm.extuser.util.ExtBspInfo"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>

<head>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<title>福利企业审批 </title>
<%
	String taskCode = (String)request.getParameter("taskCode");
	String method = (String)request.getParameter("method");
	if(taskCode==null){
		taskCode=IdHelp.getUUID32();
	}
%>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="../../../common/js/float.js"></script>
<link href="css/prosthesisapply1.css" type="text/css" rel="stylesheet" />
<script language="javascript">
 	//初始化
 	 var organArea='<%=BspUtil.getCorpOrgan().getOrganCode()%>';
     var organName='<%=BspUtil.getCorpOrgan().getOrganName()%>';
 	var taskCode='<%=taskCode%>';
 	var method='<%=method%>';
	function init(){
		if(method=="INSERT"){
			var wealFitInfoDataSet = L5.DatasetMgr.lookup("wealFitInfoDataSet");
			wealFitInfoDataSet.setParameter("TASK_CODE@=", taskCode);
			wealFitInfoDataSet.load();
			wealFitInfoDataSet.on('load',function(ds){
				if(ds.getCount()==0){
					var wealFitInfoDataSet = L5.DatasetMgr.lookup("wealFitInfoDataSet");
					wealFitInfoDataSet.newRecord({"taskCode":taskCode,"applyType":"2"});
				}
			});
		}else{
			var wealFitInfoDataSet = L5.DatasetMgr.lookup("wealFitInfoDataSet");
			wealFitInfoDataSet.setParameter("TASK_CODE@=", taskCode);
			wealFitInfoDataSet.load();
		}
	}
	function save(){
		var wealFitInfoDataSet = L5.DatasetMgr.lookup("wealFitInfoDataSet");
		var fitInfoValidate = wealFitInfoDataSet.isValidate();
		if(fitInfoValidate != true){
			L5.Msg.alert("提示",fitInfoValidate);
			return "break";
		}
		var fitInfoRecord=wealFitInfoDataSet.getCurrent();
		var command = new L5.Command("com.inspur.cams.welfare.prosthesis.apply.cmd.FitApplyCmd");
		command.setParameter("fitInfoRecord", fitInfoRecord);
		command.execute("saveQualification");
		if (!command.error) {
			alert("保存成功！");	
		}else{
			L5.Msg.alert('提示',"保存时出现错误！"+command.error);
		}
	}
	function getinfo(obj){
		alert(obj.value){
			
		}
	}
</script>
</head>
<body>
<model:datasets>
	<!-- 业务表 -->
	<model:dataset id="welfFitApplyDataSet" cmd="com.inspur.cams.welfare.base.cmd.WealFitApplyQueryCommand">
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealFitApply"></model:record>
	</model:dataset>
	<!-- 业务信息表 -->
	<model:dataset id="wealFitInfoDataSet" cmd="com.inspur.cams.welfare.base.cmd.WealFitInfoQueryCommand" >
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealFitInfo">
		<model:field name="companyName" type="string" rule="require" />	
		<model:field name="legalPeople" type="string" rule="require" />
		<model:field name="regDate" type="string" rule="require" />
		</model:record>
	</model:dataset>
	<!-- 设施信息表 -->
	<model:dataset id="wealFitDeviceDataSet" cmd="com.inspur.cams.welfare.base.cmd.WealFitDeviceQueryCommand" >
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealFitDevice"></model:record>
	</model:dataset>
	<!-- 生产能力信息 -->
	<model:dataset id="wealFitProductivepowerDataSet" cmd="com.inspur.cams.welfare.base.cmd.WealFitProductivepowerQueryCommand" >
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealFitProductivepower"></model:record>
	</model:dataset>
	<!-- 职工信息表 -->
	<model:dataset id="" cmd="com.inspur.cams.welfare.base.cmd.WealWorkerQueryCommand" >
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealWorker"></model:record>
	</model:dataset>
</model:datasets>
<div id="float" >
	<input type="button" value="下一页" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="nextPageJ('2')" />
	<input type="button" value="保存" style="height:25px;width:80px;position:absolute;margin-left:120px;"  onclick="save()"/>
	<input type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:220px;" onclick="backPageJ();"/>
</div>
<form method="post"  onsubmit="return false">
<TABLE height=677 cellSpacing=0 cellPadding=0 width=800 align=center
	border=0>
	<TBODY>
		<TR>
			<TD width=671 height=80>&nbsp;</TD>
		</TR>
		<TR>
			<TD vAlign=top height=597>
			<TABLE height=677 cellSpacing=0 cellPadding=0 width=668 align=center dataset="wealFitInfoDataSet"
				border=0>
				<TBODY>
					<TR>
						<TD width='668' height=34 align=right class=title3><STRONG>编号：鲁假肢证字第（<input 
							 field="serialNum" id='serialNum' SIZE='20' onblur="getinfo(this)"/>）号
						</STRONG></TD>
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
									<TD width='668' height=34 align=middle class=title1><STRONG>假肢和矫形器生产装配企业
									</STRONG></TD>
								</TR>
								<TR>
									<TD height=50></TD>
								</TR>
								<TR>
									<TD width='668' height=34 align=middle class=title1><STRONG>资  格  认  定
									</STRONG></TD>
								</TR>
								<TR>
									<TD height=50></TD>
								</TR>
								<TR>
									<TD width='668' height=34 align=middle class=title1><STRONG>审  批  表
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
			<TABLE cellSpacing=0 cellPadding=0 width='100%' border=0 dataset="wealFitInfoDataSet">
				<TBODY>
					<TR >
						<TD width="20%" align="left" height=150>&nbsp;</TD>
						<TD  align="left" class=title3><STRONG>企业名称（章）： </STRONG></TD>
						<TD height=40 colspan='4'><input 
							name='企业名称' field="companyName" id='companyName' SIZE='70' MAXLENGTH='200'/></TD>
					</TR>
					<TR>
						<TD height=150 align="left">&nbsp;</TD>
						<TD class=title3 align="left"><br>
						<STRONG>法&nbsp;人&nbsp;代&nbsp;表&nbsp;：</STRONG></TD>
						<TD height=40 colspan='4' ><input 
							name='法人代表' field="legalPeople" id='legalPeople'
							height=40 SIZE='70' MAXLENGTH='72'/></TD>
					</TR>
					<TR>
						<TD height=150 align="left">&nbsp;</TD>
						<TD class=title3 align="left"><STRONG>填&nbsp;表&nbsp;时&nbsp;间&nbsp;：</STRONG></TD>
						<td height=40 colspan='4'>
						<input name='填表时间' field="regDate" id='regDate'	height=40 SIZE='70' readonly="readonly" format="Y-m-d" onclick="LoushangDate(this)"/></td>
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
			<td height='27' valign=bottom align=center>第1页</td>
		</tr>
	</TBODY>
</TABLE>
</form>
</body>
</html>