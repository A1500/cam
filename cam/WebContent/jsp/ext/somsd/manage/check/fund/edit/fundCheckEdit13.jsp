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
	somCheckDataSet.setParameter("TASK_CODE@=",taskCode);
	somCheckDataSet.load();
	somCheckDataSet.on("load",function(){
		var sorgKind=somCheckDataSet.get("sorgKind");
		if(sorgKind!="1"){
			L5.Msg.alert("提示","本基金会不是公募基金会，不能进行保存操作！");	
			somJxContributeDataSet.newRecord();	
			somJxContributeDataSet1.newRecord();
			somJxCheckExpenditureDataSet.newRecord();
		}else{
			somJxContributeDataSet.setParameter("TASK_CODE@=",taskCode);
			somJxContributeDataSet.setParameter("IF_OPEN@=", "0");
			somJxContributeDataSet.load();
			somJxContributeDataSet.on("load",function(ds){
				if(ds.getCount()==0){
					somJxContributeDataSet.newRecord({"taskCode":taskCode,"ifOpen":"0"});
				}
				setSumMoney();
			});
			somJxContributeDataSet1.setParameter("TASK_CODE@=",taskCode);
			somJxContributeDataSet1.setParameter("IF_OPEN@=", "1");
			somJxContributeDataSet1.load();
			somJxContributeDataSet1.on("load",function(ds){
				if(ds.getCount()==0){
					somJxContributeDataSet1.newRecord({"taskCode":taskCode,"ifOpen":"1"});
				}
				setSumMoney1();
			});
			somJxCheckExpenditureDataSet.setParameter("TASK_CODE@=",taskCode);
			somJxCheckExpenditureDataSet.load();
			somJxCheckExpenditureDataSet.on("load",function(ds){
				if(ds.getCount()==0){
					somJxCheckExpenditureDataSet.newRecord({"taskCode":taskCode});
				}
				setPerMoney();
			});  
		}
	});
	//创建页面导航下拉框
	createFundEditSelect();
}
function save(){
	if(somCheckDataSet.get("sorgKind")!="1"){
		L5.Msg.alert("提示","本基金会不是公募基金会，不能进行保存操作！",function(){
		});	
	}else{
		var somJxContributeDataSetIsValidate = somJxContributeDataSet.isValidate();
		if(somJxContributeDataSetIsValidate!=true){
			L5.Msg.alert("提示",somJxContributeDataSetIsValidate);
			return "break";
		}
		var somJxContributeDataSet1IsValidate = somJxContributeDataSet1.isValidate();
		if(somJxContributeDataSet1IsValidate!=true){
			L5.Msg.alert("提示",somJxContributeDataSet1IsValidate);
			return "break";
		}
		var somJxCheckExpenditureDataSetIsValidate = somJxCheckExpenditureDataSet.isValidate();
		if(somJxCheckExpenditureDataSetIsValidate!=true){
			L5.Msg.alert("提示",somJxCheckExpenditureDataSetIsValidate);
			return "break";
		}
		
		var somJxContributeRecord=somJxContributeDataSet.getCurrent();
		var somJxContributeRecord1=somJxContributeDataSet1.getCurrent();
		var somJxCheckExpenditureRecord=somJxCheckExpenditureDataSet.getCurrent();
		var command = new L5.Command("com.inspur.cams.sorg.check.somcheck.cmd.SomCheckCommand");
		somJxContributeRecord.set('currentTotal',document.getElementById('合计1').value);
		somJxContributeRecord.set('inTotal',document.getElementById('合计2').value);
		somJxContributeRecord.set('offTotal',document.getElementById('合计5').value);
		
		somJxContributeRecord1.set('currentTotal',document.getElementById('_合计1').value);
		somJxContributeRecord1.set('inTotal',document.getElementById('_合计2').value);
		somJxContributeRecord1.set('offTotal',document.getElementById('_合计5').value);
		
		command.setParameter("somJxContributeRecord",somJxContributeRecord);
		command.setParameter("somJxContributeRecord1",somJxContributeRecord1);
		command.setParameter("somJxCheckExpenditureRecord",somJxCheckExpenditureRecord);
		command.setParameter("taskCode", taskCode);
		command.execute("savePageJ13");
		if (!command.error) {
			alert("保存成功！");		
		}else{
			L5.Msg.alert('提示',"保存时出现错误！"+command.error);
		}	
	}
}
function setSumMoney(){
	document.getElementById("合计3").value=setParseFloat("现金3","实物折合3");
	document.getElementById("合计4").value=setParseFloat("现金4","实物折合4");
	document.getElementById("合计6").value=setParseFloat("现金6","实物折合6");
	document.getElementById("合计7").value=setParseFloat("现金7","实物折合7");
	document.getElementById("现金2").value=setParseFloat("现金3","现金4");
	document.getElementById("实物折合2").value=setParseFloat("实物折合3","实物折合4");
	document.getElementById("现金5").value=setParseFloat("现金6","现金7");
	document.getElementById("实物折合5").value=setParseFloat("实物折合6","实物折合7");
	document.getElementById("合计2").value=setParseFloat("合计3","合计4");
	document.getElementById("合计5").value=setParseFloat("合计6","合计7");
	document.getElementById("现金1").value=setParseFloat("现金2","现金5");
	document.getElementById("实物折合1").value=setParseFloat("实物折合2","实物折合5");
	document.getElementById("合计1").value=setParseFloat("合计2","合计5");
}
function setSumMoney1(){
	document.getElementById("_合计3").value=setParseFloat("_现金3","_实物折合3");
	document.getElementById("_合计4").value=setParseFloat("_现金4","_实物折合4");
	document.getElementById("_合计6").value=setParseFloat("_现金6","_实物折合6");
	document.getElementById("_合计7").value=setParseFloat("_现金7","_实物折合7");
	document.getElementById("_现金2").value=setParseFloat("_现金3","_现金4");
	document.getElementById("_实物折合2").value=setParseFloat("_实物折合3","_实物折合4");
	document.getElementById("_现金5").value=setParseFloat("_现金6","_现金7");
	document.getElementById("_实物折合5").value=setParseFloat("_实物折合6","_实物折合7");
	document.getElementById("_合计2").value=setParseFloat("_合计3","_合计4");
	document.getElementById("_合计5").value=setParseFloat("_合计6","_合计7");
	document.getElementById("_现金1").value=setParseFloat("_现金2","_现金5");
	document.getElementById("_实物折合1").value=setParseFloat("_实物折合2","_实物折合5");
	document.getElementById("_合计1").value=setParseFloat("_合计2","_合计5");
}
function setParseFloat(id1,id2){
	var value1 = document.getElementById(id1).value;
	var value2 = document.getElementById(id2).value;
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
	return (value1+value2).toFixed(6)*1;
}
function setPerMoney(){
	var value1 = document.getElementById("公益支出").value;
	var value2 = document.getElementById("调整后的上年度总收入").value;
	var value3 = document.getElementById("工资支出").value;
	var value4 = document.getElementById("行政支出").value;
	var value5 = document.getElementById("本年度总支出").value;
	if(!value1 || !value2){
		document.getElementById("公益比例").value="";
	}else{
		document.getElementById("公益比例").value=(parseFloat(value1)/parseFloat(value2)*100).toFixed(6)*1;
		if(document.getElementById("公益比例").value=="Infinity" || document.getElementById("公益比例").value=="NaN"){
			document.getElementById("公益比例").value="";
		}
	}
	if((!value3 && !value4) || !value5){
		document.getElementById("福利支出比例").value="";
	}else{
		if(!value3){
			value3=0;
		}
		if(!value4){
			value4=0;
		}
		document.getElementById("福利支出比例").value=((parseFloat(value3)+parseFloat(value4))/parseFloat(value5)*100).toFixed(6)*1;
		if(document.getElementById("福利支出比例").value=="Infinity" || document.getElementById("福利支出比例").value=="NaN"){
			document.getElementById("福利支出比例").value="";
		}
	}

}
</script>
<style>
</style>
</head>

<body>
<model:datasets>
<!-- 公募基金会接受捐赠情况 -->
	<model:dataset id="somJxContributeDataSet" cmd="com.inspur.cams.sorg.check.somcontribute.cmd.SomContributeQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.somcontribute.dao.SomContribute">
			<model:field name="inPeopleMoney" type="string" rule="require" />
			<model:field name="inPeoplePracticali" type="string" rule="require" />
			<model:field name="inOtherMoney" type="string" rule="require" />			
			<model:field name="inOtherPracticali" type="string" rule="require" />
			<model:field name="offPeopleMoney" type="string" rule="require" />
			<model:field name="offPeoplePracticali" type="string" rule="require" />
			<model:field name="offOtherMoney" type="string" rule="require" />			
			<model:field name="offOtherPracticali" type="string" rule="require" />		
		</model:record>
	</model:dataset>
	<!-- 公募基金会公开募捐情况 -->
	<model:dataset id="somJxContributeDataSet1" cmd="com.inspur.cams.sorg.check.somcontribute.cmd.SomContributeQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.somcontribute.dao.SomContribute">
			<model:field name="itemNum" type="string" rule="require" />
			<model:field name="inPeopleMoney" type="string" rule="require" />
			<model:field name="inPeoplePracticali" type="string" rule="require" />
			<model:field name="inOtherMoney" type="string" rule="require" />			
			<model:field name="inOtherPracticali" type="string" rule="require" />
			<model:field name="offPeopleMoney" type="string" rule="require" />
			<model:field name="offPeoplePracticali" type="string" rule="require" />
			<model:field name="offOtherMoney" type="string" rule="require" />			
			<model:field name="offOtherPracticali" type="string" rule="require" />		
		</model:record>
	</model:dataset>
	<!-- 公募基金会公益支出情况 -->
	<model:dataset id="somJxCheckExpenditureDataSet" cmd="com.inspur.cams.sorg.check.somcheckexpenditure.cmd.SomCheckExpenditureQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.somcheckexpenditure.dao.SomCheckExpenditure">
			<model:field name="commLastSum" type="string" rule="require" />
			<model:field name="commLastTotal" type="string" rule="require" />
			<model:field name="commExpenditure" type="string" rule="require" />			
			<model:field name="commExpPub" type="string" rule="require" />
			<model:field name="commExpPer" type="string" rule="require" />
			<model:field name="commExpOff" type="string" rule="require" />
		</model:record>
	</model:dataset>
	<model:dataset id="somCheckDataSet" cmd="com.inspur.cams.sorg.check.somcheck.cmd.SomCheckQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.somcheck.data.SomCheck"></model:record>
	</model:dataset>
</model:datasets>
<div id="float">
	<input type="button" value="下一页" style="height: 25px; width: 80px; position: absolute; margin-left: 120px;" onclick="nextPageJ('14')" />
	<input type="button" value="上一页" style="height: 25px; width: 80px; position: absolute; margin-left: 20px;" onclick="nextPageJ('12')" />
	<input type="button" value="保存" style="height: 25px; width: 80px; position: absolute; margin-left: 220px;" onclick="save();" />
	<input type="button" value="返回" style="height: 25px; width: 80px; position: absolute; margin-left: 320px;" onclick="backJ();" />
</div>
<STYLE>
body {
	background-color: #ffffff;
	color: #000000;
	margin-left: 0;
	margin-top: 0;
	margin-width: 0;
	margin-height: 0;
	margin: 0px;
	font-size: 12px;
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

.unnamed5 {
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	border-right-width: 2px;
	border-right-style: solid;
	border-right-color: #000000;
	font-size: 14px;
}

.unnamed6 {
	border-right-width: 2px;
	border-right-style: solid;
	border-right-color: #000000;
	font-size: 14px;
}

.f16ps-size1 {
	border: 1 solid #000000;
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

.boder16pt-0 {
	font-size: 16pt;
	border: 0px none;
	vertical-align: middle;
}

.boder-cal {
	background-color: #f1F1F3;
	font-size: 14px;
	border: 0px none;
	vertical-align: middle;
}

.font-cal {
	background-color: #F1F1F3;
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	border-right-width: 1px;
	border-right-style: solid;
	border-right-color: #000000;
	font-size: 14px;
}

.font-calend {
	background-color: #F1F1F3;
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	font-size: 14px;
	border-top-style: none;
	border-right-style: none;
	border-left-style: none;
}

.font-rightdown {
	background-color: #F1F1F3;
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

.title {
	font-family: '宋体';
	font-size: 20px;
	font-weight: bold;
	color: #000000;
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

.title2 {
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	font-family: '宋体';
	border-top-style: none;
	border-right-style: none;
	border-left-style: none;
	font-size: 23px;
	font-weight: bold;
	color: #000000;
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

.input-line16zc {
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
	background-position: center center;
	text-align: center;
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

.hw-bt {
	font-family: '华文中宋';
	font-size: 26pt;
	font-weight: bold;
	color: #000000;
	letter-spacing: 2pt;
}

.kt-text {
	font-family: '楷体_GB2312';
	font-size: 16pt;
	color: #000000;
	font-weight: normal;
}

.hw-bt2 {
	font-family: '华文中宋';
	font-size: 18pt;
	font-weight: bold;
	color: #000000;
}

.fs-text {
	font-family: '仿宋';
	font-size: 16pt;
	font-weight: normal;
	color: #000000;
	letter-spacing: 1pt;
	line-height: 160%;
}

.ht-text {
	font-family: '黑体';
	font-size: 16pt;
	line-height: 110%;
	font-weight: normal;
	color: #000000;
	letter-spacing: 1pt;
}

.red {
	font-family: '仿宋';
	font-size: 16pt;
	color: #FF0000;
	line-height: 160%;
	letter-spacing: 1pt;
}

.textarea01 {
	font-family: '仿宋';
	font-size: 16pt;
	color: #000000;
	letter-spacing: 1pt;
	border: 1px solid #000000;
	line-height: 160%;
}
</STYLE>
<TABLE height=760 cellSpacing=0 cellPadding=0 width=800 align=center
	border=0>
	<TBODY>
		<TR>
			<TD width=683 height=53>
			<DIV align=center><BR>
			</DIV>
			</TD>
		</TR>
		<TD vAlign=top height=707>
		<TABLE height=645 cellSpacing=0 cellPadding=0 width=800 align=center
			border=0>
			<TBODY>
				<TR vAlign=top>
					<TD height=17 colspan='2' vAlign=center><STRONG>三、业务活动情况</STRONG></TD>
				</TR>
				</TR>
				<TR>
					<TD height=14 colspan='2' align=middle><STRONG>（一）接受捐赠情况</STRONG>（公募基金会填写）</TD>
				</TR>
				<TR>
					<TD colspan='2' align=right vAlign=bottom>单位：
					
					<span style="color:red">人民币万元</span>
					
					</TD>
				</TR>
				<TR>
					<TD height=25 colspan='2' align=middle>
					<form method="post" dataset="somJxContributeDataSet" onsubmit="return false">
					<TABLE class=unnamed1 cellSpacing=0 cellPadding=0 width='100%'
						border=0>
						<TBODY>
							<TR>
								<TD class=unnamed2 align=middle height=22>项 目</TD>
								<TD class=unnamed2 align=middle height=22>现金</TD>
								<TD class=unnamed2 align=middle height=22>实物折合</TD>
								<TD class=unnamed3 align=middle height=22>合计</TD>
							</TR>
							<TR>
								<TD class=unnamed2 height=22>一、本年捐赠收入（自动求和）</TD>
								<TD class=font-cal align=middle height=22><input
									name='query$form$0$JJHNJ_REPORT2$xianjin1' value='' ID='现金1'
									MAXLENGTH='15' CLASS='boder-cal' isMoney='true'
									style='text-align:right;padding-right:2px;' SIZE='14' readonly></TD>
								<TD class=font-cal height=22><input
									name='query$form$0$JJHNJ_REPORT2$zhehe1' value='' ID='实物折合1'
									MAXLENGTH='16' CLASS='boder-cal' SIZE='16' isMoney='true'
									style='text-align:right;padding-right:2px;' readonly></TD>
								<TD class=font-calend height=22><input
									name='query$form$0$JJHNJ_REPORT2$heji1' value='' ID='合计1'
									MAXLENGTH='16' CLASS='boder-cal' SIZE='16' isMoney='true'
									style='text-align:right;padding-right:2px;' readonly></TD>
							</TR>
							<TR>
								<TD class=unnamed2 height=22>（一）来自境内的捐赠（自动求和）</TD>
								<TD class=font-cal align=middle height=22><input
									name='query$form$0$JJHNJ_REPORT2$xianjin2' value='' ID='现金2'
									MAXLENGTH='15' CLASS='boder-cal' isMoney='true'
									style='text-align:right;padding-right:2px;' SIZE='14' readonly></TD>
								<TD class=font-cal height=22><input
									name='query$form$0$JJHNJ_REPORT2$zhehe2' value='' ID='实物折合2'
									MAXLENGTH='16' CLASS='boder-cal' SIZE='16' isMoney='true'
									style='text-align:right;padding-right:2px;' readonly></TD>
								<TD class=font-calend height=22><input
									name='query$form$0$JJHNJ_REPORT2$heji2' value='' ID='合计2'
									MAXLENGTH='16' CLASS='boder-cal' SIZE='16' isMoney='true'
									style='text-align:right;padding-right:2px;' readonly></TD>
							</TR>
							<TR>
								<TD class=unnamed2 height=22>其中：来自境内自然人的捐赠</TD>
								<TD class=unnamed2 align=middle height=22><input
									name='来自境内自然人的捐赠现金' field='inPeopleMoney' ID='现金3'
									MAXLENGTH='15' CLASS='boder-0' isMoney='true'
									style='text-align:right;padding-right:2px;' SIZE='14'
									onKeyUp="value=value.replace(/[^\d.]/g,'');setSumMoney();" 
									onblur='checkFloat(this);'></TD>
								<TD class=unnamed2 height=22><input
									name='来自境内自然人的捐赠实物折合' field='inPeoplePracticali' ID='实物折合3'
									MAXLENGTH='15' CLASS='boder-0' SIZE='16' isMoney='true'
									style='text-align:right;padding-right:2px;' onKeyUp="value=value.replace(/[^\d.]/g,'');setSumMoney();"
									onblur='checkFloat(this);'
									></TD>
								<TD class=font-calend height=22><input
									name='query$form$0$JJHNJ_REPORT2$heji3' value='' ID='合计3'
									MAXLENGTH='16' CLASS='boder-cal' SIZE='16' isMoney='true'
									style='text-align:right;padding-right:2px;' readonly></TD>
							</TR>
							<TR>
								<TD class=unnamed2 width='48%' height=22>来自境内法人或者其他组织的捐赠</TD>
								<TD class=unnamed2 align=middle width='15%' height=22><input
									name='来自境内法人或者其他组织的捐赠现金' field='inOtherMoney' ID='现金4'
									MAXLENGTH='15' CLASS='boder-0' isMoney='true'
									style='text-align:right;padding-right:2px;' SIZE='14'
									onKeyUp="value=value.replace(/[^\d.]/g,'');setSumMoney();" 
									onblur='checkFloat(this);'></TD>
								<TD class=unnamed2 width='19%' height=22><input
									name='来自境内法人或者其他组织的捐赠实物折合' field='inOtherPracticali' ID='实物折合4'
									MAXLENGTH='15' CLASS='boder-0' SIZE='16' isMoney='true'
									style='text-align:right;padding-right:2px;' onKeyUp="value=value.replace(/[^\d.]/g,'');setSumMoney();"
									onblur='checkFloat(this);'></TD>
								<TD class=font-calend width='18%' height=22><input
									name='query$form$0$JJHNJ_REPORT2$heji4' value='' ID='合计4'
									MAXLENGTH='16' CLASS='boder-cal' SIZE='16' isMoney='true'
									style='text-align:right;padding-right:2px;' readonly></TD>
							</TR>
							<TR>
								<TD class=unnamed2 height=22>（二）来自境外的捐赠（自动求和）</TD>
								<TD class=font-cal align=middle height=22><input
									name='query$form$0$JJHNJ_REPORT2$xianjin5' value='' ID='现金5'
									MAXLENGTH='15' CLASS='boder-cal' isMoney='true'
									style='text-align:right;padding-right:2px;' SIZE='14' readonly></TD>
								<TD class=font-cal height=22><input
									name='query$form$0$JJHNJ_REPORT2$zhehe5' value='' ID='实物折合5'
									MAXLENGTH='16' CLASS='boder-cal' SIZE='16' isMoney='true'
									style='text-align:right;padding-right:2px;' readonly></TD>
								<TD class=font-calend height=22><input
									name='query$form$0$JJHNJ_REPORT2$heji5' value='' ID='合计5'
									MAXLENGTH='16' CLASS='boder-cal' SIZE='16' isMoney='true'
									style='text-align:right;padding-right:2px;' readonly></TD>
							</TR>
							<TR>
								<TD class=unnamed2 height=22>其中：来自境外自然人的捐赠</TD>
								<TD class=unnamed2 align=middle height=22><input
									name='来自境外自然人的捐赠现金' field='offPeopleMoney' ID='现金6'
									MAXLENGTH='15' CLASS='boder-0' isMoney='true'
									style='text-align:right;padding-right:2px;' SIZE='14'
									onKeyUp="value=value.replace(/[^\d.]/g,'');setSumMoney();" 
									onblur='checkFloat(this);'></TD>
								<TD class=unnamed2 height=22><input
									name='来自境外自然人的捐赠实物折合' field='offPeoplePracticali' ID='实物折合6'
									MAXLENGTH='15' CLASS='boder-0' SIZE='16' isMoney='true'
									style='text-align:right;padding-right:2px;' onKeyUp="value=value.replace(/[^\d.]/g,'');setSumMoney();"
									onblur='checkFloat(this);'></TD>
								<TD class=font-calend height=22><input
									name='query$form$0$JJHNJ_REPORT2$heji6' value='' ID='合计6'
									MAXLENGTH='16' CLASS='boder-cal' SIZE='16' isMoney='true'
									style='text-align:right;padding-right:2px;' readonly></TD>
							</TR>
							<TR>
								<TD class=unnamed4 height=22>来自境外法人或者其他组织的捐赠</TD>
								<TD class=unnamed4 align=middle height=22><input
									name='来自境外法人或者其他组织的捐赠现金' field='offOtherMoney' ID='现金7'
									MAXLENGTH='15' CLASS='boder-0' isMoney='true'
									style='text-align:right;padding-right:2px;' SIZE='14'
									onKeyUp="value=value.replace(/[^\d.]/g,'');setSumMoney();" 
									onblur='checkFloat(this);'></TD>
								<TD class=unnamed4 height=22><input
									name='来自境外法人或者其他组织的捐赠实物折合' field='offOtherPracticali' ID='实物折合7'
									MAXLENGTH='15' CLASS='boder-0' SIZE='16' isMoney='true'
									style='text-align:right;padding-right:2px;' onKeyUp="value=value.replace(/[^\d.]/g,'');setSumMoney();"
									onblur='checkFloat(this);'></TD>
								<TD class=font-rightdown height=22><input
									name='query$form$0$JJHNJ_REPORT2$heji7' value='' ID='合计7'
									MAXLENGTH='16' CLASS='boder-cal' SIZE='16' isMoney='true'
									style='text-align:right;padding-right:2px;' readonly></TD>
							</TR>
						</TBODY>
					</TABLE>
					</form>
					</TD>
				</TR>
				<TR>
					<TD height=25 colspan='2' align=middle><STRONG>（二）公开募捐情况表</STRONG>（公募基金会填写）</TD>
				</TR>
				<TR>
					<TD colspan='2' align=right vAlign=bottom>单位：<span style="color:red">人民币万元</span></TD>
				</TR>
				<TR>
					<TD height=25 colspan='2' vAlign=top>
					<TABLE cellSpacing=0 cellPadding=0 width='100%' align=center
						border=0>
						<TBODY>
							<TD>
							<form method="post" dataset="somJxContributeDataSet1" onsubmit="return false">
							<TABLE class=unnamed1 cellSpacing=0 cellPadding=0 width='100%'
								border=0>
								<TBODY>
									<TR>
										<TD class=unnamed2 align=middle width='48%' height=22>项 目</TD>
										<TD class=unnamed2 align=middle width='16%' height=22>现金</TD>
										<TD class=unnamed2 align=middle width='19%' height=22>实物折合</TD>
										<TD class=unnamed3 align=middle width='17%' height=22>合计</TD>
									</TR>
									<TR>
										<TD class=unnamed2 height=22>一、本年度组织开展募捐活动(<input
											name='本年度组织开展募捐活动' field='itemNum' ID=''
											MAXLENGTH='6' CLASS='boder-cal' isMoney='true'
											style='text-align: center' SIZE='5' >)项，募捐取得的收入（自动求和）</TD>
										<TD class=font-cal height=22><input
											name='query$form$0$JJHNJ_REPORT2$xianjin9' value='' ID='_现金1'
											MAXLENGTH='15' CLASS='boder-cal' isMoney='true'
											style='text-align:right;padding-right:2px;' SIZE='14' readonly></TD>
										<TD class=font-cal align=middle height=22><input
											name='query$form$0$JJHNJ_REPORT2$zhehe9' value='' ID='_实物折合1'
											MAXLENGTH='16' CLASS='boder-cal' SIZE='16' isMoney='true'
											style='text-align:right;padding-right:2px;' readonly></TD>
										<TD class=font-calend align=middle height=22><input
											name='query$form$0$JJHNJ_REPORT2$heji9' value='' ID='_合计1'
											MAXLENGTH='16' CLASS='boder-cal' SIZE='16' isMoney='true'
											style='text-align:right;padding-right:2px;' readonly></TD>
									</TR>
									<TR>
										<TD class=unnamed2 height=22>（一）来自境内的捐赠（自动求和）</TD>
										<TD class=font-cal height=22><input
											name='query$form$0$JJHNJ_REPORT2$xianjin10' value=''
											ID='_现金2' MAXLENGTH='15' CLASS='boder-cal' isMoney='true'
											style='text-align:right;padding-right:2px;' SIZE='14' readonly></TD>
										<TD class=font-cal align=middle height=22><input
											name='query$form$0$JJHNJ_REPORT2$zhehe10' value='' ID='_实物折合2'
											MAXLENGTH='16' CLASS='boder-cal' SIZE='16' isMoney='true'
											style='text-align:right;padding-right:2px;' readonly></TD>
										<TD class=font-calend align=middle height=22><input
											name='query$form$0$JJHNJ_REPORT2$heji10' value='' ID='_合计2'
											MAXLENGTH='16' CLASS='boder-cal' SIZE='16' isMoney='true'
											style='text-align:right;padding-right:2px;' readonly></TD>
									</TR>
									<TR>
										<TD class=unnamed2 height=22>其中：来自境内自然人的捐赠</TD>
										<TD class=unnamed2 height=22><input
											name='来自境内自然人的捐赠现金' field='inPeopleMoney'
											ID='_现金3' MAXLENGTH='15' CLASS='boder-0' isMoney='true'
											style='text-align:right;padding-right:2px;' SIZE='14'
											onKeyUp="value=value.replace(/[^\d..]/g,'');setSumMoney1();" 
											onblur='checkFloat(this);'></TD>
										<TD class=unnamed2 align=middle height=22><input
											name='来自境内自然人的捐赠实物折合' field='inPeoplePracticali' ID='_实物折合3'
											MAXLENGTH='15' CLASS='boder-0' SIZE='16' isMoney='true'
											style='text-align:right;padding-right:2px;'
											onKeyUp="value=value.replace(/[^\d..]/g,'');setSumMoney1();"
											onblur='checkFloat(this);'></TD>
										<TD class=font-calend align=middle height=22><input
											name='query$form$0$JJHNJ_REPORT2$heji11' value='' ID='_合计3'
											MAXLENGTH='16' CLASS='boder-cal' SIZE='16' isMoney='true'
											style='text-align:right;padding-right:2px;' readonly></TD>
									</TR>
									<TR>
										<TD class=unnamed2 height=22>来自境内法人或者其他组织的捐赠</TD>
										<TD class=unnamed2 height=22><input
											name='来自境内法人或者其他组织的捐赠现金' field='inOtherMoney'
											ID='_现金4' MAXLENGTH='15' CLASS='boder-0' isMoney='true'
											style='text-align:right;padding-right:2px;' SIZE='14'
											onKeyUp="value=value.replace(/[^\d.]/g,'');setSumMoney1();" 
											onblur='checkFloat(this);'></TD>
										<TD class=unnamed2 align=middle height=22><input
											name='来自境内法人或者其他组织的捐赠实物折合' field='inOtherPracticali' ID='_实物折合4'
											MAXLENGTH='15' CLASS='boder-0' SIZE='16' isMoney='true'
											style='text-align:right;padding-right:2px;'
											onKeyUp="value=value.replace(/[^\d.]/g,'');setSumMoney1();"
											onblur='checkFloat(this);' ></TD>
										<TD class=font-calend align=middle height=22><input
											name='query$form$0$JJHNJ_REPORT2$heji12' value='' ID='_合计4'
											MAXLENGTH='16' CLASS='boder-cal' SIZE='16' isMoney='true'
											style='text-align:right;padding-right:2px;' readonly></TD>
									</TR>
									<TR>
										<TD class=unnamed2 height=22>（二）来自境外的捐赠（自动求和）</TD>
										<TD class=font-cal height=22><input
											name='query$form$0$JJHNJ_REPORT2$xianjin13' value=''
											ID='_现金5' MAXLENGTH='15' CLASS='boder-cal' isMoney='true'
											style='text-align:right;padding-right:2px;' SIZE='14' readonly></TD>
										<TD class=font-cal align=middle height=22><input
											name='query$form$0$JJHNJ_REPORT2$zhehe13' value='' ID='_实物折合5'
											MAXLENGTH='16' CLASS='boder-cal' SIZE='16' isMoney='true'
											style='text-align:right;padding-right:2px;' readonly></TD>
										<TD class=font-calend align=middle height=22><input
											name='query$form$0$JJHNJ_REPORT2$heji13' value='' ID='_合计5'
											MAXLENGTH='16' CLASS='boder-cal' SIZE='16' isMoney='true'
											style='text-align:right;padding-right:2px;' readonly></TD>
									</TR>
									<TR>
										<TD class=unnamed2 height=22>其中：来自境外自然人的捐赠</TD>
										<TD class=unnamed2 height=22><input
											name='来自境外自然人的捐赠现金' field='offPeopleMoney'
											ID='_现金6' MAXLENGTH='15' CLASS='boder-0' isMoney='true'
											style='text-align:right;padding-right:2px;' SIZE='14'
											onKeyUp="value=value.replace(/[^\d.]/g,'');setSumMoney1();" 
											onblur='checkFloat(this);'></TD>
										<TD class=unnamed2 align=middle height=22><input
											name='来自境外自然人的捐赠实物折合' field='offPeoplePracticali' ID='_实物折合6'
											MAXLENGTH='15' CLASS='boder-0' SIZE='16' isMoney='true'
											style='text-align:right;padding-right:2px;'
											onKeyUp="value=value.replace(/[^\d.]/g,'');setSumMoney1();" 
											onblur='checkFloat(this);'></TD>
										<TD class=font-calend align=middle height=22><input
											name='query$form$0$JJHNJ_REPORT2$heji14' value='' ID='_合计6'
											MAXLENGTH='16' CLASS='boder-cal' SIZE='16' isMoney='true'
											style='text-align:right;padding-right:2px;' readonly></TD>
									</TR>
									<TR>
										<TD class=unnamed4 height=22>来自境外法人或者其他组织的捐赠</TD>
										<TD class=unnamed4 height=22><input
											name='来自境外法人或者其他组织的捐赠现金' field='offOtherMoney'
											ID='_现金7' MAXLENGTH='15' CLASS='boder-0' isMoney='true'
											style='text-align:right;padding-right:2px;' SIZE='14'
											onKeyUp="value=value.replace(/[^\d.]/g,'');setSumMoney1();" 
											onblur='checkFloat(this);'></TD>
										<TD class=unnamed4 align=middle height=22><input
											name='来自境外法人或者其他组织的捐赠实物折合' field='offOtherPracticali' ID='_实物折合7'
											MAXLENGTH='15' CLASS='boder-0' SIZE='16' isMoney='true'
											style='text-align:right;padding-right:2px;'
											onKeyUp="value=value.replace(/[^\d.]/g,'');setSumMoney1();" 
											onblur='checkFloat(this);'></TD>
										<TD class=font-rightdown align=middle height=22><input
											name='query$form$0$JJHNJ_REPORT2$heji15' value='' ID='_合计7'
											MAXLENGTH='16' CLASS='boder-cal' SIZE='16' isMoney='true'
											style='text-align:right;padding-right:2px;' readonly></TD>
									</TR>
								</TBODY>
							</TABLE>
							</form>
							</TD>
							</TR>
					</TABLE>
					</TD>
				</TR>
				<TR>
					<TD height=25 colspan='2' align = middle><STRONG>（三）公益支出情况</STRONG>（公募基金会填写）</TD>
				</TR>
				<TR>
					<TD height=0 colspan='2' align=right vAlign=bottom></TD>
				</TR>
				<TR>
					<TD height=222 colspan='2' vAlign=top>
					<TABLE cellSpacing=0 cellPadding=0 width='100%' align=center
						border=0>
						<TBODY>
							<TR>
								<TD width='59%' height=22 align=middle>
								<div align='center'></div>
								</TD>
								<TD width='41%' align=middle>
								<div align='right'>单位：<span style="color:red">人民币万元</span></div>
								</TD>
							</TR>
							<TR>
								<TD colspan='2'>
								<form method="post" dataset="somJxCheckExpenditureDataSet" onsubmit="return false">
								<TABLE class=unnamed1 cellSpacing=0 cellPadding=0 width='100%'
									border=0>
									<TBODY>
										<TR>
											<TD class=unnamed2 align=middle width='73%' height=22>项
											目</TD>
											<TD class=unnamed3 align=middle width='27%' height=22>数额</TD>
										</TR>
										<TR>
											<TD class=unnamed2 height=22>上年度实际收入合计</TD>
											<TD class=unnamed3 align=middle height=22><input
												name='上年度实际收入合计' field='commLastSum'
												ID='上年度实际收入合计' MAXLENGTH='15' size='14' CLASS='boder-0'
												isMoney='true' style='text-align:right;padding-right:2px;' 
												onKeyUp="value=value.replace(/[^\d.]/g,'');setPerMoney();"
												onblur='checkFloat(this);'></TD>
										</TR>
										<TR>
											<TD class=unnamed2 height=22>调整后的上年度总收入</TD>
											<TD class=unnamed3 align=middle height=22><input
												name='调整后的上年度总收入' field='commLastTotal'
												ID='调整后的上年度总收入' MAXLENGTH='15' size='14' CLASS='boder-0'
												isMoney='true' style='text-align:right;padding-right:2px;'
												onKeyUp="value=value.replace(/[^\d.]/g,'');setPerMoney();" 
												onblur='checkFloat(this);'></TD>
										</TR>
										<TR>
											<TD class=unnamed2 height=22>本年度总支出</TD>
											<TD class=unnamed3 align=middle height=22><input
												name='本年度总支出' field='commExpenditure'
												ID='本年度总支出' size='14' MAXLENGTH='15' CLASS='boder-0'
												isMoney='true' style='text-align:right;padding-right:2px;'
												onKeyUp="value=value.replace(/[^\d.]/g,'');setPerMoney();" 
												onblur='checkFloat(this);'></TD>
										</TR>
										<TR>
											<TD class=unnamed2 height=22>本年度用于公益事业的支出</TD>
											<TD class=unnamed3 align=middle height=22><input
												name='本年度用于公益事业的支出' field='commExpPub'
												ID='公益支出' MAXLENGTH='15' size='14' CLASS='boder-0'
												isMoney='true' style='text-align:right;padding-right:2px;'
												onKeyUp="value=value.replace(/[^\d.]/g,'');setPerMoney();" 
												onblur='checkFloat(this);'></TD>
										</TR>
										<TR>
											<TD class=unnamed2 height=22>工作人员工资福利支出</TD>
											<TD class=unnamed3 align=middle height=22><input
												name='工作人员工资福利支出' field='commExpPer'
												ID='工资支出' size='14' MAXLENGTH='15' CLASS='boder-0'
												isMoney='true' style='text-align:right;padding-right:2px;'
												onKeyUp="value=value.replace(/[^\d.]/g,'');setPerMoney();" 
												onblur='checkFloat(this);'></TD>
										</TR>
										<TR>
											<TD class=unnamed2 height=22>行政办公支出</TD>
											<TD class=unnamed3 align=middle height=22><input
												name='行政办公支出' field='commExpOff'
												ID='行政支出' MAXLENGTH='15' size='14' CLASS='boder-0'
												isMoney='true' style='text-align:right;padding-right:2px;'
												onKeyUp="value=value.replace(/[^\d.]/g,'');setPerMoney();" 
												onblur='checkFloat(this);'></TD>
										</TR>
										<TR>
											<TD class=unnamed2 height=22>公益事业支出占上年度总收入的比例（自动生成）</TD>
											<TD class=font-calend align=left height=22>&nbsp;&nbsp;<input
												name='query$form$0$JJHNJ_REPORT2$gongyibili' value=''
												ID='公益比例' MAXLENGTH='15' CLASS='boder-cal' SIZE='15'
												style='text-align:right;padding-right:2px;' readonly> %</TD>
										</TR>
										<TR>
											<TD class=unnamed4 height=22>工作人员工资福利和行政办公支出占总支出的比例（自动生成）</TD>
											<TD class=font-rightdown align=left height=22>&nbsp;&nbsp;<input
												name='query$form$0$JJHNJ_REPORT2$fulibili' value=''
												ID='福利支出比例' MAXLENGTH='18' CLASS='boder-cal' SIZE='15'
												style='text-align:right;padding-right:2px;' readonly> %</TD>
										</TR>
									</TBODY>
								</TABLE>
								</form>
								</TD>
							</TR>
							<tr>
								<td valign=bottom height=50 colspan=2>说明：公益事业支出包括直接用于受助人的支出和开展公益项目时发生的项目直接成本，调整后的上年度总收入=上年度实际收入合计-上年收入中时间限定为上年不得使用的限定性收入+于上年解除时间限定的净资产。</td>
							</tr>
						</TBODY>
					</TABLE>
					</TD>
				</TR>
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

</body>
</html>
