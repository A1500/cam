<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
 
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<script language="javascript">
//var taskCode='<%=request.getParameter("taskCode")%>';
//初始化
function init17(){
	var somCheckPublicActivitiesDataSet = L5.DatasetMgr.lookup("somCheckPublicActivitiesDataSet");
	somCheckPublicActivitiesDataSet.setParameter("TASK_CODE", taskCode);
	somCheckPublicActivitiesDataSet.load();
	somCheckPublicActivitiesDataSet.on('load',function(ds){
		var count = ds.getCount();
		if(count!=0){
			for(i=1;i<=count;i++){
				document.getElementById("times").innerHTML=ds.getAt(i-1).get("activityNum");
				document.getElementById("JNAME"+i).innerHTML=ds.getAt(i-1).get("itemName");
				document.getElementById("income"+i).innerHTML=ds.getAt(i-1).get("itemIn");
				document.getElementById("expend"+i).innerHTML=ds.getAt(i-1).get("itemOut");
				document.getElementById("year"+i).innerHTML=ds.getAt(i-1).get("itemYear");
				document.getElementById("yearEnd"+i).innerHTML=ds.getAt(i-1).get("itemYearEnd");
				document.getElementById("itemContent"+i).innerHTML=ds.getAt(i-1).get("itemContent");
			}
		}
	});
	//创建页面导航下拉框
	//createFundDetailSelect();
}
function save(){
	var dataset = getSomCheckPublicActivitiesDataSet();
	/*if(dataset.isValidate()!=true){
		L5.Msg.alert("提示",dataset.isValidate());
		return;
	}*/
	var records = dataset.getAllRecords();
	var command = new L5.Command("com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckCommand");
	command.setParameter("records", records);
	command.setParameter("taskCode", taskCode);
	command.execute("savePageJ17");
	if (!command.error) {
		L5.Msg.alert("提示","保存成功！",function(){
		});		
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
function getSomCheckPublicActivitiesDataSet(){
	var somCheckPublicActivitiesDataSet = L5.DatasetMgr.lookup("somCheckPublicActivitiesDataSet");
	somCheckPublicActivitiesDataSet.removeAll();
	for(var i = 1;i<=5;i++){
		var record= somCheckPublicActivitiesDataSet.newRecord();
		record.set("taskCode",taskCode);
		record.set("activityNum",document.getElementById("times").innerHTML);
		record.set("itemName",document.getElementById("JNAME"+i).innerHTML);
		record.set("itemIn",document.getElementById("income"+i).innerHTML);
		record.set("itemOut",document.getElementById("expend"+i).innerHTML);
		record.set("itemYear",document.getElementById("year"+i).innerHTML);
		record.set("itemYearEnd",document.getElementById("yearEnd"+i).innerHTML);
		record.set("itemContent",document.getElementById("itemContent"+i).innerHTML);
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
<model:datasets>
	<model:dataset id="somCheckPublicActivitiesDataSet" cmd="com.inspur.cams.sorg.jxcheck.somjxcommonwealdetail.cmd.SomJxCommonwealDetailQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxcommonwealdetail.dao.SomJxCommonwealDetail">
			<model:field name="itemContent" type="string" rule="length{100}"/>
		</model:record>
	</model:dataset>
</model:datasets>
<div id="float_1" class="noprint">

</div>
<div align=center style='page-break-after:always'>
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
			本年度本基金会共开展了（ <label name='query$form$0$JJHNJ_GYHDMX$huodongshu' 
			id  = "times" style='text-align:center;border-bottom: solid 1px;width:30;font-size: 16.0pt; font-family: 仿宋'></label> &nbsp;）项公益活动，具体情况如下：
			</TD>
		</TR>
		<TR>
			<TD>
			<TABLE class=unnamed1 cellSpacing=0 cellPadding=2 width='100%'
				border=0>
				<TBODY>
					<TR>
						<TD class=unnamed2 vAlign=center align=middle width='4%' height=60><label style='text-align:center;width: 55px'
							name='query$form$0$JJHNJ_GYHDMX_SUB$xuhao$1'
							CLASS='boder-0'>1</label></TD>
						<TD class=unnamed3 vAlign=top width='96%'>
						<TABLE cellSpacing=0 cellPadding=0 width='100%' border=0>
							<TBODY>
								<TR>
									<TD height=25><SPAN class=text3>项目名称 ： <label
										id ='JNAME1' CLASS='boder-1' style="border-bottom: solid 1px;width:250;font-size: 12.0pt; font-family: 宋体"></label> </SPAN></TD>
								</TR>
								<TR>
									<TD height=15><SPAN class=text3>项目本年度收入：人民币<label
										id='income1' CLASS='boder-1' style='text-align:right;border-bottom: solid 1px;width:50;font-size: 11.0pt; font-family: 宋体' ></label>
									<span style="color:red">万元</span>，项目本年度支出：人民币<label
										id='expend1' CLASS='boder-1'
										style='text-align:right;border-bottom: solid 1px;width:50;font-size: 11.0pt; font-family: 宋体'></label>
									<span style="color:red">万元</span>，执行年度：自<label id='year1'
										 CLASS='boder-1'  style='text-align:center;border-bottom: solid 1px;width:50;font-size: 11.0pt; font-family: 宋体' ></label> 年至<label
										id='yearEnd1' CLASS='boder-1' style='text-align:center;border-bottom: solid 1px;width:50;font-size: 11.0pt; font-family: 宋体'></label> 年</SPAN></TD>
								</TR>
								<TR>
									<TD height=15><SPAN class=text3>项目内容简述：（限300字）</SPAN></TD>
								</TR>
								<TR>
									<TD><textarea readonly="readonly"
										id='itemContent1' ROWS='6'
										COLS='100' CLASS='boder-1' ></textarea></TD>
								</TR>
							</TBODY>
						</TABLE>
						</TD>
					</TR>
					<TR>
						<TD class=unnamed2 vAlign=center align=middle width='6%' height=60><label style='text-align:center;width: 55px'
							name='query$form$0$JJHNJ_GYHDMX_SUB$xuhao$2' 
							CLASS='boder-0'>2</label></TD>
						<TD class=unnamed3 vAlign=top width='94%'>
						<TABLE cellSpacing=0 cellPadding=0 width='100%' border=0>
							<TBODY>
								<TR>
									<TD height=25><SPAN class=text3>项目名称 ： <label
										id ='JNAME2' CLASS='boder-1' style="border-bottom: solid 1px;width:250;font-size: 12.0pt; font-family: 宋体"></label> </SPAN></TD>
								</TR>
								<TR>
									<TD height=15><SPAN class=text3>项目本年度收入：人民币<label
										id='income2' CLASS='boder-1' 
										style='text-align:right;border-bottom: solid 1px;width:50;font-size: 11.0pt; font-family: 宋体' ></label>
									<span style="color:red">万元</span>，项目本年度支出：人民币<label
										id='expend2' CLASS='boder-1' 
										style='text-align:right;border-bottom: solid 1px;width:50;font-size: 11.0pt; font-family: 宋体' ></label>
									<span style="color:red">万元</span>，执行年度：自<label id='year2' CLASS='boder-1'
										style='text-align:right;border-bottom: solid 1px;width:50;font-size: 11.0pt; font-family: 宋体' ></label> 年至<label
										id='yearEnd2' CLASS='boder-1'
										style='text-align:right;border-bottom: solid 1px;width:50;font-size: 11.0pt; font-family: 宋体' ></label> 年</SPAN></TD>
								</TR>
								<TR>
									<TD height=15><SPAN class=text3>项目内容简述：（限300字）</SPAN></TD>
								</TR>
								<TR>
									<TD><textarea readonly="readonly"
										id='itemContent2' ROWS='6'
										COLS='100' CLASS='boder-1' ></textarea></TD>
								</TR>
							</TBODY>
						</TABLE>
						</TD>
					</TR>
					<TR>
						<TD class=unnamed2 vAlign=center align=middle width='6%' height=60><label style='text-align:center;width: 55px'
							name='query$form$0$JJHNJ_GYHDMX_SUB$xuhao$3'
							CLASS='boder-0' >3</label></TD>
						<TD class=unnamed3 vAlign=top width='94%'>
						<TABLE cellSpacing=0 cellPadding=0 width='100%' border=0>
							<TBODY>
								<TR>
									<TD height=25><SPAN class=text3>项目名称 ： <label
										id ='JNAME3' CLASS='boder-1' style="border-bottom: solid 1px;width:250;font-size: 12.0pt; font-family: 宋体"></label> </SPAN></TD>
								</TR>
								<TR>
									<TD height=15><SPAN class=text3>项目本年度收入：人民币<label
										id='income3'  CLASS='boder-1'
										style='text-align:right;border-bottom: solid 1px;width:50;font-size: 11.0pt; font-family: 宋体' ></label>
									<span style="color:red">万元</span>，项目本年度支出：人民币<label
										id='expend3' CLASS='boder-1'
										style='text-align:right;border-bottom: solid 1px;width:50;font-size: 11.0pt; font-family: 宋体' ></label>
									<span style="color:red">万元</span>，执行年度：自<label id='year3' CLASS='boder-1'
										style='text-align:right;border-bottom: solid 1px;width:50;font-size: 11.0pt; font-family: 宋体' ></label> 年至<label
										id='yearEnd3'  CLASS='boder-1'
										style='text-align:right;border-bottom: solid 1px;width:50;font-size: 11.0pt; font-family: 宋体' ></label> 年</SPAN></TD>
								</TR>
								<TR>
									<TD height=15><SPAN class=text3>项目内容简述：（限300字）</SPAN></TD>
								</TR>
								<TR>
									<TD><textarea readonly="readonly"
										id='itemContent3' ROWS='6'
										COLS='100' CLASS='boder-1' ></textarea></TD>
								</TR>
							</TBODY>
						</TABLE>
						</TD>
					</TR>
					<TR>
						<TD class=unnamed2 vAlign=center align=middle width='6%' height=60><label style='text-align:center;width: 55px'
							name='query$form$0$JJHNJ_GYHDMX_SUB$xuhao$4'
							CLASS='boder-0'>4</label></TD>
						<TD class=unnamed3 vAlign=top width='94%'>
						<TABLE cellSpacing=0 cellPadding=0 width='100%' border=0>
							<TBODY>
								<TR>
									<TD height=25><SPAN class=text3>项目名称 ： <label
										id ='JNAME4' CLASS='boder-1' style='text-align:right;border-bottom: solid 1px;width:250;font-size: 12.0pt; font-family: 宋体' ></label> </SPAN></TD>
								</TR>
								<TR>
									<TD height=15><SPAN class=text3>项目本年度收入：人民币<label
										id='income4' CLASS='boder-1' 
										style='text-align:right;border-bottom: solid 1px;width:50;font-size: 11.0pt; font-family: 宋体' ></label>
									<span style="color:red">万元</span>，项目本年度支出：人民币<label
										id='expend4' CLASS='boder-1' 
										style='text-align:right;border-bottom: solid 1px;width:50;font-size: 11.0pt; font-family: 宋体' ></label>
									<span style="color:red">万元</span>，执行年度：自<label id='year4'
										 CLASS='boder-1' 
										style='text-align:right;border-bottom: solid 1px;width:50;font-size: 11.0pt; font-family: 宋体' ></label> 年至<label
										id='yearEnd4' CLASS='boder-1' 
										style='text-align:right;border-bottom: solid 1px;width:50;font-size: 11.0pt; font-family: 宋体' ></label> 年</SPAN></TD>
								</TR>
								<TR>
									<TD height=15><SPAN class=text3>项目内容简述：（限300字）</SPAN></TD>
								</TR>
								<TR>
									<TD><textarea readonly="readonly"
										id='itemContent4' ROWS='6'
										COLS='100' CLASS='boder-1' ></textarea></TD>
								</TR>
							</TBODY>
						</TABLE>
						</TD>
					</TR>
					<TR>
						<TD class=unnamed4 vAlign=center align=middle width='6%' height=60><label style='text-align:center;width: 55px'
							name='query$form$0$JJHNJ_GYHDMX_SUB$xuhao$5'
							CLASS='boder-0' >5</label></TD>
						<TD>
						<TABLE cellSpacing=0 cellPadding=0 width='100%' border=0>
							<TBODY>
								<TR>
									<TD height=15><SPAN class=text3>项目名称 ： <label
										id ='JNAME5'
										 CLASS='boder-1' style='text-align:right;border-bottom: solid 1px;width:250;font-size: 12.0pt; font-family: 宋体' ></label> </SPAN></TD>
								</TR>
								<TR>
									<TD height=15><SPAN class=text3>项目本年度收入：人民币<label
										id='income5' CLASS='boder-1'
										style='text-align:right;border-bottom: solid 1px;width:50;font-size: 11.0pt; font-family: 宋体' ></label>
									<span style="color:red">万元</span>，项目本年度支出：人民币<label
										id='expend5' CLASS='boder-1' 
										style='text-align:right;border-bottom: solid 1px;width:50;font-size: 11.0pt; font-family: 宋体' ></label>
									<span style="color:red">万元</span>，执行年度：自<label id='year5'  CLASS='boder-1' 
										style='text-align:right;border-bottom: solid 1px;width:50;font-size: 11.0pt; font-family: 宋体' ></label> 年至<label
										id='yearEnd5' CLASS='boder-1' 
										style='text-align:right;border-bottom: solid 1px;width:50;font-size: 11.0pt; font-family: 宋体' ></label> 年</SPAN></TD>
								</TR>
								<TR>
									<TD height=15><SPAN class=text3>项目内容简述：（限300字）</SPAN></TD>
								</TR>
								<TR>
									<TD><textarea readonly="readonly"
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
		</td>
	</tr>
</TABLE>

</form>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
</div>
</div>
