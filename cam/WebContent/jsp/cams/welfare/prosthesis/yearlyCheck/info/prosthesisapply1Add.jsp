<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<%@page import="com.inspur.cams.comm.extuser.util.ExtBspInfo"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="java.util.*"%>
<%@page import="java.text.*"%>
<html>

<head>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<title>福利企业审批 </title>
<%
	String method = (String)request.getParameter("method");
	String serialNum = (String)request.getParameter("serialNum");
	//获取当前日期
	SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");//设置日期格式
   	String regDate=df.format(new Date()); // new Date()为获取当前系统时间
	//获取随机编码
   	String taskCode=IdHelp.getUUID32();
%>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="../../../common/js/float.js"></script>
<link href="../../apply/prosthesisQualification/css/prosthesisapply1.css" type="text/css" rel="stylesheet" />
<script language="javascript">
 	//初始化
 	 var organArea='<%=BspUtil.getCorpOrgan().getOrganCode()%>';
     var organName='<%=BspUtil.getCorpOrgan().getOrganName()%>';
     //填表日期为当前时间
     var regDate='<%=regDate%>';
 	var taskCode='<%=taskCode%>';
 	var serialNum='<%=serialNum%>';
 	var taskCode0='';
	function init(){
			var wealFitInfoDataSet = L5.DatasetMgr.lookup("wealFitInfoDataSet");
			wealFitInfoDataSet.setParameter("TASK_CODE@=", taskCode);
			wealFitInfoDataSet.load();
			wealFitInfoDataSet.on('load',function(ds){
				if(ds.getCount()==0){
					var wealFitInfoDataSet = L5.DatasetMgr.lookup("wealFitInfoDataSet");
					wealFitInfoDataSet.newRecord({"taskCode":taskCode,"applyType":"1"});
				}
			});
			 backFill();
	}
	function save(){
		var wealFitStatusDataSet = L5.DatasetMgr.lookup("wealFitStatusDataSet");
		var wealFitInfoDataSet = L5.DatasetMgr.lookup("wealFitInfoDataSet");
		wealFitInfoDataSet.setParameter("regDate",regDate);
		
		var fitStatusValidate = wealFitStatusDataSet.isValidate();
		if(fitStatusValidate != true){
			L5.Msg.alert("提示",fitStatusValidate);
			return "break";
		}
		
		var fitStatusRecord=wealFitStatusDataSet.getCurrent();
		
		//人员信息表
		var wealWorkerDataSet = L5.DatasetMgr.lookup("wealWorkerDataSet");
		wealWorkerDataSet.setParameter("TASK_CODE@=",taskCode0);
		wealWorkerDataSet.load(true);
		var WorkerRd = wealWorkerDataSet.getAllRecords();
		//设施表
		var wealFitDeviceDataSet = L5.DatasetMgr.lookup("wealFitDeviceDataSet");
		wealFitDeviceDataSet.setParameter("TASK_CODE@=",taskCode0);
		wealFitDeviceDataSet.load(true);
		var FitDeviceRd = wealFitDeviceDataSet.getAllRecords();
		//生成能力信息表
		var wealFitProductivepowerDataSet = L5.DatasetMgr.lookup("wealFitProductivepowerDataSet");
		wealFitProductivepowerDataSet.setParameter("TASK_CODE@=",taskCode0);
		wealFitProductivepowerDataSet.load(true);
		var FitProductivepowerRd = wealFitProductivepowerDataSet.getAllRecords();
		
		var command = new L5.Command("com.inspur.cams.welfare.prosthesis.apply.cmd.FitApplyCmd");
		command.setParameter("fitStatusRecord", fitStatusRecord);
		command.setParameter("WorkerRd",WorkerRd);
		command.setParameter("FitDeviceRd",FitDeviceRd);
		command.setParameter("FitProductivepowerRd",FitProductivepowerRd);
		command.setParameter("regDate",regDate);
		command.setParameter("taskCode",taskCode);
		
		
		command.execute("saveQualificationD");
		if (!command.error) {
			alert("保存成功！");	
		}else{
			L5.Msg.alert('提示',"保存时出现错误！"+command.error);
		}
	}
	//根据编号回填数据
	function backFill(){
		var wealFitStatusDataSet = L5.DatasetMgr.lookup("wealFitStatusDataSet");
		wealFitStatusDataSet.setParameter("SERIAL_NUM@=",serialNum);
			if(serialNum!="")wealFitStatusDataSet.load();
			wealFitStatusDataSet.on('load',function(ds){
				if(ds.getCount()>0){
					applyYear = ds.getAt(0).get("applyYear");
					serialNum = ds.getAt(0).get("serialNum");
					
					document.getElementById("companyName").value=ds.getAt(0).get("companyName");
					document.getElementById("legalPeople").value=ds.getAt(0).get("legalPeople");
					document.getElementById("regDate").value=regDate;
					document.getElementById("serialNum").innerHTML=serialNum
					document.getElementById("checkYear").innerHTML=ds.getAt(0).get("nextCheck");
					
					
					var wealFitInfoDataSet1 = L5.DatasetMgr.lookup("wealFitInfoDataSet1");
					wealFitInfoDataSet1.setParameter("SERIAL_NUM@=",serialNum);
					wealFitInfoDataSet1.setParameter("APPLY_YEAR@=",applyYear);
					wealFitInfoDataSet1.load();
					wealFitInfoDataSet1.on('load',function(ds){
						taskCode0 =ds.getAt(0).get("taskCode");
					});
				}else{
					document.getElementById("companyName").value="";
					document.getElementById("legalPeople").value="";
					document.getElementById("regDate").value="";
				}
			});
	}

	function nextPageY(){
		if(save() == "break"){
			return;
		}
		var data = new L5.Map();
		var url='jsp/cams/welfare/prosthesis/yearlyCheck/info/prosthesisapply2.jsp';
		data.put("taskCode",taskCode);
		var text = '网上申报';
		L5.forward(url,text,data);
	}
	//第一页返回按钮
	function backPageD(){
		var data = new L5.Map();
		var url='jsp/cams/welfare/prosthesis/yearlyCheck/applytask/prosthesisYearlyCheckList.jsp';
		L5.forward(url);
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
	<!-- 业务信息表 -->
	<model:dataset id="wealFitInfoDataSet1" cmd="com.inspur.cams.welfare.base.cmd.WealFitInfoQueryCommand" >
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealFitInfo">
		</model:record>
	</model:dataset>
	<!-- 业务状态表 -->
	<model:dataset id="wealFitStatusDataSet" cmd="com.inspur.cams.welfare.base.cmd.WealFitStatusQueryCommand" >
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealFitStatus">
		<model:field name="companyName" type="string" rule="require" />	
		<model:field name="legalPeople" type="string" rule="require" />
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
	<model:dataset id="wealWorkerDataSet" cmd="com.inspur.cams.welfare.base.cmd.WealWorkerQueryCommand" >
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealWorker"></model:record>
	</model:dataset>
</model:datasets>
<div id="float" >
	<input type="button" value="下一页" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="nextPageY()" />
	<input type="button" value="保存" style="height:25px;width:80px;position:absolute;margin-left:120px;"  onclick="save()"/>
	<input type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:220px;" onclick="backPageD();"/>
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
						<TD width='668' height=34 align=right class=title3><STRONG>编号：鲁假肢证字第（<label  field="serialNum" id='serialNum' style='font-size: 14.0pt; font-family: 宋体;'"></label>）号
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
									<TD width='668' height=34 align=middle class=title1><label id="checkYear" style="font-size:30px"></label>&nbsp;&nbsp;<STRONG>年 度 检 查 表
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
<div id="float" >
	<input type="button" value="下一页" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="nextPageY()" />
	<input type="button" value="保存" style="height:25px;width:80px;position:absolute;margin-left:120px;"  onclick="save()"/>
	<input type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:220px;" onclick="backPageD();"/>
</div>
</body>
</html>