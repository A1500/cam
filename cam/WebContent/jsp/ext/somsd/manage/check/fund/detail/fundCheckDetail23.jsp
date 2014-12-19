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
	var somJxCheckCashFlowDataSet = L5.DatasetMgr.lookup("somJxCheckCashFlowDataSet");
	somJxCheckCashFlowDataSet.setParameter("TASK_CODE@=", taskCode);
	somJxCheckCashFlowDataSet.load();
	somJxCheckCashFlowDataSet.on("load",function(ds){
		if(ds.getCount()==0){
			somJxCheckCashFlowDataSet.newRecord();
		}
	});
	//创建页面导航下拉框
	createFundDetailSelect();
}
function save(){
	var somJxCheckCashFlowDataSetIsValidate = somJxCheckCashFlowDataSet.isValidate();
	if(somJxCheckCashFlowDataSetIsValidate!=true){
		L5.Msg.alert("提示",somJxCheckCashFlowDataSetIsValidate);
		return;
	}
	var somJxCheckCashFlowRecord=somJxCheckCashFlowDataSet.getCurrent();
	var command = new L5.Command("com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckCommand");
	command.setParameter("taskCode", taskCode);
	command.setParameter("somJxCheckCashFlowRecord", somJxCheckCashFlowRecord);
	command.execute("savePageJ23");
	if (!command.error) {
		L5.Msg.alert("提示","保存成功！",function(){
		});		
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
</script>

<script>
function setSumYewu1(){
   
   var preName = "query$form$0$JJH_NJ_REPORT6$";    
   var sum = 0;
   var sum1 = 0;
   var ele = "jieshoujuanzeng$shouquhuifei$tigongfuwu$xiaoshoushangpin$zhengfubuzhu$shoudaoqitayewu";
   var eles = ele.split("$");
   
   for(i=0;i<eles.length;i++){
      
      var obj =  document.getElementById(preName + eles[i]);
          if(obj.innerHTML != ""){
             sum += parseFloat(obj.innerHTML);
          }
     }     
     document.getElementById(preName + 'yewuliuruxiaoji').innerHTML = (Math.round(sum*1000000))/1000000;
    
   calYewuJinge1();
}

function setSumYewu2(){
   
   var preName = "query$form$0$JJH_NJ_REPORT6$";    
   var sum = 0;
   var sum1 = 0;
   var ele = "juanzengzhifu$zhifuyuangong$shangpinfuwuzhifu$zhifuqitayewu";
   var eles = ele.split("$");
   
   for(i=0;i<eles.length;i++){
      
      var obj =  document.getElementById(preName + eles[i]);
          if(obj.innerHTML != ""){
             sum += parseFloat(obj.innerHTML);
          }
     }     
     document.getElementById(preName + 'yewuliuchuxiaoji').innerHTML = (Math.round(sum*1000000))/1000000;
    
   calYewuJinge1();
}
 
   
    function calYewuJinge1(){
      var preName = "query$form$0$JJH_NJ_REPORT6$";           
     var sum1=0;
     var obj =  document.getElementById(preName + 'yewuliuruxiaoji');
           if(obj.innerHTML != ""){
              sum1 += parseFloat(obj.innerHTML);
           }
     var obj =  document.getElementById(preName + 'yewuliuchuxiaoji');
           if(obj.innerHTML != ""){
              sum1 -= parseFloat(obj.innerHTML);
           }
     document.getElementById(preName + 'yewujinge').innerHTML = (Math.round(sum1*1000000))/1000000; 
    getJing();
    }
// ----------------------------------------投资活动产生的现金流量----------------------------------------------

function setSumTouzi1(){
   
   var preName = "query$form$0$JJH_NJ_REPORT6$";    
   var sum = 0;
   var sum1 = 0;
   var ele = "shouhuitouzi$touzishouyi$chuzhizichanshouhui$shoudaoqitatouzi";
   var eles = ele.split("$");
   
   for(i=0;i<eles.length;i++){
      
      var obj =  document.getElementById(preName + eles[i]);
          if(obj.innerHTML != ""){
             sum += parseFloat(obj.innerHTML);
          }
     }     
     document.getElementById(preName + 'touziliuruxiaoji').innerHTML = (Math.round(sum*1000000))/1000000;
    
   calTouziJinge1();
}

function setSumTouzi2(){
   
   var preName = "query$form$0$JJH_NJ_REPORT6$";    
   var sum = 0;
   var sum1 = 0;
   var ele = "goujianzichanzhifu$touzizhifu$zhifuqitatouzi";
   var eles = ele.split("$");
   
   for(i=0;i<eles.length;i++){
      
      var obj =  document.getElementById(preName + eles[i]);
          if(obj.innerHTML != ""){
             sum += parseFloat(obj.innerHTML);
          }
     }     
     document.getElementById(preName + 'touziliuchuxiaoji').innerHTML = (Math.round(sum*1000000))/1000000;
    
   calTouziJinge1();
}
 
   
    function calTouziJinge1(){
      var preName = "query$form$0$JJH_NJ_REPORT6$";           
     var sum1=0;
     var obj =  document.getElementById(preName + 'touziliuruxiaoji');
           if(obj.innerHTML != ""){
              sum1 += parseFloat(obj.innerHTML);
           }
     var obj =  document.getElementById(preName + 'touziliuchuxiaoji');
           if(obj.innerHTML != ""){
              sum1 -= parseFloat(obj.innerHTML);
           }
     document.getElementById(preName + 'touzijinge').innerHTML = (Math.round(sum1*1000000))/1000000; 
    getJing();
    }

// ----------------------------------------筹资活动产生的现金流量----------------------------------------------

function setSumChouzi1(){
   
   var preName = "query$form$0$JJH_NJ_REPORT6$";    
   var sum = 0;
   var sum1 = 0;
   var ele = "jiekuanshoudao$shoudaoqitachouzi";
   var eles = ele.split("$");
   
   for(i=0;i<eles.length;i++){
      
      var obj =  document.getElementById(preName + eles[i]);
          if(obj.innerHTML != ""){
             sum += parseFloat(obj.innerHTML);
          }
     }     
     document.getElementById(preName + 'chouziliuruxiaoji').innerHTML = (Math.round(sum*1000000))/1000000;
    
   calChouziJinge1();
}

function setSumChouzi2(){
   
   var preName = "query$form$0$JJH_NJ_REPORT6$";    
   var sum = 0;
   var sum1 = 0;
   var ele = "jiekuanzhifu$lixizhifu$zhifuqitachouzi";
   var eles = ele.split("$");
   
   for(i=0;i<eles.length;i++){
      
      var obj =  document.getElementById(preName + eles[i]);
          if(obj.innerHTML != ""){
             sum += parseFloat(obj.innerHTML);
          }
     }     
     document.getElementById(preName + 'chouziliuchuxiaoji').innerHTML = (Math.round(sum*1000000))/1000000;
    
   calChouziJinge1();
}
 
   
    function calChouziJinge1(){
      var preName = "query$form$0$JJH_NJ_REPORT6$";           
     var sum1=0;
     var obj =  document.getElementById(preName + 'chouziliuruxiaoji');
           if(obj.innerHTML != ""){
              sum1 += parseFloat(obj.innerHTML);
           }
     var obj =  document.getElementById(preName + 'chouziliuchuxiaoji');
           if(obj.innerHTML != ""){
              sum1 -= parseFloat(obj.innerHTML);
           }
     document.getElementById(preName + 'chouzijinge').innerHTML = (Math.round(sum1*1000000))/1000000; 
    getJing();
    }
function getJing(){
      var preName = "query$form$0$JJH_NJ_REPORT6$";           
     var sum1=0;
     var obj =  document.getElementById(preName + 'yewujinge');
           if(obj.innerHTML != ""){
              sum1 += parseFloat(obj.innerHTML);
           }
     var obj =  document.getElementById(preName + 'touzijinge');
           if(obj.innerHTML != ""){
              sum1 += parseFloat(obj.innerHTML);
           }
           
     var obj =  document.getElementById(preName + 'chouzijinge');
           if(obj.innerHTML != ""){
              sum1 += parseFloat(obj.innerHTML);
           }
     var obj =  document.getElementById(preName + 'huilvyingxiange');
           if(obj.innerHTML != ""){
              sum1 += parseFloat(obj.innerHTML);
           }
     document.getElementById(preName + 'xianjinzengjiae').innerHTML = (Math.round(sum1*1000000))/1000000; 
} 
</script>
<style media="print">
	.noprint     { display: none }
</style>
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
	bcolor: #0000ff;
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	font-size: 14px;
	border-top-style: none;
	border-right-style: none;
	border-left-style: none;
}

.font-cal_xianjin {
	background-color: #F1F1F3;
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
	width:100%;
	font-size: 14px;
	vertical-align: middle;
}

.boder-cal {
	width:100%;
	background-color: #F1F1F3;
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
</head>

<body>
<model:datasets>
	<model:dataset id="somJxCheckCashFlowDataSet" cmd="com.inspur.cams.sorg.check.checkcashflow.cmd.SomCheckCashFlowQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.checkcashflow.data.SomCheckCashFlow">
		</model:record>
	</model:dataset>
</model:datasets>
<div id="float" class="noprint">
	<input type="button" value="下一页" style="height:25px;width:80px;position:absolute;margin-left:120px;" onclick="nextPageJ1('24')"/>
	<input type="button" value="上一页" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="nextPageJ1('22')"/>
	<input type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:220px;" onclick="backJ();"/>
	<input  type="button" value="打印" style="height:25px;width:80px;position:absolute;margin-left:320px;" onclick="docPrint();"/>
</div>
<div align=center>
<div align=center style="width: 800px">
<form dataset="somJxCheckCashFlowDataSet" name="myform" method="post" onsubmit="return false">

<TABLE height=927 cellSpacing=0 cellPadding=0 width=700 align=center
	border=0>
	<TBODY>
		<TR>
			<TD height=53>&nbsp;</TD>
		</TR>
		<TR>
			<TD align=middle width=595 height=30><STRONG>现金流量表</STRONG></TD>
		</TR>
		<TR>
			<TD vAlign=top height=844>
			<TABLE height=634 cellSpacing=0 cellPadding=0 width=700 align=center
				border=0>
				<TBODY>
					<TR>
						<TD vAlign=top align=middle>
						<TABLE cellSpacing=0 cellPadding=0 width='100%' align=center
							border=0>
							<TBODY>
								<TR>
									<TD align=right height=22>
									<TABLE cellSpacing=0 cellPadding=0 width='100%' border=0>
										<TBODY>
											<TR>
												<TD width='33%' height='41' align=right>单位：<span style="color:red">人民币万元</span></TD>
											</TR>
										</TBODY>
									</TABLE>
									</TD>
								</TR>
								<TR>
									<TD height=631>
									<TABLE class=unnamed1 cellSpacing=0 cellPadding=0 width='100%'
										border=0>
										<TBODY>
											<TR>
												<TD class=unnamed2 align=middle width='58%' height=22>项
												目</TD>
												<TD class=unnamed2 align=middle width='7%' height=22>行次</TD>
												<TD class=unnamed3 align=middle width='35%' height=22>金
												额</TD>
											</TR>
											<TR>
												<TD class=unnamed2 width='58%' height=22>一、业务活动产生的现金流量：</TD>
												<TD class=unnamed2 align=middle width='7%' height=22>&nbsp;</TD>
												<TD class=unnamed3 align=middle width='35%' height=22>&nbsp;</TD>
											</TR>
											<TR>
												<TD class=unnamed2 width='58%' height=22>接受捐赠收到的现金</TD>
												<TD class=unnamed2 align=middle width='7%' height=22>1</TD>
												<TD class=unnamed3 width='35%' height=22><label
													ID='接受捐赠' MAXLENGTH='15' isMoney='true'
													style='text-align: right' CLASS='boder-0' SIZE='22'
													field="baReceiveDonations" style="width: 98%; " 
													></label></TD>
											</TR>
											<TR>
												<TD class=unnamed2 width='58%' height=22>收取会费收到的现金</TD>
												<TD class=unnamed2 align=middle width='7%' height=22>2</TD>
												<TD class=unnamed3 width='35%' height=22><label
													id='query$form$0$JJH_NJ_REPORT6$shouquhuifei' value=''
													ID='收取会费' MAXLENGTH='15' CLASS='boder-0' isMoney='true'
													style='text-align: right' SIZE='22'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumYewu1();" 
													field="baGatherDues" style="width: 98%; " 
													></label></TD>
											</TR>
											<TR>
												<TD class=unnamed2 width='58%' height=22>提供服务收到的现金</TD>
												<TD class=unnamed2 align=middle width='7%' height=22>3</TD>
												<TD class=unnamed3 width='35%' height=22><label
													id='query$form$0$JJH_NJ_REPORT6$tigongfuwu' value=''
													ID='提供服务' MAXLENGTH='15' CLASS='boder-0' isMoney='true'
													style='text-align: right' SIZE='22'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumYewu1();" 
													field="baRenderServices" style="width: 98%; " 
													></label></TD>
											</TR>
											<TR>
												<TD class=unnamed2 width='58%' height=22>销售商品收到的现金</TD>
												<TD class=unnamed2 align=middle width='7%' height=22>4</TD>
												<TD class=unnamed3 width='35%' height=22><label
													id='query$form$0$JJH_NJ_REPORT6$xiaoshoushangpin'
													value='' ID='销售商品' MAXLENGTH='15' isMoney='true'
													style='text-align: right' CLASS='boder-0' SIZE='22'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumYewu1();" 
													field="baSellProduct" style="width: 98%; " 
													></label></TD>
											</TR>
											<TR>
												<TD class=unnamed2 width='58%' height=22>政府补助收到的现金</TD>
												<TD class=unnamed2 align=middle width='7%' height=22>5</TD>
												<TD class=unnamed3 width='35%' height=22><label
													id='query$form$0$JJH_NJ_REPORT6$zhengfubuzhu' value=''
													ID='政府补助' MAXLENGTH='15' isMoney='true'
													style='text-align: right' CLASS='boder-0' SIZE='22'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumYewu1();" 
													field="baGovernmentGrants" style="width: 98%; " 
													></label></TD>
											</TR>
											<TR>
												<TD class=unnamed2 width='58%' height=22>
												收到的其他与业务活动有关的现金</TD>
												<TD class=unnamed2 align=middle width='7%' height=22>8</TD>
												<TD class=unnamed3 width='35%' height=22><label
													id='query$form$0$JJH_NJ_REPORT6$shoudaoqitayewu' value=''
													ID='收到其他业务' MAXLENGTH='15' CLASS='boder-0' isMoney='true'
													style='text-align: right' SIZE='22'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumYewu1();" 
													field="baInfolwOthers" style="width: 98%; " 
													></label></TD>
											</TR>
											<TR>
												<TD class=unnamed2 align=middle width='58%' height=22>现金流入小计</TD>
												<TD class=unnamed2 align=middle width='7%' height=22>13</TD>
												<TD class=font-cal_xianjin width='35%' height=22><label
													id='query$form$0$JJH_NJ_REPORT6$yewuliuruxiaoji' value=''
													ID='业务流入小计' MAXLENGTH='15' isMoney='true'
													style='text-align: right' CLASS='boder-cal' readonly SIZE='22'
													field="baInflowSum" style="width: 98%; " 
													></label></TD>
											</TR>
											<TR>
												<TD class=unnamed2 width='58%' height=22>提供捐赠或者资助支付的现金</TD>
												<TD class=unnamed2 align=middle width='7%' height=22>14</TD>
												<TD class=unnamed3 width='35%' height=22><label
													id='query$form$0$JJH_NJ_REPORT6$juanzengzhifu' value=''
													ID='捐赠支付' MAXLENGTH='15' CLASS='boder-0' isMoney='true'
													style='text-align: right' SIZE='22'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumYewu2();" 
													field="baDonatedPay" style="width: 98%; " 
													></label></TD>
											</TR>
											<TR>
												<TD class=unnamed2 width='58%' height=22>
												支付给员工以及为员工支付的现金</TD>
												<TD class=unnamed2 align=middle width='7%' height=22>15</TD>
												<TD class=unnamed3 width='35%' height=22><label
													id='query$form$0$JJH_NJ_REPORT6$zhifuyuangong' value=''
													ID='支付员工' MAXLENGTH='15' isMoney='true'
													style='text-align: right' CLASS='boder-0' SIZE='22'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumYewu2();" 
													field="baPayEmployee" style="width: 98%; " 
													></label></TD>
											</TR>
											<TR>
												<TD class=unnamed2 width='58%' height=22>
												购买商品、接受服务支付的现金</TD>
												<TD class=unnamed2 align=middle width='7%' height=22>16</TD>
												<TD class=unnamed3 width='35%' height=22><label
													id='query$form$0$JJH_NJ_REPORT6$shangpinfuwuzhifu'
													value='' ID='商品服务支付' MAXLENGTH='15' isMoney='true'
													style='text-align: right' CLASS='boder-0' SIZE='22'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumYewu2();" 
													field="baProductServices" style="width: 98%; " 
													></label></TD>
											</TR>
											<TR>
												<TD class=unnamed2 width='58%' height=22>
												支付的其他与业务活动有关的现金</TD>
												<TD class=unnamed2 align=middle width='7%' height=22>19</TD>
												<TD class=unnamed3 width='35%' height=22><label
													id='query$form$0$JJH_NJ_REPORT6$zhifuqitayewu' value=''
													ID='支付其他业务' MAXLENGTH='15' isMoney='true'
													style='text-align: right' CLASS='boder-0' SIZE='22'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumYewu2();" 
													field="baOutflowOthers" style="width: 98%; " 
													></label></TD>
											</TR>
											<TR>
												<TD class=unnamed2 align=middle width='58%' height=22>现金流出小计</TD>
												<TD class=unnamed2 align=middle width='7%' height=22>23</TD>
												<TD class=font-cal_xianjin width='35%' height=22><label
													id='query$form$0$JJH_NJ_REPORT6$yewuliuchuxiaoji'
													value='' ID='业务流出小计' MAXLENGTH='15' isMoney='true'
													style='text-align: right' CLASS='boder-cal' readonly SIZE='22'
													field="baOutflowSum" style="width: 98%; " 
													></label></TD>
											</TR>
											<TR>
												<TD class=unnamed2 width='58%' height=22>业务活动产生的现金流量净额</TD>
												<TD class=unnamed2 align=middle width='7%' height=22>24</TD>
												<TD class=font-cal_xianjin width='35%' height=22><label
													id='query$form$0$JJH_NJ_REPORT6$yewujinge' value=''
													ID='业务净额' MAXLENGTH='15' isMoney='true'
													style='text-align: right' CLASS='boder-cal' readonly SIZE='22'
													field="baNetAmount" style="width: 98%; " 
													></label></TD>
											</TR>
											<TR>
												<TD class=unnamed2 width='58%' height=22>二、投资活动产生的现金流量：</TD>
												<TD class=unnamed2 align=middle width='7%' height=22>&nbsp;</TD>
												<TD class=unnamed3 width='35%' height=22>&nbsp;</TD>
											</TR>
											<TR>
												<TD class=unnamed2 width='58%' height=22>收回投资所收到的现金</TD>
												<TD class=unnamed2 align=middle width='7%' height=22>25</TD>
												<TD class=unnamed3 width='35%' height=22><label
													id='query$form$0$JJH_NJ_REPORT6$shouhuitouzi' value=''
													ID='收回投资' MAXLENGTH='15' CLASS='boder-0' isMoney='true'
													style='text-align: right' SIZE='22'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumTouzi1();" 
													field="iaRegoupingOutlay" style="width: 98%; " 
													></label></TD>
											</TR>
											<TR>
												<TD class=unnamed2 width='58%' height=22>取得投资收益所收到的现金</TD>
												<TD class=unnamed2 align=middle width='7%' height=22>26</TD>
												<TD class=unnamed3 width='35%' height=22><label
													id='query$form$0$JJH_NJ_REPORT6$touzishouyi' value=''
													ID='投资收益' MAXLENGTH='15' isMoney='true'
													style='text-align: right' CLASS='boder-0' SIZE='22'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumTouzi1();" 
													field="iaMadeIncome" style="width: 98%; " 
													></label></TD>
											</TR>
											<TR>
												<TD class=unnamed2 width='58%' height=22>
												处置固定资产和无形资产所收回的现金</TD>
												<TD class=unnamed2 align=middle width='7%' height=22>27</TD>
												<TD class=unnamed3 width='35%' height=22><label
													id='query$form$0$JJH_NJ_REPORT6$chuzhizichanshouhui'
													value='' ID='处置资产收回' MAXLENGTH='15' isMoney='true'
													style='text-align: right' CLASS='boder-0' SIZE='22'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumTouzi1();" 
													field="iaInflowAssets" style="width: 98%; " 
													></label></TD>
											</TR>
											<TR>
												<TD class=unnamed2 width='58%' height=22>
												收到的其他与投资活动有关的现金</TD>
												<TD class=unnamed2 align=middle width='7%' height=22>30</TD>
												<TD class=unnamed3 width='35%' height=22><label
													id='query$form$0$JJH_NJ_REPORT6$shoudaoqitatouzi'
													value='' ID='收到其他投资' MAXLENGTH='15' isMoney='true'
													style='text-align: right' CLASS='boder-0' SIZE='22'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumTouzi1();" 
													field="iaInflowOthers" style="width: 98%; " 
													></label></TD>
											</TR>
											<TR>
												<TD class=unnamed2 align=middle width='58%' height=22>现金流入小计</TD>
												<TD class=unnamed2 align=middle width='7%' height=22>34</TD>
												<TD class=font-cal_xianjin width='35%' height=22><label
													id='query$form$0$JJH_NJ_REPORT6$touziliuruxiaoji'
													value='' ID='投资流入小计' MAXLENGTH='15' isMoney='true'
													style='text-align: right' CLASS='boder-cal' readonly SIZE='22'
													field="iaInflowSum" style="width: 98%; " 
													></label></TD>
											</TR>
											<TR>
												<TD class=unnamed2 width='58%' height=22>
												购建固定资产和无形资产所支付的现金</TD>
												<TD class=unnamed2 align=middle width='7%' height=22>35</TD>
												<TD class=unnamed3 width='35%' height=22><label
													id='query$form$0$JJH_NJ_REPORT6$goujianzichanzhifu'
													value='' ID='购建资产支付' MAXLENGTH='15' isMoney='true'
													style='text-align: right' CLASS='boder-0' SIZE='22'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumTouzi2();" 
													field="iaOutflowAssets" style="width: 98%; " 
													></label></TD>
											</TR>
											<TR>
												<TD class=unnamed2 height=22>对外投资所支付的现金</TD>
												<TD class=unnamed2 align=middle height=22>36</TD>
												<TD class=unnamed3 height=22><label
													id='query$form$0$JJH_NJ_REPORT6$touzizhifu' value=''
													ID='投资支付' MAXLENGTH='15' isMoney='true'
													style='text-align: right' CLASS='boder-0' SIZE='22'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumTouzi2();" 
													field="iaOutflowAbroad" style="width: 98%; " 
													></label></TD>
											</TR>
											<TR>
												<TD class=unnamed2 height=22>支付的其他与投资活动有关的现金</TD>
												<TD class=unnamed2 align=middle height=22>39</TD>
												<TD class=unnamed3 height=22><label
													id='query$form$0$JJH_NJ_REPORT6$zhifuqitatouzi' value=''
													ID='支付其他投资' MAXLENGTH='15' CLASS='boder-0' isMoney='true'
													style='text-align: right' SIZE='22'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumTouzi2();" 
													field="iaOutflowOthers" style="width: 98%; " 
													></label></TD>
											</TR>
											<TR>
												<TD class=unnamed2 align=middle height=22>现金流出小计</TD>
												<TD class=unnamed2 align=middle height=22>43</TD>
												<TD class=font-cal_xianjin height=22><label
													id='query$form$0$JJH_NJ_REPORT6$touziliuchuxiaoji'
													value='' ID='投资流出小计' MAXLENGTH='15' isMoney='true'
													style='text-align: right' CLASS='boder-cal' readonly SIZE='22'
													field="iaOutflowSum" style="width: 98%; " 
													></label></TD>
											</TR>
											<TR>
												<TD class=unnamed2 height=22>投资活动产生的现金流量净额</TD>
												<TD class=unnamed2 align=middle height=22>44</TD>
												<TD class=font-cal_xianjin height=22><label
													id='query$form$0$JJH_NJ_REPORT6$touzijinge' value=''
													ID='投资净额' isMoney='true' style='text-align: right'
													MAXLENGTH='15' CLASS='boder-cal' readonly SIZE='22' 
													field="iaNetAmount" style="width: 98%; " 
													></label>
												</TD>
											</TR>
											<TR>
												<TD class=unnamed2 height=22>三、筹资活动产生的现金流量：</TD>
												<TD class=unnamed2 align=middle height=22>&nbsp;</TD>
												<TD class=unnamed3 height=22>&nbsp;</TD>
											</TR>
											<TR>
												<TD class=unnamed2 height=22>借款所收到的现金</TD>
												<TD class=unnamed2 align=middle height=22>45</TD>
												<TD class=unnamed3 height=22><label
													id='query$form$0$JJH_NJ_REPORT6$jiekuanshoudao' value=''
													ID='借款收到' MAXLENGTH='15' CLASS='boder-0' isMoney='true'
													style='text-align: right' SIZE='22'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumChouzi1();" 
													field="faInflowLoan" style="width: 98%; " 
													></label></TD>
											</TR>
											<TR>
												<TD class=unnamed2 height=22>收到的其他与筹资活动有关的现金</TD>
												<TD class=unnamed2 align=middle height=22>48</TD>
												<TD class=unnamed3 height=22><label
													id='query$form$0$JJH_NJ_REPORT6$shoudaoqitachouzi'
													value='' ID='收到其他筹资' MAXLENGTH='15' CLASS='boder-0'
													isMoney='true' style='text-align: right' SIZE='22'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumChouzi1();" 
													field="faInflowOthers" style="width: 98%; " 
													></label></TD>
											</TR>
											<TR>
												<TD class=unnamed2 align=middle height=22>现金流入小计</TD>
												<TD class=unnamed2 align=middle height=22>50</TD>
												<TD class=font-cal_xianjin height=22><label
													id='query$form$0$JJH_NJ_REPORT6$chouziliuruxiaoji'
													value='' ID='筹资流入小计' isMoney='true'
													style='text-align: right' MAXLENGTH='15' CLASS='boder-cal' readonly
													SIZE='22' 
													field="faInflowSum" style="width: 98%; " 
													></label></TD>
											</TR>
											<TR>
												<TD class=unnamed2 height=22>偿还借款所支付的现金</TD>
												<TD class=unnamed2 align=middle height=22>51</TD>
												<TD class=unnamed3 height=22><label
													id='query$form$0$JJH_NJ_REPORT6$jiekuanzhifu' value=''
													ID='借款支付' MAXLENGTH='15' isMoney='true'
													style='text-align: right' CLASS='boder-0' SIZE='22'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumChouzi2();" 
													field="faOutflowDebt" style="width: 98%; " 
													></label></TD>
											</TR>
											<TR>
												<TD class=unnamed2 height=22>偿付利息所支付的现金</TD>
												<TD class=unnamed2 align=middle height=22>52</TD>
												<TD class=unnamed3 height=22><label
													id='query$form$0$JJH_NJ_REPORT6$lixizhifu' value=''
													ID='利息支付' MAXLENGTH='15' CLASS='boder-0' isMoney='true'
													style='text-align: right' SIZE='22'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumChouzi2();" 
													field="faOutflowRatio" style="width: 98%; " 
													></label></TD>
											</TR>
											<TR>
												<TD class=unnamed2 height=22>支付的其他与筹资活动有关的现金</TD>
												<TD class=unnamed2 align=middle height=22>55</TD>
												<TD class=unnamed3 height=22><label
													id='query$form$0$JJH_NJ_REPORT6$zhifuqitachouzi' value=''
													ID='支付其他筹资' MAXLENGTH='15' isMoney='true'
													style='text-align: right' CLASS='boder-0' SIZE='22'
													onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumChouzi2();" 
													field="faOutflowOthers" style="width: 98%; " 
													></label></TD>
											</TR>
											<TR>
												<TD class=unnamed2 align=middle height=22>现金流出小计</TD>
												<TD class=unnamed2 align=middle height=22>58</TD>
												<TD class=font-cal_xianjin height=22><label
													id='query$form$0$JJH_NJ_REPORT6$chouziliuchuxiaoji'
													value='' ID='筹资流出小计' MAXLENGTH='15' isMoney='true'
													style='text-align: right' CLASS='boder-cal' readonly SIZE='22'
													field="faOutflowSum" style="width: 98%; " 
													></label></TD>
											</TR>
											<TR>
												<TD class=unnamed2 height=22>筹资活动产生的现金流量净额</TD>
												<TD class=unnamed2 align=middle height=22>59</TD>
												<TD class=font-cal_xianjin height=22><label
													id='query$form$0$JJH_NJ_REPORT6$chouzijinge' value=''
													ID='筹资净额' MAXLENGTH='15' isMoney='true'
													style='text-align: right' CLASS='boder-cal' readonly SIZE='22'
													field="faNetAmount" style="width: 98%; " 
													></label></TD>
											</TR>
											<TR>
												<TD class=unnamed2 height=22>四、汇率变动对现金的影响额</TD>
												<TD class=unnamed2 align=middle height=22>60</TD>
												<TD class=unnamed3 height=22><label
													id='query$form$0$JJH_NJ_REPORT6$huilvyingxiange' value=''
													ID='汇率影响额' MAXLENGTH='15' isMoney='true'
													style='text-align: right' CLASS='boder-0' SIZE='22'
													field="exchangeRateMovement" style="width: 98%; " 
													onkeyup="value=value.replace(/[^\d.-]/g,'');getJing();getJing();"
													></label></TD>
											</TR>
											<TR>
												<TD class=unnamed4 height=22>五、现金及现金等价物净增加额</TD>
												<TD class=unnamed4 align=middle height=22>61</TD>
												<TD height=22><label
													id='query$form$0$JJH_NJ_REPORT6$xianjinzengjiae' value=''
													ID='现金增加额' MAXLENGTH='15' isMoney='true'
													style='text-align: right' CLASS='boder-0' SIZE='22'
													field="netRevalueation" style="width: 98%; " maxlength="10"
													></label></TD>
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

<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
</form>
</div>
</div>
</body>
</html>
