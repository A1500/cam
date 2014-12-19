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
	var somJxCheckBalanceSheetDataSet = L5.DatasetMgr.lookup("somJxCheckBalanceSheetDataSet");
	somJxCheckBalanceSheetDataSet.setParameter("TASK_CODE@=", taskCode);
	somJxCheckBalanceSheetDataSet.load();
	somJxCheckBalanceSheetDataSet.on("load",function(ds){
		if(ds.getCount()==0){
			somJxCheckBalanceSheetDataSet.newRecord();
		}
		//流动资产
		setSumChu(1,8,9);
		setSumMo(1,8,9);		
		//流动负债
		setSumMo1(23,31,32);
		setSumMo12(23,31,32);
		
		//长期投资
		setSumChu(10,11,12);
		setSumMo(10,11,12);		
		//长期负债
		setSumMo1(33,35,36);
		setSumMo12(33,35,36);
		
		//固定资产
		calZichanJingzhi(13,14,15);
		calMoZichanJingzhi(13,14,15);		
		//净资产 
		setSumMo1(39,40,41);
		setSumMo12(39,40,41);		
	});
	//创建页面导航下拉框
	createFundEditSelect();
}
function save(){
	var somJxCheckBalanceSheetDataSetIsValidate = somJxCheckBalanceSheetDataSet.isValidate();
	if(somJxCheckBalanceSheetDataSetIsValidate!=true){
		L5.Msg.alert("提示",somJxCheckBalanceSheetDataSetIsValidate);
		return "break";
	}
	var JxCheckBalanceSheetRecord=somJxCheckBalanceSheetDataSet.getCurrent();
	//if(document.getElementById("年初数22").value != document.getElementById("年初数42").value){
		//L5.Msg.alert("提示","资产总计的年初数与负债和净资产总计的年初数不相等，请核对！");
		//return "break";
	//}
	
	if(document.getElementById("期末数22").value != document.getElementById("期末数42").value){
		L5.Msg.alert("提示","资产总计的期末数与负债和净资产总计的期末数不相等，请核对！");
		return "break";
	}
	JxCheckBalanceSheetRecord.set("caSumS",document.getElementById("年初数9").value);
	JxCheckBalanceSheetRecord.set("caSumE",document.getElementById("期末数9").value);	
	JxCheckBalanceSheetRecord.set("clSumS",document.getElementById("年初数32").value);
	JxCheckBalanceSheetRecord.set("clSumE",document.getElementById("期末数32").value);
	JxCheckBalanceSheetRecord.set("piSumS",document.getElementById("年初数12").value);
	JxCheckBalanceSheetRecord.set("piSumE",document.getElementById("期末数12").value);	
	JxCheckBalanceSheetRecord.set("llSumS",document.getElementById("年初数36").value);
	JxCheckBalanceSheetRecord.set("llSumE",document.getElementById("期末数36").value);					
	JxCheckBalanceSheetRecord.set("faNetValueS",document.getElementById("年初数15").value);
	JxCheckBalanceSheetRecord.set("faNetValueE",document.getElementById("期末数15").value);	
	JxCheckBalanceSheetRecord.set("paSumS",document.getElementById("年初数38").value);
	JxCheckBalanceSheetRecord.set("paSumE",document.getElementById("期末数38").value);									
	JxCheckBalanceSheetRecord.set("faSumS",document.getElementById("年初数19").value);
	JxCheckBalanceSheetRecord.set("faSumE",document.getElementById("期末数19").value);									
	JxCheckBalanceSheetRecord.set("netAssetsSumS",document.getElementById("年初数41").value);
	JxCheckBalanceSheetRecord.set("netAssetsSumE",document.getElementById("期末数41").value);									
	JxCheckBalanceSheetRecord.set("assetsSumS",document.getElementById("年初数22").value);
	JxCheckBalanceSheetRecord.set("assetsSumE",document.getElementById("期末数22").value);									
	JxCheckBalanceSheetRecord.set("debtAssetsSumS",document.getElementById("年初数42").value);
	JxCheckBalanceSheetRecord.set("debtAssetsSumE",document.getElementById("期末数42").value);								
	var command = new L5.Command("com.inspur.cams.sorg.check.somcheck.cmd.SomCheckCommand");
	command.setParameter("taskCode", taskCode);
	command.setParameter("somJxCheckBalanceSheetRecord", JxCheckBalanceSheetRecord);
	command.execute("savePageJ21");
	if (!command.error) {
		alert("保存成功！");	
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
</script>
<script>
function setSumChu(start, end, result){
    var leixing = "年初数";
   var sum = 0;
   for(i=start;i<=end;i++){
      
      var obj =  document.getElementById( leixing+i);
          if(obj.value != ""){
             sum += parseFloat(obj.value);
          }
     }
   document.getElementById( leixing+result).value = (Math.round(sum*1000000))/1000000;  
   
   calChu1() ;
} 

   
    function calZichanJingzhi(one, two, result){
     var leixing = "年初数";
     var sum1=0;
     var obj =  document.getElementById( leixing + one);
           if(obj.value != ""){
              sum1 += parseFloat(obj.value);
           }
     var obj =  document.getElementById( leixing + two);
           if(obj.value != ""){
              sum1 -= parseFloat(obj.value);
           }
     document.getElementById( leixing + result).value = (Math.round(sum1*1000000))/1000000; 
     
     setSumChu(15, 18, 19)
    }



function calChu1(){
    var leixing = "年初数";
    var a9 = document.getElementById( leixing+9);
    var a12 = document.getElementById( leixing+12);
    var a19 = document.getElementById( leixing+19);
    var a20 = document.getElementById( leixing+20);
    var a21 = document.getElementById( leixing+21); 
    var sum = 0;
    var eles = new Array(a9, a12, a19, a20, a21);
    for(i=0;i<eles.length;i++){
 
          if(eles[i].value != ""){ 
             sum += parseFloat(eles[i].value);
          }
     }
     
    document.getElementById( leixing+22).value = (Math.round(sum*1000000))/1000000;
} 

//----------------------------资产总计期末数-----------------------------------   

function setSumMo(start, end, result){
   
   var leixing = "期末数";
       
   var sum = 0;
   for(i=start;i<=end;i++){
      
      var obj =  document.getElementById( leixing +i);
          if(obj.value != ""){
             sum += parseFloat(obj.value);
          }
     }
   document.getElementById( leixing +result).value = (Math.round(sum*1000000))/1000000;  
   
   calMo() ;
} 

   
    function calMoZichanJingzhi(one, two, result){
      
     var sum1=0;  
     var leixing = "期末数";
     var obj =  document.getElementById(  leixing + one);
           if(obj.value != ""){
              sum1 += parseFloat(obj.value);
           }
     var obj =  document.getElementById(  leixing + two);
           if(obj.value != ""){
              sum1 -= parseFloat(obj.value);
           }
     document.getElementById(  leixing + result).value = (Math.round(sum1*1000000))/1000000; 
     
     setSumMo(15, 18, 19)
    }



function calMo(){
    
    leixing = "期末数";    
    var a9 = document.getElementById(  leixing +9);
    var a12 = document.getElementById(  leixing +12);
    var a19 = document.getElementById(  leixing +19);
    var a20 = document.getElementById(  leixing +20);
    var a21 = document.getElementById(  leixing +21); 
    var sum = 0;
    var eles = new Array(a9, a12, a19, a20, a21);
    for(i=0;i<eles.length;i++){
 
          if(eles[i].value != ""){ 
             sum += parseFloat(eles[i].value);
          }
     }
     
    document.getElementById(  leixing +22).value = (Math.round(sum*1000000))/1000000;
}

//----------------------------负债和净资产-----------------------------------    

function setSumMo1(start, end, result){
   
   
   var leixing = "年初数";
       
   var sum = 0;
   for(i=start;i<=end;i++){
      
      var obj =  document.getElementById(  leixing +i);
          if(obj.value != ""){
             sum += parseFloat(obj.value);
          }
     }
   document.getElementById(  leixing +result).value = (Math.round(sum*1000000))/1000000;  
   if(start == 39 || start == 40){
     calMo3();
   }else{
     calMo2();
   }
} 

function calMo1(){
    
    var leixing = "年初数";

    var a38 = document.getElementById(  leixing +38);
    var a41 = document.getElementById(  leixing +41); 
    var sum = 0;
    var eles = new Array(a38, a41);
    for(i=0;i<eles.length;i++){
 
          if(eles[i].value != ""){ 
             sum += parseFloat(eles[i].value);
          }
     }
     
    document.getElementById(  leixing +42).value = (Math.round(sum*1000000))/1000000;
}

function calMo2(){
    
    var leixing = "年初数";

    var a32 = document.getElementById(  leixing +32);
    var a36 = document.getElementById(  leixing +36);
    var a37 = document.getElementById(  leixing +37); 
    var sum = 0;
    var eles = new Array(a32, a36, a37);
    for(i=0;i<eles.length;i++){
 
          if(eles[i].value != ""){ 
             sum += parseFloat(eles[i].value);
          }
     }
     
    document.getElementById(  leixing +38).value = (Math.round(sum*1000000))/1000000;
    
    calMo1()
}

function calMo3(){
    
    var leixing = "年初数";

    var a32 = document.getElementById(  leixing +39);
    var a36 = document.getElementById(  leixing +40);
    var sum = 0;
    var eles = new Array(a32, a36);
    for(i=0;i<eles.length;i++){
 
          if(eles[i].value != ""){ 
             sum += parseFloat(eles[i].value);
          }
     }
     
    document.getElementById(  leixing + 41).value = (Math.round(sum*1000000))/1000000;
    
    calMo1()
}

//----------------------------负债和净资产期末数-----------------------------------    

function setSumMo12(start, end, result){
   
  
   var leixing = "期末数";
       
   var sum = 0;
   for(i=start;i<=end;i++){
      
      var obj =  document.getElementById(  leixing +i);
          if(obj.value != ""){
             sum += parseFloat(obj.value);
          }
     }
   document.getElementById(  leixing +result).value = (Math.round(sum*1000000))/1000000;  
   if(start == 39 || start == 40){
     calMo32();
   }else{
     calMo22();
   }
} 

function calMo12(){
    
    leixing = "期末数";    

    var a38 = document.getElementById(  leixing +38);
    var a41 = document.getElementById(  leixing +41); 
    var sum = 0;
    var eles = new Array(a38, a41);
    for(i=0;i<eles.length;i++){
 
          if(eles[i].value != ""){ 
             sum += parseFloat(eles[i].value);
          }
     }
     
    document.getElementById(  leixing +42).value = (Math.round(sum*1000000))/1000000;
}

function calMo22(){
    
    leixing = "期末数";    

    var a32 = document.getElementById(  leixing +32);
    var a36 = document.getElementById(  leixing +36);
    var a37 = document.getElementById(  leixing +37); 
    var sum = 0;
    var eles = new Array(a32, a36, a37);
    for(i=0;i<eles.length;i++){
 
          if(eles[i].value != ""){ 
             sum += parseFloat(eles[i].value);
          }
     }
     
    document.getElementById(  leixing +38).value = (Math.round(sum*1000000))/1000000;
    
    calMo12()
}

function calMo32(){
    
    leixing = "期末数";    

    var a32 = document.getElementById(  leixing +39);
    var a36 = document.getElementById(  leixing +40);
    var sum = 0;
    var eles = new Array(a32, a36);
    for(i=0;i<eles.length;i++){
 
          if(eles[i].value != ""){ 
             sum += parseFloat(eles[i].value);
          }
     }
     
    document.getElementById(  leixing + 41).value = (Math.round(sum*1000000))/1000000;
    
    calMo12()
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
	width:98%;
	font-size: 14px;
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
	<model:dataset id="somJxCheckBalanceSheetDataSet" cmd="com.inspur.cams.sorg.check.balancesheet.cmd.SomCheckBalanceSheetQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.balancesheet.data.SomCheckBalanceSheet">
			<model:field name="caMoneyfundsE" type="string" rule="require" />
			<model:field name="clShorttermBorrowingE" type="string" rule="require" />
			<model:field name="caLiquidInvestmentE" type="string" rule="require" />
			<model:field name="clDuesE" type="string" rule="require" />
			<model:field name="caReceivablesE" type="string" rule="require" />
			<model:field name="clAccruedPayrollsE" type="string" rule="require" />
			<model:field name="caAdvanceMoneyE" type="string" rule="require" />
			<model:field name="clTasPayableE" type="string" rule="require" />
			<model:field name="caInventoryE" type="string" rule="require" />
			<model:field name="clDepositReceivedE" type="string" rule="require" />
			<model:field name="caDeferredExpensesE" type="string" rule="require" />
			<model:field name="clAccruedExpensesE" type="string" rule="require" />
			<model:field name="caDebtInvestmentsE" type="string" rule="require" />
			<model:field name="clAccruedLiabilitiesE" type="string" rule="require" />
			<model:field name="caOthersE" type="string" rule="require" />
			<model:field name="clLongtermDueE" type="string" rule="require" />
			<model:field name="clOthersE" type="string" rule="require" />
			<model:field name="piLongtermEquityInvE" type="string" rule="require" />
			<model:field name="piLongtermDebtInvE" type="string" rule="require" />
			<model:field name="llLongtermLoansE" type="string" rule="require" />
			<model:field name="llLongtermPayableE" type="string" rule="require" />
			<model:field name="llOthersE" type="string" rule="require" />
			<model:field name="faPrimeCostE" type="string" rule="require" />
			<model:field name="faAccumulatedDepreciationE" type="string" rule="require" />
			<model:field name="paDebtE" type="string" rule="require" />
			<model:field name="faConstructionInProcessE" type="string" rule="require" />
			<model:field name="faCulturalHeritageE" type="string" rule="require" />
			<model:field name="faDisposalFixedAssetsE" type="string" rule="require" />
			<model:field name="intangibleAssetsE" type="string" rule="require" />
			<model:field name="unlimitNetAssetsE" type="string" rule="require" />
			<model:field name="limitNetAssetsE" type="string" rule="require" />
			<model:field name="entrustedAgentAssetsE" type="string" rule="require" />
		</model:record>
	</model:dataset>
</model:datasets>
<div id="float" >
	<input type="button" value="下一页" style="height:25px;width:80px;position:absolute;margin-left:120px;" onclick="nextPageJ('22')"/>
	<input type="button" value="上一页" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="lastPageJ('20')"/>
	<input type="button" value="保存" style="height:25px;width:80px;position:absolute;margin-left:220px;" onclick="save();"/>
	<input type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:320px;" onclick="backJ();"/>
</div>
<div align=center>
<div align=center style="width: 800px">
<form dataset="somJxCheckBalanceSheetDataSet" name="myform" method="post" onsubmit="return false">

<TABLE  cellSpacing=0 cellPadding=0 width=700 align=center
	border=0>
	<TBODY>
		<TD align=left width=700 height=31><strong> 四、财务会计报告 </strong></TD>
		</TR>
		<TR>
			<TD vAlign=top height=844>
			<TABLE cellSpacing=0 cellPadding=0 width=700 align=center
				border=0>
				<TBODY>
					<TR>
						<TD width='700' align=middle vAlign=top>
						<TABLE cellSpacing=0 cellPadding=0 width='100%' align=center
							border=0>
							<TBODY>
								<TR>
									<TD align=middle height=22>
									<div align='center'><STRONG>资产负债表</STRONG></div>
									</TD>
								</TR>
								<TR>
									<TD align=right height=22>
									<TABLE cellSpacing=0 cellPadding=0 width='100%' border=0>
										<TBODY>
											<TR>
												<TD width='33%' height='24' align=right>单位：<span style="color:red">人民币万元</span></TD>
											</TR>
										</TBODY>
									</TABLE>
									</TD>
								</TR>
								<TR>
									<TD>
									<TABLE class=unnamed1 cellSpacing=0 cellPadding=0 width='100%'
										border=0>
										<TBODY>
											<TR>
												<TD class=unnamed2 align=middle width=16% height=22>资 产</TD>
												<TD class=unnamed2 align=middle width=3% height=22>行次</TD>
												<TD class=unnamed2 align=middle width=14% height=22>年初数</TD>
												<TD class=unnamed5 align=middle width=14% height=22>期末数</TD>
												<TD class=unnamed2 align=middle width=21%>负债和净资产</TD>
												<TD class=unnamed2 align=middle width=3%>行次</TD>
												<TD class=unnamed2 align=middle width=14%>年初数</TD>
												<TD class=unnamed3 align=middle width=14%>期末数</TD>
											</TR>
											<TR>
												<TD class=unnamed2 height=22>流动资产：</TD>
												<TD class=unnamed2 height=22>&nbsp;</TD>
												<TD class=unnamed2 align=middle height=22>&nbsp;</TD>
												<TD class=unnamed5 align=middle height=22>&nbsp;</TD>
												<TD class=unnamed2>流动负债：</TD>
												<TD class=unnamed2 align=middle>&nbsp;</TD>
												<TD class=unnamed2 align=middle>&nbsp;</TD>
												<TD class=unnamed3 align=middle>&nbsp;</TD>
											</TR>
											<TR>
												<TD class=unnamed2 height=22>货币资金</TD>
												<TD class=unnamed2 align=middle height=22>1</TD>
												<TD class=unnamed2 align=middle height=22><input
													name='货币资金' value=''
													ID='年初数1' MAXLENGTH='15' CLASS='boder-0' SIZE='14'
													isMoney='true' style='text-align:right;padding-right:2px;'
													onblur='checkFloat(this);'onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumChu(1,8,9);" 
													field="caMoneyfundsS" style="width: 98%; " 
													></TD>
												<TD class=unnamed5 align=middle height=22><input
													name='货币资金' value=''
													ID='期末数1' MAXLENGTH='15' isMoney='true'
													style='text-align:right;padding-right:2px;' CLASS='boder-0' SIZE='14'
													onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumMo(1,8,9);" 
													field="caMoneyfundsE" style="width: 98%; " 
													></TD>
												<TD class=unnamed2>短期借款</TD>
												<TD class=unnamed2 align=middle>61</TD>
												<TD class=unnamed2 align=middle><input
													name='短期借款' value=''
													ID='年初数23' MAXLENGTH='15' CLASS='boder-0' isMoney='true'
													style='text-align:right;padding-right:2px;' SIZE='14'
													onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumMo1(23,31,32);" 
													field="clShorttermBorrowingS" style="width: 98%; " 
													></TD>
												<TD class=unnamed3 align=middle><input
													name='短期借款' value=''
													ID='期末数23' MAXLENGTH='15' isMoney='true'
													style='text-align:right;padding-right:2px;' CLASS='boder-0' SIZE='14'
													onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumMo12(23,31,32);" 
													field="clShorttermBorrowingE" style="width: 98%; " 
													></TD>
											</TR>
											<TR>
												<TD class=unnamed2 height=22>短期投资</TD>
												<TD class=unnamed2 align=middle height=22>2</TD>
												<TD class=unnamed2 align=middle height=22><input
													name='短期投资' value=''
													ID='年初数2' MAXLENGTH='15' CLASS='boder-0' SIZE='14'
													isMoney='true' style='text-align:right;padding-right:2px;'
													onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumChu(1,8,9);" 
													field="caLiquidInvestmentS" style="width: 98%; " 
													></TD>
												<TD class=unnamed5 align=middle height=22><input
													name='短期投资' value=''
													ID='期末数2' isMoney='true' style='text-align:right;padding-right:2px;'
													MAXLENGTH='15' CLASS='boder-0' SIZE='14'
													onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumMo(1,8,9);" 
													field="caLiquidInvestmentE" style="width: 98%; " 
													></TD>
												<TD class=unnamed2>应付款项</TD>
												<TD class=unnamed2 align=middle>62</TD>
												<TD class=unnamed2 align=middle><input
													name='应付款项' value=''
													ID='年初数24' MAXLENGTH='15' CLASS='boder-0' isMoney='true'
													style='text-align:right;padding-right:2px;' SIZE='14'
													onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumMo1(23,31,32);" 
													field="clDuesS" style="width: 98%; " 
													></TD>
												<TD class=unnamed3 align=middle><input
													name='应付款项' value=''
													ID='期末数24' MAXLENGTH='15' isMoney='true'
													style='text-align:right;padding-right:2px;' CLASS='boder-0' SIZE='14'
													onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumMo12(23,31,32);" 
													field="clDuesE" style="width: 98%; " 
													></TD>
											</TR>
											<TR>
												<TD class=unnamed2 height=22>应收款项</TD>
												<TD class=unnamed2 align=middle height=22>3</TD>
												<TD class=unnamed2 align=middle height=22><input
													name='应收款项' value=''
													ID='年初数3' MAXLENGTH='15' isMoney='true'
													style='text-align:right;padding-right:2px;' CLASS='boder-0' SIZE='14'
													onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumChu(1,8,9);" 
													field="caReceivablesS" style="width: 98%; " 
													></TD>
												<TD class=unnamed5 align=middle height=22><input
													name='应收款项' value=''
													ID='期末数3' MAXLENGTH='15' CLASS='boder-0' isMoney='true'
													style='text-align:right;padding-right:2px;' SIZE='14'
													onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumMo(1,8,9);" 
													field="caReceivablesE" style="width: 98%; " 
													></TD>
												<TD class=unnamed2>应付工资</TD>
												<TD class=unnamed2 align=middle>63</TD>
												<TD class=unnamed2 align=middle><input
													name='应付工资' value=''
													ID='年初数25' MAXLENGTH='15' isMoney='true'
													style='text-align:right;padding-right:2px;' CLASS='boder-0' SIZE='14'
													onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumMo1(23,31,32);" 
													field="clAccruedPayrollsS" style="width: 98%; " 
													></TD>
												<TD class=unnamed3 align=middle><input
													name='应付工资' value=''
													ID='期末数25' MAXLENGTH='15' CLASS='boder-0' isMoney='true'
													style='text-align:right;padding-right:2px;' SIZE='14'
													onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumMo12(23,31,32);" 
													field="clAccruedPayrollsE" style="width: 98%; " 
													></TD>
											</TR>
											<TR>
												<TD class=unnamed2 height=24>预付账款</TD>
												<TD class=unnamed2 align=middle height=24>4</TD>
												<TD class=unnamed2 align=middle height=24><input
													name='预付账款' value=''
													ID='年初数4' MAXLENGTH='15' isMoney='true'
													style='text-align:right;padding-right:2px;' CLASS='boder-0' SIZE='14'
													onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumChu(1,8,9);" 
													field="caAdvanceMoneyS" style="width: 98%; " 
													></TD>
												<TD class=unnamed5 align=middle height=24><input
													name='预付账款' value=''
													ID='期末数4' MAXLENGTH='15' isMoney='true'
													style='text-align:right;padding-right:2px;' CLASS='boder-0' SIZE='14'
													onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumMo(1,8,9);" 
													field="caAdvanceMoneyE" style="width: 98%; " 
													></TD>
												<TD class=unnamed2>应交税金</TD>
												<TD class=unnamed2 align=middle>65</TD>
												<TD class=unnamed2 align=middle><input
													name='应交税金' value=''
													ID='年初数26' isMoney='true' style='text-align:right;padding-right:2px;'
													MAXLENGTH='15' CLASS='boder-0' SIZE='14'
													onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumMo1(23,31,32);" 
													field="clTasPayableS" style="width: 98%; " 
													></TD>
												<TD class=unnamed3 align=middle><input
													name='应交税金' value=''
													ID='期末数26' MAXLENGTH='15' CLASS='boder-0' isMoney='true'
													style='text-align:right;padding-right:2px;' SIZE='14'
													onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumMo12(23,31,32);" 
													field="clTasPayableE" style="width: 98%; " 
													></TD>
											</TR>
											<TR>
												<TD class=unnamed2 height=22>存 货</TD>
												<TD class=unnamed2 align=middle height=22>8</TD>
												<TD class=unnamed2 align=middle height=22><input
													name='存 货' value=''
													ID='年初数5' MAXLENGTH='15' CLASS='boder-0' isMoney='true'
													style='text-align:right;padding-right:2px;' SIZE='14'
													onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumChu(1,8,9);" 
													field="caInventoryS" style="width: 98%; " 
													></TD>
												<TD class=unnamed5 align=middle height=22><input
													name='存 货' value=''
													ID='期末数5' MAXLENGTH='15' CLASS='boder-0' isMoney='true'
													style='text-align:right;padding-right:2px;' SIZE='14'
													onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumMo(1,8,9);" 
													field="caInventoryE" style="width: 98%; " 
													></TD>
												<TD class=unnamed2>预收账款</TD>
												<TD class=unnamed2 align=middle>66</TD>
												<TD class=unnamed2 align=middle><input
													name='预收账款' value=''
													ID='年初数27' MAXLENGTH='15' CLASS='boder-0' isMoney='true'
													style='text-align:right;padding-right:2px;' SIZE='14'
													onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumMo1(23,31,32);" 
													field="clDepositReceivedS" style="width: 98%; " 
													></TD>
												<TD class=unnamed3 align=middle><SPAN><input
													name='预收账款' value=''
													ID='期末数27' MAXLENGTH='15' CLASS='boder-0' isMoney='true'
													style='text-align:right;padding-right:2px;' SIZE='14'
													onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumMo12(23,31,32);" 
													field="clDepositReceivedE" style="width: 98%; " 
													> </SPAN></TD>
											</TR>
											<TR>
												<TD class=unnamed2 height=22>待摊费用</TD>
												<TD class=unnamed2 align=middle height=22>9</TD>
												<TD class=unnamed2 align=middle height=22><input
													name='待摊费用' value=''
													ID='年初数6' MAXLENGTH='15' CLASS='boder-0' SIZE='14'
													isMoney='true' style='text-align:right;padding-right:2px;'
													onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumChu(1,8,9);" 
													field="caDeferredExpensesS" style="width: 98%; " 
													></TD>
												<TD class=unnamed5 align=middle height=22><input
													name='待摊费用' value=''
													ID='期末数6' MAXLENGTH='15' isMoney='true'
													style='text-align:right;padding-right:2px;' CLASS='boder-0' SIZE='14'
													onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumMo(1,8,9);" 
													field="caDeferredExpensesE" style="width: 98%; " 
													></TD>
												<TD class=unnamed2>预提费用</TD>
												<TD class=unnamed2 align=middle>71</TD>
												<TD class=unnamed2 align=middle><input
													name='预提费用' value=''
													ID='年初数28' isMoney='true' style='text-align:right;padding-right:2px;'
													MAXLENGTH='15' CLASS='boder-0' SIZE='14'
													onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumMo1(23,31,32);" 
													field="clAccruedExpensesS" style="width: 98%; " 
													></TD>
												<TD class=unnamed3 align=middle><input
													name='预提费用' value=''
													ID='期末数28' isMoney='true' style='text-align:right;padding-right:2px;'
													MAXLENGTH='15' CLASS='boder-0' SIZE='14'
													onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumMo12(23,31,32);" 
													field="clAccruedExpensesE" style="width: 98%; " 
													></TD>
											</TR>
											<TR>
												<TD class=unnamed2 height=41>一年内到期的长期债权投资</TD>
												<TD class=unnamed2 align=middle height=41>15</TD>
												<TD class=unnamed2 align=middle height=41><input
													name='一年内到期的长期债权投资' value=''
													ID='年初数7' isMoney='true' style='text-align:right;padding-right:2px;'
													MAXLENGTH='15' CLASS='boder-0' SIZE='14'
													onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumChu(1,8,9);" 
													field="caDebtInvestmentsS" style="width: 98%; " 
													></TD>
												<TD class=unnamed5 align=middle height=41><input
													name='一年内到期的长期债权投资' value=''
													ID='期末数7' MAXLENGTH='15' CLASS='boder-0' isMoney='true'
													style='text-align:right;padding-right:2px;' SIZE='14'
													onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumMo(1,8,9);" 
													field="caDebtInvestmentsE" style="width: 98%; " 
													></TD>
												<TD class=unnamed2>预计负债</TD>
												<TD class=unnamed2 align=middle>72</TD>
												<TD class=unnamed2 align=middle><input
													name='预计负债' value=''
													ID='年初数29' MAXLENGTH='15' isMoney='true'
													style='text-align:right;padding-right:2px;' CLASS='boder-0' SIZE='14'
													onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumMo1(23,31,32);" 
													field="clAccruedLiabilitiesS" style="width: 98%; " 
													></TD>
												<TD class=unnamed3 align=middle><input
													name='预计负债' value=''
													ID='期末数29' MAXLENGTH='15' isMoney='true'
													style='text-align:right;padding-right:2px;' CLASS='boder-0' SIZE='14'
													onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumMo12(23,31,32);" 
													field="clAccruedLiabilitiesE" style="width: 98%; " 
													></TD>
											</TR>
											<TR>
												<TD class=unnamed2 height=36>其他流动资产</TD>
												<TD class=unnamed2 align=middle height=36>18</TD>
												<TD class=unnamed2 align=middle height=36><input
													name='其他流动资产' value=''
													ID='年初数8' MAXLENGTH='15' isMoney='true'
													style='text-align:right;padding-right:2px;' CLASS='boder-0' SIZE='14'
													onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumChu(1,8,9);" 
													field="caOthersS" style="width: 98%; " 
													></TD>
												<TD class=unnamed5 align=middle height=36><input
													name='其他流动资产' value=''
													ID='期末数8' MAXLENGTH='15' isMoney='true'
													style='text-align:right;padding-right:2px;' CLASS='boder-0' SIZE='14'
													onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumMo(1,8,9);" 
													field="caOthersE" style="width: 98%; " 
													></TD>
												<TD class=unnamed2>一年内到期的长期负债</TD>
												<TD class=unnamed2 align=middle>74</TD>
												<TD class=unnamed2 align=middle><input
													name='一年内到期的长期负债' value=''
													ID='年初数30' MAXLENGTH='15' CLASS='boder-0' isMoney='true'
													style='text-align:right;padding-right:2px;' SIZE='14'
													onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumMo1(23,31,32);" 
													field="clLongtermDueS" style="width: 98%; " 
													></TD>
												<TD class=unnamed3 align=middle><input
													name='一年内到期的长期负债' value=''
													ID='期末数30' isMoney='true' style='text-align:right;padding-right:2px;'
													MAXLENGTH='15' CLASS='boder-0' SIZE='14'
													onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumMo12(23,31,32);" 
													field="clLongtermDueE" style="width: 98%; " 
													></TD>
											</TR>
											<TR>
												<TD class=unnamed2 height=22>流动资产合计</TD>
												<TD class=unnamed2 align=middle height=22>20</TD>
												<TD class=unnamed2 align=middle height=22><input
													name='流动资产合计年初数' value=''
													ID='年初数9' MAXLENGTH='15' CLASS='boder-cal' readonly isMoney='true'
													style='text-align:right;padding-right:2px;' SIZE='14' 
													field="caSumS" style="width: 98%; " 
													></TD>
												<TD class=unnamed5 align=middle height=22><input
													name='流动资产合计期末数' value=''
													ID='期末数9' MAXLENGTH='15' CLASS='boder-cal' readonly isMoney='true'
													style='text-align:right;padding-right:2px;' SIZE='14' 
													field="caSumE" style="width: 98%; " 
													></TD>
												<TD class=unnamed2>其他流动负债</TD>
												<TD class=unnamed2 align=middle>78</TD>
												<TD class=unnamed2 align=middle><input
													name='其他流动负债' value=''
													ID='年初数31' MAXLENGTH='15' CLASS='boder-0' isMoney='true'
													style='text-align:right;padding-right:2px;' SIZE='14'
													onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumMo1(23,31,32);" 
													field="clOthersS" style="width: 98%; " 
													></TD>
												<TD class=unnamed3 align=middle><input
													name='其他流动负债' value=''
													ID='期末数31' isMoney='true' style='text-align:right;padding-right:2px;'
													MAXLENGTH='15' CLASS='boder-0' SIZE='14'
													onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumMo12(23,31,32);" 
													field="clOthersE" style="width: 98%; " 
													></TD>
											</TR>
											<TR>
												<TD class=unnamed2 height=22>&nbsp;</TD>
												<TD class=unnamed2 align=middle height=22>&nbsp;</TD>
												<TD class=unnamed2 align=middle height=22>&nbsp;</TD>
												<TD class=unnamed5 align=middle height=22>&nbsp;</TD>
												<TD class=unnamed2>流动负债合计</TD>
												<TD class=unnamed2 align=middle>80</TD>
												<TD class=unnamed2 align=middle><input
													name='动负债合计年初数' value=''
													ID='年初数32' MAXLENGTH='15' CLASS='boder-cal' readonly isMoney='true'
													style='text-align:right;padding-right:2px;' SIZE='14' 
													field="clSumS" style="width: 98%; " 
													></TD>
												<TD class=unnamed3 align=middle><input
													name='动负债合计期末数' value=''
													ID='期末数32' MAXLENGTH='15' CLASS='boder-cal' readonly isMoney='true'
													style='text-align:right;padding-right:2px;' SIZE='14' 
													field="clSumE" style="width: 98%; " 
													></TD>
											</TR>
											<TR>
												<TD class=unnamed2 height=16>长期投资：</TD>
												<TD class=unnamed2 align=middle height=16>&nbsp;</TD>
												<TD class=unnamed2 align=middle height=16>&nbsp;</TD>
												<TD class=unnamed5 align=middle height=16>&nbsp;</TD>
												<TD class=unnamed2>&nbsp;</TD>
												<TD class=unnamed2 align=middle>&nbsp;</TD>
												<TD class=unnamed2 align=middle>&nbsp;</TD>
												<TD class=unnamed3 align=middle>&nbsp;</TD>
											</TR>
											<TR>
												<TD class=unnamed2 height=22>长期股权投资</TD>
												<TD class=unnamed2 align=middle height=22>21</TD>
												<TD class=unnamed2 align=middle height=22><input
													name='长期股权投资' value=''
													ID='年初数10' MAXLENGTH='15' CLASS='boder-0' isMoney='true'
													style='text-align:right;padding-right:2px;' SIZE='14'
													onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumChu(10,11,12);" 
													field="piLongtermEquityInvS" style="width: 98%; " 
													></TD>
												<TD class=unnamed5 align=middle height=22><input
													name='长期股权投资' value=''
													ID='期末数10' isMoney='true' style='text-align:right;padding-right:2px;'
													MAXLENGTH='15' CLASS='boder-0' SIZE='14'
													onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumMo(10,11,12);" 
													field="piLongtermEquityInvE" style="width: 98%; " 
													></TD>
												<TD class=unnamed2>长期负债：</TD>
												<TD class=unnamed2 align=middle>&nbsp;</TD>
												<TD class=unnamed2 align=middle>&nbsp;</TD>
												<TD class=unnamed3 align=middle>&nbsp;</TD>
											</TR>
											<TR>
												<TD class=unnamed2 height=22>长期债权投资</TD>
												<TD class=unnamed2 align=middle height=22>24</TD>
												<TD class=unnamed2 align=middle height=22><input
													name='长期债权投资' value=''
													ID='年初数11' MAXLENGTH='15' CLASS='boder-0' isMoney='true'
													style='text-align:right;padding-right:2px;' SIZE='14'
													onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumChu(10,11,12);" 
													field="piLongtermDebtInvS" style="width: 98%; " 
													></TD>
												<TD class=unnamed5 align=middle height=22><input
													name='长期债权投资' value=''
													ID='期末数11' MAXLENGTH='15' isMoney='true'
													style='text-align:right;padding-right:2px;' CLASS='boder-0' SIZE='14'
													onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumMo(10,11,12);" 
													field="piLongtermDebtInvE" style="width: 98%; " 
													></TD>
												<TD class=unnamed2>长期借款</TD>
												<TD class=unnamed2 align=middle>81</TD>
												<TD class=unnamed2 align=middle><input
													name='长期借款' value=''
													ID='年初数33' isMoney='true' style='text-align:right;padding-right:2px;'
													MAXLENGTH='15' CLASS='boder-0' SIZE='14'
													onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumMo1(33,35,36);" 
													field="llLongtermLoansS" style="width: 98%; " 
													></TD>
												<TD class=unnamed3 align=middle><input
													name='长期借款' value=''
													ID='期末数33' MAXLENGTH='15' isMoney='true'
													style='text-align:right;padding-right:2px;' CLASS='boder-0' SIZE='14'
													onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumMo12(33,35,36);" 
													field="llLongtermLoansE" style="width: 98%; " 
													></TD>
											</TR>
											<TR>
												<TD class=unnamed2 height=22>长期投资合计</TD>
												<TD class=unnamed2 align=middle height=22>30</TD>
												<TD class=unnamed2 align=middle height=22><input
													name='长期投资合计年初数' value=''
													ID='年初数12' MAXLENGTH='15' isMoney='true'
													style='text-align:right;padding-right:2px;' CLASS='boder-cal' readonly SIZE='14'
													field="piSumS" style="width: 98%; " 
													></TD>
												<TD class=unnamed5 align=middle height=22><input
													name='长期投资合计期末数' value=''
													ID='期末数12' MAXLENGTH='15' isMoney='true'
													style='text-align:right;padding-right:2px;' CLASS='boder-cal' readonly SIZE='14'
													field="piSumE" style="width: 98%; " 
													></TD>
												<TD class=unnamed2>长期应付款</TD>
												<TD class=unnamed2 align=middle>84</TD>
												<TD class=unnamed2 align=middle><input
													name='长期应付款' value=''
													ID='年初数34' isMoney='true' style='text-align:right;padding-right:2px;'
													MAXLENGTH='15' CLASS='boder-0' SIZE='14'
													onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumMo1(33,35,36);" 
													field="llLongtermPayableS" style="width: 98%; " 
													></TD>
												<TD class=unnamed3 align=middle><input
													name='长期应付款' value=''
													ID='期末数34' isMoney='true' style='text-align:right;padding-right:2px;'
													MAXLENGTH='15' CLASS='boder-0' SIZE='14'
													onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumMo12(33,35,36);" 
													field="llLongtermPayableE" style="width: 98%; " 
													></TD>
											</TR>
											<TR>
												<TD class=unnamed2 height=22>&nbsp;</TD>
												<TD class=unnamed2 align=middle height=22>&nbsp;</TD>
												<TD class=unnamed2 align=middle height=22>&nbsp;</TD>
												<TD class=unnamed5 align=middle height=22>&nbsp;</TD>
												<TD class=unnamed2>其他长期负债</TD>
												<TD class=unnamed2 align=middle>88</TD>
												<TD class=unnamed2 align=middle><input
													name='其他长期负债' value=''
													ID='年初数35' MAXLENGTH='15' isMoney='true'
													style='text-align:right;padding-right:2px;' CLASS='boder-0' SIZE='14'
													onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumMo1(33,35,36);" 
													field="llOthersS" style="width: 98%; " 
													></TD>
												<TD class=unnamed3 align=middle><input
													name='其他长期负债' value=''
													ID='期末数35' isMoney='true' style='text-align:right;padding-right:2px;'
													MAXLENGTH='15' CLASS='boder-0' SIZE='14'
													onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumMo12(33,35,36);" 
													field="llOthersE" style="width: 98%; " 
													></TD>
											</TR>
											<TR>
												<TD class=unnamed2 height=22>固定资产：</TD>
												<TD class=unnamed2 align=middle height=22>&nbsp;</TD>
												<TD class=unnamed2 align=middle height=22>&nbsp;</TD>
												<TD class=unnamed5 align=middle height=22>&nbsp;</TD>
												<TD class=unnamed2>长期负债合计</TD>
												<TD class=unnamed2 align=middle>90</TD>
												<TD class=unnamed2 align=middle><input
													name='长期负债合计年初数' value=''
													ID='年初数36' isMoney='true' style='text-align:right;padding-right:2px;'
													MAXLENGTH='15' CLASS='boder-cal' readonly SIZE='14' 
													field="llSumS" style="width: 98%; " 
													>
												</TD>
												<TD class=unnamed3 align=middle><input
													name='长期负债合计期末数' value=''
													ID='期末数36' MAXLENGTH='15' isMoney='true'
													style='text-align:right;padding-right:2px;' CLASS='boder-cal' readonly SIZE='14'
													field="llSumE" style="width: 98%; " 
													></TD>
											</TR>
											<TR>
												<TD class=unnamed2 height=22>固定资产原价</TD>
												<TD class=unnamed2 align=middle>31</TD>
												<TD class=unnamed2 align=middle height=22><input
													name='固定资产原价' value=''
													ID='年初数13' MAXLENGTH='15' isMoney='true'
													style='text-align:right;padding-right:2px;' CLASS='boder-0' SIZE='14'
													onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');calZichanJingzhi(13,14,15);" 
													field="faPrimeCostS" style="width: 98%; " 
													></TD>
												<TD class=unnamed5 align=middle height=22><input
													name='固定资产原价' value=''
													ID='期末数13' MAXLENGTH='15' CLASS='boder-0' isMoney='true'
													style='text-align:right;padding-right:2px;' SIZE='14'
													onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');calMoZichanJingzhi(13,14,15);" 
													field="faPrimeCostE" style="width: 98%; " 
													></TD>
												<TD class=unnamed2>&nbsp;</TD>
												<TD class=unnamed2 align=middle>&nbsp;</TD>
												<TD class=unnamed2 align=middle>&nbsp;</TD>
												<TD class=unnamed3 align=middle>&nbsp;</TD>
											</TR>
											<TR>
												<TD class=unnamed2 height=22>减：累计折旧</TD>
												<TD class=unnamed2 align=middle>32</TD>
												<TD class=unnamed2 align=middle height=22><input
													name='减：累计折旧' value=''
													ID='年初数14' MAXLENGTH='15' CLASS='boder-0' isMoney='true'
													style='text-align:right;padding-right:2px;' SIZE='14'
													onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');calZichanJingzhi(13,14,15);" 
													field="faAccumulatedDepreciationS" style="width: 98%; " 
													></TD>
												<TD class=unnamed5 align=middle height=22><input
													name='减：累计折旧' value=''
													ID='期末数14' MAXLENGTH='15' CLASS='boder-0' SIZE='14'
													isMoney='true' style='text-align:right;padding-right:2px;'
													onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');calMoZichanJingzhi(13,14,15);" 
													field="faAccumulatedDepreciationE" style="width: 98%; " 
													></TD>
												<TD class=unnamed2>受托代理负债：</TD>
												<TD class=unnamed2 align=middle>&nbsp;</TD>
												<TD class=unnamed2 align=middle>&nbsp;</TD>
												<TD class=unnamed3 align=middle>&nbsp;</TD>
											</TR>
											<TR>
												<TD class=unnamed2 height=22>固定资产净值</TD>
												<TD class=unnamed2 align=middle>33</TD>
												<TD class=unnamed2 align=middle height=22><input
													name='固定资产净值' value=''
													ID='年初数15' MAXLENGTH='15' CLASS='boder-cal' readonly isMoney='true'
													style='text-align:right;padding-right:2px;' SIZE='14' 
													field="faNetValueS" style="width: 98%; " 
													></TD>
												<TD class=unnamed5 align=middle height=22><input
													name='固定资产净值' value=''
													ID='期末数15' MAXLENGTH='15' CLASS='boder-cal' readonly isMoney='true'
													style='text-align:right;padding-right:2px;' SIZE='14' 
													field="faNetValueE" style="width: 98%; " 
													></TD>
												<TD class=unnamed2>受托代理负债</TD>
												<TD class=unnamed2 align=middle>91</TD>
												<TD class=unnamed2 align=middle><input
													name='受托代理负债' value=''
													ID='年初数37' MAXLENGTH='15' CLASS='boder-0' isMoney='true'
													style='text-align:right;padding-right:2px;' SIZE='14' onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');calMo2();"
													field="paDebtS" style="width: 98%; " 
													></TD>
												<TD class=unnamed3 align=middle><input
													name='受托代理负债' value=''
													ID='期末数37' MAXLENGTH='15' isMoney='true'
													style='text-align:right;padding-right:2px;' CLASS='boder-0' SIZE='14'
													onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');calMo22();" 
													field="paDebtE" style="width: 98%; " 
													></TD>
											</TR>
											<TR>
												<TD class=unnamed2 height=22>在建工程</TD>
												<TD class=unnamed2 align=middle>34</TD>
												<TD class=unnamed2 align=middle height=22><input
													name='在建工程' value=''
													ID='年初数16' isMoney='true' style='text-align:right;padding-right:2px;'
													MAXLENGTH='15' CLASS='boder-0' SIZE='14'
													onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumChu(15,18,19);" 
													field="faConstructionInProcessS" style="width: 98%; " 
													></TD>
												<TD class=unnamed5 align=middle height=22><input
													name='在建工程' value=''
													ID='期末数16' MAXLENGTH='15' CLASS='boder-0' isMoney='true'
													style='text-align:right;padding-right:2px;' SIZE='14'
													onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumMo(15,18,19);" 
													field="faConstructionInProcessE" style="width: 98%; " 
													></TD>
												<TD class=unnamed2>&nbsp;</TD>
												<TD class=unnamed2 align=middle>&nbsp;</TD>
												<TD class=unnamed2 align=middle>&nbsp;</TD>
												<TD class=unnamed3 align=middle>&nbsp;</TD>
											</TR>
											<TR>
												<TD class=unnamed2 height=22>文物文化资产</TD>
												<TD class=unnamed2 align=middle>35</TD>
												<TD class=unnamed2 align=middle height=22><input
													name='文物文化资产' value=''
													ID='年初数17' isMoney='true' style='text-align:right;padding-right:2px;'
													MAXLENGTH='15' CLASS='boder-0' SIZE='14'
													onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumChu(15,18,19);" 
													field="faCulturalHeritageS" style="width: 98%; " 
													></TD>
												<TD class=unnamed5 align=middle height=22><input
													name='文物文化资产' value=''
													ID='期末数17' MAXLENGTH='15' CLASS='boder-0' isMoney='true'
													style='text-align:right;padding-right:2px;' SIZE='14'
													onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumMo(15,18,19);" 
													field="faCulturalHeritageE" style="width: 98%; " 
													></TD>
												<TD class=unnamed2>负债合计</TD>
												<TD class=unnamed2 align=middle>100</TD>
												<TD class=unnamed2 align=middle><input
													name='负债合计年初数' value=''
													ID='年初数38' MAXLENGTH='15' isMoney='true'
													style='text-align:right;padding-right:2px;' CLASS='boder-cal' readonly SIZE='14'
													field="paSumS" style="width: 98%; " 
													></TD>
												<TD class=unnamed3 align=middle><input
													name='负债合计期末数' value=''
													ID='期末数38' MAXLENGTH='15' isMoney='true'
													style='text-align:right;padding-right:2px;' CLASS='boder-cal' readonly SIZE='14'
													field="paSumE" style="width: 98%; " 
													></TD>
											</TR>
											<TR>
												<TD class=unnamed2 height=22>固定资产清理</TD>
												<TD class=unnamed2 align=middle>38</TD>
												<TD class=unnamed2 align=middle height=22><input
													name='固定资产清理' value=''
													ID='年初数18' MAXLENGTH='15' isMoney='true'
													style='text-align:right;padding-right:2px;' CLASS='boder-0' SIZE='14'
													onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumChu(15,18,19);" 
													field="faDisposalFixedAssetsS" style="width: 98%; " 
													></TD>
												<TD class=unnamed5 align=middle height=22><input
													name='固定资产清理' value=''
													ID='期末数18' MAXLENGTH='15' isMoney='true'
													style='text-align:right;padding-right:2px;' CLASS='boder-0' SIZE='14'
													onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumMo(15,18,19);" 
													field="faDisposalFixedAssetsE" style="width: 98%; " 
													></TD>
												<TD class=unnamed2>&nbsp;</TD>
												<TD class=unnamed2 align=middle>&nbsp;</TD>
												<TD class=unnamed2 align=middle>&nbsp;</TD>
												<TD class=unnamed3 align=middle>&nbsp;</TD>
											</TR>
											<TR>
												<TD class=unnamed2 height=22>固定资产合计</TD>
												<TD class=unnamed2 align=middle>40</TD>
												<TD class=unnamed2 align=middle height=22><input
													name='固定资产合计年初数' value=''
													ID='年初数19' MAXLENGTH='15' CLASS='boder-cal' readonly isMoney='true'
													style='text-align:right;padding-right:2px;' SIZE='14' 
													field="faSumS" style="width: 98%; " 
													></TD>
												<TD class=unnamed5 align=middle height=22><input
													name='固定资产合计期末数' value=''
													ID='期末数19' MAXLENGTH='15' CLASS='boder-cal' readonly isMoney='true'
													style='text-align:right;padding-right:2px;' SIZE='14' 
													field="faSumE" style="width: 98%; " 
													></TD>
												<TD class=unnamed2>&nbsp;</TD>
												<TD class=unnamed2 align=middle>&nbsp;</TD>
												<TD class=unnamed2 align=middle>&nbsp;</TD>
												<TD class=unnamed3 align=middle>&nbsp;</TD>
											</TR>
											<TR>
												<TD class=unnamed2 height=13>无形资产：</TD>
												<TD class=unnamed2 align=middle height=13>&nbsp;</TD>
												<TD class=unnamed2 align=middle height=13>&nbsp;</TD>
												<TD class=unnamed5 align=middle height=13>&nbsp;</TD>
												<TD class=unnamed2>&nbsp;</TD>
												<TD class=unnamed2 align=middle>&nbsp;</TD>
												<TD class=unnamed2 align=middle>&nbsp;</TD>
												<TD class=unnamed3 align=middle>&nbsp;</TD>
											</TR>
											<TR>
												<TD class=unnamed2 height=22>无形资产</TD>
												<TD class=unnamed2 align=middle height=22>41</TD>
												<TD class=unnamed2 align=middle height=22><input
													name='无形资产' value=''
													ID='年初数20' MAXLENGTH='15' CLASS='boder-0' isMoney='true'
													style='text-align:right;padding-right:2px;' SIZE='14' onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');calChu1();"
													field="intangibleAssetsS" style="width: 98%; " 
													></TD>
												<TD class=unnamed5 align=middle height=22><input
													name='无形资产' value=''
													ID='期末数20' MAXLENGTH='15' CLASS='boder-0' isMoney='true'
													style='text-align:right;padding-right:2px;' SIZE='14' onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');calMo();"
													field="intangibleAssetsE" style="width: 98%; " 
													></TD>
												<TD class=unnamed2>净资产：</TD>
												<TD class=unnamed2 align=middle>&nbsp;</TD>
												<TD class=unnamed2 align=middle>&nbsp;</TD>
												<TD class=unnamed3 align=middle>&nbsp;</TD>
											</TR>
											<TR>
												<TD class=unnamed2 height=22>&nbsp;</TD>
												<TD class=unnamed2 align=middle height=22>&nbsp;</TD>
												<TD class=unnamed2 align=middle height=22>&nbsp;</TD>
												<TD class=unnamed5 align=middle height=22>&nbsp;</TD>
												<TD class=unnamed2>非限定性净资产</TD>
												<TD class=unnamed2 align=middle>101</TD>
												<TD class=unnamed2 align=middle><input
													name='非限定性净资产' value=''
													ID='年初数39' MAXLENGTH='15' CLASS='boder-0' SIZE='14'
													isMoney='true' style='text-align:right;padding-right:2px;'
													onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumMo1(39,40,41);" 
													field="unlimitNetAssetsS" style="width: 98%; " 
													></TD>
												<TD class=unnamed3 align=middle><input
													name='非限定性净资产' value=''
													ID='期末数39' MAXLENGTH='15' CLASS='boder-0' SIZE='14'
													isMoney='true' style='text-align:right;padding-right:2px;'
													onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumMo12(39,40,41);" 
													field="unlimitNetAssetsE" style="width: 98%; " 
													></TD>
											</TR>
											<TR>
												<TD class=unnamed2 height=22>受托代理资产：</TD>
												<TD class=unnamed2 align=middle height=22>&nbsp;</TD>
												<TD class=unnamed2 align=middle height=22>&nbsp;</TD>
												<TD class=unnamed5 align=middle height=22>&nbsp;</TD>
												<TD class=unnamed2>限定性净资产</TD>
												<TD class=unnamed2 align=middle>105</TD>
												<TD class=unnamed2 align=middle><input
													name='限定性净资产' value=''
													ID='年初数40' MAXLENGTH='15' CLASS='boder-0' isMoney='true'
													style='text-align:right;padding-right:2px;' SIZE='14'
													onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumMo1(39,40,41);" 
													field="limitNetAssetsS" style="width: 98%; " 
													></TD>
												<TD class=unnamed3 align=middle><input
													name='限定性净资产' value=''
													ID='期末数40' MAXLENGTH='15' CLASS='boder-0' isMoney='true'
													style='text-align:right;padding-right:2px;' SIZE='14'
													onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');setSumMo12(39,40,41);" 
													field="limitNetAssetsE" style="width: 98%; " 
													></TD>
											</TR>
											<TR>
												<TD class=unnamed2 height=22>受托代理资产</TD>
												<TD class=unnamed2 align=middle height=22>51</TD>
												<TD class=unnamed2 align=middle height=22><input
													name='受托代理资产' value=''
													ID='年初数21' MAXLENGTH='15' CLASS='boder-0' isMoney='true'
													style='text-align:right;padding-right:2px;' SIZE='14' onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');calChu1();"
													field="entrustedAgentAssetsS" style="width: 98%; " 
													></TD>
												<TD class=unnamed5 align=middle height=22><span
													class='unnamed6'><input
													name='受托代理资产' value=''
													ID='期末数21' MAXLENGTH='15' isMoney='true'
													style='text-align:right;padding-right:2px;' CLASS='boder-0' SIZE='14'
													onblur='checkFloat(this);'onKeyUp="value=value.replace(/[^\d.-]/g,'');calMo();" 
													field="entrustedAgentAssetsE" style="width: 98%; " 
													> </span></TD>
												<TD class=unnamed2>净资产合计</TD>
												<TD class=unnamed2 align=middle>110</TD>
												<TD class=unnamed2 align=middle><input
													name='净资产合计年初数' value=''
													ID='年初数41' MAXLENGTH='15' CLASS='boder-cal' readonly isMoney='true'
													style='text-align:right;padding-right:2px;' SIZE='14' 
													field="netAssetsSumS" style="width: 98%; " 
													></TD>
												<TD class=unnamed3 align=middle><input
													name='净资产合计期末数' value=''
													ID='期末数41' MAXLENGTH='15' CLASS='boder-cal' readonly isMoney='true'
													style='text-align:right;padding-right:2px;' SIZE='14' 
													field="netAssetsSumE" style="width: 98%; " 
													></TD>
											</TR>
											<TR>
												<TD class=unnamed4 height=22>资产总计</TD>
												<TD class=unnamed4 align=middle height=22>60</TD>
												<TD class=unnamed4 align=middle height=22><input
													name='资产总计年初数' value=''
													ID='年初数22' isMoney='true' style='text-align:right;padding-right:2px;'
													MAXLENGTH='15' CLASS='boder-cal' readonly SIZE='14' 
													field="assetsSumS" style="width: 98%; " 
													>
												</TD>
												<TD class=unnamed6 align=middle height=22><input
													name='资产总计期末数' value=''
													ID='期末数22' MAXLENGTH='15' isMoney='true'
													style='text-align:right;padding-right:2px;' CLASS='boder-cal' readonly SIZE='14'
													field="assetsSumE" style="width: 98%; " 
													></TD>
												<TD class=unnamed4>负债和净资产总计</TD>
												<TD class=unnamed4 align=middle>120</TD>
												<TD class=unnamed4 align=middle><input
													name='负债和净资产总计年初数' value=''
													ID='年初数42' MAXLENGTH='15' CLASS='boder-cal' readonly isMoney='true'
													style='text-align:right;padding-right:2px;' SIZE='14' 
													field="debtAssetsSumS" style="width: 98%; " 
													></TD>
												<TD align=middle><input
													name='负债和净资产总计期末数' value=''
													ID='期末数42' MAXLENGTH='15' CLASS='boder-cal' readonly isMoney='true'
													style='text-align:right;padding-right:2px;' SIZE='14' 
													field="debtAssetsSumE" style="width: 98%; " 
													></TD>
											</TR>
										</TBODY>
									</TABLE>
									</TD>
								</TR>
							</TBODY>
						</TABLE>
						<TABLE align='center'>
							<tr align='center'>
								<td width='100%' height='27' align=center valign=bottom><br>
								第21页</td>
							</tr>
						</TABLE>
						</TD>
					</TR>
				</TBODY>
			</TABLE>
			</TD>
		</TR>
	</TBODY>
</TABLE>

<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
</form>
</div>
</div>
</body>
</html>
