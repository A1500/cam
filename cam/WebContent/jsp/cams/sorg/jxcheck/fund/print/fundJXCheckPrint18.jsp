<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<script language="javascript">
//var taskCode='<%=request.getParameter("taskCode")%>';
//初始化
function init18(){
	var somJxMajorDetailDataSet = L5.DatasetMgr.lookup("somJxMajorDetailDataSet");
	somJxMajorDetailDataSet.setParameter("TASK_CODE@=", taskCode);
	somJxMajorDetailDataSet.load();
	somJxMajorDetailDataSet.on("load",function(ds){
		if(ds.getCount()!=0){
			for(i=0;i<ds.getCount();i++){
				var record = ds.getAt(i);
				var tab1 = document.getElementById("table1_18");
				tab1.rows[i+3].cells[0].getElementsByTagName("label")[0].innerHTML=record.get("projectName");
				tab1.rows[i+3].cells[1].getElementsByTagName("label")[0].innerHTML=record.get("income");
				tab1.rows[i+3].cells[2].getElementsByTagName("label")[0].innerHTML=record.get("toPersonCash");
				tab1.rows[i+3].cells[3].getElementsByTagName("label")[0].innerHTML=record.get("salaryCash");
				tab1.rows[i+3].cells[4].getElementsByTagName("label")[0].innerHTML=record.get("officeCash");
				tab1.rows[i+3].cells[5].getElementsByTagName("label")[0].innerHTML=record.get("assetsCash");
				tab1.rows[i+3].cells[6].getElementsByTagName("label")[0].innerHTML=record.get("publicityCash");
				tab1.rows[i+3].cells[7].getElementsByTagName("label")[0].innerHTML=record.get("travalCash");
				tab1.rows[i+3].cells[8].getElementsByTagName("label")[0].innerHTML=record.get("otherCash");
				tab1.rows[i+3].cells[9].getElementsByTagName("label")[0].innerHTML=record.get("moneySum");
				tab1.rows[i+3].cells[10].getElementsByTagName("label")[0].innerHTML=record.get("total");
			}
		}
		setSumMoney_18();
	});
	//创建页面导航下拉框
	//createFundDetailSelect();
}
function save(){
	somJxMajorDetailDataSet.removeAll();
	var tab1 = document.getElementById("table1_18");
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
	}

	var somJxMajorDetailRecords=somJxMajorDetailDataSet.getAllRecords();
	var command = new L5.Command("com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckCommand");
	command.setParameter("somJxMajorDetailRecords", somJxMajorDetailRecords);
	command.setParameter("taskCode", taskCode);
	command.execute("savePageJ18");
	if (!command.error) {
		L5.Msg.alert("提示","保存成功！",function(){
		});
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
function setSumMoney_18(){
	for(var i=1;i<=20;i++){
		document.getElementById("query$form$0$JJHNJ_ZHDGYXMSHZ$shouru").innerHTML
		=setParseFloat("query$form$0$JJHNJ_ZHDGYXMSHZ$shouru","query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$shouru$"+i);
		document.getElementById("query$form$0$JJHNJ_ZHDGYXMSHZ$zhijiekuanwu").innerHTML
		=setParseFloat("query$form$0$JJHNJ_ZHDGYXMSHZ$zhijiekuanwu","query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zhijiekuanwu$"+i);

		document.getElementById("query$form$0$JJHNJ_ZHDGYXMSHZ$xiangmurenyuangongzi").innerHTML
		=setParseFloat("query$form$0$JJHNJ_ZHDGYXMSHZ$xiangmurenyuangongzi","query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmurenyuangongzi$"+i);
		document.getElementById("query$form$0$JJHNJ_ZHDGYXMSHZ$bangongfeiyong").innerHTML
		=setParseFloat("query$form$0$JJHNJ_ZHDGYXMSHZ$bangongfeiyong","query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$bangongfeiyong$"+i);

		document.getElementById("query$form$0$JJHNJ_ZHDGYXMSHZ$zichanshiyongfeiyong").innerHTML
		=setParseFloat("query$form$0$JJHNJ_ZHDGYXMSHZ$zichanshiyongfeiyong","query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zichanshiyongfeiyong$"+i);
		document.getElementById("query$form$0$JJHNJ_ZHDGYXMSHZ$xuanchuanfeiyong").innerHTML
		=setParseFloat("query$form$0$JJHNJ_ZHDGYXMSHZ$xuanchuanfeiyong","query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xuanchuanfeiyong$"+i);

		document.getElementById("query$form$0$JJHNJ_ZHDGYXMSHZ$chalvfei").innerHTML
		=setParseFloat("query$form$0$JJHNJ_ZHDGYXMSHZ$chalvfei","query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$chalvfei$"+i);
		document.getElementById("query$form$0$JJHNJ_ZHDGYXMSHZ$qitafeiyong").innerHTML
		=setParseFloat("query$form$0$JJHNJ_ZHDGYXMSHZ$qitafeiyong","query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$qitafeiyong$"+i);

		document.getElementById("query$form$0$JJHNJ_ZHDGYXMSHZ$xiaoji").innerHTML
		=setParseFloat("query$form$0$JJHNJ_ZHDGYXMSHZ$xiaoji","query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiaoji$"+i);
		document.getElementById("query$form$0$JJHNJ_ZHDGYXMSHZ$zongji").innerHTML
		=setParseFloat("query$form$0$JJHNJ_ZHDGYXMSHZ$zongji","query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zongji$"+i);
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
<style media="print">
	.noprint     { display: none }
</style>
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

#table1_18 td {
	border-right: 1px solid #000;
	border-bottom: 1px solid #000
}

.input-01_18 {
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
<model:datasets>
	<model:dataset id="somJxMajorDetailDataSet" cmd="com.inspur.cams.sorg.jxcheck.somjxmajordetail.cmd.SomJxMajorDetailQueryCommand" global="true" method="queryNoPage">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxmajordetail.dao.SomJxMajorDetail"></model:record>
	</model:dataset>
</model:datasets>
<div id="float_1" class="noprint">

</div>

<div align=center style='page-break-after:always'>
<div align=center style="width: 800px">
<form dataset="" name="myform" method="post" onsubmit="return false">
<TABLE cellSpacing=0 cellPadding=0 width=800 align=center border=0>
	<TBODY>
		<TR>
			<TD width='33%' height=51><STRONG class=word-st-14>（六）重大公益项目收支明细表</STRONG></TD>
		</TR>
	</TBODY>
</TABLE>
<TABLE class='word-st-14 border-tl' id=table1_18 cellSpacing=0
	cellPadding=0 width=800 align=center border=0>
	<TBODY>
		<TR>
			<TD align=center width=85 rowSpan=3>项目名称</TD>
			<TD align=center width=53 rowSpan=3>收入</TD>
			<TD align=center colSpan=9 height=30>支出 <strong>（单位：<span style="color:red">元</span>	）</strong>
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
			<TD  height=32>1.<label readonly="readonly"
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$1'
				ID='子表.项目名称$1' CLASS='input-01_18' ROWS='3' style='width:80%' COLS='11'
				></label></TD>
			<TD align=middle  height=32><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$shouru$1'  ID='收入'
				CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle ><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zhijiekuanwu$1'
				ID='直接款物' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle ><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmurenyuangongzi$1'
				 ID='项目人员工资' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle ><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$bangongfeiyong$1'
				ID='办公费用' CLASS='input-01_18'  style='text-align:right'></label></TD>
			<TD align=middle ><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zichanshiyongfeiyong$1'
				value='' ID='资产使用费用' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle ><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xuanchuanfeiyong$1'
				ID='宣传费用' CLASS='input-01_18'  style='text-align:right'></label></TD>
			<TD align=middle ><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$chalvfei$1'
				ID='差旅费' CLASS='input-01_18'  style='text-align:right'></label></TD>
			<TD align=middle ><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$qitafeiyong$1'
				ID='其他费用' CLASS='input-01_18'  style='text-align:right'></label></TD>
			<TD align=middle ><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiaoji$1' ID='小计'
				CLASS='input-01_18'  style='text-align:right'></label></TD>
			<TD align=middle ><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zongji$1'  ID='总计'
				CLASS='input-01_18'  style='text-align:right' ></label></TD>
		</TR>
		<TR>
			<TD  height=32>2.<label readonly="readonly"
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$2'
				ID='子表.项目名称$22' CLASS='input-01_18' ROWS='3' style='width:80%' COLS='11'
				></label></TD>
			<TD align=middle  height=32><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$shouru$2'  ID='收入'
				CLASS='input-01_18' style='text-align:right'
				></label></TD>
			<TD align=middle ><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zhijiekuanwu$2'
				ID='直接款物' CLASS='input-01_18'  style='text-align:right'></label></TD>
			<TD align=middle ><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmurenyuangongzi$2'
				 ID='项目人员工资' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle ><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$bangongfeiyong$2'
				ID='办公费用' CLASS='input-01_18'  style='text-align:right'></label></TD>
			<TD align=middle ><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zichanshiyongfeiyong$2'
				 ID='资产使用费用' CLASS='input-01_18'  style='text-align:right'></label></TD>
			<TD align=middle ><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xuanchuanfeiyong$2'
				ID='宣传费用' CLASS='input-01_18'  style='text-align:right'></label></TD>
			<TD align=middle ><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$chalvfei$2'
				ID='差旅费' CLASS='input-01_18'  style='text-align:right'></label></TD>
			<TD align=middle ><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$qitafeiyong$2'
				ID='其他费用' CLASS='input-01_18'  style='text-align:right'></label></TD>
			<TD align=middle ><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiaoji$2'  ID='小计'
				CLASS='input-01_18'  style='text-align:right' ></label></TD>
			<TD align=middle ><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zongji$2' ID='总计'
				CLASS='input-01_18'  style='text-align:right' ></label></TD>
		</TR>
		<TR>
			<TD height=32>3.<label readonly="readonly"
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$3'
				ID='子表.项目名称$22' CLASS='input-01_18' ROWS='3' style='width:80%' COLS='11'
				></label></TD>
			<TD align=middle height=32><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$shouru$3' ID='收入'
				CLASS='input-01_18' style='text-align:right'
				></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zhijiekuanwu$3'
				ID='直接款物' CLASS='input-01_18'  style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmurenyuangongzi$3'
				 ID='项目人员工资' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$bangongfeiyong$3'
				ID='办公费用' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zichanshiyongfeiyong$3'
				 ID='资产使用费用' CLASS='input-01_18'  style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xuanchuanfeiyong$3'
				ID='宣传费用' CLASS='input-01_18'  style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$chalvfei$3'
				ID='差旅费' CLASS='input-01_18'  style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$qitafeiyong$3'
				ID='其他费用' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiaoji$3'  ID='小计'
				CLASS='input-01_18'  style='text-align:right' ></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zongji$3' ID='总计'
				CLASS='input-01_18'  style='text-align:right' ></label></TD>
		</TR>
		<TR>
			<TD height=32>4.<label readonly="readonly"
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$4'
				ID='子表.项目名称$22' CLASS='input-01_18' ROWS='3' style='width:80%' COLS='11'
				></label></TD>
			<TD align=middle height=32><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$shouru$4' ID='收入'
				CLASS='input-01_18' style='text-align:right'
				></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zhijiekuanwu$4'
				ID='直接款物' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmurenyuangongzi$4'
				 ID='项目人员工资' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$bangongfeiyong$4'
				ID='办公费用' CLASS='input-01_18'  style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zichanshiyongfeiyong$4'
				value='' ID='资产使用费用' CLASS='input-01_18'  style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xuanchuanfeiyong$4'
				ID='宣传费用' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$chalvfei$4'
				ID='差旅费' CLASS='input-01_18'  style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$qitafeiyong$4'
				ID='其他费用' CLASS='input-01_18'  style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiaoji$4'  ID='小计'
				CLASS='input-01_18' style='text-align:right' ></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zongji$4'  ID='总计'
				CLASS='input-01_18'  style='text-align:right' ></label></TD>
		</TR>
		<TR>
			<TD height=32>5.<label readonly="readonly"
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$5'
				ID='子表.项目名称$22' CLASS='input-01_18' ROWS='3' style='width:80%' COLS='11'
				></label></TD>
			<TD align=middle height=32><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$shouru$5'  ID='收入'
				CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zhijiekuanwu$5'
				ID='直接款物' CLASS='input-01_18'  style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmurenyuangongzi$5'
				 ID='项目人员工资' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$bangongfeiyong$5'
				ID='办公费用' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zichanshiyongfeiyong$5'
				 ID='资产使用费用' CLASS='input-01_18'  style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xuanchuanfeiyong$5'
				ID='宣传费用' CLASS='input-01_18'  style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$chalvfei$5'
				ID='差旅费' CLASS='input-01_18'  style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$qitafeiyong$5'
				ID='其他费用' CLASS='input-01_18'  style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiaoji$5' ID='小计'
				CLASS='input-01_18'  style='text-align:right' ></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zongji$5'  ID='总计'
				CLASS='input-01_18'  style='text-align:right' ></label></TD>
		</TR>
		<TR>
			<TD height=32>6.<label readonly="readonly"
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$6'
				ID='子表.项目名称$22' CLASS='input-01_18' ROWS='3' style='width:80%' COLS='11'
				></label></TD>
			<TD align=middle height=32><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$shouru$6' ID='收入'
				CLASS='input-01_18' style='text-align:right'
				></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zhijiekuanwu$6'
				ID='直接款物' CLASS='input-01_18'  style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmurenyuangongzi$6'
				 ID='项目人员工资' CLASS='input-01_18'  style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$bangongfeiyong$6'
				ID='办公费用' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zichanshiyongfeiyong$6'
				ID='资产使用费用' CLASS='input-01_18'  style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xuanchuanfeiyong$6'
				ID='宣传费用' CLASS='input-01_18'  style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$chalvfei$6'
				ID='差旅费' CLASS='input-01_18'  style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$qitafeiyong$6'
				ID='其他费用' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiaoji$6' ID='小计'
				CLASS='input-01_18' style='text-align:right' ></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zongji$6' ID='总计'
				CLASS='input-01_18'  style='text-align:right' ></label></TD>
		</TR>
		<TR>
			<TD height=32>7.<label readonly="readonly"
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$7'
				ID='子表.项目名称$22' CLASS='input-01_18' ROWS='3' style='width:80%' COLS='11'
				></label></TD>
			<TD align=middle height=32><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$shouru$7'  ID='收入'
				CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zhijiekuanwu$7'
				ID='直接款物' CLASS='input-01_18'  style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmurenyuangongzi$7'
				value='' ID='项目人员工资' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$bangongfeiyong$7'
				ID='办公费用' CLASS='input-01_18'  style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zichanshiyongfeiyong$7'
				value='' ID='资产使用费用' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xuanchuanfeiyong$7'
				ID='宣传费用' CLASS='input-01_18'  style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$chalvfei$7'
				ID='差旅费' CLASS='input-01_18'  style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$qitafeiyong$7'
				ID='其他费用' CLASS='input-01_18'  style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiaoji$7' ID='小计'
				CLASS='input-01_18'  style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zongji$7'  ID='总计'
				CLASS='input-01_18' style='text-align:right' ></label></TD>
		</TR>
		<TR>
			<TD height=32>8.<label readonly="readonly"
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$8'
				ID='子表.项目名称$22' CLASS='input-01_18' ROWS='3' style='width:80%' COLS='11'
				></label></TD>
			<TD align=middle height=32><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$shouru$8' ID='收入'
				CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zhijiekuanwu$8'
				ID='直接款物' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmurenyuangongzi$8'
				 ID='项目人员工资' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$bangongfeiyong$8'
				ID='办公费用' CLASS='input-01_18'  style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zichanshiyongfeiyong$8'
				 ID='资产使用费用' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xuanchuanfeiyong$8'
				ID='宣传费用' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$chalvfei$8'
				ID='差旅费' CLASS='input-01_18'  style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$qitafeiyong$8'
				ID='其他费用' CLASS='input-01_18'  style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiaoji$8' ID='小计'
				CLASS='input-01_18' style='text-align:right' ></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zongji$8' ID='总计'
				CLASS='input-01_18' style='text-align:right' ></label></TD>
		</TR>
		<TR>
			<TD height=32>9.<label readonly="readonly"
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$9'
				ID='子表.项目名称$22' CLASS='input-01_18' ROWS='3' style='width:80%' COLS='11'
				></label></TD>
			<TD align=middle height=32><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$shouru$9' ID='收入'
				CLASS='input-01_18' style='text-align:right'
				></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zhijiekuanwu$9'
				ID='直接款物' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmurenyuangongzi$9'
				 ID='项目人员工资' CLASS='input-01_18'  style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$bangongfeiyong$9'
				ID='办公费用' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zichanshiyongfeiyong$9'
				 ID='资产使用费用' CLASS='input-01_18'  style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xuanchuanfeiyong$9'
				ID='宣传费用' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$chalvfei$9'
				ID='差旅费' CLASS='input-01_18'  style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$qitafeiyong$9'
				ID='其他费用' CLASS='input-01_18'  style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiaoji$9'  ID='小计'
				CLASS='input-01_18'  style='text-align:right' ></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zongji$9' ID='总计'
				CLASS='input-01_18'  style='text-align:right' ></label></TD>
		</TR>
		<TR>
			<TD height=32>10.<label readonly="readonly"
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$10'
				ID='子表.项目名称$22' CLASS='input-01_18' ROWS='3' style='width:80%' COLS='11'
				></label></TD>
			<TD align=middle height=32><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$shouru$10'  ID='收入'
				CLASS='input-01_18' style='text-align:right'
				></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zhijiekuanwu$10'
				ID='直接款物' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmurenyuangongzi$10'
				 ID='项目人员工资' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$bangongfeiyong$10'
				ID='办公费用' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zichanshiyongfeiyong$10'
				 ID='资产使用费用' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xuanchuanfeiyong$10'
				 ID='宣传费用' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$chalvfei$10'
				ID='差旅费' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$qitafeiyong$10'
				ID='其他费用' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiaoji$10' ID='小计'
				CLASS='input-01_18' style='text-align:right'></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zongji$10' ID='总计'
				CLASS='input-01_18' style='text-align:right'></TD>
		</TR>
		<tr>
			<TD  height=32>11.<label readonly="readonly"
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$11'
				ID='子表.项目名称$122' CLASS='input-01_18' ROWS='3' style='width:80%' COLS='11'
				></label></TD>
			<TD align=middle  height=32><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$shouru$11' ID='收入'
				CLASS='input-01_18' style='text-align:right'
				></label></TD>
			<TD align=middle ><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zhijiekuanwu$11'
				ID='直接款物' CLASS='input-01_18'
				 style='text-align:right'></label></TD>
			<TD align=middle ><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmurenyuangongzi$11'
				 ID='项目人员工资' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle ><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$bangongfeiyong$11'
				ID='办公费用' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle ><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zichanshiyongfeiyong$11'
				value='' ID='资产使用费用' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle ><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xuanchuanfeiyong$11'
				value='' ID='宣传费用' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle ><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$chalvfei$11'
				ID='差旅费' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle ><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$qitafeiyong$11'
				ID='其他费用' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle ><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiaoji$11'  ID='小计'
				CLASS='input-01_18'  style='text-align:right' ></label></TD>
			<TD align=middle ><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zongji$11' ID='总计'
				CLASS='input-01_18'  style='text-align:right' ></label></TD>
		</TR>
		<TR>
			<TD  height=32>12.<label readonly="readonly"
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$12'
				ID='子表.项目名称$122' CLASS='input-01_18' ROWS='3' style='width:80%' COLS='11'
				></label></TD>
			<TD align=middle  height=32><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$shouru$12' ID='收入'
				CLASS='input-01_18' style='text-align:right'style='text-align:right'
				></label></TD>
			<TD align=middle ><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zhijiekuanwu$12'
				ID='直接款物' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle ><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmurenyuangongzi$12'
				 ID='项目人员工资' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle ><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$bangongfeiyong$12'
				ID='办公费用' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle ><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zichanshiyongfeiyong$12'
				 ID='资产使用费用' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle ><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xuanchuanfeiyong$12'
				 ID='宣传费用' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle ><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$chalvfei$12'
				ID='差旅费' CLASS='input-01_18'  style='text-align:right'></label></TD>
			<TD align=middle ><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$qitafeiyong$12'
				ID='其他费用' CLASS='input-01_18'  style='text-align:right'></label></TD>
			<TD align=middle ><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiaoji$12' ID='小计'
				CLASS='input-01_18'  style='text-align:right' ></label></TD>
			<TD align=middle ><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zongji$12'  ID='总计'
				CLASS='input-01_18' style='text-align:right' ></label></TD>
		</TR>
		<TR>
			<TD height=32>13.<label readonly="readonly"
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$13'
				ID='子表.项目名称$122' CLASS='input-01_18' ROWS='3' style='width:80%' COLS='11'
				></label></TD>
			<TD align=middle height=32><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$shouru$13' ID='收入'
				CLASS='input-01_18' style='text-align:right'
				></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zhijiekuanwu$13'
				ID='直接款物' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmurenyuangongzi$13'
				 ID='项目人员工资' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$bangongfeiyong$13'
				ID='办公费用' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zichanshiyongfeiyong$13'
				ID='资产使用费用' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xuanchuanfeiyong$13'
				ID='宣传费用' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$chalvfei$13'
				ID='差旅费' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$qitafeiyong$13'
				ID='其他费用' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiaoji$13'  ID='小计'
				CLASS='input-01_18'  style='text-align:right' ></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zongji$13'  ID='总计'
				CLASS='input-01_18'  style='text-align:right' ></label></TD>
		</TR>
		<TR>
			<TD height=32>14.<label readonly="readonly"
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$14'
				ID='子表.项目名称$122' CLASS='input-01_18' ROWS='3' style='width:80%' COLS='11'
				></label></TD>
			<TD align=middle height=32><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$shouru$14'  ID='收入'
				CLASS='input-01_18' style='text-align:right'
				></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zhijiekuanwu$14'
				ID='直接款物' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmurenyuangongzi$14'
				 ID='项目人员工资' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$bangongfeiyong$14'
				ID='办公费用' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zichanshiyongfeiyong$14'
				 ID='资产使用费用' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xuanchuanfeiyong$14'
				 ID='宣传费用' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$chalvfei$14'
				ID='差旅费' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$qitafeiyong$14'
				ID='其他费用' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiaoji$14' ID='小计'
				CLASS='input-01_18'  style='text-align:right' ></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zongji$14'  ID='总计'
				CLASS='input-01_18'  style='text-align:right' ></label></TD>
		</TR>
		<TR>
			<TD height=32>15.<label readonly="readonly"
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$15'
				ID='子表.项目名称$122' CLASS='input-01_18' ROWS='3' style='width:80%' COLS='11'
				></label></TD>
			<TD align=middle height=32><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$shouru$15'  ID='收入'
				CLASS='input-01_18' style='text-align:right'
				></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zhijiekuanwu$15'
				ID='直接款物' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmurenyuangongzi$15'
				 ID='项目人员工资' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$bangongfeiyong$15'
				ID='办公费用' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zichanshiyongfeiyong$15'
				 ID='资产使用费用' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xuanchuanfeiyong$15'
				 ID='宣传费用' CLASS='input-01_18'  style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$chalvfei$15'
				ID='差旅费' CLASS='input-01_18'  style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$qitafeiyong$15'
				ID='其他费用' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiaoji$15' ID='小计'
				CLASS='input-01_18'  style='text-align:right' ></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zongji$15' value='' ID='总计'
				CLASS='input-01_18'  style='text-align:right' ></label></TD>
		</TR>
		<TR>
			<TD height=32>16.<label readonly="readonly"
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$16'
				ID='子表.项目名称$122' CLASS='input-01_18' ROWS='3' style='width:80%' COLS='11'
				></label></TD>
			<TD align=middle height=32><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$shouru$16' ID='收入'
				CLASS='input-01_18' style='text-align:right'
				></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zhijiekuanwu$16'
				ID='直接款物' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmurenyuangongzi$16'
				 ID='项目人员工资' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$bangongfeiyong$16'
				ID='办公费用' CLASS='input-01_18' SIZE='11' style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zichanshiyongfeiyong$16'
				 ID='资产使用费用' CLASS='input-01_18'  style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xuanchuanfeiyong$16'
				 ID='宣传费用' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$chalvfei$16'
				ID='差旅费' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$qitafeiyong$16'
				ID='其他费用' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiaoji$16'  ID='小计'
				CLASS='input-01_18'  style='text-align:right' ></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zongji$16' value='' ID='总计'
				CLASS='input-01_18' style='text-align:right' ></label></TD>
		</TR>
		<TR>
			<TD height=32>17.<label readonly="readonly"
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$17'
				ID='子表.项目名称$122' CLASS='input-01_18' ROWS='3' style='width:80%' COLS='11'
				></label></TD>
			<TD align=middle height=32><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$shouru$17' ID='收入'
				CLASS='input-01_18' style='text-align:right'
				></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zhijiekuanwu$17'
				ID='直接款物' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmurenyuangongzi$17'
				 ID='项目人员工资' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$bangongfeiyong$17'
				ID='办公费用' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zichanshiyongfeiyong$17'
				 ID='资产使用费用' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xuanchuanfeiyong$17'
				 ID='宣传费用' CLASS='input-01_18'  style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$chalvfei$17'
				ID='差旅费' CLASS='input-01_18'  style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$qitafeiyong$17'
				ID='其他费用' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiaoji$17'  ID='小计'
				CLASS='input-01_18' style='text-align:right' ></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zongji$17'  ID='总计'
				CLASS='input-01_18' style='text-align:right' ></label></TD>
		</TR>
		<TR>
			<TD height=32>18.<label readonly="readonly"
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$18'
				ID='子表.项目名称$122' CLASS='input-01_18' ROWS='3' style='width:80%' COLS='11'
				></label></TD>
			<TD align=middle height=32><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$shouru$18'  ID='收入'
				CLASS='input-01_18' style='text-align:right'
				></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zhijiekuanwu$18'
				ID='直接款物' CLASS='input-01_18'  style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmurenyuangongzi$18'
				 ID='项目人员工资' CLASS='input-01_18'  style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$bangongfeiyong$18'
				ID='办公费用' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zichanshiyongfeiyong$18'
				 ID='资产使用费用' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xuanchuanfeiyong$18'
				ID='宣传费用' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$chalvfei$18'
				ID='差旅费' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$qitafeiyong$18'
				ID='其他费用' CLASS='input-01_18'  style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiaoji$18'  ID='小计'
				CLASS='input-01_18'  style='text-align:right' ></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zongji$18'  ID='总计'
				CLASS='input-01_18'  style='text-align:right' ></label></TD>
		</TR>
		<TR>
			<TD height=32>19.<label readonly="readonly"
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$19'
				ID='子表.项目名称$122' CLASS='input-01_18' ROWS='3' style='width:80%' COLS='11'
				></label></TD>
			<TD align=middle height=32><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$shouru$19' ID='收入'
				CLASS='input-01_18' style='text-align:right'
				></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zhijiekuanwu$19'
				ID='直接款物' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmurenyuangongzi$19'
				ID='项目人员工资' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$bangongfeiyong$19'
				ID='办公费用' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zichanshiyongfeiyong$19'
				 ID='资产使用费用' CLASS='input-01_18'  style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xuanchuanfeiyong$19'
				 ID='宣传费用' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$chalvfei$19'
				ID='差旅费' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$qitafeiyong$19'
				ID='其他费用' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiaoji$19'ID='小计'
				CLASS='input-01_18'  style='text-align:right' ></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zongji$19'  ID='总计'
				CLASS='input-01_18'  style='text-align:right' ></label></TD>
		</TR>
		<TR>
			<TD height=32>20.<label readonly="readonly"
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmumingcheng$20'
				ID='子表.项目名称$122' CLASS='input-01_18' ROWS='3' style='width:80%' COLS='11'
				></label></TD>
			<TD align=middle height=32><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$shouru$20'  ID='收入'
				CLASS='input-01_18' style='text-align:right'
				></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zhijiekuanwu$20'
				ID='直接款物' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiangmurenyuangongzi$20'
				 ID='项目人员工资' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$bangongfeiyong$20'
				ID='办公费用' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zichanshiyongfeiyong$20'
				ID='资产使用费用' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xuanchuanfeiyong$20'
				 ID='宣传费用' CLASS='input-01_18'  style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$chalvfei$20'
				ID='差旅费' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$qitafeiyong$20'
				ID='其他费用' CLASS='input-01_18' style='text-align:right'></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$xiaoji$20'  ID='小计'
				CLASS='input-01_18'  style='text-align:right' ></label></TD>
			<TD align=middle><label
				id='query$form$0$JJHNJ_ZHDGYHDSHZ_SUB$zongji$20'  ID='总计'
				CLASS='input-01_18' style='text-align:right' ></label></TD>
		</tr>
		<TR>
			<TD align=middle  height=32>合 计</TD>
			<TD align=middle  height=32><label
				id='query$form$0$JJHNJ_ZHDGYXMSHZ$shouru'  ID='收入'
				CLASS='input-01_18'  style='text-align:right' ></label></TD>
			<TD align=middle ><label
				id='query$form$0$JJHNJ_ZHDGYXMSHZ$zhijiekuanwu' ID='直接款物'
				CLASS='input-01_18'  style='text-align:right' ></label></TD>
			<TD align=middle ><label
				id='query$form$0$JJHNJ_ZHDGYXMSHZ$xiangmurenyuangongzi'
				ID='项目人员工资' CLASS='input-01_18'  style='text-align:right' ></label></TD>
			<TD align=middle ><label
				id='query$form$0$JJHNJ_ZHDGYXMSHZ$bangongfeiyong'
				ID='办公费用' CLASS='input-01_18' style='text-align:right' ></label></TD>
			<TD align=middle ><label
				id='query$form$0$JJHNJ_ZHDGYXMSHZ$zichanshiyongfeiyong'
				ID='资产使用费用' CLASS='input-01_18'  style='text-align:right' ></label></TD>
			<TD align=middle ><label
				id='query$form$0$JJHNJ_ZHDGYXMSHZ$xuanchuanfeiyong'
				ID='宣传费用' CLASS='input-01_18'  style='text-align:right' ></label></TD>
			<TD align=middle ><label
				id='query$form$0$JJHNJ_ZHDGYXMSHZ$chalvfei' ID='差旅费'
				CLASS='input-01_18' style='text-align:right' ></label></TD>
			<TD align=middle ><label
				id='query$form$0$JJHNJ_ZHDGYXMSHZ$qitafeiyong' ID='其他费用'
				CLASS='input-01_18' style='text-align:right' ></label></TD>
			<TD align=middle ><label
				id='query$form$0$JJHNJ_ZHDGYXMSHZ$xiaoji'  ID='小计'
				CLASS='input-01_18'  style='text-align:right' ></label></TD>
			<TD align=middle ><label
				id='query$form$0$JJHNJ_ZHDGYXMSHZ$zongji'  ID='总计'
				CLASS='input-01_18'  style='text-align:right' ></label></TD>
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
		</td>
	</tr>
</TABLE>

</form>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
</div>
</div>