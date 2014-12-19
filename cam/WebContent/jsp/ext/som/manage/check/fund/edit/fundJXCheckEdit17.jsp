<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<next:ScriptManager />
<script type="text/javascript" src="../../js/float.js"></script>
<link href="../../css/float.css" type="text/css" rel="stylesheet" />
<script language="javascript">
var taskCode='<%=request.getParameter("taskCode")%>';
//初始化
function init(){
	somCheckPublicActivitiesDataSet.setParameter("TASK_CODE", taskCode);
	somCheckPublicActivitiesDataSet.load();
	somCheckPublicActivitiesDataSet.on('load',function(ds){
		var count = ds.getCount();
		if(count!=0){
			for(i=1;i<=count;i++){
				document.getElementById("times").value=ds.getAt(i-1).get("activityNum");
				document.getElementById("JNAME"+i).value=ds.getAt(i-1).get("itemName");
				document.getElementById("income"+i).value=ds.getAt(i-1).get("itemIn");
				document.getElementById("expend"+i).value=ds.getAt(i-1).get("itemOut");
				document.getElementById("year"+i).value=ds.getAt(i-1).get("itemYear");
				document.getElementById("yearEnd"+i).value=ds.getAt(i-1).get("itemYearEnd");
				document.getElementById("itemContent"+i).value=ds.getAt(i-1).get("itemContent");
			}
		}
	});
	//创建页面导航下拉框
	createFundEditSelect();
}
function save(){
	var times=document.getElementById("times").value;
	if(times==""){
		L5.Msg.alert("提示","请输入本年度本基金会开展公益活动数目！");
		return "break";
	}
	var dataset = getSomCheckPublicActivitiesDataSet();
	if(dataset=="break"){
		return "break";
	}
	var records = dataset.getAllRecords();
	var command = new L5.Command("com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckCommand");
	command.setParameter("records", records);
	command.setParameter("taskCode", taskCode);
	command.execute("savePageJ17");
	if (!command.error) {
		alert("保存成功！");
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
function getSomCheckPublicActivitiesDataSet(){
	somCheckPublicActivitiesDataSet.removeAll();
	for(var i = 1;i<=5;i++){
		var record= somCheckPublicActivitiesDataSet.newRecord();
		record.set("taskCode",taskCode);
		record.set("activityNum",document.getElementById("times").value);
		record.set("itemName",document.getElementById("JNAME"+i).value);
		record.set("itemIn",document.getElementById("income"+i).value);
		record.set("itemOut",document.getElementById("expend"+i).value);
		record.set("itemYear",document.getElementById("year"+i).value);
		record.set("itemYearEnd",document.getElementById("yearEnd"+i).value);
		record.set("itemContent",document.getElementById("itemContent"+i).value);
		var itemName=document.getElementById("JNAME"+i).value;
		var itemIn=document.getElementById("income"+i).value;
		var itemOut=document.getElementById("expend"+i).value;
		var itemYear=document.getElementById("year"+i).value;
		var itemYearEnd=document.getElementById("yearEnd"+i).value;
		var itemContent=document.getElementById("itemContent"+i).value;
		if(itemName==""||itemIn==""||itemOut==""||itemYear==""||itemYearEnd==""||itemContent==""){
			if(i==1){
				L5.Msg.alert("提示","请至少输入一条公益活动信息！没有的请填无！");
				return "break";
			}else{
				if(!(itemName==""&&itemIn==""&&itemOut==""&&itemYear==""&&itemYearEnd==""&&itemContent=="")){
					L5.Msg.alert("提示","请输入完整的公益活动信息！");
					return "break";
				}
			}
		}
	}
	return somCheckPublicActivitiesDataSet;
}
</script>

<STYLE>
body {
	background-color: #ffffff;
	color: #000000;
	margin-left: 0;
	margin-top: 0;
	margin-width: 0;
	margin-height: 0;
	margin: 0px;
	font-size: 14px;
	font-family: '宋体 ';
	font-weight: normal;
	line-height: 18px;
}

table {
	color: #000000;
	font-size: 14px;
	font-family: '宋体 ';
	font-weight: normal;
}

textarea {
	overflow-x: hidden;
	overflow-y: hidden;
}

.text {
	font-size: 14px;
	line-height: 20px;
}

.text3 {
	font-size: 12px;
	line-height: 13px;
}

.text1 {
	font-size: 16px;
	letter-spacing: normal;
}

.text2 {
	font-size: 16px;
	line-height: 30px;
	letter-spacing: normal;
}

.unnamed1 {
	border: 1 solid #000000;
	font-size: 14px;
}

.unnamed2 {
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	border-right-width: 1px;
	border-right-style: solid;
	border-right-color: #000000;
	font-size: 14px;
}

.unnamed3 {
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	font-size: 14px;
	border-top-style: none;
	border-right-style: none;
	border-left-style: none;
}

.unnamed4 {
	border-right-width: 1px;
	border-right-style: solid;
	border-right-color: #000000;
	font-size: 14px;
}

.f16ps-size1 {
	border: 1px solid #000000;
	font-size: 16pt;
}

.f16ps-size2 {
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	border-right-width: 1px;
	border-right-style: solid;
	border-right-color: #000000;
	font-size: 16pt;
}

.f16ps-size3 {
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	font-size: 16pt;
	border-top-style: none;
	border-right-style: none;
	border-left-style: none;
}

.f16ps-size4 {
	border-right-width: 1px;
	border-right-style: solid;
	border-right-color: #000000;
	font-size: 16pt;
}

.boder1 {
	border: 1 solid #000000;
	font-size: 16px;
	line-height: 25px;
}

.boder2 {
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	border-right-width: 1px;
	border-right-style: solid;
	border-right-color: #000000;
	font-size: 16px;
	line-height: 25px;
}

.boder3 {
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	font-size: 16px;
	line-height: 25px;
}

.boder4 {
	border-right-width: 1px;
	border-right-style: solid;
	border-right-color: #000000;
	font-size: 16px;
	line-height: 25px;
}

.table {
	font-size: 14px;
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	border-top-width: 0px;
	border-right-width: 0px;
	border-left-width: 0px;
	border-top-style: none;
	border-right-style: none;
	border-left-style: none;
	vertical-align: middle;
}

.boder-0 {
	font-size: 14px;
	vertical-align: middle;
}

.boder-1 {
	font-size: 14px;
	vertical-align: middle;
}

.boder16pt-0 {
	font-size: 16pt;
	border: 0px none;
	vertical-align: middle;
}

.boderbgh-0 {
	font-size: 14px;
	border: 0px none;
	vertical-align: middle;
	color: #000000;
	background-color: #CCCCCC;
}

.boder0-color {
	font-size: 14px;
	border: 0px none;
	vertical-align: middle;
	background-color: #D8D8D8;
}

.table-text16 {
	font-size: 16px;
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	border-top-width: 0px;
	border-right-width: 0px;
	border-left-width: 0px;
	border-top-style: none;
	border-right-style: none;
	border-left-style: none;
	vertical-align: middle;
}

.boder16-0 {
	font-size: 16px;
	border: 0px none;
	vertical-align: middle;
}

.title2625 {
	font-family: '宋体';
	font-size: 14px;
	font-weight: bold;
	color: #000000;
	line-height: 150%;
}

.title1 {
	font-family: '宋体';
	font-size: 23px;
	font-weight: bold;
	color: #000000;
}

.text-12s {
	font-family: '宋体';
	font-size: 12px;
	color: #000000;
	line-height: 21px;
	word-spacing: 120em;
}

.biaoti {
	font-family: '宋体';
	font-size: 15px;
	font-weight: bold;
	color: #000000;
}

.minfei-bt {
	font-family: '黑体';
	font-size: 32px;
	font-weight: bold;
	color: #000000;
}

.minfei-bt1 {
	font-family: '宋体';
	font-size: 22px;
	color: #000000;
}

.minfei-bt2 {
	font-size: 20px;
	font-weight: bold;
	color: #000000;
	letter-spacing: 4pt;
}

.npo-bt {
	font-size: 42px;
	line-height: 25px;
	font-weight: bold;
	color: #000000;
	font-family: '宋体';
	text-indent: 10pt;
}

.npo-zi {
	font-family: '宋体';
	font-size: 20px;
	font-weight: bold;
	color: #000000;
}

.npo-font {
	font-family: '黑体';
	font-size: 22px;
	font-weight: normal;
	color: #000000;
}

.npo-bottomtext {
	font-family: '宋体';
	font-size: 28px;
	line-height: 15px;
	font-weight: bolder;
	color: #000000;
}

.font12s {
	font-family: '宋体';
	font-size: 12px;
	color: #000000;
}

.font12size {
	font-family: '宋体';
	font-size: 12px;
	color: #000000;
	letter-spacing: 4px;
}

.font16pt {
	font-family: '宋体';
	font-size: 16pt;
	color: #000000;
	letter-spacing: 4px;
	line-height: 30pt;
}

.table-text12 {
	font-size: 12px;
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	border-top-width: 0px;
	border-right-width: 0px;
	border-left-width: 0px;
	border-top-style: none;
	border-right-style: none;
	border-left-style: none;
	vertical-align: middle;
}

.font12size1 {
	border: 1 solid #000000;
	font-size: 12px;
	line-height: 22px;
}

.font12size2 {
	line-height: 22px;
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	border-right-width: 1px;
	border-right-style: solid;
	border-right-color: #000000;
	font-size: 12px;
}

.font12size3 {
	line-height: 22px;
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	font-size: 12px;
	border-top-style: none;
	border-right-style: none;
	border-left-style: none;
}

.font12size4 {
	line-height: 22px;
	border-right-width: 1px;
	border-right-style: solid;
	border-right-color: #000000;
	font-size: 12px;
}

.boder12-0 {
	font-size: 12px;
	border: 0px none;
	vertical-align: middle;
}

.input-line16 {
	font-size: 16pt;
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	border-top-width: 0px;
	border-right-width: 0px;
	border-left-width: 0px;
	border-top-style: none;
	border-right-style: none;
	border-left-style: none;
	font-family: '宋体';
	color: #000000;
}

.font16fpt {
	font-family: '仿宋';
	font-size: 16pt;
	color: #000000;
	letter-spacing: 4px;
	line-height: 30pt;
}

.font18pt {
	font-family: '宋体';
	font-size: 16pt;
	color: #000000;
	letter-spacing: 4px;
	line-height: 45px;
}

.input-line16f {
	font-size: 16pt;
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	border-top-width: 0px;
	border-right-width: 0px;
	border-left-width: 0px;
	border-top-style: none;
	border-right-style: none;
	border-left-style: none;
	vertical-align: middle;
	font-family: '仿宋';
}

.input-line18 {
	font-size: 18pt;
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	border-top-width: 0px;
	border-right-width: 0px;
	border-left-width: 0px;
	border-top-style: none;
	border-right-style: none;
	border-left-style: none;
	vertical-align: middle;
	font-family: '宋体';
	line-height: 40pt;
}

.stb-bt {
	font-family: '黑体';
	font-size: 30px;
	font-weight: bold;
	color: #000000;
	line-height: 40pt;
}

.stb-bt1 {
	font-family: '宋体';
	font-size: 30px;
	font-weight: bold;
	color: #000000;
	line-height: 40pt;
}

.boder18-0 {
	font-size: 18pt;
	border: 0px none;
	vertical-align: middle;
}

.select {
	font-family: '宋体';
	font-size: 12px;
	color: #000000;
	width: 80px;
}

.font16fpt-001 {
	font-family: '仿宋';
	font-size: 16pt;
	color: #000000;
	letter-spacing: 2px;
	line-height: 24pt;
}

.font16pt-001 {
	font-family: '仿宋';
	font-size: 16pt;
	color: #000000;
	letter-spacing: 2px;
	line-height: 24pt;
}

.STYLE1 {
	color: #FF0000
}
</STYLE>
</head>

<body>
<model:datasets>
	<model:dataset id="somCheckPublicActivitiesDataSet" cmd="com.inspur.cams.sorg.jxcheck.somjxcommonwealdetail.cmd.SomJxCommonwealDetailQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxcommonwealdetail.dao.SomJxCommonwealDetail">
			<model:field name="itemContent" type="string" rule="length{100}"/>
		</model:record>
	</model:dataset>
</model:datasets>
<div id="float">
	<input type="button" value="下一页" style="height: 25px; width: 80px; position: absolute; margin-left: 120px;" onclick="nextPageJ('18')" />
	<input type="button" value="上一页" style="height: 25px; width: 80px; position: absolute; margin-left: 20px;" onclick="nextPageJ('16')" />
	<input type="button" value="保存" style="height: 25px; width: 80px; position: absolute; margin-left: 220px;" onclick="save();" />
	<input type="button" value="返回" style="height: 25px; width: 80px; position: absolute; margin-left: 320px;" onclick="backJ();" />
</div>
<div align=center>
<div align=center style="width: 800px">
<form dataset="" name="myform" method="post" onsubmit="return false">

<TABLE cellSpacing=0 cellPadding=0 width=660 align=center border=0>
	<TBODY>
		<TR>
			<TD height=31 align=center>
			<div align='left'><SPAN class=title2625><STRONG>（五）本年度业务活动情况报告
			</STRONG></SPAN></div>
			</TD>
		</TR>
		<TR>
			<TD class=text height=49>本年度公益活动明细 <BR>
			本年度本基金会共开展了（ <input name='query$form$0$JJHNJ_GYHDMX$huodongshu'
			id  = "times" maxlength="6" onkeyup="value=value.replace(/[^\d]/g,'') "
				value='' CLASS='boder-0' SIZE='10' style='text-align:center'> ）项公益活动，具体情况如下：
			</TD>
		</TR>
		<TR>
			<TD>
			<TABLE class=unnamed1 cellSpacing=0 cellPadding=2 width='100%'
				border=0>
				<TBODY>
					<TR>
						<TD class=unnamed2 vAlign=center align=middle width='4%' height=60><input style='text-align:center'
							name='query$form$0$JJHNJ_GYHDMX_SUB$xuhao$1' value='1'
							CLASS='boder-0' SIZE='3' readonly></TD>
						<TD class=unnamed3 vAlign=top width='96%'>
						<TABLE cellSpacing=0 cellPadding=0 width='100%' border=0>
							<TBODY>
								<TR>
									<TD height=15><SPAN class=text3>项目名称 ： <input
										id ='JNAME1'
										value='' CLASS='boder-1' SIZE='70' maxlength=50> </SPAN></TD>
								</TR>
								<TR>
									<TD height=15><SPAN class=text3>项目本年度收入：人民币<input
										id='income1' value=''
										CLASS='boder-1' SIZE='10' isMoney='true'
										style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.]/g,'') "maxlength="15">
									<span style="color:red">元</span>，项目本年度支出：人民币<input
										id='expend1' value=''
										CLASS='boder-1' SIZE='10' isMoney='true'
										style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.]/g,'') "maxlength="15">
									<span style="color:red">元</span>，执行年度：自<input id='year1'
										value='' CLASS='boder-1' SIZE='4'
										onkeyup="value=value.replace(/[^\d]/g,'') "maxlength="4" style='text-align:center' > 年至<input
										id='yearEnd1' value=''
										CLASS='boder-1' SIZE='4'
										onkeyup="value=value.replace(/[^\d]/g,'') "maxlength="4"style='text-align:center'> 年</SPAN></TD>
								</TR>
								<TR>
									<TD height=15><SPAN class=text3>项目内容简述：（限300字）</SPAN></TD>
								</TR>
								<TR>
									<TD><textarea
										id='itemContent1' ROWS='6'
										COLS='100' CLASS='boder-1' ></textarea></TD>
								</TR>
							</TBODY>
						</TABLE>
						</TD>
					</TR>
					<TR>
						<TD class=unnamed2 vAlign=center align=middle width='6%' height=60><input style='text-align:center'
							name='query$form$0$JJHNJ_GYHDMX_SUB$xuhao$2' value='2'
							CLASS='boder-0' SIZE='3' readonly></TD>
						<TD class=unnamed3 vAlign=top width='94%'>
						<TABLE cellSpacing=0 cellPadding=0 width='100%' border=0>
							<TBODY>
								<TR>
									<TD height=15><SPAN class=text3>项目名称 ： <input
										id ='JNAME2'
										value='' CLASS='boder-1' SIZE='70' maxlength=50> </SPAN></TD>
								</TR>
								<TR>
									<TD height=15><SPAN class=text3>项目本年度收入：人民币<input
										id='income2' value=''
										CLASS='boder-1' SIZE='10' isMoney='true'
										style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.]/g,'') "maxlength="15">
									<span style="color:red">元</span>，项目本年度支出：人民币<input
										id='expend2' value=''
										CLASS='boder-1' SIZE='10' isMoney='true'
										style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.]/g,'') "maxlength="15">
									<span style="color:red">元</span>，执行年度：自<input id='year2'
										value='' CLASS='boder-1' SIZE='4'
										onkeyup="value=value.replace(/[^\d]/g,'') "maxlength="4"style='text-align:center'> 年至<input
										id='yearEnd2' value=''
										CLASS='boder-1' SIZE='4'
										onkeyup="value=value.replace(/[^\d]/g,'') "maxlength="4"style='text-align:center'> 年</SPAN></TD>
								</TR>
								<TR>
									<TD height=15><SPAN class=text3>项目内容简述：（限300字）</SPAN></TD>
								</TR>
								<TR>
									<TD><textarea
										id='itemContent2' ROWS='6'
										COLS='100' CLASS='boder-1' ></textarea></TD>
								</TR>
							</TBODY>
						</TABLE>
						</TD>
					</TR>
					<TR>
						<TD class=unnamed2 vAlign=center align=middle width='6%' height=60><input style='text-align:center'
							name='query$form$0$JJHNJ_GYHDMX_SUB$xuhao$3' value='3'
							CLASS='boder-0' SIZE='3' readonly></TD>
						<TD class=unnamed3 vAlign=top width='94%'>
						<TABLE cellSpacing=0 cellPadding=0 width='100%' border=0>
							<TBODY>
								<TR>
									<TD height=15><SPAN class=text3>项目名称 ： <input
										id ='JNAME3'
										value='' CLASS='boder-1' SIZE='70' maxlength="50"> </SPAN></TD>
								</TR>
								<TR>
									<TD height=15><SPAN class=text3>项目本年度收入：人民币<input
										id='income3' value=''
										CLASS='boder-1' SIZE='10' isMoney='true'
										style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.]/g,'') "maxlength="15">
									<span style="color:red">元</span>，项目本年度支出：人民币<input
										id='expend3' value=''
										CLASS='boder-1' SIZE='10' isMoney='true'
										style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.]/g,'') "maxlength="15">
									<span style="color:red">元</span>，执行年度：自<input id='year3'
										value='' CLASS='boder-1' SIZE='4'
										onkeyup="value=value.replace(/[^\d]/g,'') "maxlength="4"style='text-align:center'> 年至<input
										id='yearEnd3' value=''
										CLASS='boder-1' SIZE='4'
										onkeyup="value=value.replace(/[^\d]/g,'') "maxlength="4"style='text-align:center'> 年</SPAN></TD>
								</TR>
								<TR>
									<TD height=15><SPAN class=text3>项目内容简述：（限300字）</SPAN></TD>
								</TR>
								<TR>
									<TD><textarea
										id='itemContent3' ROWS='6'
										COLS='100' CLASS='boder-1' ></textarea></TD>
								</TR>
							</TBODY>
						</TABLE>
						</TD>
					</TR>
					<TR>
						<TD class=unnamed2 vAlign=center align=middle width='6%' height=60><input style='text-align:center'
							name='query$form$0$JJHNJ_GYHDMX_SUB$xuhao$4' value='4'
							CLASS='boder-0' SIZE='3' readonly></TD>
						<TD class=unnamed3 vAlign=top width='94%'>
						<TABLE cellSpacing=0 cellPadding=0 width='100%' border=0>
							<TBODY>
								<TR>
									<TD height=15><SPAN class=text3>项目名称 ： <input
										id ='JNAME4'
										value='' CLASS='boder-1' SIZE='70' maxlength="50"> </SPAN></TD>
								</TR>
								<TR>
									<TD height=15><SPAN class=text3>项目本年度收入：人民币<input
										id='income4' value=''
										CLASS='boder-1' SIZE='10' isMoney='true'
										style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.]/g,'') "maxlength="15">
									<span style="color:red">元</span>，项目本年度支出：人民币<input
										id='expend4' value=''
										CLASS='boder-1' SIZE='10' isMoney='true'
										style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.]/g,'') "maxlength="15">
									<span style="color:red">元</span>，执行年度：自<input id='year4'
										value='' CLASS='boder-1' SIZE='4'
										onkeyup="value=value.replace(/[^\d]/g,'') "maxlength="4"style='text-align:center'> 年至<input
										id='yearEnd4' value=''
										CLASS='boder-1' SIZE='4'
										onkeyup="value=value.replace(/[^\d]/g,'') "maxlength="4"style='text-align:center'> 年</SPAN></TD>
								</TR>
								<TR>
									<TD height=15><SPAN class=text3>项目内容简述：（限300字）</SPAN></TD>
								</TR>
								<TR>
									<TD><textarea
										id='itemContent4' ROWS='6'
										COLS='100' CLASS='boder-1' ></textarea></TD>
								</TR>
							</TBODY>
						</TABLE>
						</TD>
					</TR>
					<TR>
						<TD class=unnamed4 vAlign=center align=middle width='6%' height=60><input style='text-align:center'
							name='query$form$0$JJHNJ_GYHDMX_SUB$xuhao$5' value='5'
							CLASS='boder-0' SIZE='3' readonly></TD>
						<TD>
						<TABLE cellSpacing=0 cellPadding=0 width='100%' border=0>
							<TBODY>
								<TR>
									<TD height=15><SPAN class=text3>项目名称 ： <input
										id ='JNAME5'
										value='' CLASS='boder-1' SIZE='70' maxlength="50"> </SPAN></TD>
								</TR>
								<TR>
									<TD height=15><SPAN class=text3>项目本年度收入：人民币<input
										id='income5' value=''
										CLASS='boder-1' SIZE='10' isMoney='true'
										style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.]/g,'') "maxlength="15">
									<span style="color:red">元</span>，项目本年度支出：人民币<input
										id='expend5' value=''
										CLASS='boder-1' SIZE='10' isMoney='true'
										style='text-align:right;padding-right:2px;' onblur='checkFloat(this);'onkeyup="value=value.replace(/[^\d.]/g,'') "maxlength="15">
									<span style="color:red">元</span>，执行年度：自<input id='year5'
										value='' CLASS='boder-1' SIZE='4'
										onkeyup="value=value.replace(/[^\d]/g,'') "maxlength="4"style='text-align:center'> 年至<input
										id='yearEnd5' value=''
										CLASS='boder-1' SIZE='4'
										onkeyup="value=value.replace(/[^\d]/g,'') "maxlength="4"style='text-align:center'> 年</SPAN></TD>
								</TR>
								<TR>
									<TD height=15><SPAN class=text3>项目内容简述：（限300字）</SPAN></TD>
								</TR>
								<TR>
									<TD><textarea
										id='itemContent5' ROWS='6'
										COLS='100' CLASS='boder-1' ></textarea></TD>
								</TR>
							</TBODY>
						</TABLE>
						</TD>
					</TR>
				</TBODY>
			</TABLE>
			</TD>
		</TR>
	</TBODY>
</TABLE>
<TABLE align='center'>
	<tr valign=bottom align='center'>
		<td width='100%' height='27' align=center valign=bottom><br>
		第13页</td>
	</tr>
</TABLE>

</form>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
</div>
</div>
</body>
</html>
