<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<html>

<head>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<title>基 金 会</title>
<%
	String taskCode = (String) request.getParameter("taskCode");
	if (taskCode == null) {
		taskCode = IdHelp.getUUID32();
	}
%>
<next:ScriptManager />
<script type="text/javascript" src="../../js/float.js"></script>
<link href="../../css/float.css" type="text/css" rel="stylesheet" />
<script language="javascript">
var taskCode='<%=request.getParameter("taskCode")%>';
//初始化
function init(){
	var somJxFundPeopleDataSet = L5.DatasetMgr.lookup("somJxFundPeopleDataSet");
	somJxFundPeopleDataSet.setParameter("TASK_CODE@=", taskCode);
	somJxFundPeopleDataSet.setParameter("PEOPLE_TYPE@in","1,2");
	somJxFundPeopleDataSet.load();
	somJxFundPeopleDataSet.on("load",function(ds){
		if(ds.getCount()==0){
			for(i=0;i<26;i++){
				addTr();
			}
			for(i=0;i<10;i++){
				addJianTr();
			}
			
		}else{
			for(i=1;i<=ds.getCount();i++){
				for(j=0;j<ds.getCount();j++){
					var record = ds.getAt(j);
					if( record.get('seqNum') == i ){
						if(record.get("peopleType")=="1"){
							var tab1 = document.getElementById("activities");
							addTr();
							var rowLength = tab1.rows.length;
							tab1.rows[rowLength-1].cells[1].getElementsByTagName("label")[0].innerHTML=record.get("name");
							tab1.rows[rowLength-1].cells[2].getElementsByTagName("label")[0].innerHTML=record.get("sex");
							tab1.rows[rowLength-1].cells[3].getElementsByTagName("label")[0].innerHTML=record.get("birthday");
							tab1.rows[rowLength-1].cells[4].getElementsByTagName("label")[0].innerHTML=record.get("sorgDuty");
							tab1.rows[rowLength-1].cells[5].getElementsByTagName("label")[0].innerHTML=record.get("remarkDate");
							tab1.rows[rowLength-1].cells[6].getElementsByTagName("label")[0].innerHTML=record.get("meetingTimes");
							tab1.rows[rowLength-1].cells[7].getElementsByTagName("label")[0].innerHTML=record.get("money");
							tab1.rows[rowLength-1].cells[8].getElementsByTagName("label")[0].innerHTML=record.get("betreffzeile");
						}
						if(record.get("peopleType")=="2"){
							var tab2 = document.getElementById("activitiesJian");
							addJianTr();
							var rowLength2 = tab2.rows.length;
							tab2.rows[rowLength2-1].cells[1].getElementsByTagName("label")[0].innerHTML=record.get("name");
							tab2.rows[rowLength2-1].cells[2].getElementsByTagName("label")[0].innerHTML=record.get("sex");
							tab2.rows[rowLength2-1].cells[3].getElementsByTagName("label")[0].innerHTML=record.get("birthday");
							tab2.rows[rowLength2-1].cells[4].getElementsByTagName("label")[0].innerHTML=record.get("remarkDate");
							tab2.rows[rowLength2-1].cells[5].getElementsByTagName("label")[0].innerHTML=record.get("meetingTimes");
							tab2.rows[rowLength2-1].cells[6].getElementsByTagName("label")[0].innerHTML=record.get("dutyDate");
							tab2.rows[rowLength2-1].cells[7].getElementsByTagName("label")[0].innerHTML=record.get("money");
							tab2.rows[rowLength2-1].cells[8].getElementsByTagName("label")[0].innerHTML=record.get("betreffzeile");
						}
					}
					
				}
			}
		}
	});
	//创建页面导航下拉框
	createFundDetailSelect();
}
function save(){
	
}
//增加一行方法
function addTr(){
	 var tab=document.getElementById("activities");
    //添加行
    var newTR = tab.insertRow(tab.rows.length);
    //trid++;
    //获取序号=行索引
    var  xuhao=newTR.rowIndex.toString();
    newTR.id = xuhao;
    //添加列:序号
    var newNameTD=newTR.insertCell(0);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderBottom=" solid windowtext 0.5pt";
    newNameTD.style.borderRight="solid windowtext 0.5pt";
    //添加列内容
    newNameTD.innerHTML = xuhao;
    //添加列:姓名
    var newNameTD=newTR.insertCell(1);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderBottom="solid windowtext 0.5pt";
    newNameTD.style.borderRight="solid windowtext 0.5pt";
    //添加列内容
    newNameTD.innerHTML ="<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size:14.0pt; font-family: 宋体'><label style='width: 100%;'></label></span></p>"
    //添加列:性别
    var newNameTD=newTR.insertCell(2);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderBottom="solid windowtext 0.5pt";
    newNameTD.style.borderRight="solid windowtext 0.5pt";
    //添加列内容
    newNameTD.innerHTML = "<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 12.0pt; font-family: 宋体'><label style='width: 100%;'></label></span></p>";
    //添加列:出生日期
    var newNameTD=newTR.insertCell(3);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderBottom="solid windowtext 0.5pt";
    newNameTD.style.borderRight="solid windowtext 0.5pt";
    //添加列内容
    newNameTD.innerHTML ="<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 14.0pt; font-family: 宋体'><label style='width: 100%; '></label></span></p>";
    //添加列:理事会职务
    var newNameTD=newTR.insertCell(4);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderBottom="solid windowtext 0.5pt";
    newNameTD.style.borderRight="solid windowtext 0.5pt";
    //添加列内容
    newNameTD.innerHTML = "<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 14.0pt; font-family: 宋体'><label style='width: 100%;'></label></span></p>";
	//添加列:在登记管理机关备案时间
    var newNameTD=newTR.insertCell(5);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderBottom="solid windowtext 0.5pt";
    newNameTD.style.borderRight="solid windowtext 0.5pt";
    //添加列内容
    newNameTD.innerHTML ="<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 14.0pt; font-family: 宋体'><label style='width: 100%; '></label></span></p>"
    //添加列:本年度出席理事会会议次数
    var newNameTD=newTR.insertCell(6);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderBottom="solid windowtext 0.5pt";
    newNameTD.style.borderRight="solid windowtext 0.5pt";
    //添加列内容
    newNameTD.innerHTML = "<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 14.0pt; font-family: 宋体'><label style='width: 100%; '></label></span></p>";
    //添加列:本年度在基金会领取的报酬(人民币元)
    var newNameTD=newTR.insertCell(7);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderBottom="solid windowtext 0.5pt";
    newNameTD.style.borderRight="solid windowtext 0.5pt";
    //添加列内容
    newNameTD.innerHTML ="<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 14.0pt; font-family: 宋体'><label style='width: 100%; ' ></label></span></p>";
    //添加列:本年度在基金会领取的津贴(人民币元)
    var newNameTD=newTR.insertCell(8);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderBottom="solid windowtext 0.5pt";
    //添加列内容
    newNameTD.innerHTML = "<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 14.0pt; font-family: 宋体'><label style='width: 100%;' ></label></span></p>";
}
function deltr(trid){
	var tab=document.getElementById("activities");
    var row=document.getElementById(trid);    
    var index=row.rowIndex;//rowIndex属性为tr的索引值，从0开始   
    tab.deleteRow(index);  //从table中删除
    //重新排列序号
    var nextid;
    for(i=index;i<tab.rows.length;i++){
        tab.rows[i].cells[0].innerHTML = i.toString();
    }
}


//增加一行方法
function addJianTr(){
	 var tab=document.getElementById("activitiesJian");
    //添加行
    var newTR = tab.insertRow(tab.rows.length);
    //trid++;
    //获取序号=行索引
    var  xuhao=newTR.rowIndex.toString();
    newTR.id ="jian"+ xuhao;
    //添加列:序号
    var newNameTD=newTR.insertCell(0);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderBottom=" solid windowtext 0.5pt";
    newNameTD.style.borderRight="solid windowtext 0.5pt";
    //添加列内容
    newNameTD.innerHTML = xuhao;
    //添加列:姓名
    var newNameTD=newTR.insertCell(1);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderBottom="solid windowtext 0.5pt";
    newNameTD.style.borderRight="solid windowtext 0.5pt";
    //添加列内容
    newNameTD.innerHTML ="<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 14.0pt; font-family: 宋体'><label style='width: 100%;' ></label></span></p>"
    //添加列:性别
    var newNameTD=newTR.insertCell(2);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderBottom="solid windowtext 0.5pt";
    newNameTD.style.borderRight="solid windowtext 0.5pt";
    //添加列内容
    newNameTD.innerHTML = "<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 14.0pt; font-family: 宋体'><label style='width: 100%;'></label></span></p>";
    //添加列:出生日期
    var newNameTD=newTR.insertCell(3);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderBottom="solid windowtext 0.5pt";
    newNameTD.style.borderRight="solid windowtext 0.5pt";
    //添加列内容
    newNameTD.innerHTML ="<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 14.0pt; font-family: 宋体'><label style='width: 100%; '></label></span></p>";
	//添加列:在登记管理机关备案时间
    var newNameTD=newTR.insertCell(4);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderBottom="solid windowtext 0.5pt";
    newNameTD.style.borderRight="solid windowtext 0.5pt";
    //添加列内容
    newNameTD.innerHTML ="<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 14.0pt; font-family: 宋体'><label style='width: 100%; '></label></span></p>"
    //添加列:本年度列席理事会会议次数
    var newNameTD=newTR.insertCell(5);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderBottom="solid windowtext 0.5pt";
    newNameTD.style.borderRight="solid windowtext 0.5pt";
    //添加列内容
    newNameTD.innerHTML = "<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 14.0pt; font-family: 宋体'><label style='width: 100%; '></label></span></p>";
    //添加列:任期起止时间
    var newNameTD=newTR.insertCell(6);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderBottom="solid windowtext 0.5pt";
    newNameTD.style.borderRight="solid windowtext 0.5pt";
    //添加列内容
    newNameTD.innerHTML ="<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 14.0pt; font-family: 宋体'><label style='width: 100%; '></label></span></p>";
    //添加列:本年度在基金会领取的津贴(人民币元)
    var newNameTD=newTR.insertCell(7);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderBottom="solid windowtext 0.5pt";
    newNameTD.style.borderRight="solid windowtext 0.5pt";
    //添加列内容
    newNameTD.innerHTML = "<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 14.0pt; font-family: 宋体'><label style='width: 100%; '></label></span></p>";
	 //添加列:本年度在基金会领取的津贴(人民币元)
    var newNameTD=newTR.insertCell(8);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderBottom="solid windowtext 0.5pt";
    //添加列内容
    newNameTD.innerHTML = "<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 14.0pt; font-family: 宋体'><label style='width: 100%; '></label></span></p>";
	
}
function delJianTr(trid){
		var tab=document.getElementById("activitiesJian");
    var row=document.getElementById(trid);    
    var index=row.rowIndex;//rowIndex属性为tr的索引值，从0开始   
    tab.deleteRow(index);  //从table中删除
    //重新排列序号
    var nextid;
    for(i=index;i<tab.rows.length;i++){
        tab.rows[i].cells[0].innerHTML = i.toString();
    }
}
</script>
<style media="print">
	.noprint     { display: none }
</style>
</head>

<body>
<model:datasets>
	<model:dataset id="somJxFundPeopleDataSet" cmd="com.inspur.cams.sorg.check.somcheckcouncilmember.cmd.SomCheckCouncilMemberQueryCommand" global="true" method="queryNoPage">
		<model:record fromBean="com.inspur.cams.sorg.check.somcheckcouncilmember.dao.SomCheckCouncilMember"></model:record>
	</model:dataset>
</model:datasets>
<div id="float" class="noprint">
	<input type="button" value="下一页" style="height:25px;width:80px;position:absolute;margin-left:120px;" onclick="nextPageJ1('5')"/>
	<input type="button" value="上一页" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="lastPageJ1('3')"/>
	<input type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:220px;" onclick="backJ();"/>
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
	font-family: '仿宋_GB2312';
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
	font-family: '仿宋_GB2312';
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
	font-family: '仿宋_GB2312';
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
	font-family: '仿宋_GB2312';
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
	font-family: '仿宋_GB2312';
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
	font-family: '仿宋_GB2312';
	font-size: 16pt;
	color: #FF0000;
	line-height: 160%;
	letter-spacing: 1pt;
}

.textarea01 {
	font-family: '仿宋_GB2312';
	font-size: 16pt;
	color: #000000;
	letter-spacing: 1pt;
	border: 1px solid #000000;
	line-height: 160%;
}
</STYLE>

<TABLE height=436 cellSpacing=0 cellPadding=0 width=950 align=center
	border=0>
	<TBODY>
		<br>
		<TR>
			<TD width='685' height=30>&nbsp;</TD>
		</TR>
		<TR>
			<TD align=left height=14><STRONG>(二)理事会成员情况</STRONG></TD>
		</TR>
		<TR>
			<TD vAlign=top>
			<TABLE class=unnamed1 cellSpacing=0 cellPadding=0 width='100%' id="activities"
				border=0>
				<TBODY>
					<TR align=middle>
						<TD class=font12size2 width='5%' height=20>序号</TD>
						<TD class=font12size2 width='10%' height=20>姓名</TD>
						<TD class=font12size2 width='10%' height=20>性别</TD>
						<TD class=font12size2 width='11%' height=20>出生日期</TD>
						<TD class=font12size2 width='11%' height=20>理事会职务</TD>
						<TD class=font12size2 width='11%' height=20>在登记管理机关备案时间</TD>
						<TD class=font12size2 width='8%' height=20>本年度出席理事会会议次数</TD>
						<TD width='11%' height=20 class=font12size2>本年度在基金会领取的报酬(人民币元)
						</TD>
						<TD width='26%' class=font12size3>领取报酬事由</TD>
					</TR>
					
				</TBODY>
			</TABLE>
			<span style="color:red">说明：上表按照理事长、副理事长、秘书长、理事顺序填写，如有兼任情况，如副理事长兼任秘书长，一并写清楚。</span>
			<div align='left'><STRONG>（三）监事情况</STRONG></div>
			<TABLE class=font12size1 cellSpacing=0 cellPadding=0 width='100%' id='activitiesJian'
				border=0>
				<TBODY>
					<TR align=middle>
						<TD class=font12size2 width='5%' height=39>序号</TD>
						<TD class=font12size2 width='9%'>姓名</TD>
						<TD class=font12size2 width='9%'>性别</TD>
						<TD class=font12size2 width='10%'>出生日期</TD>
						<TD class=font12size2 width='11%'>在登记管理机关备案时间</TD>
						<TD class=font12size2 width='8%'>本年度列席理事会会议次数</TD>
						<TD class=font12size2 width='15%'>任期起止时间</TD>
						<TD class=font12size2 width='11%'>本年度在基金会领取的报酬(人民币元)</TD>
						<TD class=font12size3 width='19%'>领取报酬事由</TD>
					</TR>
					
	</TBODY>
</TABLE>
<TABLE align='center'>
	<tr valign=bottom align='center'>
		<td width='100%' height='27' align=center valign=bottom><br>
		</td>
	</tr>
</TABLE>

</body>
</html>
