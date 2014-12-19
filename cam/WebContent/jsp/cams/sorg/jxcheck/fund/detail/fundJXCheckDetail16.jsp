<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<html>

<head>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<title>基 金 会</title>
<next:ScriptManager />
<script type="text/javascript" src="../../js/float.js"></script>
<link href="../../css/float.css" type="text/css" rel="stylesheet" />
<script language="javascript">
var taskCode='<%=request.getParameter("taskCode")%>';
//初始化
function init(){
	var somJxLargeDonationDataSet = L5.DatasetMgr.lookup("somJxLargeDonationDataSet");
	somJxLargeDonationDataSet.setParameter("TASK_CODE@=", taskCode);
	somJxLargeDonationDataSet.load();
	somJxLargeDonationDataSet.on("load",function(ds){
		if(ds.getCount()!=0){
			for(i=1;i<=ds.getCount();i++){
				document.getElementById("donorName"+i).innerHTML=ds.getAt(i-1).get("donorName");
				document.getElementById("moneyCash"+i).innerHTML=ds.getAt(i-1).get("moneyCash");
				document.getElementById("moneyPurpose"+i).innerHTML=ds.getAt(i-1).get("moneyPurpose");
				document.getElementById("goodsCash"+i).innerHTML=ds.getAt(i-1).get("goodsCash");
				document.getElementById("goodsPurpose"+i).innerHTML=ds.getAt(i-1).get("goodsPurpose");
			}
		}
		setSumMoney();
	});
	//创建页面导航下拉框
	createFundDetailSelect();
}
function save(){
	somJxLargeDonationDataSet.removeAll();
	for(i=1;i<=10;i++){
		var record = somJxLargeDonationDataSet.newRecord();
		record.set("donorName",document.getElementById("donorName"+i).value);
		record.set("moneyCash",document.getElementById("moneyCash"+i).value);
		record.set("moneyPurpose",document.getElementById("moneyPurpose"+i).value);
		record.set("goodsCash",document.getElementById("goodsCash"+i).value);
		record.set("goodsPurpose",document.getElementById("goodsPurpose"+i).value);
	}
	var somJxLargeDonationRecords=somJxLargeDonationDataSet.getAllRecords();
	var command = new L5.Command("com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckCommand");
	command.setParameter("somJxLargeDonationRecords", somJxLargeDonationRecords);
	command.setParameter("taskCode", taskCode);
	command.execute("savePageJ16");
	if (!command.error) {
		L5.Msg.alert("提示","保存成功！",function(){
		});
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
function setSumMoney(){
	for(var i=1;i<=10;i++){
		document.getElementById("子表1.本年捐赠额$"+i).innerHTML=setParseFloat("moneyCash"+i,"goodsCash"+i);
		document.getElementById("合计本年捐赠额").innerHTML=setParseFloat("合计本年捐赠额","子表1.本年捐赠额$"+i);
	}
}
function setParseFloat(id1,id2){
	var value1 = document.getElementById(id1).innerHTML;
	var value2 = document.getElementById(id2).innerHTML;
	if(!value1){
		value1 = 0;
	}else{
		value1 = parseFloat(value1);
	}
	if(!value2){
		value2 = 0;
	}else{
		value2 = parseFloat(value2);
	}
	return (value1+value2);
}
function docPrint(){
		        document.execCommand("Print", false);
		    }
</script>
<style media="print">
	.noprint     { display: none }
</style>
<script>
function textCounter(field, maxlimit) {
    if (field.value.length > maxlimit)
	field.value = field.value.substring(0, maxlimit);
}
function setSubSum(numflag){
      var preName = "query$form$0$JJHNJ_YEWHDDAEJZPAGE_SUB$";
      var sum1=0;
      var obj1= document.getElementById(preName + "juankuan$" + numflag);
      if(obj1.innerHTML != ""){
              sum1 += parseFloat(obj1.innerHTML);
           }
      var obj2= document.getElementById(preName + "juanwu$"+ numflag);
      if(obj2.innerHTML != ""){
              sum1 += parseFloat(obj2.innerHTML);
           }

    	document.getElementById(preName + "bennianjuanzenge$"+numflag).innerHTML=sum1;


    //总合计值
    var preName1 = "query$form$0$JJHNJ_YEWHDDAEJZPAGE$";
    var leixing = "hejibennianjuanzenge";
    var totalsum = 0;
    for(i=1;i<=10;i++){
       var obj =  document.all(preName + "bennianjuanzenge$" +i);
           if(obj.value != ""){
              totalsum += parseFloat(obj.value);
           }
      }
    document.all(preName1 + leixing ).value = totalsum;

 }
</script>
<STYLE>
textarea {
	overflow-x: hidden;
	overflow-y: hidden;
}

.margin-0 {
	margin: 0px;
}

.word-zhx {
	text-decoration: line-through;
}

.word {
	font-family: '黑体', '宋体';
	font-size: 20px;
}

.word-1 {
	font-family: '黑体', '宋体';
	font-size: 32px;
}

.word-2 {
	font-family: '黑体', '宋体';
	font-size: 26px;
}

.word-fs-bt {
	font-size: 24px;
	font-family: '楷体_GB2312', '宋体', '黑体';
	font-weight: bold;
}

.word-fs {
	font-size: 16px;
	font-family: '楷体_GB2312', '宋体', '黑体';
}

.word-fs-14 {
	font-size: 15px;
	font-family: '楷体_GB2312', '宋体', '黑体';
}

.word-fs-13 {
	font-size: 14px;
	font-family: '宋体', '黑体';
}

.word-st-14 {
	font-size: 14px;
	font-family: '宋体';
}

.word-st-12 {
	font-size: 12px;
	font-family: '宋体';
}

.pad-t-b-7 {
	padding-top: 7px;
	padding-bottom: 7px;
}

.pad-t-25 {
	padding-top: 25px;
}

.pad-t-30 {
	padding-top: 10px;
}

.pad-t-10 {
	padding-top: 10px;
}

.pad-l-15 {
	padding-left: 15px;
}

.pad-r-100 {
	padding-right: 100px;
}

.pad-b {
	padding-bottom: 10px;
}

.pad-l-10 {
	padding-left: 10px;
}

.div-b-line {
	border-bottom: 1px solid #000;
}

.input-b-trl {
	border-top: 0px;
	border-left: 0px;
	border-right: 0px;
}

.border-lrb {
	border: 1px solid #000;
	border-top: 0px;
}

.border-r {
	border-right: 1px solid #000;
}

.border-q {
	border: 1px solid #000;
}

.border-tl {
	border-top: 1px solid #000;
	border-left: 1px solid #000;
}

.backcolor {
	background-color: #000;
}

.input-d {
	width: 90%;
	height: 35px;
	line-height: 23px;
	border: 0px;
	overflow: hidden;
}

.input-x {
	border: 0px;
	width: 96%;
	text-align: center
}

.input-t {
	border: 0px;
	width: 96%;
	text-align: left;
}

.input-c-b {
	border: 0px;
	text-align: center;
}

#table1 td {
	border-right: 1px solid #000;
	border-bottom: 1px solid #000
}

.input-01 {
	font-family: '宋体';
	font-size: 14px;
	color: #000000;
}

.input-02 {
	font-family: '宋体';
	font-size: 12px;
	color: #000000;
	border-top-width: 0px;
	border-right-width: 0px;
	border-bottom-width: 0px;
	border-left-width: 0px;
	border-top-style: none;
	border-right-style: none;
	border-bottom-style: none;
	border-left-style: none;
}  /*14号字体 表格样式*/
.f14pt-boder1 { /*整体边框*/
	border: 1px solid #000000;
	font-size: 14px;
}

.f14pt-boder2 { /*右底边框*/
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	border-right-width: 1px;
	border-right-style: solid;
	border-right-color: #000000;
	font-size: 14px;
}

.f14pt-boder3 { /*底边框*/
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	font-size: 14px;
	border-top-style: none;
	border-right-style: none;
	border-left-style: none;
}

.f14pt-boder4 { /*右边框*/
	border-right-width: 1px;
	border-right-style: solid;
	border-right-color: #000000;
	font-size: 14px;
}
</STYLE>
</head>

<body>
<model:datasets>
	<model:dataset id="somJxLargeDonationDataSet" cmd="com.inspur.cams.sorg.jxcheck.somjxlargedonation.cmd.SomJxLargeDonationQueryCommand" global="true" >
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxlargedonation.dao.SomJxLargeDonation"></model:record>
	</model:dataset>
</model:datasets>
<div id="float" class="noprint">
	<input type="button" value="下一页" style="height: 25px; width: 80px; position: absolute; margin-left: 120px;" onclick="nextPageJ1('17')" />
	<input type="button" value="上一页" style="height: 25px; width: 80px; position: absolute; margin-left: 20px;" onclick="nextPageJ1('15')" />
	<input  type="button" value="打印" style="height:25px;width:80px;position:absolute;margin-left:220px;" onclick="docPrint();"/>
</div>
<div align=center>
<div align=center style="width: 800px">
<form dataset="" name="myform" method="post" onsubmit="return false">
<TABLE cellSpacing=0 cellPadding=0 width=645 align=center border=0>
	<TBODY>
		<TR>
			<TD height=51><STRONG class=word-st-14>（四）大额捐赠收入情况</STRONG></TD>
		</TR>
		<TR>
			<TD height=27><STRONG> <SPAN class=word-st-14>本表列示累计捐款超过基金会当年捐赠收入5%以上的捐赠单位或个人：</SPAN></STRONG></TD>
		</TR>
	</TBODY>
</TABLE>
<TABLE class='word-st-14 border-tl' id=table1 cellSpacing=0
	cellPadding=0 width=735 align=center border=0>
	<TBODY>
		<TR>
			<TD align=middle width='275' height=24><STRONG>捐赠人</STRONG></TD>
			<TD align=middle width='134'height=24><STRONG>本年捐赠额（<span style="color:red">元</span>）</STRONG></TD>
			<TD align=middle width='330'height=24><STRONG>用途</STRONG></TD>
		</TR>
		<TR>
			<TD height=24>1.&nbsp;<label
				name='query$form$0$JJHNJ_YEWHDDAEJZPAGE_SUB$juanzengren$1'
				ID='donorName1' CLASS='input-01' style='text-align: right'></label>
			</TD>
			<TD align=middle height=24>&nbsp; <label
				name='query$form$0$JJHNJ_YEWHDDAEJZPAGE_SUB$bennianjuanzenge$1'
				 ID='子表1.本年捐赠额$1' CLASS='input-01'
				style='text-align: right'></label>
			</TD>
			<TD align=middle height=24>&nbsp;<label
				name='query$form$0$JJHNJ_YEWHDDAEJZPAGE_SUB$yongtu$1'
				ID='子表1.用途$1' CLASS='input-01'></label>
			</TD>
		</TR>
		<TR>
			<TD align=middle height=24>其中：捐款</TD>
			<TD align=middle height=24>&nbsp; <label
				name='query$form$0$JJHNJ_YEWHDDAEJZPAGE_SUB$juankuan$1'
				ID='moneyCash1' CLASS='input-01' style='text-align: right'></label></TD>
			<TD align=middle height=24>&nbsp;<label
				name='query$form$0$JJHNJ_YEWHDDAEJZPAGE_SUB$juankuanyongtu$1'
				 ID='moneyPurpose1' CLASS='input-01' ></label></TD>
		</TR>
		<TR>
			<TD align=middle height=24>捐物</TD>
			<TD align=middle height=24>&nbsp; <label
				name='query$form$0$JJHNJ_YEWHDDAEJZPAGE_SUB$juanwu$1'
				ID='goodsCash1' CLASS='input-01' SIZE='15' style='text-align: right'></label></TD>
			<TD align=middle height=24>&nbsp; <label
				name='query$form$0$JJHNJ_YEWHDDAEJZPAGE_SUB$juanwuyongtu$1'
				ID='goodsPurpose1' CLASS='input-01'></label>
			</TD>
		</TR>
		<TR>
			<TD height=24>2.&nbsp; <label
				name='query$form$0$JJHNJ_YEWHDDAEJZPAGE_SUB$juanzengren$2'
				ID='donorName2' CLASS='input-01'></label>
			</TD>
			<TD align=middle height=24>&nbsp; <label
				name='query$form$0$JJHNJ_YEWHDDAEJZPAGE_SUB$bennianjuanzenge$2'
				ID='子表1.本年捐赠额$2' CLASS='input-01' style='text-align: right'></label>
			</TD>
			<TD align=middle height=24>&nbsp; <label
				name='query$form$0$JJHNJ_YEWHDDAEJZPAGE_SUB$yongtu$2'
				ID='子表1.用途$2' CLASS='input-01'></label>
			</TD>
		</TR>
		<TR>
			<TD align=middle height=24>其中：捐款</TD>
			<TD align=middle height=24>&nbsp; <label
				name='query$form$0$JJHNJ_YEWHDDAEJZPAGE_SUB$juankuan$2'
				ID='moneyCash2' CLASS='input-01' style='text-align: right'></label></TD>
			<TD align=middle height=24>&nbsp; <label
				name='query$form$0$JJHNJ_YEWHDDAEJZPAGE_SUB$juankuanyongtu$2'
				 ID='moneyPurpose2' CLASS='input-01' ></label></TD>
		</TR>
		<TR>
			<TD align=middle height=24>捐物</TD>
			<TD align=middle height=24>&nbsp; <label
				name='query$form$0$JJHNJ_YEWHDDAEJZPAGE_SUB$juanwu$2'
				ID='goodsCash2' CLASS='input-01' style='text-align: right'></label></TD>
			<TD align=middle height=24>&nbsp; <label
				name='query$form$0$JJHNJ_YEWHDDAEJZPAGE_SUB$juanwuyongtu$2'
				ID='goodsPurpose2' CLASS='input-01' ></label>
			</TD>
		</TR>
		<TR>
			<TD height=24>3.&nbsp;<label
				name='query$form$0$JJHNJ_YEWHDDAEJZPAGE_SUB$juanzengren$3'
				ID='donorName3' CLASS='input-01' ></label>
			</TD>
			<TD align=middle height=24>&nbsp; <label
				name='query$form$0$JJHNJ_YEWHDDAEJZPAGE_SUB$bennianjuanzenge$3'
				 ID='子表1.本年捐赠额$3' CLASS='input-01' ></label>
			</TD>
			<TD align=middle height=24>&nbsp;<label
				name='query$form$0$JJHNJ_YEWHDDAEJZPAGE_SUB$yongtu$3'
				ID='子表1.用途$3' CLASS='input-01' ></label>
			</TD>
		</TR>
		<TR>
			<TD align=middle height=24>其中：捐款</TD>
			<TD align=middle height=24>&nbsp; <label
				name='query$form$0$JJHNJ_YEWHDDAEJZPAGE_SUB$juankuan$3'
				ID='moneyCash3' CLASS='input-01' style='text-align: right'></label></TD>
			<TD align=middle height=24>&nbsp;<label
				name='query$form$0$JJHNJ_YEWHDDAEJZPAGE_SUB$juankuanyongtu$3'
				 ID='moneyPurpose3' CLASS='input-01' ></label></TD>
		</TR>
		<TR>
			<TD align=middle height=24>捐物</TD>
			<TD align=middle height=24>&nbsp; <label
				name='query$form$0$JJHNJ_YEWHDDAEJZPAGE_SUB$juanwu$3'
				ID='goodsCash3' CLASS='input-01' style='text-align: right'></label></TD>
			<TD align=middle height=24>&nbsp;<label
				name='query$form$0$JJHNJ_YEWHDDAEJZPAGE_SUB$juanwuyongtu$3'
				ID='goodsPurpose3' CLASS='input-01' ></label>
			</TD>
		</TR>
		<TR>
			<TD height=24>4.&nbsp;<label
				name='query$form$0$JJHNJ_YEWHDDAEJZPAGE_SUB$juanzengren$4'
				ID='donorName4' CLASS='input-01'  ></label>
			</TD>
			<TD align=middle height=24>&nbsp; <label
				name='query$form$0$JJHNJ_YEWHDDAEJZPAGE_SUB$bennianjuanzenge$4'
				 ID='子表1.本年捐赠额$4' CLASS='input-01' style='text-align: right' ></label>
			</TD>
			<TD align=middle height=24>&nbsp;<label
				name='query$form$0$JJHNJ_YEWHDDAEJZPAGE_SUB$yongtu$4'
				ID='子表1.用途$4' CLASS='input-01' ></label>
			</TD>
		</TR>
		<TR>
			<TD align=middle height=24>其中：捐款</TD>
			<TD align=middle height=24>&nbsp; <label
				name='query$form$0$JJHNJ_YEWHDDAEJZPAGE_SUB$juankuan$4'
				ID='moneyCash4' CLASS='input-01' style='text-align: right'></label></TD>
			<TD align=middle height=24>&nbsp;<label
				name='query$form$0$JJHNJ_YEWHDDAEJZPAGE_SUB$juankuanyongtu$4'
				ID='moneyPurpose4' CLASS='input-01'></label></TD>
		</TR>
		<TR>
			<TD align=middle height=24>捐物</TD>
			<TD align=middle height=24>&nbsp; <label
				name='query$form$0$JJHNJ_YEWHDDAEJZPAGE_SUB$juanwu$4'
				ID='goodsCash4' CLASS='input-01' style='text-align: right'></label></TD>
			<TD align=middle height=24>&nbsp; <label
				name='query$form$0$JJHNJ_YEWHDDAEJZPAGE_SUB$juanwuyongtu$4'
				ID='goodsPurpose4' CLASS='input-01' ></label>
			</TD>
		</TR>
		<TR>
			<TD height=24>5.&nbsp;<label
				name='query$form$0$JJHNJ_YEWHDDAEJZPAGE_SUB$juanzengren$5'
				ID='donorName5' CLASS='input-01'  ></label>
			</TD>
			<TD align=middle height=24>&nbsp; <label
				name='query$form$0$JJHNJ_YEWHDDAEJZPAGE_SUB$bennianjuanzenge$5'
				 ID='子表1.本年捐赠额$5' CLASS='input-01' style='text-align: right'></label>
			</TD>
			<TD align=middle height=24>&nbsp;<label
				name='query$form$0$JJHNJ_YEWHDDAEJZPAGE_SUB$yongtu$5'
				ID='子表1.用途$5' CLASS='input-01'></label>
			</TD>
		</TR>
		<TR>
			<TD align=middle height=24>其中：捐款</TD>
			<TD align=middle height=24>&nbsp; <label
				name='query$form$0$JJHNJ_YEWHDDAEJZPAGE_SUB$juankuan$5'
				ID='moneyCash5' CLASS='input-01'  style='text-align: right'></label></TD>
			<TD align=middle height=24>&nbsp;<label
				name='query$form$0$JJHNJ_YEWHDDAEJZPAGE_SUB$juankuanyongtu$5'
				ID='moneyPurpose5' CLASS='input-01' ></label></TD>
		</TR>
		<TR>
			<TD align=middle height=24>捐物</TD>
			<TD align=middle height=24>&nbsp; <label
				name='query$form$0$JJHNJ_YEWHDDAEJZPAGE_SUB$juanwu$5'
				ID='goodsCash5' CLASS='input-01' style='text-align: right'></label></TD>
			<TD align=middle height=24>&nbsp;<label
				name='query$form$0$JJHNJ_YEWHDDAEJZPAGE_SUB$juanwuyongtu$5'
				ID='goodsPurpose5' CLASS='input-01' ></label>
			</TD>
		</TR>
		<TR>
			<TD height=24>6.&nbsp;<STRONG><label
				name='query$form$0$JJHNJ_YEWHDDAEJZPAGE_SUB$juanzengren$6'
				ID='donorName6' CLASS='input-01' ></label>
			</STRONG></TD>
			<TD align=middle height=24>&nbsp; <STRONG><label
				name='query$form$0$JJHNJ_YEWHDDAEJZPAGE_SUB$bennianjuanzenge$6'
				 ID='子表1.本年捐赠额$6' CLASS='input-01' style='text-align: right'></label>
			</STRONG></TD>
			<TD align=middle height=24>&nbsp; <label
				name='query$form$0$JJHNJ_YEWHDDAEJZPAGE_SUB$yongtu$6'
				ID='子表1.用途$6' CLASS='input-01'  ></label>
			</TD>
		</TR>
		<TR>
			<TD align=middle height=24>其中：捐款</TD>
			<TD align=middle height=24>&nbsp; <label
				name='query$form$0$JJHNJ_YEWHDDAEJZPAGE_SUB$juankuan$6'
				ID='moneyCash6' CLASS='input-01' style='text-align: right'></label></TD>
			<TD align=middle height=24>&nbsp;<label
				 ID='moneyPurpose6' CLASS='input-01'></label></TD>
		</TR>
		<TR>
			<TD align=middle height=24>捐物</TD>
			<TD align=middle height=24>&nbsp; <label
				name='query$form$0$JJHNJ_YEWHDDAEJZPAGE_SUB$juanwu$6'
				ID='goodsCash6' CLASS='input-01' style='text-align: right'></label></TD>
			<TD align=middle height=24>&nbsp; <label
				name='query$form$0$JJHNJ_YEWHDDAEJZPAGE_SUB$juanwuyongtu$6'
				ID='goodsPurpose6' CLASS='input-01' ></label>
			</TD>
		</TR>
		<TR>
			<TD height=24>7.&nbsp;<STRONG><label
				name='query$form$0$JJHNJ_YEWHDDAEJZPAGE_SUB$juanzengren$7'
				ID='donorName7' CLASS='input-01'></label>
			</STRONG></TD>
			<TD align=middle height=24>&nbsp; <STRONG><label
				name='query$form$0$JJHNJ_YEWHDDAEJZPAGE_SUB$bennianjuanzenge$7'
				 ID='子表1.本年捐赠额$7' CLASS='input-01' style='text-align: right'></label>
			</STRONG></TD>
			<TD align=middle height=24>&nbsp;<label
				name='query$form$0$JJHNJ_YEWHDDAEJZPAGE_SUB$yongtu$7'
				ID='子表1.用途$7' CLASS='input-01' ></label>
			</TD>
		</TR>
		<TR>
			<TD align=middle height=24>其中：捐款</TD>
			<TD align=middle height=24>&nbsp; <label
				name='query$form$0$JJHNJ_YEWHDDAEJZPAGE_SUB$juankuan$7'
				ID='moneyCash7' CLASS='input-01' style='text-align: right'></label></TD>
			<TD align=middle height=24>&nbsp;<label
				name='query$form$0$JJHNJ_YEWHDDAEJZPAGE_SUB$juankuanyongtu$7'
				 ID='moneyPurpose7' CLASS='input-01'></label></TD>
		</TR>
		<TR>
			<TD align=middle height=24>捐物</TD>
			<TD align=middle height=24>&nbsp; <label
				name='query$form$0$JJHNJ_YEWHDDAEJZPAGE_SUB$juanwu$7'
				ID='goodsCash7' CLASS='input-01' style='text-align: right'></label></TD>
			<TD align=middle height=24>&nbsp;<label
				name='query$form$0$JJHNJ_YEWHDDAEJZPAGE_SUB$juanwuyongtu$7'
				ID='goodsPurpose7' CLASS='input-01'></label>
			</TD>
		</TR>
		<TR>
			<TD height=24>8.&nbsp;<STRONG><label
				name='query$form$0$JJHNJ_YEWHDDAEJZPAGE_SUB$juanzengren$8'
				ID='donorName8' CLASS='input-01'></label>
			</STRONG></TD>
			<TD align=middle height=24>&nbsp; <STRONG><label
				name='query$form$0$JJHNJ_YEWHDDAEJZPAGE_SUB$bennianjuanzenge$8'
				ID='子表1.本年捐赠额$8' CLASS='input-01' style='text-align: right'></label>
			</STRONG></TD>
			<TD align=middle height=24>&nbsp;<label
				name='query$form$0$JJHNJ_YEWHDDAEJZPAGE_SUB$juankuanyongtu$8'
				 ID='' CLASS='input-01'></label></TD>
		</TR>
		<TR>
			<TD align=middle height=24>其中：捐款</TD>
			<TD align=middle height=24>&nbsp; <label
				name='query$form$0$JJHNJ_YEWHDDAEJZPAGE_SUB$juankuan$8'
				ID='moneyCash8' CLASS='input-01' style='text-align: right'></label></TD>
			<TD align=middle height=24>&nbsp;<label
				name='query$form$0$JJHNJ_YEWHDDAEJZPAGE_SUB$juankuanyongtu$8'
				 ID='moneyPurpose8' CLASS='input-01' ></label></TD>
		</TR>
		<TR>
			<TD align=middle height=24>捐物</TD>
			<TD align=middle height=24>&nbsp; <label
				name='query$form$0$JJHNJ_YEWHDDAEJZPAGE_SUB$juanwu$8'
				ID='goodsCash8' CLASS='input-01' style='text-align: right'></label></TD>
			<TD align=middle height=24>&nbsp; <label
				name='query$form$0$JJHNJ_YEWHDDAEJZPAGE_SUB$juanwuyongtu$8'
				ID='goodsPurpose8' CLASS='input-01'  ></label>
			</TD>
		</TR>
		<TR>
			<TD height=24>9.&nbsp; <STRONG><label
				name='query$form$0$JJHNJ_YEWHDDAEJZPAGE_SUB$juanzengren$9'
				ID='donorName9' CLASS='input-01' ></label>
			</STRONG></TD>
			<TD align=middle height=24>&nbsp; <STRONG><label
				name='query$form$0$JJHNJ_YEWHDDAEJZPAGE_SUB$bennianjuanzenge$9'
				 ID='子表1.本年捐赠额$9' CLASS='input-01' style='text-align: right'></label>
			</STRONG></TD>
			<TD align=middle height=24>&nbsp; <label
				name='query$form$0$JJHNJ_YEWHDDAEJZPAGE_SUB$juankuanyongtu$9'
				 ID='' CLASS='input-01'></label></TD>
		</TR>
		<TR>
			<TD align=middle height=24>其中：捐款</TD>
			<TD align=middle height=24>&nbsp; <label
				name='query$form$0$JJHNJ_YEWHDDAEJZPAGE_SUB$juankuan$9'
				ID='moneyCash9' CLASS='input-01' style='text-align: right'></label></TD>
			<TD align=middle height=24>&nbsp; <label
				name='query$form$0$JJHNJ_YEWHDDAEJZPAGE_SUB$juankuanyongtu$9'
				 ID='moneyPurpose9' CLASS='input-01' ></label></TD>
		</TR>
		<TR>
			<TD align=middle height=24>捐物</TD>
			<TD align=middle height=24>&nbsp; <label
				name='query$form$0$JJHNJ_YEWHDDAEJZPAGE_SUB$juanwu$9'
				ID='goodsCash9' CLASS='input-01' style='text-align: right'></label></TD>
			<TD align=middle height=24>&nbsp; <label
				name='query$form$0$JJHNJ_YEWHDDAEJZPAGE_SUB$juanwuyongtu$9'
				ID='goodsPurpose9' CLASS='input-01'></label>
			</TD>
		</TR>
		<TR>
			<TD height=24>10.&nbsp; <STRONG><label
				name='query$form$0$JJHNJ_YEWHDDAEJZPAGE_SUB$juanzengren$10'
				ID='donorName10' CLASS='input-01'></label>
			</STRONG></TD>
			<TD align=middle height=24>&nbsp; <STRONG><label
				name='query$form$0$JJHNJ_YEWHDDAEJZPAGE_SUB$bennianjuanzenge$10'
				 ID='子表1.本年捐赠额$10' CLASS='input-01' style='text-align: right' ></label>
			</STRONG></TD>
			<TD align=middle height=24>&nbsp;<label
				name='query$form$0$JJHNJ_YEWHDDAEJZPAGE_SUB$juankuanyongtu$10'
				 ID='' CLASS='input-01'></label></TD>
		</TR>
		<TR>
			<TD align=middle height=24>其中：捐款</TD>
			<TD align=middle height=24>&nbsp; <label
				name='query$form$0$JJHNJ_YEWHDDAEJZPAGE_SUB$juankuan$10'
				ID='moneyCash10' CLASS='input-01' style='text-align: right'></label></TD>
			<TD align=middle height=24>&nbsp;<label
				name='query$form$0$JJHNJ_YEWHDDAEJZPAGE_SUB$juankuanyongtu$10'
				ID='moneyPurpose10' CLASS='input-01'></label></TD>
		</TR>
		<TR>
			<TD align=middle height=24>捐物</TD>
			<TD align=middle height=24>&nbsp; <label
				name='query$form$0$JJHNJ_YEWHDDAEJZPAGE_SUB$juanwu$10'
				ID='goodsCash10' CLASS='input-01' style='text-align: right'></label></TD>
			<TD align=middle height=24>&nbsp; <label
				name='query$form$0$JJHNJ_YEWHDDAEJZPAGE_SUB$juanwuyongtu$10'
				 ID='goodsPurpose10' CLASS='input-01'></label></TD>
		</TR>
		<TR>
			<TD align=middle height=24>合计</TD>
			<TD align=middle height=24>&nbsp; <label
				name='query$form$0$JJHNJ_YEWHDDAEJZPAGE$hejibennianjuanzenge'
				 ID='合计本年捐赠额' CLASS='input-01' style='text-align: right' ></label></TD>
			<TD align=middle height=24>&nbsp; <label
				name='query$form$0$JJHNJ_YEWHDDAEJZPAGE$hejiyongtu'
				ID='合计用途' CLASS='input-01' style='text-align: right'  ></label>
			</TD>
		</TR>
	</TBODY>
</TABLE>
<TABLE align='center'>
	<tr valign=bottom align='center'>
		<td width='100%' height='27' align=center valign=bottom><br>
		第12页</td>
	</tr>
</TABLE>

</form>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
</div>
</div>
</body>
</html>