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
	var somJxMajorDetailDataSet = L5.DatasetMgr.lookup("somJxMajorDetailDataSet");
	somJxMajorDetailDataSet.setParameter("TASK_CODE@=", taskCode);
	somJxMajorDetailDataSet.load();
	somJxMajorDetailDataSet.on("load",function(ds){
		if(ds.getCount()!=0){
			for(i=0;i<ds.getCount();i++){
				var record = ds.getAt(i);
				var tab1 = document.getElementById("table1");
				tab1.rows[i+3].cells[0].getElementsByTagName("textarea")[0].value=record.get("projectName");
				tab1.rows[i+3].cells[1].getElementsByTagName("input")[0].value=record.get("income");
				tab1.rows[i+3].cells[2].getElementsByTagName("input")[0].value=record.get("toPersonCash");
				tab1.rows[i+3].cells[3].getElementsByTagName("input")[0].value=record.get("salaryCash");
				tab1.rows[i+3].cells[4].getElementsByTagName("input")[0].value=record.get("officeCash");
				tab1.rows[i+3].cells[5].getElementsByTagName("input")[0].value=record.get("assetsCash");
				tab1.rows[i+3].cells[6].getElementsByTagName("input")[0].value=record.get("publicityCash");
				tab1.rows[i+3].cells[7].getElementsByTagName("input")[0].value=record.get("travalCash");
				tab1.rows[i+3].cells[8].getElementsByTagName("input")[0].value=record.get("otherCash");
				tab1.rows[i+3].cells[9].getElementsByTagName("input")[0].value=record.get("moneySum");
				tab1.rows[i+3].cells[10].getElementsByTagName("input")[0].value=record.get("total");
			}
		}
		setSumMoney();
	});
	//创建页面导航下拉框
	createFundEditSelect();
}
function save(){
	somJxMajorDetailDataSet.removeAll();
	var tab1 = document.getElementById("table1");
	for(i=3;i<=22;i++){
		var record = somJxMajorDetailDataSet.newRecord();
		record.set("projectName",tab1.rows[i].cells[0].getElementsByTagName("textarea")[0].value);
		record.set("income",tab1.rows[i].cells[1].getElementsByTagName("input")[0].value);
		record.set("toPersonCash",tab1.rows[i].cells[2].getElementsByTagName("input")[0].value);
		record.set("salaryCash",tab1.rows[i].cells[3].getElementsByTagName("input")[0].value);
		record.set("officeCash",tab1.rows[i].cells[4].getElementsByTagName("input")[0].value);
		record.set("assetsCash",tab1.rows[i].cells[5].getElementsByTagName("input")[0].value);
		record.set("publicityCash",tab1.rows[i].cells[6].getElementsByTagName("input")[0].value);
		record.set("travalCash",tab1.rows[i].cells[7].getElementsByTagName("input")[0].value);
		record.set("otherCash",tab1.rows[i].cells[8].getElementsByTagName("input")[0].value);
		record.set("moneySum",tab1.rows[i].cells[9].getElementsByTagName("input")[0].value);
		record.set("total",tab1.rows[i].cells[10].getElementsByTagName("input")[0].value);

		var projectName=tab1.rows[i].cells[0].getElementsByTagName("textarea")[0].value;
		var income=tab1.rows[i].cells[1].getElementsByTagName("input")[0].value;
		var toPersonCash=tab1.rows[i].cells[2].getElementsByTagName("input")[0].value;
		var salaryCash=tab1.rows[i].cells[3].getElementsByTagName("input")[0].value;
		var officeCash=tab1.rows[i].cells[4].getElementsByTagName("input")[0].value;
		var assetsCash=tab1.rows[i].cells[5].getElementsByTagName("input")[0].value;
		var publicityCash=tab1.rows[i].cells[6].getElementsByTagName("input")[0].value;
		var travalCash=tab1.rows[i].cells[7].getElementsByTagName("input")[0].value;
		var otherCash=tab1.rows[i].cells[8].getElementsByTagName("input")[0].value;
		if(projectName==""||income==""||toPersonCash==""||salaryCash==""||officeCash==""||assetsCash==""||publicityCash==""||travalCash==""||otherCash==""){
			if(i==3){
				L5.Msg.alert("提示","请至少输入一条重大公益项目收支明细信息！没有的请填无！");
				return "break";
			}else{
				if(!(projectName==""&&income==""&&toPersonCash==""&&salaryCash==""&&officeCash==""&&assetsCash==""&&publicityCash==""&&travalCash==""&&otherCash=="")){
					L5.Msg.alert("提示","请输入完整的重大公益项目收支明细信息！");
					return "break";
				}
			}
		}
	}

	var somJxMajorDetailRecords=somJxMajorDetailDataSet.getAllRecords();
	var command = new L5.Command("com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckCommand");
	command.setParameter("somJxMajorDetailRecords", somJxMajorDetailRecords);
	command.setParameter("taskCode", taskCode);
	command.execute("savePageJ18");
	if (!command.error) {
		alert("保存成功！");
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
function setSumMoney(){
	for(var i=1;i<=20;i++){
		document.getElementsByName("query$form$0$JJHNJ_ZHDGYXMSHZ$shouru")[0].value
		=setParseFloat("query$form$0$JJHNJ_ZHDGYXMSHZ$shouru","query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$shouru$"+i);
		document.getElementsByName("query$form$0$JJHNJ_ZHDGYXMSHZ$zhijiekuanwu")[0].value
		=setParseFloat("query$form$0$JJHNJ_ZHDGYXMSHZ$zhijiekuanwu","query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zhijiekuanwu$"+i);

		document.getElementsByName("query$form$0$JJHNJ_ZHDGYXMSHZ$xiangmurenyuangongzi")[0].value
		=setParseFloat("query$form$0$JJHNJ_ZHDGYXMSHZ$xiangmurenyuangongzi","query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmurenyuangongzi$"+i);
		document.getElementsByName("query$form$0$JJHNJ_ZHDGYXMSHZ$bangongfeiyong")[0].value
		=setParseFloat("query$form$0$JJHNJ_ZHDGYXMSHZ$bangongfeiyong","query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$bangongfeiyong$"+i);

		document.getElementsByName("query$form$0$JJHNJ_ZHDGYXMSHZ$zichanshiyongfeiyong")[0].value
		=setParseFloat("query$form$0$JJHNJ_ZHDGYXMSHZ$zichanshiyongfeiyong","query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zichanshiyongfeiyong$"+i);
		document.getElementsByName("query$form$0$JJHNJ_ZHDGYXMSHZ$xuanchuanfeiyong")[0].value
		=setParseFloat("query$form$0$JJHNJ_ZHDGYXMSHZ$xuanchuanfeiyong","query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xuanchuanfeiyong$"+i);

		document.getElementsByName("query$form$0$JJHNJ_ZHDGYXMSHZ$chalvfei")[0].value
		=setParseFloat("query$form$0$JJHNJ_ZHDGYXMSHZ$chalvfei","query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$chalvfei$"+i);
		document.getElementsByName("query$form$0$JJHNJ_ZHDGYXMSHZ$qitafeiyong")[0].value
		=setParseFloat("query$form$0$JJHNJ_ZHDGYXMSHZ$qitafeiyong","query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$qitafeiyong$"+i);

		document.getElementsByName("query$form$0$JJHNJ_ZHDGYXMSHZ$xiaoji")[0].value
		=setParseFloat("query$form$0$JJHNJ_ZHDGYXMSHZ$xiaoji","query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiaoji$"+i);
		document.getElementsByName("query$form$0$JJHNJ_ZHDGYXMSHZ$zongji")[0].value
		=setParseFloat("query$form$0$JJHNJ_ZHDGYXMSHZ$zongji","query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zongji$"+i);
	}
}
function setParseFloat(id1,id2){
	var value1 = document.getElementsByName(id1)[0].value;
	var value2 = document.getElementsByName(id2)[0].value;
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
</script>
<script>
function textCounter(field, maxlimit) {
    if (field.value.length > maxlimit)
	field.value = field.value.substring(0, maxlimit);
}
//type为列名 numflag为下标   flag为是否设计小计
function setSum(typeflag,numflag,flag){
	var type ="";
	if(typeflag==1){
		type = "shouru";
	}
	if(typeflag==2){
		type = "zhijiekuanwu"; //直接款物
	}
	if(typeflag==3){
		type = "xiangmurenyuangongzi"; //项目人员工资
	}
	if(typeflag==4){
		type = "bangongfeiyong"; //办公费用
	}
	if(typeflag==5){
		type = "zichanshiyongfeiyong"; //资产使用费用
	}
	if(typeflag==6){
		type = "xuanchuanfeiyong"; //宣传费用
	}
	if(typeflag==7){
		type = "chalvfei"; //差旅费
	}
	if(typeflag==8){
		type = "qitafeiyong"; //其他费用
	}

  //列的求和。
  var preName = "query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$";
    var preName1 = "query$form$0$JJHNJ_ZHDGYXMSHZ$";

    var totalsum1 = 0;
    for(i=1;i<=20;i++){
       var obj =  document.all(preName + type +"$" +i);
           if(obj.value != ""){
              totalsum1 += parseFloat(obj.value);
           }
      }
    document.all(preName1 + type ).value =   (Math.round(totalsum1*1000000))/1000000;

    //行的求和。
	var sum2=0; //总计
	if(typeflag==2){

    	var typeObj2 = document.all(preName + "zhijiekuanwu" +"$" +numflag);
    	if(typeObj2.value != "")
    	sum2+=parseFloat(typeObj2.value);
    	var typeObj9 = document.all(preName + "xiaoji" +"$" +numflag);
    	if(typeObj9.value != "")
    	sum2+=parseFloat(typeObj9.value);

    	document.all(preName + "zongji"+"$" +numflag ).value =   (Math.round(sum2*1000000))/1000000;

    	//总计的列求和。
    var totalsum2 = 0;
    for(i=1;i<=20;i++){
       var obj =  document.all(preName + "zongji" +"$" +i);
           if(obj.value != ""){
              totalsum2 += parseFloat(obj.value);
           }
      }
    document.all(preName1 + "zongji" ).value =     (Math.round(totalsum2*1000000))/1000000;

  }

  var sum1=0; //小计
  if(flag==1 ){
  	var typeObj3 = document.all(preName + "xiangmurenyuangongzi" +"$" +numflag);
  	if(typeObj3.value != "")
  	sum1+=parseFloat(typeObj3.value);
  	var typeObj4 = document.all(preName + "bangongfeiyong" +"$" +numflag);
  	if(typeObj4.value != "")
  	sum1+=parseFloat(typeObj4.value);
  	var typeObj5 = document.all(preName + "zichanshiyongfeiyong" +"$" +numflag);
  	if(typeObj5.value != "")
  	sum1+=parseFloat(typeObj5.value);
  	var typeObj6 = document.all(preName + "xuanchuanfeiyong" +"$" +numflag);
  	if(typeObj6.value != "")
  	sum1+=parseFloat(typeObj6.value);
  	var typeObj7 = document.all(preName + "chalvfei" +"$" +numflag);
  	if(typeObj7.value != "")
  	sum1+=parseFloat(typeObj7.value);
  	var typeObj8 = document.all(preName + "qitafeiyong" +"$" +numflag);
  	if(typeObj8.value != "")
  	sum1+=parseFloat(typeObj8.value);

  	document.all(preName + "xiaoji"+"$" +numflag ).value =   (Math.round(sum1*1000000))/1000000;

  	var obj2 = document.all(preName + "zhijiekuanwu" +"$" +numflag);
  	var temp =0;
    if(obj2.value != "")
    temp+=parseFloat(obj2.value);
  	document.all(preName + "zongji"+"$" +numflag).value =  (Math.round((sum1+ temp )*1000000))/1000000;


  	//小计的列求和。
    var totalsum3 = 0;
    for(i=1;i<=20;i++){
       var obj =  document.all(preName + "xiaoji" +"$" +i);
           if(obj.value != ""){
              totalsum3 += parseFloat(obj.value);
           }
      }
    document.all(preName1 + "xiaoji" ).value =  (Math.round(totalsum3*1000000))/1000000;


    //总计的列求和。
    var totalsum2 = 0;
    for(i=1;i<=20;i++){
       var obj =  document.all(preName + "zongji" +"$" +i);
           if(obj.value != ""){
              totalsum2 += parseFloat(obj.value);
           }
      }
    document.all(preName1 + "zongji" ).value =  (Math.round(totalsum2*1000000))/1000000;

  }
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
	width:98%;
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
	<model:dataset id="somJxMajorDetailDataSet" cmd="com.inspur.cams.sorg.jxcheck.somjxmajordetail.cmd.SomJxMajorDetailQueryCommand" global="true" method="queryNoPage">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxmajordetail.dao.SomJxMajorDetail"></model:record>
	</model:dataset>
</model:datasets>
<div id="float">
	<input type="button" value="下一页" style="height: 25px; width: 80px; position: absolute; margin-left: 120px;" onclick="nextPageJ('19')" />
	<input type="button" value="上一页" style="height: 25px; width: 80px; position: absolute; margin-left: 20px;" onclick="nextPageJ('17')" />
	<input type="button" value="保存" style="height: 25px; width: 80px; position: absolute; margin-left: 220px;" onclick="save();" />
	<input type="button" value="返回" style="height: 25px; width: 80px; position: absolute; margin-left: 320px;" onclick="backJ();" />
</div>

<div align=center>
<div align=center style="width: 800px">
<form dataset="" name="myform" method="post" onsubmit="return false">
<TABLE cellSpacing=0 cellPadding=0 width=800 align=center border=0>
	<TBODY>
		<TR>
			<TD width='33%' height=51><STRONG class=word-st-14>（六）重大公益项目收支明细表</STRONG></TD>
		</TR>
	</TBODY>
</TABLE>
<TABLE class='word-st-14 border-tl' id=table1 cellSpacing=0
	cellPadding=0 width=800 align=center border=0>
	<TBODY>
		<TR>
			<TD align=center width=85 rowSpan=3>项目名称</TD>
			<TD align=center width=53 rowSpan=3>收入</TD>
			<TD align=center colSpan=9 height=30>支出 <strong>（单位：<span style="color:red">元</span>）</strong>
			</TD>
		</TR>
		<TR>
			<TD width=53 rowSpan=2>直接用于受助人的款物</TD>
			<TD height=53 colSpan=7 align='center'>项目直接成本</TD>
			<TD width=53 rowSpan=2 align='center'>总计</TD>
		</TR>
		<TR>
			<TD width=53 height=66>采购费用</TD>
			<TD width=53>人员报酬</TD>
			<TD width=53>资产使用费用</TD>
			<TD width=53>宣传推广费用</TD>
			<TD width=53>差旅等费用</TD>
			<TD width=53>其他费用</TD>
			<TD width=53>小计</TD>
		</TR>
		<TR>
			<TD  height=32>1.<textarea
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$1'
				onKeyDown="textCounter(query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$1,30);"
				onKeyUp="textCounter(query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$1,30);"
				ID='子表.项目名称$1' CLASS='input-01' ROWS='3' style='width:80%' COLS='11' limit='30'
				></textarea></TD>
			<TD align=middle  height=32><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$shouru$1' value='' ID='收入'
				CLASS='input-01' SIZE='11' MAXLENGTH='15' onblur='checkFloat(this);'onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(1,1,0);"
				style='text-align:right;padding-right:2px;'
				></TD>
			<TD align=middle ><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zhijiekuanwu$1' value=''
				ID='直接款物' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(2,1,0);"
				style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle ><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmurenyuangongzi$1'
				value='' ID='项目人员工资' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(3,1,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle ><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$bangongfeiyong$1' value=''
				ID='办公费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(4,1,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle ><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zichanshiyongfeiyong$1'
				value='' ID='资产使用费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(5,1,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle ><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xuanchuanfeiyong$1' value=''
				ID='宣传费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(6,1,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle ><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$chalvfei$1' value=''
				ID='差旅费' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(7,1,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle ><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$qitafeiyong$1' value=''
				ID='其他费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(8,1,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle ><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiaoji$1' value='' ID='小计'
				CLASS='input-01' SIZE='11' style='text-align:right;padding-right:2px;' readonly></TD>
			<TD align=middle ><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zongji$1' value='' ID='总计'
				CLASS='input-01' SIZE='11' style='text-align:right;padding-right:2px;' readonly></TD>
		</TR>
		<TR>
			<TD  height=32>2.<textarea
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$2'
				onKeyDown="textCounter(query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$2,30);"
				onKeyUp="textCounter(query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$2,30);"
				ID='子表.项目名称$22' CLASS='input-01' ROWS='3' style='width:80%' COLS='11' limit='30'
				></textarea></TD>
			<TD align=middle  height=32><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$shouru$2' value='' ID='收入'
				CLASS='input-01' SIZE='11' MAXLENGTH='15' onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(1,2,0);"style='text-align:right;padding-right:2px;'
				></TD>
			<TD align=middle ><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zhijiekuanwu$2' value=''
				ID='直接款物' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(2,2,0);"style='text-align:right;padding-right:2px;' style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle ><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmurenyuangongzi$2'
				value='' ID='项目人员工资' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(3,2,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle ><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$bangongfeiyong$2' value=''
				ID='办公费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(4,2,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle ><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zichanshiyongfeiyong$2'
				value='' ID='资产使用费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(5,2,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle ><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xuanchuanfeiyong$2' value=''
				ID='宣传费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(6,2,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle ><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$chalvfei$2' value=''
				ID='差旅费' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(7,2,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle ><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$qitafeiyong$2' value=''
				ID='其他费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(8,2,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle ><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiaoji$2' value='' ID='小计'
				CLASS='input-01' SIZE='11' style='text-align:right;padding-right:2px;' readonly></TD>
			<TD align=middle ><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zongji$2' value='' ID='总计'
				CLASS='input-01' SIZE='11' style='text-align:right;padding-right:2px;' readonly></TD>
		</TR>
		<TR>
			<TD height=32>3.<textarea
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$3'
				onKeyDown="textCounter(query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$3,30);"
				onKeyUp="textCounter(query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$3,30);"
				ID='子表.项目名称$22' CLASS='input-01' ROWS='3' style='width:80%' COLS='11' limit='30'
				></textarea></TD>
			<TD align=middle height=32><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$shouru$3' value='' ID='收入'
				CLASS='input-01' SIZE='11' MAXLENGTH='15' onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(1,3,0);"style='text-align:right;padding-right:2px;'
				></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zhijiekuanwu$3' value=''
				ID='直接款物' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(2,3,0);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmurenyuangongzi$3'
				value='' ID='项目人员工资' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(3,3,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$bangongfeiyong$3' value=''
				ID='办公费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(4,3,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zichanshiyongfeiyong$3'
				value='' ID='资产使用费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(5,3,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xuanchuanfeiyong$3' value=''
				ID='宣传费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(6,3,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$chalvfei$3' value=''
				ID='差旅费' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(7,3,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$qitafeiyong$3' value=''
				ID='其他费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(8,3,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiaoji$3' value='' ID='小计'
				CLASS='input-01' SIZE='11' style='text-align:right;padding-right:2px;' readonly></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zongji$3' value='' ID='总计'
				CLASS='input-01' SIZE='11' style='text-align:right;padding-right:2px;' readonly></TD>
		</TR>
		<TR>
			<TD height=32>4.<textarea
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$4'
				onKeyDown="textCounter(query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$4,30);"
				onKeyUp="textCounter(query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$4,30);"
				ID='子表.项目名称$22' CLASS='input-01' ROWS='3' style='width:80%' COLS='11' limit='30'
				></textarea></TD>
			<TD align=middle height=32><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$shouru$4' value='' ID='收入'
				CLASS='input-01' SIZE='11' MAXLENGTH='15' onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(1,4,0);"style='text-align:right;padding-right:2px;'
				></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zhijiekuanwu$4' value=''
				ID='直接款物' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(2,4,0);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmurenyuangongzi$4'
				value='' ID='项目人员工资' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(3,4,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$bangongfeiyong$4' value=''
				ID='办公费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(4,4,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zichanshiyongfeiyong$4'
				value='' ID='资产使用费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(5,4,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xuanchuanfeiyong$4' value=''
				ID='宣传费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(6,4,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$chalvfei$4' value=''
				ID='差旅费' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(7,4,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$qitafeiyong$4' value=''
				ID='其他费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(8,4,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiaoji$4' value='' ID='小计'
				CLASS='input-01' SIZE='11' style='text-align:right;padding-right:2px;' readonly></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zongji$4' value='' ID='总计'
				CLASS='input-01' SIZE='11' style='text-align:right;padding-right:2px;' readonly></TD>
		</TR>
		<TR>
			<TD height=32>5.<textarea
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$5'
				onKeyDown="textCounter(query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$5,30);"
				onKeyUp="textCounter(query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$5,30);"
				ID='子表.项目名称$22' CLASS='input-01' ROWS='3' style='width:80%' COLS='11' limit='30'
				></textarea></TD>
			<TD align=middle height=32><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$shouru$5' value='' ID='收入'
				CLASS='input-01' SIZE='11' MAXLENGTH='15' onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(1,5,0);"style='text-align:right;padding-right:2px;'
				></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zhijiekuanwu$5' value=''
				ID='直接款物' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(2,5,0);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmurenyuangongzi$5'
				value='' ID='项目人员工资' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(3,5,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$bangongfeiyong$5' value=''
				ID='办公费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(4,5,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zichanshiyongfeiyong$5'
				value='' ID='资产使用费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(5,5,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xuanchuanfeiyong$5' value=''
				ID='宣传费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(6,5,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$chalvfei$5' value=''
				ID='差旅费' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(7,5,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$qitafeiyong$5' value=''
				ID='其他费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(8,5,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiaoji$5' value='' ID='小计'
				CLASS='input-01' SIZE='11' style='text-align:right;padding-right:2px;' readonly></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zongji$5' value='' ID='总计'
				CLASS='input-01' SIZE='11' style='text-align:right;padding-right:2px;' readonly></TD>
		</TR>
		<TR>
			<TD height=32>6.<textarea
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$6'
				onKeyDown="textCounter(query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$6,30);"
				onKeyUp="textCounter(query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$6,30);"
				ID='子表.项目名称$22' CLASS='input-01' ROWS='3' style='width:80%' COLS='11' limit='30'
				></textarea></TD>
			<TD align=middle height=32><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$shouru$6' value='' ID='收入'
				CLASS='input-01' SIZE='11' MAXLENGTH='15' onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(1,6,0);"style='text-align:right;padding-right:2px;'
				></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zhijiekuanwu$6' value=''
				ID='直接款物' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(2,6,0);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmurenyuangongzi$6'
				value='' ID='项目人员工资' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(3,6,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$bangongfeiyong$6' value=''
				ID='办公费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(4,6,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zichanshiyongfeiyong$6'
				value='' ID='资产使用费用' CLASS='input-01' SIZE='11'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(5,6,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xuanchuanfeiyong$6' value=''
				ID='宣传费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(6,6,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$chalvfei$6' value=''
				ID='差旅费' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(7,6,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$qitafeiyong$6' value=''
				ID='其他费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(8,6,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiaoji$6' value='' ID='小计'
				CLASS='input-01' SIZE='11' style='text-align:right;padding-right:2px;' readonly></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zongji$6' value='' ID='总计'
				CLASS='input-01' SIZE='11' style='text-align:right;padding-right:2px;' readonly></TD>
		</TR>
		<TR>
			<TD height=32>7.<textarea
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$7'
				onKeyDown="textCounter(query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$7,30);"
				onKeyUp="textCounter(query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$7,30);"
				ID='子表.项目名称$22' CLASS='input-01' ROWS='3' style='width:80%' COLS='11' limit='30'
				></textarea></TD>
			<TD align=middle height=32><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$shouru$7' value='' ID='收入'
				CLASS='input-01' SIZE='11' MAXLENGTH='15' onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(1,7,0);"style='text-align:right;padding-right:2px;'
				></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zhijiekuanwu$7' value=''
				ID='直接款物' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(2,7,0);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmurenyuangongzi$7'
				value='' ID='项目人员工资' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(3,7,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$bangongfeiyong$7' value=''
				ID='办公费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(4,7,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zichanshiyongfeiyong$7'
				value='' ID='资产使用费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(5,7,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xuanchuanfeiyong$7' value=''
				ID='宣传费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(6,7,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$chalvfei$7' value=''
				ID='差旅费' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(7,7,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$qitafeiyong$7' value=''
				ID='其他费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(8,7,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiaoji$7' value='' ID='小计'
				CLASS='input-01' SIZE='11' style='text-align:right;padding-right:2px;' readonly></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zongji$7' value='' ID='总计'
				CLASS='input-01' SIZE='11' style='text-align:right;padding-right:2px;' readonly></TD>
		</TR>
		<TR>
			<TD height=32>8.<textarea
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$8'
				onKeyDown="textCounter(query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$8,30);"
				onKeyUp="textCounter(query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$8,30);"
				ID='子表.项目名称$22' CLASS='input-01' ROWS='3' style='width:80%' COLS='11' limit='30'
				></textarea></TD>
			<TD align=middle height=32><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$shouru$8' value='' ID='收入'
				CLASS='input-01' SIZE='11' MAXLENGTH='15' onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(1,8,0);"style='text-align:right;padding-right:2px;'
				></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zhijiekuanwu$8' value=''
				ID='直接款物' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(2,8,0);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmurenyuangongzi$8'
				value='' ID='项目人员工资' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(3,8,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$bangongfeiyong$8' value=''
				ID='办公费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(4,8,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zichanshiyongfeiyong$8'
				value='' ID='资产使用费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(5,8,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xuanchuanfeiyong$8' value=''
				ID='宣传费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(6,8,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$chalvfei$8' value=''
				ID='差旅费' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(7,8,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$qitafeiyong$8' value=''
				ID='其他费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(8,8,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiaoji$8' value='' ID='小计'
				CLASS='input-01' SIZE='11' style='text-align:right;padding-right:2px;' readonly></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zongji$8' value='' ID='总计'
				CLASS='input-01' SIZE='11' style='text-align:right;padding-right:2px;' readonly></TD>
		</TR>
		<TR>
			<TD height=32>9.<textarea
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$9'
				onKeyDown="textCounter(query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$9,30);"
				onKeyUp="textCounter(query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$9,30);"
				ID='子表.项目名称$22' CLASS='input-01' ROWS='3' style='width:80%' COLS='11' limit='30'
				></textarea></TD>
			<TD align=middle height=32><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$shouru$9' value='' ID='收入'
				CLASS='input-01' SIZE='11' MAXLENGTH='15' onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(1,9,0);"style='text-align:right;padding-right:2px;'
				></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zhijiekuanwu$9' value=''
				ID='直接款物' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(2,9,0);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmurenyuangongzi$9'
				value='' ID='项目人员工资' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(3,9,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$bangongfeiyong$9' value=''
				ID='办公费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(4,9,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zichanshiyongfeiyong$9'
				value='' ID='资产使用费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(5,9,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xuanchuanfeiyong$9' value=''
				ID='宣传费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(6,9,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$chalvfei$9' value=''
				ID='差旅费' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(7,9,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$qitafeiyong$9' value=''
				ID='其他费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(8,9,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiaoji$9' value='' ID='小计'
				CLASS='input-01' SIZE='11' style='text-align:right;padding-right:2px;' readonly></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zongji$9' value='' ID='总计'
				CLASS='input-01' SIZE='11' style='text-align:right;padding-right:2px;' readonly></TD>
		</TR>
		<TR>
			<TD height=32>10.<textarea
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$10'
				onKeyDown="textCounter(query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$10,30);"
				onKeyUp="textCounter(query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$10,30);"
				ID='子表.项目名称$22' CLASS='input-01' ROWS='3' style='width:80%' COLS='11' limit='30'
				></textarea></TD>
			<TD align=middle height=32><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$shouru$10' value='' ID='收入'
				CLASS='input-01' SIZE='11' MAXLENGTH='15' onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(1,10,0);"style='text-align:right;padding-right:2px;'
				></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zhijiekuanwu$10' value=''
				ID='直接款物' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(2,10,0);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmurenyuangongzi$10'
				value='' ID='项目人员工资' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(3,10,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$bangongfeiyong$10' value=''
				ID='办公费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(4,10,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zichanshiyongfeiyong$10'
				value='' ID='资产使用费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(5,10,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xuanchuanfeiyong$10'
				value='' ID='宣传费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(6,10,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$chalvfei$10' value=''
				ID='差旅费' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(7,10,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$qitafeiyong$10' value=''
				ID='其他费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(8,10,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiaoji$10' value='' ID='小计'
				CLASS='input-01' SIZE='11' style='text-align:right;padding-right:2px;' readonly></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zongji$10' value='' ID='总计'
				CLASS='input-01' SIZE='11' style='text-align:right;padding-right:2px;' readonly></TD>
		</TR>
		<tr>
			<TD  height=32>11.<textarea
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$11'
				onKeyDown="textCounter(query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$11,30);"
				onKeyUp="textCounter(query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$11,30);"
				ID='子表.项目名称$122' CLASS='input-01' ROWS='3' style='width:80%' COLS='11' limit='30'
				></textarea></TD>
			<TD align=middle  height=32><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$shouru$11' value='' ID='收入'
				CLASS='input-01' SIZE='11' MAXLENGTH='15' onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(1,11,0);"style='text-align:right;padding-right:2px;'
				></TD>
			<TD align=middle ><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zhijiekuanwu$11' value=''
				ID='直接款物' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(2,11,0);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle ><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmurenyuangongzi$11'
				value='' ID='项目人员工资' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(3,11,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle ><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$bangongfeiyong$11' value=''
				ID='办公费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(4,11,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle ><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zichanshiyongfeiyong$11'
				value='' ID='资产使用费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(5,11,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle ><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xuanchuanfeiyong$11'
				value='' ID='宣传费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(6,11,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle ><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$chalvfei$11' value=''
				ID='差旅费' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(7,11,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle ><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$qitafeiyong$11' value=''
				ID='其他费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(8,11,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle ><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiaoji$11' value='' ID='小计'
				CLASS='input-01' SIZE='11' style='text-align:right;padding-right:2px;' readonly></TD>
			<TD align=middle ><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zongji$11' value='' ID='总计'
				CLASS='input-01' SIZE='11' style='text-align:right;padding-right:2px;' readonly></TD>
		</TR>
		<TR>
			<TD  height=32>12.<textarea
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$12'
				onKeyDown="textCounter(query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$12,30);"
				onKeyUp="textCounter(query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$12,30);"
				ID='子表.项目名称$122' CLASS='input-01' ROWS='3' style='width:80%' COLS='11' limit='30'
				></textarea></TD>
			<TD align=middle  height=32><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$shouru$12' value='' ID='收入'
				CLASS='input-01' SIZE='11' MAXLENGTH='15' onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(1,12,0);"style='text-align:right;padding-right:2px;'style='text-align:right;padding-right:2px;'
				></TD>
			<TD align=middle ><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zhijiekuanwu$12' value=''
				ID='直接款物' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(2,12,0);"style='text-align:right;padding-right:2px;' style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle ><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmurenyuangongzi$12'
				value='' ID='项目人员工资' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(3,12,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle ><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$bangongfeiyong$12' value=''
				ID='办公费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(4,12,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle ><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zichanshiyongfeiyong$12'
				value='' ID='资产使用费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(5,12,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle ><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xuanchuanfeiyong$12'
				value='' ID='宣传费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(6,12,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle ><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$chalvfei$12' value=''
				ID='差旅费' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(7,12,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle ><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$qitafeiyong$12' value=''
				ID='其他费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(8,12,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle ><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiaoji$12' value='' ID='小计'
				CLASS='input-01' SIZE='11' style='text-align:right;padding-right:2px;' readonly></TD>
			<TD align=middle ><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zongji$12' value='' ID='总计'
				CLASS='input-01' SIZE='11' style='text-align:right;padding-right:2px;' readonly></TD>
		</TR>
		<TR>
			<TD height=32>13.<textarea
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$13'
				onKeyDown="textCounter(query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$13,30);"
				onKeyUp="textCounter(query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$13,30);"
				ID='子表.项目名称$122' CLASS='input-01' ROWS='3' style='width:80%' COLS='11' limit='30'
				></textarea></TD>
			<TD align=middle height=32><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$shouru$13' value='' ID='收入'
				CLASS='input-01' SIZE='11' MAXLENGTH='15' onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(1,13,0);"style='text-align:right;padding-right:2px;'
				></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zhijiekuanwu$13' value=''
				ID='直接款物' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(2,13,0);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmurenyuangongzi$13'
				value='' ID='项目人员工资' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(3,13,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$bangongfeiyong$13' value=''
				ID='办公费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(4,13,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zichanshiyongfeiyong$13'
				value='' ID='资产使用费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(5,13,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xuanchuanfeiyong$13'
				value='' ID='宣传费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(6,13,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$chalvfei$13' value=''
				ID='差旅费' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(7,13,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$qitafeiyong$13' value=''
				ID='其他费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(8,13,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiaoji$13' value='' ID='小计'
				CLASS='input-01' SIZE='11' style='text-align:right;padding-right:2px;' readonly></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zongji$13' value='' ID='总计'
				CLASS='input-01' SIZE='11' style='text-align:right;padding-right:2px;' readonly></TD>
		</TR>
		<TR>
			<TD height=32>14.<textarea
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$14'
				onKeyDown="textCounter(query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$14,30);"
				onKeyUp="textCounter(query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$14,30);"
				ID='子表.项目名称$122' CLASS='input-01' ROWS='3' style='width:80%' COLS='11' limit='30'
				></textarea></TD>
			<TD align=middle height=32><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$shouru$14' value='' ID='收入'
				CLASS='input-01' SIZE='11' MAXLENGTH='15' onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(1,14,0);"style='text-align:right;padding-right:2px;'
				></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zhijiekuanwu$14' value=''
				ID='直接款物' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(2,14,0);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmurenyuangongzi$14'
				value='' ID='项目人员工资' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(3,14,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$bangongfeiyong$14' value=''
				ID='办公费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(4,14,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zichanshiyongfeiyong$14'
				value='' ID='资产使用费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(5,14,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xuanchuanfeiyong$14'
				value='' ID='宣传费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(6,14,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$chalvfei$14' value=''
				ID='差旅费' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(7,14,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$qitafeiyong$14' value=''
				ID='其他费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(8,14,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiaoji$14' value='' ID='小计'
				CLASS='input-01' SIZE='11' style='text-align:right;padding-right:2px;' readonly></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zongji$14' value='' ID='总计'
				CLASS='input-01' SIZE='11' style='text-align:right;padding-right:2px;' readonly></TD>
		</TR>
		<TR>
			<TD height=32>15.<textarea
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$15'
				onKeyDown="textCounter(query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$15,30);"
				onKeyUp="textCounter(query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$15,30);"
				ID='子表.项目名称$122' CLASS='input-01' ROWS='3' style='width:80%' COLS='11' limit='30'
				></textarea></TD>
			<TD align=middle height=32><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$shouru$15' value='' ID='收入'
				CLASS='input-01' SIZE='11' MAXLENGTH='15' onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(1,15,0);"style='text-align:right;padding-right:2px;'
				></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zhijiekuanwu$15' value=''
				ID='直接款物' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(2,15,0);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmurenyuangongzi$15'
				value='' ID='项目人员工资' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(3,15,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$bangongfeiyong$15' value=''
				ID='办公费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(4,15,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zichanshiyongfeiyong$15'
				value='' ID='资产使用费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(5,15,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xuanchuanfeiyong$15'
				value='' ID='宣传费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(6,15,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$chalvfei$15' value=''
				ID='差旅费' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(7,15,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$qitafeiyong$15' value=''
				ID='其他费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(8,15,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiaoji$15' value='' ID='小计'
				CLASS='input-01' SIZE='11' style='text-align:right;padding-right:2px;' readonly></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zongji$15' value='' ID='总计'
				CLASS='input-01' SIZE='11' style='text-align:right;padding-right:2px;' readonly></TD>
		</TR>
		<TR>
			<TD height=32>16.<textarea
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$16'
				onKeyDown="textCounter(query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$16,30);"
				onKeyUp="textCounter(query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$16,30);"
				ID='子表.项目名称$122' CLASS='input-01' ROWS='3' style='width:80%' COLS='11' limit='30'
				></textarea></TD>
			<TD align=middle height=32><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$shouru$16' value='' ID='收入'
				CLASS='input-01' SIZE='11' MAXLENGTH='15' onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(1,16,0);"style='text-align:right;padding-right:2px;'
				></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zhijiekuanwu$16' value=''
				ID='直接款物' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(2,16,0);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmurenyuangongzi$16'
				value='' ID='项目人员工资' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(3,16,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$bangongfeiyong$16' value=''
				ID='办公费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(4,16,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zichanshiyongfeiyong$16'
				value='' ID='资产使用费用' CLASS='input-01' SIZE='11'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(5,16,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xuanchuanfeiyong$16'
				value='' ID='宣传费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(6,16,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$chalvfei$16' value=''
				ID='差旅费' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(7,16,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$qitafeiyong$16' value=''
				ID='其他费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(8,16,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiaoji$16' value='' ID='小计'
				CLASS='input-01' SIZE='11' style='text-align:right;padding-right:2px;' readonly></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zongji$16' value='' ID='总计'
				CLASS='input-01' SIZE='11' style='text-align:right;padding-right:2px;' readonly></TD>
		</TR>
		<TR>
			<TD height=32>17.<textarea
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$17'
				onKeyDown="textCounter(query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$17,30);"
				onKeyUp="textCounter(query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$17,30);"
				ID='子表.项目名称$122' CLASS='input-01' ROWS='3' style='width:80%' COLS='11' limit='30'
				></textarea></TD>
			<TD align=middle height=32><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$shouru$17' value='' ID='收入'
				CLASS='input-01' SIZE='11' MAXLENGTH='15' onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(1,17,0);"style='text-align:right;padding-right:2px;'
				></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zhijiekuanwu$17' value=''
				ID='直接款物' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(2,17,0);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmurenyuangongzi$17'
				value='' ID='项目人员工资' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(3,17,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$bangongfeiyong$17' value=''
				ID='办公费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(4,17,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zichanshiyongfeiyong$17'
				value='' ID='资产使用费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(5,17,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xuanchuanfeiyong$17'
				value='' ID='宣传费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(6,17,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$chalvfei$17' value=''
				ID='差旅费' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(7,17,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$qitafeiyong$17' value=''
				ID='其他费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(8,17,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiaoji$17' value='' ID='小计'
				CLASS='input-01' SIZE='11' style='text-align:right;padding-right:2px;' readonly></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zongji$17' value='' ID='总计'
				CLASS='input-01' SIZE='11' style='text-align:right;padding-right:2px;' readonly></TD>
		</TR>
		<TR>
			<TD height=32>18.<textarea
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$18'
				onKeyDown="textCounter(query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$18,30);"
				onKeyUp="textCounter(query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$18,30);"
				ID='子表.项目名称$122' CLASS='input-01' ROWS='3' style='width:80%' COLS='11' limit='30'
				></textarea></TD>
			<TD align=middle height=32><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$shouru$18' value='' ID='收入'
				CLASS='input-01' SIZE='11' MAXLENGTH='15' onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(1,18,0);"style='text-align:right;padding-right:2px;'
				></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zhijiekuanwu$18' value=''
				ID='直接款物' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(2,18,0);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmurenyuangongzi$18'
				value='' ID='项目人员工资' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(3,18,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$bangongfeiyong$18' value=''
				ID='办公费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(4,18,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zichanshiyongfeiyong$18'
				value='' ID='资产使用费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(5,18,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xuanchuanfeiyong$18'
				value='' ID='宣传费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(6,18,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$chalvfei$18' value=''
				ID='差旅费' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(7,18,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$qitafeiyong$18' value=''
				ID='其他费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(8,18,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiaoji$18' value='' ID='小计'
				CLASS='input-01' SIZE='11' style='text-align:right;padding-right:2px;' readonly></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zongji$18' value='' ID='总计'
				CLASS='input-01' SIZE='11' style='text-align:right;padding-right:2px;' readonly></TD>
		</TR>
		<TR>
			<TD height=32>19.<textarea
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$19'
				onKeyDown="textCounter(query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$19,30);"
				onKeyUp="textCounter(query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$19,30);"
				ID='子表.项目名称$122' CLASS='input-01' ROWS='3' style='width:80%' COLS='11' limit='30'
				></textarea></TD>
			<TD align=middle height=32><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$shouru$19' value='' ID='收入'
				CLASS='input-01' SIZE='11' MAXLENGTH='15' onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(1,19,0);"style='text-align:right;padding-right:2px;'
				></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zhijiekuanwu$19' value=''
				ID='直接款物' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(2,19,0);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmurenyuangongzi$19'
				value='' ID='项目人员工资' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(3,19,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$bangongfeiyong$19' value=''
				ID='办公费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(4,19,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zichanshiyongfeiyong$19'
				value='' ID='资产使用费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(5,19,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xuanchuanfeiyong$19'
				value='' ID='宣传费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(6,19,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$chalvfei$19' value=''
				ID='差旅费' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(7,19,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$qitafeiyong$19' value=''
				ID='其他费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(8,19,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiaoji$19' value='' ID='小计'
				CLASS='input-01' SIZE='11' style='text-align:right;padding-right:2px;' readonly></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zongji$19' value='' ID='总计'
				CLASS='input-01' SIZE='11' style='text-align:right;padding-right:2px;' readonly></TD>
		</TR>
		<TR>
			<TD height=32>20.<textarea
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$20'
				onKeyDown="textCounter(query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$20,30);"
				onKeyUp="textCounter(query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$20,30);"
				ID='子表.项目名称$122' CLASS='input-01' ROWS='3' style='width:80%' COLS='11' limit='30'
				></textarea></TD>
			<TD align=middle height=32><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$shouru$20' value='' ID='收入'
				CLASS='input-01' SIZE='11' MAXLENGTH='15' onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(1,20,0);"style='text-align:right;padding-right:2px;'
				></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zhijiekuanwu$20' value=''
				ID='直接款物' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(2,20,0);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmurenyuangongzi$20'
				value='' ID='项目人员工资' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(3,20,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$bangongfeiyong$20' value=''
				ID='办公费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(4,20,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zichanshiyongfeiyong$20'
				value='' ID='资产使用费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(5,20,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xuanchuanfeiyong$20'
				value='' ID='宣传费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(6,20,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$chalvfei$20' value=''
				ID='差旅费' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(7,20,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$qitafeiyong$20' value=''
				ID='其他费用' CLASS='input-01' SIZE='11' MAXLENGTH='15'
				onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSum(8,20,1);" style='text-align:right;padding-right:2px;'></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiaoji$20' value='' ID='小计'
				CLASS='input-01' SIZE='11' style='text-align:right;padding-right:2px;' readonly></TD>
			<TD align=middle><input
				name='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zongji$20' value='' ID='总计'
				CLASS='input-01' SIZE='11' style='text-align:right;padding-right:2px;' readonly></TD>
		</tr>
		<TR>
			<TD align=middle  height=32>合 计</TD>
			<TD align=middle  height=32><input
				name='query$form$0$JJHNJ_ZHDGYXMSHZ$shouru' value='' ID='收入'
				CLASS='input-01' SIZE='11' style='text-align:right;padding-right:2px;' readonly></TD>
			<TD align=middle ><input
				name='query$form$0$JJHNJ_ZHDGYXMSHZ$zhijiekuanwu' value='' ID='直接款物'
				CLASS='input-01' SIZE='11' style='text-align:right;padding-right:2px;' readonly></TD>
			<TD align=middle ><input
				name='query$form$0$JJHNJ_ZHDGYXMSHZ$xiangmurenyuangongzi' value=''
				ID='项目人员工资' CLASS='input-01' SIZE='11' style='text-align:right;padding-right:2px;' readonly></TD>
			<TD align=middle ><input
				name='query$form$0$JJHNJ_ZHDGYXMSHZ$bangongfeiyong' value=''
				ID='办公费用' CLASS='input-01' SIZE='11' style='text-align:right;padding-right:2px;' readonly></TD>
			<TD align=middle ><input
				name='query$form$0$JJHNJ_ZHDGYXMSHZ$zichanshiyongfeiyong' value=''
				ID='资产使用费用' CLASS='input-01' SIZE='11' style='text-align:right;padding-right:2px;' readonly></TD>
			<TD align=middle ><input
				name='query$form$0$JJHNJ_ZHDGYXMSHZ$xuanchuanfeiyong' value=''
				ID='宣传费用' CLASS='input-01' SIZE='11' style='text-align:right;padding-right:2px;' readonly></TD>
			<TD align=middle ><input
				name='query$form$0$JJHNJ_ZHDGYXMSHZ$chalvfei' value='' ID='差旅费'
				CLASS='input-01' SIZE='11' style='text-align:right;padding-right:2px;' readonly></TD>
			<TD align=middle ><input
				name='query$form$0$JJHNJ_ZHDGYXMSHZ$qitafeiyong' value='' ID='其他费用'
				CLASS='input-01' SIZE='11' style='text-align:right;padding-right:2px;' readonly></TD>
			<TD align=middle ><input
				name='query$form$0$JJHNJ_ZHDGYXMSHZ$xiaoji' value='' ID='小计'
				CLASS='input-01' SIZE='11' style='text-align:right;padding-right:2px;' readonly></TD>
			<TD align=middle ><input
				name='query$form$0$JJHNJ_ZHDGYXMSHZ$zongji' value='' ID='总计'
				CLASS='input-01' SIZE='11' style='text-align:right;padding-right:2px;' readonly></TD>
		</TR>
	</TBODY>
</TABLE>
<TABLE cellSpacing=0 cellPadding=0 width=645 align=center border=0>
	<tr align='left'>
		<td class='word-st-14'>说明：<BR>
		满足下列条件之一的公益项目应填列此表：<BR>
		1、项目捐赠收入超过当年捐赠收入的20%以上的项目应填列本表。<BR>
		2、项目支出超过当年基金会总支出20%以上的项目应填列本表。<BR>
		3、项目持续时间在2年以上的（包括2年）。</td>
	</tr>
</table>
<TABLE align='center'>
	<tr valign=bottom align='center'>
		<td width='100%' height='27' align=center valign=bottom><br>
		第14页</td>
	</tr>
</TABLE>

</form>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
</div>
</div>
</body>
</html>
