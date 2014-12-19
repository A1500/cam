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
	var somJxCheckDataSet = L5.DatasetMgr.lookup("somJxCheckDataSet");
	somJxCheckDataSet.setParameter("TASK_CODE@=", taskCode);
	somJxCheckDataSet.load();
	somJxCheckDataSet.on("load",function(ds){
		if(ds.getCount()==1){
			document.getElementById("ifPutoutReport").value=ds.get("ifPutoutReport");
			document.getElementById("ifPutoutView").value=ds.get("ifPutoutView");
			document.getElementById("ifPutoutFunds").value=ds.get("ifPutoutFunds");
			document.getElementById("ifPutoutSys").value=ds.get("ifPutoutSys");
			document.getElementById("ifPutoutWeb").value=ds.get("ifPutoutWeb");
			document.getElementById("ifPutoutAdvance").value=ds.get("ifPutoutAdvance");
		}
	});
	var somJxProclamationDataSet = L5.DatasetMgr.lookup("somJxProclamationDataSet");
	somJxProclamationDataSet.setParameter("TASK_CODE@=", taskCode);
	somJxProclamationDataSet.load();
	somJxProclamationDataSet.on("load",function(ds){
		if(ds.getCount()!=0){
			var a1=1;
			var a2=1;
			var a3=1;
			var a4=1;
			var a5=1;
			for(i=0;i<ds.getCount();i++){
				var record = ds.getAt(i);
				if(record.get('seq') == '1'){
					var tab2 = document.getElementById("activitiesPublishDetail1");
					tab2.rows[a1].cells[1].getElementsByTagName("textarea")[0].value=record.get("insertionName");
					tab2.rows[a1].cells[2].getElementsByTagName("textarea")[0].value=record.get("item");
					tab2.rows[a1].cells[3].getElementsByTagName("input")[0].value=record.get("insertionDate");
					a1++;
				}else if(record.get('seq') == '2'){
					var tab2 = document.getElementById("activitiesPublishDetail2");
					tab2.rows[a2].cells[1].getElementsByTagName("textarea")[0].value=record.get("insertionName");
					tab2.rows[a2].cells[2].getElementsByTagName("textarea")[0].value=record.get("item");
					tab2.rows[a2].cells[3].getElementsByTagName("input")[0].value=record.get("insertionDate");
					a2++;
				}else if(record.get('seq') == '3'){
					var tab2 = document.getElementById("activitiesPublishDetail3");
					tab2.rows[a3].cells[1].getElementsByTagName("textarea")[0].value=record.get("insertionName");
					tab2.rows[a3].cells[2].getElementsByTagName("textarea")[0].value=record.get("item");
					tab2.rows[a3].cells[3].getElementsByTagName("input")[0].value=record.get("insertionDate");
					a3++;
				}else if(record.get('seq') == '4'){
					var tab2 = document.getElementById("activitiesPublishDetail4");
					tab2.rows[a4].cells[1].getElementsByTagName("textarea")[0].value=record.get("insertionName");
					tab2.rows[a4].cells[2].getElementsByTagName("textarea")[0].value=record.get("item");
					tab2.rows[a4].cells[3].getElementsByTagName("input")[0].value=record.get("insertionDate");
					a4++;
				}else if(record.get('seq') == '5'){
					var tab2 = document.getElementById("activitiesPublishDetail5");
					tab2.rows[a5].cells[1].getElementsByTagName("textarea")[0].value=record.get("insertionName");
					tab2.rows[a5].cells[2].getElementsByTagName("textarea")[0].value=record.get("item");
					tab2.rows[a5].cells[3].getElementsByTagName("input")[0].value=record.get("insertionDate");
					a5++;
				}
				
			}
		}
	});
	//创建页面导航下拉框
	createFundEditSelect();
}
function save(){
	var somJxCheckDataSetIsValidate = somJxCheckDataSet.isValidate();
	if(somJxCheckDataSetIsValidate!=true){
		L5.Msg.alert("提示",somJxCheckDataSetIsValidate);
		return "break";
	}	
	var ifPutoutReport = document.getElementById("ifPutoutReport").value;
	var ifPutoutView = document.getElementById("ifPutoutView").value;
	var ifPutoutFunds = document.getElementById("ifPutoutFunds").value;
	var ifPutoutSys = document.getElementById("ifPutoutSys").value;
	var ifPutoutWeb = document.getElementById("ifPutoutWeb").value;
	var ifPutoutAdvance = document.getElementById("ifPutoutAdvance").value;
	var sorgKind=somJxCheckDataSet.get("sorgKind");//公募非公募
	if(sorgKind!="1"){
		somJxCheckDataSet.set("ifPutoutFunds","");
		somJxCheckDataSet.set("ifPutoutSys","");
	}
	
	somJxProclamationDataSet.removeAll();
	var tab1 = document.getElementById("activitiesPublishDetail1");
	for(i=1;i<=3;i++){
		var record = somJxProclamationDataSet.newRecord();
		record.set('seq','1');
		record.set("insertionName",tab1.rows[i].cells[1].getElementsByTagName("textarea")[0].value);
		record.set("item",tab1.rows[i].cells[2].getElementsByTagName("textarea")[0].value);
		record.set("insertionDate",tab1.rows[i].cells[3].getElementsByTagName("input")[0].value);		
		var insertionName=tab1.rows[i].cells[1].getElementsByTagName("textarea")[0].value;
		var item=tab1.rows[i].cells[2].getElementsByTagName("textarea")[0].value;
		var insertionDate=tab1.rows[i].cells[3].getElementsByTagName("input")[0].value;
		if(ifPutoutView=="1"){
			if(insertionName==""||item==""||insertionDate==""){
				if(i==1){
					L5.Msg.alert("提示","请至少输入一条在其他媒体上公布上年度工作报告信息！没有的请填无！");
					return "break";
				}else{
					if(!(insertionName==""&&item==""&&insertionDate=="")){
						L5.Msg.alert("提示","请输入完整的在其他媒体上公布上年度工作报告信息！");
						return "break";
					}			
				}
			}
		}
	}
	var tab2 = document.getElementById("activitiesPublishDetail2");
	for(i=1;i<=3;i++){
		var record = somJxProclamationDataSet.newRecord();
		record.set('seq','2');
		record.set("insertionName",tab2.rows[i].cells[1].getElementsByTagName("textarea")[0].value);
		record.set("item",tab2.rows[i].cells[2].getElementsByTagName("textarea")[0].value);
		record.set("insertionDate",tab2.rows[i].cells[3].getElementsByTagName("input")[0].value);		
		var insertionName=tab2.rows[i].cells[1].getElementsByTagName("textarea")[0].value;
		var item=tab2.rows[i].cells[2].getElementsByTagName("textarea")[0].value;
		var insertionDate=tab2.rows[i].cells[3].getElementsByTagName("input")[0].value;
		if(ifPutoutFunds=="1"&&sorgKind=="1"){
			if(insertionName==""||item==""||insertionDate==""){
				if(i==1){
					L5.Msg.alert("提示","请至少输入一条在开展募捐活动前媒体上公布募捐公告信息！没有的请填无！");
					return "break";
				}else{
					if(!(insertionName==""&&item==""&&insertionDate=="")){
						L5.Msg.alert("提示","请输入完整的在开展募捐活动前媒体上公布募捐公告信息！");
						return "break";
					}			
				}
			}
		}
	}
	var tab3 = document.getElementById("activitiesPublishDetail3");
	for(i=1;i<=3;i++){
		var record = somJxProclamationDataSet.newRecord();
		record.set('seq','3');
		record.set("insertionName",tab3.rows[i].cells[1].getElementsByTagName("textarea")[0].value);
		record.set("item",tab3.rows[i].cells[2].getElementsByTagName("textarea")[0].value);
		record.set("insertionDate",tab3.rows[i].cells[3].getElementsByTagName("input")[0].value);		
		var insertionName=tab3.rows[i].cells[1].getElementsByTagName("textarea")[0].value;
		var item=tab3.rows[i].cells[2].getElementsByTagName("textarea")[0].value;
		var insertionDate=tab3.rows[i].cells[3].getElementsByTagName("input")[0].value;
		if(ifPutoutSys=="1"&&ifPutoutSys=="1"){
			if(insertionName==""||item==""||insertionDate==""){
				if(i==1){
					L5.Msg.alert("提示","请至少输入一条在媒体上公布了内部管理制度信息！没有的请填无！");
					return "break";
				}else{
					if(!(insertionName==""&&item==""&&insertionDate=="")){
						L5.Msg.alert("提示","请输入完整的在媒体上公布了内部管理制度信息！");
						return "break";
					}			
				}
			}
		}
	}
	var tab4 = document.getElementById("activitiesPublishDetail4");
	for(i=1;i<=2;i++){
		var record = somJxProclamationDataSet.newRecord();
		record.set('seq','4');
		record.set("insertionName",tab4.rows[i].cells[1].getElementsByTagName("textarea")[0].value);
		record.set("item",tab4.rows[i].cells[2].getElementsByTagName("textarea")[0].value);
		record.set("insertionDate",tab4.rows[i].cells[3].getElementsByTagName("input")[0].value);		
		var insertionName=tab4.rows[i].cells[1].getElementsByTagName("textarea")[0].value;
		var item=tab4.rows[i].cells[2].getElementsByTagName("textarea")[0].value;
		var insertionDate=tab4.rows[i].cells[3].getElementsByTagName("input")[0].value;
		if(ifPutoutWeb=="1"){
			if(insertionName==""||item==""||insertionDate==""){
				if(i==1){
					L5.Msg.alert("提示","请至少输入一条在自身网站和其他公开媒体上公布详细的收入和支出明细信息！没有的请填无！");
					return "break";
				}else{
					if(!(insertionName==""&&item==""&&insertionDate=="")){
						L5.Msg.alert("提示","请输入完整的在自身网站和其他公开媒体上公布详细的收入和支出明细信息！");
						return "break";
					}			
				}
			}
		}
	}
	var tab5 = document.getElementById("activitiesPublishDetail5");
	for(i=1;i<=3;i++){
		var record = somJxProclamationDataSet.newRecord();
		record.set('seq','5');
		record.set("insertionName",tab5.rows[i].cells[1].getElementsByTagName("textarea")[0].value);
		record.set("item",tab5.rows[i].cells[2].getElementsByTagName("textarea")[0].value);
		record.set("insertionDate",tab5.rows[i].cells[3].getElementsByTagName("input")[0].value);		
		var insertionName=tab5.rows[i].cells[1].getElementsByTagName("textarea")[0].value;
		var item=tab5.rows[i].cells[2].getElementsByTagName("textarea")[0].value;
		var insertionDate=tab5.rows[i].cells[3].getElementsByTagName("input")[0].value;
		if(ifPutoutAdvance=="1"){
			if(insertionName==""||item==""||insertionDate==""){
				if(i==1){
					L5.Msg.alert("提示","请至少输入一条在媒体上公布公益项目的进展情况、资金使用情况信息！没有的请填无！");
					return "break";
				}else{
					if(!(insertionName==""&&item==""&&insertionDate=="")){
						L5.Msg.alert("提示","请输入完整的在媒体上公布公益项目的进展情况、资金使用情况信息！");
						return "break";
					}			
				}
			}
		}
	}
	//信息公布情况
	var somJxProclamationDataSetIsValidate = somJxProclamationDataSet.isValidate();
	if(somJxProclamationDataSetIsValidate!=true){
		L5.Msg.alert("提示",somJxProclamationDataSetIsValidate);
		return "break";
	}
	
	var proclamationRecords=somJxProclamationDataSet.getAllRecords();
	var somCheckRecord=somJxCheckDataSet.getCurrent();
	/*somCheckRecord.set("ifPutoutReport", ifPutoutReport);
	somCheckRecord.set("ifPutoutView", ifPutoutView);
	somCheckRecord.set("ifPutoutFunds", ifPutoutFunds);
	somCheckRecord.set("ifPutoutSys", ifPutoutSys);
	somCheckRecord.set("ifPutoutWeb", ifPutoutWeb);
	somCheckRecord.set("ifPutoutAdvance", ifPutoutAdvance);*/
	var command = new L5.Command("com.inspur.cams.sorg.check.somcheck.cmd.SomCheckCommand");
	
	command.setParameter("somCheckRecord", somCheckRecord);
	command.setParameter("proclamationRecords", proclamationRecords);
	command.setParameter("taskCode", taskCode);
	command.execute("savePageJ27");
	if (!command.error) {
		alert("保存成功！");	
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
</script>
<script>
function textCounter(field, maxlimit) {
    if (field.value.length > maxlimit)
	field.value = field.value.substring(0, maxlimit);
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

.boder-0 {
	font-size: 14px;
	border: 0px none;
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
	width:98%;
	font-size: 14px;
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

.hw-bt1 {
	font-family: '华文中宋';
	font-size: 26pt;
	font-weight: bold;
	color: #000000;
	letter-spacing: 2pt;
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	border-top-style: none;
	border-right-style: none;
	border-left-style: none;
	padding-bottom: 0px;
	vertical-align: bottom;
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
</head>

<body>
<model:datasets>
	<model:dataset id="somJxProclamationDataSet" cmd="com.inspur.cams.sorg.check.somproclamation.cmd.SomProclamationQueryCommand" global="true" method="queryNoPage">
		<model:record fromBean="com.inspur.cams.sorg.check.somproclamation.dao.SomProclamation">
			<model:field name="item" type="string" rule="length{100}" />
			<model:field name="insertionName" type="string" rule="length{100}" />
		</model:record>
	</model:dataset>
	<model:dataset id="somJxCheckDataSet" cmd="com.inspur.cams.sorg.check.somcheck.cmd.SomCheckQueryCommand" global="true" >
		<model:record fromBean="com.inspur.cams.sorg.check.somcheck.data.SomCheck">
			<model:field name="ifPutoutReport" type="string" rule="require" />
			<model:field name="ifPutoutView" type="string" rule="require" />
			<model:field name="ifPutoutWeb" type="string" rule="require" />
			<model:field name="ifPutoutAdvance" type="string" rule="require" />
		</model:record>
	</model:dataset>
	<!-- 是否 -->
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO" autoLoad="true"	global="true"></model:dataset>
</model:datasets>
<div id="float" >
	<input type="button" value="下一页" style="height:25px;width:80px;position:absolute;margin-left:120px;" onclick="nextPageJ('28')"/>
	<input type="button" value="上一页" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="lastPageJ('26')"/>
	<input type="button" value="保存" style="height:25px;width:80px;position:absolute;margin-left:220px;" onclick="save();"/>
	<input type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:320px;" onclick="backJ();"/>
</div>
<div align=center>
<div align=center style="width: 800px">
<form dataset="somJxCheckDataSet" name="myform" method="post" onsubmit="return false">

<TABLE cellSpacing=0 cellPadding=0 width=800 align=center border=0>
	<TBODY>
		<TR>
			<TD width=644 height=48>&nbsp;</TD>
		</TR>
		<TR>
			<TD height=30><strong>八、信息公开情况</strong></TD>
		</TR>
		<TR>
			<TD height=30>（一）是否在登记管理机关指定的媒体上公布上年度工作报告摘要 
				<select id='ifPutoutReport'field='ifPutoutReport' style='width:100'name='是否在登记管理机关指定的媒体上公布上年度工作报告摘要 '><option dataset='comm_yesorno'/></select>
			</TD>
		</TR>
		<TR>
			<TD height=30>（二）是否在其他媒体上公布上年度工作报告 
				<select id='ifPutoutView'field='ifPutoutView' style='width:100'name='是否在其他媒体上公布上年度工作报告'><option dataset='comm_yesorno'/></select>
			</TD>
		</TR>
		<TR>
			<TD height=30> 如选“是”，请说明在哪些媒体上进行公布
			</TD>
		</TR>
		<TR>
			<TD vAlign=top>
			<TABLE id=activitiesPublishDetail1 class=unnamed1 cellSpacing=0 cellPadding=0 width=800
				border=0>
				<TBODY>
					<TR align=middle>
						<TD class=unnamed2 width='7%' height=32>序号</TD>
						<TD class=unnamed2 width='38%' height=32>刊载媒体名称</TD>
						<TD class=unnamed2 width='39%' height=32>刊载事项</TD>
						<TD class=unnamed3 width='16%' height=32>刊载日期</TD>
					</TR>
					<TR align=middle>
						<TD class=unnamed2 height=32>1
						</TD>
						<TD class=unnamed2 height=32><textarea
							name='query$form$0$INDEX_INFO_THROWS$pilushixiang$1'
							COLS='40' rows='2' limit='40' CLASS='boder12-0' ></textarea>
						</TD>
						<TD class=unnamed2 height=32><textarea
							name='query$form$0$INDEX_INFO_THROWS$wangzhanmingcheng$1'
							ID='子表1.网站名称$1' COLS='50' rows='2' limit='50' CLASS='boder12-0'
							></textarea></TD>
						<TD class=unnamed3 height=32>
							<input id='' format="Y-m-d" onclick="LoushangDate(this);" readonly="readonly" style='text-align:center' CLASS='boder12-0'/>
						</TD>
					</TR>
					<TR align=middle>
						<TD class=unnamed2 height=32>2
						</TD>
						<TD class=unnamed2 height=32><textarea
							name='query$form$0$INDEX_INFO_THROWS$pilushixiang$2'
							COLS='40' rows='2' limit='40' CLASS='boder12-0' ></textarea>
						</TD>
						<TD class=unnamed2 height=32><textarea
							name='query$form$0$INDEX_INFO_THROWS$wangzhanmingcheng$2'
							COLS='50' rows='2' limit='50' CLASS='boder12-0' ></textarea>
						</TD>
						<TD class=unnamed3 height=32>
							<input id='' format="Y-m-d" onclick="LoushangDate(this);" readonly="readonly" style='text-align:center' CLASS='boder12-0'/>
						</TD>
					</TR>
					<TR align=middle>
						<TD class=unnamed2 height=32>3
						</TD>
						<TD class=unnamed2 height=32><textarea
							name='query$form$0$INDEX_INFO_THROWS$pilushixiang$3'
							COLS='40' rows='2' limit='40' CLASS='boder12-0' ></textarea>
						</TD>
						<TD class=unnamed2 height=32><textarea
							name='query$form$0$INDEX_INFO_THROWS$wangzhanmingcheng$3'
							COLS='50' rows='2' limit='50' CLASS='boder12-0' ></textarea>
						</TD>
						<TD class=unnamed3 height=32>
							<input id='' format="Y-m-d" onclick="LoushangDate(this);" readonly="readonly" style='text-align:center' CLASS='boder12-0'/>
						</TD>
					</TR>
				</TBODY>
			</TABLE>
			</TD>
		</TR>
		<TR>
			<TD height=30>（三）是否在开展募捐活动前媒体上公布募捐公告（公募基金会填写） 
				<select id='ifPutoutFunds'field='ifPutoutFunds' style='width:100'name='是否在开展募捐活动前媒体上公布募捐公告'><option dataset='comm_yesorno'/></select>
			</TD>
		</TR>
		<TR>
			<TD height=30> 如选“是”，请说明在哪些媒体上进行公布
			</TD>
		</TR>
		<TR>
			<TD vAlign=center align=left height=14>
				<TABLE id=activitiesPublishDetail2 class=unnamed1 cellSpacing=0 cellPadding=0 width='100%'
					border=0>
				<TBODY>
					<TR align=middle>
						<TD class=unnamed2 width='7%' height=32>序号</TD>
						<TD class=unnamed2 width='38%' height=32>刊载媒体名称</TD>
						<TD class=unnamed2 width='39%' height=32>刊载事项</TD>
						<TD class=unnamed3 width='16%' height=32>刊载日期</TD>
					</TR>
					<TR align=middle>
						<TD class=unnamed2 height=32>1
						</TD>
						<TD class=unnamed2 height=32><textarea
							name='query$form$0$INDEX_INFO_THROWS$pilushixiang$1'
							COLS='40' rows='2' limit='40' CLASS='boder12-0' ></textarea>
						</TD>
						<TD class=unnamed2 height=32><textarea
							name='query$form$0$INDEX_INFO_THROWS$wangzhanmingcheng$1'
							ID='子表1.网站名称$1' COLS='50' rows='2' limit='50' CLASS='boder12-0'
							></textarea></TD>
						<TD class=unnamed3 height=32>
							<input id='' format="Y-m-d" onclick="LoushangDate(this);" readonly="readonly" style='text-align:center' CLASS='boder12-0'/>
						</TD>
					</TR>
					<TR align=middle>
						<TD class=unnamed2 height=32>2
						</TD>
						<TD class=unnamed2 height=32><textarea
							name='query$form$0$INDEX_INFO_THROWS$pilushixiang$2'
							COLS='40' rows='2' limit='40' CLASS='boder12-0' ></textarea>
						</TD>
						<TD class=unnamed2 height=32><textarea
							name='query$form$0$INDEX_INFO_THROWS$wangzhanmingcheng$2'
							COLS='50' rows='2' limit='50' CLASS='boder12-0' ></textarea>
						</TD>
						<TD class=unnamed3 height=32>
							<input id='' format="Y-m-d" onclick="LoushangDate(this);" readonly="readonly" style='text-align:center' CLASS='boder12-0'/>
						</TD>
					</TR>
					<TR align=middle>
						<TD class=unnamed2 height=32>3
						</TD>
						<TD class=unnamed2 height=32><textarea
							name='query$form$0$INDEX_INFO_THROWS$pilushixiang$3'
							COLS='40' rows='2' limit='40' CLASS='boder12-0' ></textarea>
						</TD>
						<TD class=unnamed2 height=32><textarea
							name='query$form$0$INDEX_INFO_THROWS$wangzhanmingcheng$3'
							COLS='50' rows='2' limit='50' CLASS='boder12-0' ></textarea>
						</TD>
						<TD class=unnamed3 height=32>
							<input id='' format="Y-m-d" onclick="LoushangDate(this);" readonly="readonly" style='text-align:center' CLASS='boder12-0'/>
						</TD>
					</TR>
				</TBODY>
			</TABLE>
			</TD>
		</TR>
		<TR>
			<TD height=30>（四）是否在媒体上公布了内部管理制度（公募基金会填写）
				<select id='ifPutoutSys' field='ifPutoutSys' style='width:100'name='是否在媒体上公布了内部管理制度'><option dataset='comm_yesorno'/></select>
			</TD>
		</TR>
		<TR>
			<TD height=30> 如选“是”，请说明在哪些媒体上进行公布
			</TD>
		</TR>
		<TR>
			<TD vAlign=center align=left height=14>
				<TABLE id=activitiesPublishDetail3 class=unnamed1 cellSpacing=0 cellPadding=0 width='100%'
					border=0>
				<TBODY>
					<TR align=middle>
						<TD class=unnamed2 width='7%' height=32>序号</TD>
						<TD class=unnamed2 width='38%' height=32>刊载媒体名称</TD>
						<TD class=unnamed2 width='39%' height=32>刊载事项</TD>
						<TD class=unnamed3 width='16%' height=32>刊载日期</TD>
					</TR>
					<TR align=middle>
						<TD class=unnamed2 height=32>1
						</TD>
						<TD class=unnamed2 height=32><textarea
							name='query$form$0$INDEX_INFO_THROWS$pilushixiang$1'
							COLS='40' rows='2' limit='40' CLASS='boder12-0' ></textarea>
						</TD>
						<TD class=unnamed2 height=32><textarea
							name='query$form$0$INDEX_INFO_THROWS$wangzhanmingcheng$1'
							ID='子表1.网站名称$1' COLS='50' rows='2' limit='50' CLASS='boder12-0'
							></textarea></TD>
						<TD class=unnamed3 height=32>
							<input id='' format="Y-m-d" onclick="LoushangDate(this);" readonly="readonly" style='text-align:center' CLASS='boder12-0'/>
						</TD>
					</TR>
					<TR align=middle>
						<TD class=unnamed2 height=32>2
						</TD>
						<TD class=unnamed2 height=32><textarea
							name='query$form$0$INDEX_INFO_THROWS$pilushixiang$2'
							COLS='40' rows='2' limit='40' CLASS='boder12-0' ></textarea>
						</TD>
						<TD class=unnamed2 height=32><textarea
							name='query$form$0$INDEX_INFO_THROWS$wangzhanmingcheng$2'
							COLS='50' rows='2' limit='50' CLASS='boder12-0' ></textarea>
						</TD>
						<TD class=unnamed3 height=32>
							<input id='' format="Y-m-d" onclick="LoushangDate(this);" readonly="readonly" style='text-align:center' CLASS='boder12-0'/>
						</TD>
					</TR>
					<TR align=middle>
						<TD class=unnamed2 height=32>3
						</TD>
						<TD class=unnamed2 height=32><textarea
							name='query$form$0$INDEX_INFO_THROWS$pilushixiang$3'
							COLS='40' rows='2' limit='40' CLASS='boder12-0' ></textarea>
						</TD>
						<TD class=unnamed2 height=32><textarea
							name='query$form$0$INDEX_INFO_THROWS$wangzhanmingcheng$3'
							COLS='50' rows='2' limit='50' CLASS='boder12-0' ></textarea>
						</TD>
						<TD class=unnamed3 height=32>
							<input id='' format="Y-m-d" onclick="LoushangDate(this);" readonly="readonly" style='text-align:center' CLASS='boder12-0'/>
						</TD>
					</TR>
				</TBODY>
			</TABLE>
			</TD>
		</TR>
		<TR>
			<TD height=30>（五）在开展募捐以及为突发事件接收的公益捐赠，取得捐赠收入后，是否在自身网站和其他公开媒体上公布详细的收入和支出明细？
				<select id='ifPutoutWeb' field='ifPutoutWeb' style='width:100'name='是否在自身网站和其他公开媒体上公布详细的收入和支出明细'><option dataset='comm_yesorno'/></select>
				（公募基金会应填写开展募捐以及为突发事件接收的公益捐赠，非公募基金会应填写为突发事件接收的公益捐赠的收支明细的公布情况）
			</TD>
		</TR>
		<TR>
			<TD height=30> 如选“是”，请说明在哪些媒体上进行公布
			</TD>
		</TR>
		<TR>
			<TD vAlign=center align=left height=14>
				<TABLE id=activitiesPublishDetail4 class=unnamed1 cellSpacing=0 cellPadding=0 width='100%'
					border=0>
				<TBODY>
					<TR align=middle>
						<TD class=unnamed2 width='7%' height=32>序号</TD>
						<TD class=unnamed2 width='38%' height=32>刊载媒体名称</TD>
						<TD class=unnamed2 width='39%' height=32>刊载事项</TD>
						<TD class=unnamed3 width='16%' height=32>刊载日期</TD>
					</TR>
					<TR align=middle>
						<TD class=unnamed2 height=32>1
						</TD>
						<TD class=unnamed2 height=32><textarea
							name='query$form$0$INDEX_INFO_THROWS$pilushixiang$1'
							COLS='40' rows='2' limit='40' CLASS='boder12-0' ></textarea>
						</TD>
						<TD class=unnamed2 height=32><textarea
							name='query$form$0$INDEX_INFO_THROWS$wangzhanmingcheng$1'
							ID='子表1.网站名称$1' COLS='50' rows='2' limit='50' CLASS='boder12-0'
							></textarea></TD>
						<TD class=unnamed3 height=32>
							<input id='' format="Y-m-d" onclick="LoushangDate(this);" readonly="readonly" style='text-align:center' CLASS='boder12-0'/>
						</TD>
					</TR>
					<TR align=middle>
						<TD class=unnamed2 height=32>2
						</TD>
						<TD class=unnamed2 height=32><textarea
							name='query$form$0$INDEX_INFO_THROWS$pilushixiang$2'
							COLS='40' rows='2' limit='40' CLASS='boder12-0' ></textarea>
						</TD>
						<TD class=unnamed2 height=32><textarea
							name='query$form$0$INDEX_INFO_THROWS$wangzhanmingcheng$2'
							
							
							COLS='50' rows='2' limit='50' CLASS='boder12-0' ></textarea>
						</TD>
						<TD class=unnamed3 height=32>
							<input id='' format="Y-m-d" onclick="LoushangDate(this);" readonly="readonly" style='text-align:center' CLASS='boder12-0'/>
						</TD>
					</TR>
				</TBODY>
			</TABLE>
			</TD>
		</TR>
		<TR>
			<TD height=30>（六）是否在媒体上公布公益项目的进展情况、资金使用情况 
				<select id='ifPutoutAdvance' field='ifPutoutAdvance'style='width:100' name='是否在媒体上公布公益项目的进展情况、资金使用情况'><option dataset='comm_yesorno'/></select>
			</TD>
		</TR>
		<TR>
			<TD height=30> 如选“是”，请说明在哪些媒体上进行公布
			</TD>
		</TR>
		<TR>
			<TD vAlign=center align=left height=14>
				<TABLE id=activitiesPublishDetail5 class=unnamed1 cellSpacing=0 cellPadding=0 width='100%'
					border=0>
				<TBODY>
					<TR align=middle>
						<TD class=unnamed2 width='7%' height=32>序号</TD>
						<TD class=unnamed2 width='38%' height=32>刊载媒体名称</TD>
						<TD class=unnamed2 width='39%' height=32>刊载事项</TD>
						<TD class=unnamed3 width='16%' height=32>刊载日期</TD>
					</TR>
					<TR align=middle>
						<TD class=unnamed2 height=32>1
						</TD>
						<TD class=unnamed2 height=32><textarea
							name='query$form$0$INDEX_INFO_THROWS$pilushixiang$1'
							COLS='40' rows='2' limit='40' CLASS='boder12-0' ></textarea>
						</TD>
						<TD class=unnamed2 height=32><textarea
							name='query$form$0$INDEX_INFO_THROWS$wangzhanmingcheng$1'
							ID='子表1.网站名称$1' COLS='50' rows='2' limit='50' CLASS='boder12-0'
							></textarea></TD>
						<TD class=unnamed3 height=32>
							<input id='' format="Y-m-d" onclick="LoushangDate(this);" readonly="readonly" style='text-align:center' CLASS='boder12-0'/>
						</TD>
					</TR>
					<TR align=middle>
						<TD class=unnamed2 height=32>2
						</TD>
						<TD class=unnamed2 height=32><textarea
							name='query$form$0$INDEX_INFO_THROWS$pilushixiang$2'
							COLS='40' rows='2' limit='40' CLASS='boder12-0' ></textarea>
						</TD>
						<TD class=unnamed2 height=32><textarea
							name='query$form$0$INDEX_INFO_THROWS$wangzhanmingcheng$2'
							COLS='50' rows='2' limit='50' CLASS='boder12-0' ></textarea>
						</TD>
						<TD class=unnamed3 height=32>
							<input id='' format="Y-m-d" onclick="LoushangDate(this);" readonly="readonly" style='text-align:center' CLASS='boder12-0'/>
						</TD>
					</TR>
					<TR align=middle>
						<TD class=unnamed2 height=32>3
						</TD>
						<TD class=unnamed2 height=32><textarea
							name='query$form$0$INDEX_INFO_THROWS$pilushixiang$3'
							COLS='40' rows='2' limit='40' CLASS='boder12-0' ></textarea>
						</TD>
						<TD class=unnamed2 height=32><textarea
							name='query$form$0$INDEX_INFO_THROWS$wangzhanmingcheng$3'
							COLS='50' rows='2' limit='50' CLASS='boder12-0' ></textarea>
						</TD>
						<TD class=unnamed3 height=32>
							<input id='' format="Y-m-d" onclick="LoushangDate(this);" readonly="readonly" style='text-align:center' CLASS='boder12-0'/>
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
		第27页</td>
	</tr>
</TABLE>

<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
</form>
</div>
</div>
</body>
</html>
