<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
 
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<script language="javascript">
//var taskCode='<%=request.getParameter("taskCode")%>';
//初始化
function init29(){
	var somJxCheckInterProjectDataSet = L5.DatasetMgr.lookup("somJxCheckInterProjectDataSet");
	somJxCheckInterProjectDataSet.setParameter("TASK_CODE@=", taskCode);
	somJxCheckInterProjectDataSet.load();
	somJxCheckInterProjectDataSet.on("load",function(ds){
		if(ds.getCount()==0){
		
		}else{
			for(i=0;i<ds.getCount();i++){
				var record = ds.getAt(i);
				var tab = document.getElementById("activitiesInterProject");
				tab.rows[i+2].cells[1].getElementsByTagName("textarea")[0].value=record.get("projectName");
				tab.rows[i+2].cells[2].getElementsByTagName("textarea")[0].value=record.get("coopOrganName");
				tab.rows[i+2].cells[3].getElementsByTagName("textarea")[0].value=record.get("coopOrganNation");
				tab.rows[i+2].cells[4].getElementsByTagName("label")[0].innerHTML=record.get("onProjectFund");
				tab.rows[i+2].cells[5].getElementsByTagName("label")[0].innerHTML=record.get("offProjectFund");				
				tab.rows[i+2].cells[6].getElementsByTagName("textarea")[0].value=record.get("projectType");
				tab.rows[i+2].cells[7].getElementsByTagName("textarea")[0].value=record.get("projectDesc");
			}
		}
	});
	
	//加载国际会议数据
	var somCheckInterMeetingDataSet = L5.DatasetMgr.lookup("somCheckInterMeetingDataSet");
	somCheckInterMeetingDataSet.setParameter("TASK_CODE", taskCode);
	somCheckInterMeetingDataSet.load();
	somCheckInterMeetingDataSet.on('load',function(ds){
		var count = ds.getCount();
		if(count == 0){

		}else{		
			for(i=0;i<ds.getCount();i++){
				var record = ds.getAt(i);
				var tab = document.getElementById("internationalMeeting");
				tab.rows[i+1].cells[1].getElementsByTagName("textarea")[0].value=record.get("meetingName");
				tab.rows[i+1].cells[2].getElementsByTagName("textarea")[0].value=record.get("meetingDate");
				tab.rows[i+1].cells[3].getElementsByTagName("textarea")[0].value=record.get("meetingPlace");
				tab.rows[i+1].cells[4].getElementsByTagName("textarea")[0].value=record.get("hostOrganName");
				tab.rows[i+1].cells[5].getElementsByTagName("textarea")[0].value=record.get("fundsSource");
			}
		}
	});
	
	//加载国组织数据
	var somCheckInterOrgDataSet = L5.DatasetMgr.lookup("somCheckInterOrgDataSet");
	somCheckInterOrgDataSet.setParameter("TASK_CODE", taskCode);
	somCheckInterOrgDataSet.load();
	somCheckInterOrgDataSet.on('load',function(ds){
		var count = ds.getCount();
		if(count == 0){

		}else{	
			for(i=0;i<ds.getCount();i++){
				var record = ds.getAt(i);
				var tab = document.getElementById("internationalOrganization");
				tab.rows[i+1].cells[1].getElementsByTagName("textarea")[0].value=record.get("orgCnName");
				tab.rows[i+1].cells[2].getElementsByTagName("textarea")[0].value=record.get("orgEnName");
				tab.rows[i+1].cells[3].getElementsByTagName("label")[0].innerHTML=record.get("joinDate");
				tab.rows[i+1].cells[4].getElementsByTagName("textarea")[0].value=record.get("auditOrganName");
				tab.rows[i+1].cells[5].getElementsByTagName("textarea")[0].value=record.get("dutyType");
			}	
		}
	});	
	//创建页面导航下拉框
	//createFundDetailSelect();
}
function save(){
	var somJxCheckInterProjectDataSet=getSomJxCheckInterProjectDataSet();
	var somCheckInterMeetingDataSet = getSomCheckInterMeetingDataSet();
	var somCheckInterOrgDataSet = getSomCheckInterOrgDataSet();
	
	var interProjectRecords=somJxCheckInterProjectDataSet.getAllRecords();
	var somCheckInterMeetingRecords = somCheckInterMeetingDataSet.getAllRecords();
	var somCheckInterOrgRecords = somCheckInterOrgDataSet.getAllRecords();
	var command = new L5.Command("com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckCommand");
	command.setParameter("interProjectRecords", interProjectRecords);
	command.setParameter("somCheckInterMeetingRecords", somCheckInterMeetingRecords);
	command.setParameter("somCheckInterOrgRecords", somCheckInterOrgRecords);
	command.setParameter("taskCode", taskCode);
	command.execute("savePageJ29");
	if (!command.error) {
		L5.Msg.alert("提示","保存成功！",function(){
		});		
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}

//获取涉外合作项目dataset				
function getSomJxCheckInterProjectDataSet(){
	somJxCheckInterProjectDataSet.removeAll();
	var tab = document.getElementById("activitiesInterProject");
	for(i=2;i<=6;i++){
		var record = somJxCheckInterProjectDataSet.newRecord();
		record.set("projectName",tab.rows[i].cells[1].getElementsByTagName("textarea")[0].value);
		record.set("coopOrganName",tab.rows[i].cells[2].getElementsByTagName("textarea")[0].value);
		record.set("coopOrganNation",tab.rows[i].cells[3].getElementsByTagName("textarea")[0].value);
		record.set("offProjectFund",tab.rows[i].cells[4].getElementsByTagName("input")[0].value);
		record.set("onProjectFund",tab.rows[i].cells[5].getElementsByTagName("input")[0].value);
		record.set("projectType",tab.rows[i].cells[6].getElementsByTagName("textarea")[0].value);
		record.set("projectDesc",tab.rows[i].cells[7].getElementsByTagName("textarea")[0].value);
	}
	return somJxCheckInterProjectDataSet;
}
//获取国际会议dataset
function getSomCheckInterMeetingDataSet(){
	var tab=document.getElementById("internationalMeeting");
	var somCheckInterMeetingDataSet = L5.DatasetMgr.lookup("somCheckInterMeetingDataSet");
	somCheckInterMeetingDataSet.removeAll();
	for(i=1;i<=5;i++){
		var record= somCheckInterMeetingDataSet.newRecord();
		record.set("meetingName",tab.rows[i].cells[1].getElementsByTagName("textarea")[0].value);
		record.set("meetingDate",tab.rows[i].cells[2].getElementsByTagName("textarea")[0].value);
		record.set("meetingPlace",tab.rows[i].cells[3].getElementsByTagName("textarea")[0].value);
		record.set("hostOrganName",tab.rows[i].cells[4].getElementsByTagName("textarea")[0].value);
		record.set("fundsSource",tab.rows[i].cells[5].getElementsByTagName("textarea")[0].value);
	}
	return somCheckInterMeetingDataSet;
}
//获取国际组织dataset
function getSomCheckInterOrgDataSet(){
	var tab=document.getElementById("internationalOrganization");
	var somCheckInterOrgDataSet = L5.DatasetMgr.lookup("somCheckInterOrgDataSet");
	somCheckInterOrgDataSet.removeAll();
	for(i=1;i<=5;i++){
		var record= somCheckInterOrgDataSet.newRecord();
		record.set("orgCnName",tab.rows[i].cells[1].getElementsByTagName("textarea")[0].value);
		record.set("orgEnName",tab.rows[i].cells[2].getElementsByTagName("textarea")[0].value);
		record.set("joinDate",tab.rows[i].cells[3].getElementsByTagName("input")[0].value);
		record.set("auditOrganName",tab.rows[i].cells[4].getElementsByTagName("textarea")[0].value);
		record.set("dutyType",tab.rows[i].cells[5].getElementsByTagName("textarea")[0].value);
	}
	return somCheckInterOrgDataSet;
}
function LoushangDate(ele){

}
</script>
<style media="print">
.noprint {
	display: none
}
</style>
<script>
function textCounter(field, maxlimit) {
    if (field.value.length > maxlimit)
	field.value = field.value.substring(0, maxlimit);
}
function createNo(obj){
    /*var objName = obj.name;
    var rownum = 5;
    var num1 = objName.lastIndexOf('JOIN_OUTER_ITEM');
    var num2 = objName.lastIndexOf('JOIN_OUTER_MEET');
    // var num3 = objName.lastIndexOf('JOIN_OUTER_ORG');
  	
  	if (num1>0){
			  //=============  国际合作项目（最主要的五项）  =======================
			  var prefixName = "query$form$0$JOIN_OUTER_ITEM$";
			  
			  var v1_1 = prefixName + "shewaixuhao$";
			  var v1_2 = prefixName + "xiangmumingcheng$";
			  var v1_3 = prefixName + "hezuofangmingcheng$";
			  var v1_4 = prefixName + "tigongfangmingcheng$";
			  var v1_5 = prefixName + "wofangjingfei$";
			  var v1_6 = prefixName + "waifangjingfei$";
			  var v1_7 = prefixName + "xiangmuleibie$";
			  var v1_8 = prefixName + "hezuoxiangmu$";
				
				var min_row = 0;
			  for(i=1; i<= rownum; i++){
			     var ele1 = document.all(v1_1+i);
			     var ele2 = document.all(v1_2+i);
			     var ele3 = document.all(v1_3+i);
			     var ele4 = document.all(v1_4+i);
			     var ele5 = document.all(v1_5+i);
			     var ele6 = document.all(v1_6+i);
			     var ele7 = document.all(v1_7+i);
			     var ele8 = document.all(v1_8+i);
			     
			     // 判定各条信息是否有输入项
			     if(ele2.value != "" || ele3.value != "" || !ele4[0].selected || ele5.value != "" || ele6.value != "" || !ele7[0].selected || ele8.value != ""){
			       min_row++;
			       ele1.value=min_row;          
			     }//end if 
			     else{
			     	 ele1.value = "";
			     }
			  }
	  } else if(num2>0){
			  //===================  参加国际会议（最主要的五项）  =========================
			
			  var prefixName = "query$form$0$JOIN_OUTER_MEET$";
			  
			  var v1_1 = prefixName + "huiyixuhao$";
			  var v1_2 = prefixName + "huiyimingcheng$";
			  var v1_3 = prefixName + "huiyishijian$";
			  var v1_4 = prefixName + "huiyididian$";
			  var v1_5 = prefixName + "zhubanfangmingcheng$";
			  var v1_6 = prefixName + "jingfeilaiyuan$";
			
				var min_row = 0;
			  for(i=1; i<= rownum; i++){
			     var ele1 = document.all(v1_1+i);
			     var ele2 = document.all(v1_2+i);
			     var ele3 = document.all(v1_3+i);
			     var ele4 = document.all(v1_4+i);
			     var ele5 = document.all(v1_5+i);
			     var ele6 = document.all(v1_6+i);
			     
			     // 判定各条信息是否有输入项
			     // 如果有输入项，则必须把对应的该项填写完整
			     
			     if( ele2.value != "" || ele3.value != "" || !ele4[0].selected || ele5.value != "" || !ele6[0].selected){
			        min_row++;
			        ele1.value=min_row;
			     } // end if 
				   else{
				     	ele1.value = "";
				   }
			  }
		} else {
			  //===================  参加国际组织（最主要的五项）  =========================
			
			  var prefixName = "query$form$0$JOIN_OUTER_ORG$";
			  
			  var v1_1 = prefixName + "zuzhixuhao$";
			  var v1_2 = prefixName + "zhongwenquancheng$";
			  var v1_3 = prefixName + "yingwenquancheng$";
			  var v1_4 = prefixName + "canjiashijian$";
			  var v1_5 = prefixName + "pizhunbumen$";
			  var v1_6 = prefixName + "danrenzhiwu$";
			
				var min_row = 0;
			  for(i=1; i<= rownum; i++){
			     var ele1 = document.all(v1_1+i);
			     var ele2 = document.all(v1_2+i);
			     var ele3 = document.all(v1_3+i);
			     var ele4 = document.all(v1_4+i);
			     var ele5 = document.all(v1_5+i);
			     var ele6 = document.all(v1_6+i);
			     
			     // 判定各条信息是否有输入项
			     // 如果有输入项，则必须把对应的该项填写完整
			     
			     if( ele2.value != "" || ele3.value != "" || ele4.value != "" || ele5.value != "" || !ele6[0].selected){
			        min_row++;
			        ele1.value=min_row;
			     }//end if 
				   else{
				     	ele1.value = "";
				   }
			  }
		}*/
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

.boder12-0_29 {
	width：98%;
	font-size:12px;
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
<model:datasets>
	<model:dataset id="somJxCheckInterProjectDataSet" cmd="com.inspur.cams.sorg.jxcheck.somjxcheckinterproject.cmd.SomJxCheckInterProjectQueryCommand" global="true" method="queryNoPage">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxcheckinterproject.dao.SomJxCheckInterProject"></model:record>
	</model:dataset>
	<model:dataset id="somCheckInterMeetingDataSet" cmd="com.inspur.cams.sorg.jxcheck.somjxcheckintermeeting.cmd.SomJxCheckInterMeetingQueryCommand" global="true" method="queryNoPage">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxcheckintermeeting.dao.SomJxCheckInterMeeting"></model:record>
	</model:dataset>
	<model:dataset id="somCheckInterOrgDataSet" cmd="com.inspur.cams.sorg.jxcheck.somjxcheckinterorg.cmd.SomJxCheckInterOrgQueryCommand" global="true" method="queryNoPage">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxcheckinterorg.dao.SomJxCheckInterOrg"></model:record>
	</model:dataset>
</model:datasets>
<div id="float_1" class="noprint">

</div>
<div align=center style='page-break-after:always'>
<div align=center style="width: 800px">
<form dataset="" name="myform" method="post" onsubmit="return false">

<TABLE height=465 cellSpacing=0 cellPadding=0 width=644 align=center
	border=0>
	<TBODY>
		<TR>
			<TD width=644 height=53>&nbsp;</TD>
		</TR>
		<TR>
			<TD height=30><STRONG>（四）涉外活动情况</STRONG></TD>
		</TR>
		<TR>
			<TD height=14>&nbsp;</TD>
		</TR>
		<TR>
			<TD vAlign=top align=middle height=14>
			<div align='center'><STRONG>1．涉外合作项目</STRONG></div>
			</TD>
		</TR>
		<TR>
			<TD vAlign=top height=14>&nbsp;</TD>
		</TR>
		<TR>
			<TD vAlign=top height=14>
			<TABLE id=activitiesInterProject class=unnamed1 cellSpacing=0 cellPadding=0 width='100%'
				border=0>
				<TBODY>
					<TR align=middle>
						<TD class=font12size2 width='5%' height=32 rowSpan=2>序号</TD>
						<TD class=font12size2 width='12%' height=32 rowSpan=2>项目名称</TD>
						<TD class=font12size2 width='12%' height=32 rowSpan=2>境外<br>
						合作单位名称</TD>
						<TD class=font12size2 width='8%' height=32 rowSpan=2>所属国家<br>
						或地区</TD>
						<TD class=font12size2 colSpan=2>项目经费<BR>
						（<span style="color:red">人民币万元</span>）</TD>
						<TD class=font12size2 width='13%' rowSpan=2>项目类别</TD>
						<TD class=font12size3 width='37%' rowSpan=2>合作项目内容简介</TD>
					</TR>
					<TR align=middle>
						<TD class=font12size2 width='11%'>境内</TD>
						<TD class=font12size2 width='12%'>境外</TD>
					</TR>
					<TR align=middle>
						<TD class=font12size2 width=31 height=31><input value='1' CLASS='boder12-0_29' SIZE='2'	readOnly='true' style='text-align:center'></TD>
						<TD class=font12size2 height=31><textarea
							name='query$form$0$JOIN_OUTER_ITEM$xiangmumingcheng$1'
							onKeyDown="textCounter(query$form$0$JOIN_OUTER_ITEM$xiangmumingcheng$1,18);"
							onKeyUp="textCounter(query$form$0$JOIN_OUTER_ITEM$xiangmumingcheng$1,18);"
							ID='子表1.项目名称$1' COLS='12' rows='3' limit='18' CLASS='boder12-0_29'
							onChange='createNo(this);' readonly ></textarea></TD>
						<TD class=font12size2 height=31><textarea
							name='query$form$0$JOIN_OUTER_ITEM$hezuofangmingcheng$1'
							onKeyDown="textCounter(query$form$0$JOIN_OUTER_ITEM$hezuofangmingcheng$1,18);"
							onKeyUp="textCounter(query$form$0$JOIN_OUTER_ITEM$hezuofangmingcheng$1,18);"
							ID='子表1.合作方名称$1' CLASS='boder12-0_29' COLS='12' rows='3' limit='18'
							onChange='createNo(this);' readonly ></textarea></TD>
						<TD class=font12size2 height=31>
							<textarea CLASS='boder12-0_29' COLS='12' rows='3' limit='18'readonly ></textarea></TD>
						<TD class=font12size2 vAlign=middle>&nbsp;<label style='width:73px'
							name='query$form$0$JOIN_OUTER_ITEM$wofangjingfei$1' value=''
							ID='子表1.我方经费$1' 
							onkeyup="value=value.replace(/[^\d.-]/g,'') " style='text-align:right' CLASS='boder12-0_29' SIZE='10' maxlength='10'
							onChange='createNo(this);' ></TD>
						<TD class=font12size2 vAlign=middle>&nbsp;<label style='width:73px'
							name='query$form$0$JOIN_OUTER_ITEM$waifangjingfei$1' value=''
							ID='子表1.外方经费$1'
							onkeyup="value=value.replace(/[^\d.-]/g,'') " style='text-align:right' CLASS='boder12-0_29' maxlength='10' SIZE='10'
							onChange='createNo(this);' ></TD>
						<TD class=font12size2 vAlign=middle>
							<textarea CLASS='boder12-0_29' COLS='12' rows='3' limit='18'readonly ></textarea></TD>
						<TD class=font12size3><textarea
							name='query$form$0$JOIN_OUTER_ITEM$hezuoxiangmu$1'
							onKeyDown="textCounter(query$form$0$JOIN_OUTER_ITEM$hezuoxiangmu$1,45);"
							onKeyUp="textCounter(query$form$0$JOIN_OUTER_ITEM$hezuoxiangmu$1,45);"
							ID='子表1.合作项目$1' CLASS='boder12-0_29' COLS='30' rows='3' limit='45'
							onChange='createNo(this);' readonly ></textarea></TD>
					</TR>
					<TR align=middle>
						<TD class=font12size2 height=30><input value='2' CLASS='boder12-0_29' SIZE='2'	readOnly='true' style='text-align:center'></TD>
						<TD class=font12size2 height=30><textarea
							name='query$form$0$JOIN_OUTER_ITEM$xiangmumingcheng$2'
							onKeyDown="textCounter(query$form$0$JOIN_OUTER_ITEM$xiangmumingcheng$2,18);"
							onKeyUp="textCounter(query$form$0$JOIN_OUTER_ITEM$xiangmumingcheng$2,18);"
							ID='子表1.项目名称$2' COLS='12' rows='3' limit='18' CLASS='boder12-0_29'
							onChange='createNo(this);' readonly ></textarea></TD>
						<TD class=font12size2 height=30><textarea
							name='query$form$0$JOIN_OUTER_ITEM$hezuofangmingcheng$2'
							onKeyDown="textCounter(query$form$0$JOIN_OUTER_ITEM$hezuofangmingcheng$2,18);"
							onKeyUp="textCounter(query$form$0$JOIN_OUTER_ITEM$hezuofangmingcheng$2,18);"
							ID='子表1.合作方名称$2' CLASS='boder12-0_29' COLS='12' rows='3' limit='18'
							onChange='createNo(this);' readonly ></textarea></TD>
						<TD class=font12size2 height=30>
							<textarea CLASS='boder12-0_29' COLS='12' rows='3' limit='18'readonly ></textarea></TD>
						<TD class=font12size2 vAlign=middle>&nbsp;<label
							name='query$form$0$JOIN_OUTER_ITEM$wofangjingfei$2' value=''
							ID='子表1.我方经费$2'
							onkeyup="value=value.replace(/[^\d.-]/g,'') " style='text-align:right' CLASS='boder12-0_29' maxlength='10' SIZE='10'
							onChange='createNo(this);' ></TD>
						<TD class=font12size2 vAlign=middle>&nbsp;<label
							name='query$form$0$JOIN_OUTER_ITEM$waifangjingfei$2' value=''
							ID='子表1.外方经费$2'
							onkeyup="value=value.replace(/[^\d.-]/g,'') " style='text-align:right' CLASS='boder12-0_29' maxlength='10' SIZE='10'
							onChange='createNo(this);' ></TD>
						<TD class=font12size2 vAlign=middle>
							<textarea CLASS='boder12-0_29' COLS='12' rows='3' limit='18'readonly ></textarea></TD>
						<TD class=font12size3><textarea
							name='query$form$0$JOIN_OUTER_ITEM$hezuoxiangmu$2'
							onKeyDown="textCounter(query$form$0$JOIN_OUTER_ITEM$hezuoxiangmu$2,45);"
							onKeyUp="textCounter(query$form$0$JOIN_OUTER_ITEM$hezuoxiangmu$2,45);"
							ID='子表1.合作项目$2' CLASS='boder12-0_29' COLS='30' rows='3' limit='45'
							onChange='createNo(this);' readonly ></textarea></TD>
					</TR>
					<TR align=middle>
						<TD class=font12size2 height=32><input value='3' CLASS='boder12-0_29' SIZE='2'	readOnly='true' style='text-align:center'></TD>
						<TD class=font12size2 height=32><textarea
							name='query$form$0$JOIN_OUTER_ITEM$xiangmumingcheng$3'
							onKeyDown="textCounter(query$form$0$JOIN_OUTER_ITEM$xiangmumingcheng$3,18);"
							onKeyUp="textCounter(query$form$0$JOIN_OUTER_ITEM$xiangmumingcheng$3,18);"
							ID='子表1.项目名称$3' COLS='12' rows='3' limit='18' CLASS='boder12-0_29'
							onChange='createNo(this);' readonly ></textarea></TD>
						<TD class=font12size2 height=32><textarea
							name='query$form$0$JOIN_OUTER_ITEM$hezuofangmingcheng$3'
							onKeyDown="textCounter(query$form$0$JOIN_OUTER_ITEM$hezuofangmingcheng$3,18);"
							onKeyUp="textCounter(query$form$0$JOIN_OUTER_ITEM$hezuofangmingcheng$3,18);"
							ID='子表1.合作方名称$3' CLASS='boder12-0_29' COLS='12' rows='3' limit='18'
							onChange='createNo(this);' readonly ></textarea></TD>
						<TD class=font12size2 height=32>
							<textarea CLASS='boder12-0_29' COLS='12' rows='3' limit='18'readonly ></textarea></TD>
						<TD class=font12size2 vAlign=middle>&nbsp;<label
							name='query$form$0$JOIN_OUTER_ITEM$wofangjingfei$3' value=''
							ID='子表1.我方经费$3'
							onkeyup="value=value.replace(/[^\d.-]/g,'') " style='text-align:right' CLASS='boder12-0_29' maxlength='10' SIZE='10'
							onChange='createNo(this);' ></TD>
						<TD class=font12size2 vAlign=middle>&nbsp;<label
							name='query$form$0$JOIN_OUTER_ITEM$waifangjingfei$3' value=''
							ID='子表1.外方经费$3'
							onkeyup="value=value.replace(/[^\d.-]/g,'') " style='text-align:right' CLASS='boder12-0_29' maxlength='10' SIZE='10'
							onChange='createNo(this);' ></TD>
						<TD class=font12size2 vAlign=middle>
							<textarea CLASS='boder12-0_29' COLS='12' rows='3' limit='18'readonly ></textarea></TD>
						<TD class=font12size3><textarea
							name='query$form$0$JOIN_OUTER_ITEM$hezuoxiangmu$3'
							onKeyDown="textCounter(query$form$0$JOIN_OUTER_ITEM$hezuoxiangmu$3,45);"
							onKeyUp="textCounter(query$form$0$JOIN_OUTER_ITEM$hezuoxiangmu$3,45);"
							ID='子表1.合作项目$3' CLASS='boder12-0_29' COLS='30' rows='3' limit='45'
							onChange='createNo(this);' readonly ></textarea></TD>
					</TR>
					<TR align=middle>
						<TD class=font12size2 height=31><input value='4' CLASS='boder12-0_29' SIZE='2'	readOnly='true' style='text-align:center'></TD>
						<TD class=font12size2 height=31><textarea
							name='query$form$0$JOIN_OUTER_ITEM$xiangmumingcheng$4'
							onKeyDown="textCounter(query$form$0$JOIN_OUTER_ITEM$xiangmumingcheng$4,18);"
							onKeyUp="textCounter(query$form$0$JOIN_OUTER_ITEM$xiangmumingcheng$4,18);"
							ID='子表1.项目名称$4' COLS='12' rows='3' limit='18' CLASS='boder12-0_29'
							onChange='createNo(this);' readonly ></textarea></TD>
						<TD class=font12size2 height=31><textarea
							name='query$form$0$JOIN_OUTER_ITEM$hezuofangmingcheng$4'
							onKeyDown="textCounter(query$form$0$JOIN_OUTER_ITEM$hezuofangmingcheng$4,18);"
							onKeyUp="textCounter(query$form$0$JOIN_OUTER_ITEM$hezuofangmingcheng$4,18);"
							ID='子表1.合作方名称$4' CLASS='boder12-0_29' COLS='12' rows='3' limit='18'
							onChange='createNo(this);' readonly ></textarea></TD>
						<TD class=font12size2 height=31>
							<textarea CLASS='boder12-0_29' COLS='12' rows='3' limit='18'readonly ></textarea></TD>
						<TD class=font12size2 vAlign=middle>&nbsp;<label
							name='query$form$0$JOIN_OUTER_ITEM$wofangjingfei$4' value=''
							ID='子表1.我方经费$4'
							onkeyup="value=value.replace(/[^\d.-]/g,'') " style='text-align:right' CLASS='boder12-0_29' maxlength='10' SIZE='10'
							onChange='createNo(this);' ></TD>
						<TD class=font12size2 vAlign=middle>&nbsp;<label
							name='query$form$0$JOIN_OUTER_ITEM$waifangjingfei$4' value=''
							ID='子表1.外方经费$4'
							onkeyup="value=value.replace(/[^\d.-]/g,'') " style='text-align:right' CLASS='boder12-0_29' maxlength='10' SIZE='10'
							onChange='createNo(this);' ></TD>
						<TD class=font12size2 vAlign=middle>
							<textarea CLASS='boder12-0_29' COLS='12' rows='3' limit='18'readonly ></textarea></TD>
						<TD class=font12size3><textarea
							name='query$form$0$JOIN_OUTER_ITEM$hezuoxiangmu$4'
							onKeyDown="textCounter(query$form$0$JOIN_OUTER_ITEM$hezuoxiangmu$4,45);"
							onKeyUp="textCounter(query$form$0$JOIN_OUTER_ITEM$hezuoxiangmu$4,45);"
							ID='子表1.合作项目$4' CLASS='boder12-0_29' COLS='30' rows='3' limit='45'
							onChange='createNo(this);' readonly ></textarea></TD>
					</TR>
					<TR align=middle>
						<TD class=font12size4 height=32><input value='5' CLASS='boder12-0_29' SIZE='2'	readOnly='true' style='text-align:center'></TD>
						<TD class=font12size4 height=32><textarea
							name='query$form$0$JOIN_OUTER_ITEM$xiangmumingcheng$5'
							onKeyDown="textCounter(query$form$0$JOIN_OUTER_ITEM$xiangmumingcheng$5,18);"
							onKeyUp="textCounter(query$form$0$JOIN_OUTER_ITEM$xiangmumingcheng$5,18);"
							ID='子表1.项目名称$5' COLS='12' rows='3' limit='18' CLASS='boder12-0_29'
							onChange='createNo(this);' readonly ></textarea></TD>
						<TD class=font12size4 height=32><textarea
							name='query$form$0$JOIN_OUTER_ITEM$hezuofangmingcheng$5'
							onKeyDown="textCounter(query$form$0$JOIN_OUTER_ITEM$hezuofangmingcheng$5,18);"
							onKeyUp="textCounter(query$form$0$JOIN_OUTER_ITEM$hezuofangmingcheng$5,18);"
							ID='子表1.合作方名称$5' CLASS='boder12-0_29' COLS='12' rows='3' limit='18'
							onChange='createNo(this);' readonly ></textarea></TD>
						<TD class=font12size4 height=32>
							<textarea CLASS='boder12-0_29' COLS='12' rows='3' limit='18'readonly ></textarea></TD>
						<TD class=font12size4 valign=middle>&nbsp;<label
							name='query$form$0$JOIN_OUTER_ITEM$wofangjingfei$5' value=''
							ID='子表1.我方经费$5'
							onkeyup="value=value.replace(/[^\d.-]/g,'') " style='text-align:right' CLASS='boder12-0_29' size='10' maxlength='10'
							SIZE='10' onChange='createNo(this);' ></TD>
						<TD class=font12size4 valign=middle>&nbsp;<label
							name='query$form$0$JOIN_OUTER_ITEM$waifangjingfei$5' value=''
							ID='子表1.外方经费$5'
							onkeyup="value=value.replace(/[^\d.-]/g,'') " style='text-align:right' CLASS='boder12-0_29' maxlength='10' SIZE='10'
							onChange='createNo(this);' ></TD>
						<TD class=font12size4 valign=top>
							<textarea CLASS='boder12-0_29' COLS='12' rows='3' limit='18'readonly ></textarea></TD>
						<TD><textarea
							name='query$form$0$JOIN_OUTER_ITEM$hezuoxiangmu$5'
							onKeyDown="textCounter(query$form$0$JOIN_OUTER_ITEM$hezuoxiangmu$5,45);"
							onKeyUp="textCounter(query$form$0$JOIN_OUTER_ITEM$hezuoxiangmu$5,45);"
							ID='子表1.合作项目$5' CLASS='boder12-0_29' COLS='30' rows='3' limit='45'
							onChange='createNo(this);' readonly ></textarea></TD>
					</TR>
				</TBODY>
			</TABLE>
			</TD>
		</TR>
		<TR>
			<TD vAlign=center align=left height=25>&nbsp;</TD>
		</TR>
		<TR>
			<TD vAlign=top align=middle height=14>
			<div align='center'><STRONG>2．参加国际会议情况</STRONG></div>
			</TD>
		</TR>
		<TR>
			<TD vAlign=top height=14>&nbsp;</TD>
		</TR>
		<TR>
			<TD vAlign=top height=14>
			<TABLE id=internationalMeeting class=unnamed1 cellSpacing=0 cellPadding=0 width='100%'
				border=0>
				<TBODY>
					<TR align=middle>
						<TD class=font12size2 width='5%' height=32>序号</TD>
						<TD class=font12size2 width='28%' height=32>会议的名称</TD>
						<TD class=font12size2 width='12%' height=32>会议时间</TD>
						<TD class=font12size2 width='20%' height=32>会议地点</TD>
						<TD class=font12size2 width='21%'>主办方名称</TD>
						<TD class=font12size3 width='16%'>我方经费来源</TD>
					</TR>
					<TR align=middle>
						<TD class=font12size2 height=31><input value='1' CLASS='boder12-0_29' SIZE='2'	readOnly='true' style='text-align:center'></TD>
						<TD class=font12size2 height=31><textarea
							name='query$form$0$JOIN_OUTER_MEET$huiyimingcheng$1'
							onKeyDown="textCounter(query$form$0$JOIN_OUTER_MEET$huiyimingcheng$1,28);"
							onKeyUp="textCounter(query$form$0$JOIN_OUTER_MEET$huiyimingcheng$1,28);"
							ID='子表2.会议名称$1' COLS='28' limit='28' CLASS='boder12-0_29'
							onChange='createNo(this);' readonly ></textarea></TD>
						<TD class=font12size2 height=31>
							<textarea CLASS='boder12-0_29' COLS='12' rows='3' limit='18'readonly ></textarea></TD>
						<TD class=font12size2 height=31>
							<textarea CLASS='boder12-0_29' COLS='12' rows='3' limit='18'readonly ></textarea></TD>
						<TD class=font12size2><textarea
							name='query$form$0$JOIN_OUTER_MEET$zhubanfangmingcheng$1'
							onKeyDown="textCounter(query$form$0$JOIN_OUTER_MEET$zhubanfangmingcheng$1,20);"
							onKeyUp="textCounter(query$form$0$JOIN_OUTER_MEET$zhubanfangmingcheng$1,20);"
							ID='子表2.主办方名称$1' COLS='20' limit='20' CLASS='boder12-0_29'
							onChange='createNo(this);' readonly ></textarea></TD>
						<TD class=font12size3>
							<textarea CLASS='boder12-0_29' COLS='12' rows='3' limit='18'readonly ></textarea></TD>
					</TR>
					<TR align=middle>
						<TD class=font12size2 height=31><input value='2' CLASS='boder12-0_29' SIZE='2'	readOnly='true' style='text-align:center'></TD>
						<TD class=font12size2 height=31><textarea
							name='query$form$0$JOIN_OUTER_MEET$huiyimingcheng$2'
							onKeyDown="textCounter(query$form$0$JOIN_OUTER_MEET$huiyimingcheng$2,28);"
							onKeyUp="textCounter(query$form$0$JOIN_OUTER_MEET$huiyimingcheng$2,28);"
							ID='子表2.会议名称$2' COLS='28' limit='28' CLASS='boder12-0_29'
							onChange='createNo(this);' readonly ></textarea></TD>
						<TD class=font12size2 height=31>
							<textarea CLASS='boder12-0_29' COLS='12' rows='3' limit='18'readonly ></textarea></TD>
						<TD class=font12size2 height=31>
							<textarea CLASS='boder12-0_29' COLS='12' rows='3' limit='18'readonly ></textarea></TD>
						<TD class=font12size2><textarea
							name='query$form$0$JOIN_OUTER_MEET$zhubanfangmingcheng$2'
							onKeyDown="textCounter(query$form$0$JOIN_OUTER_MEET$zhubanfangmingcheng$2,20);"
							onKeyUp="textCounter(query$form$0$JOIN_OUTER_MEET$zhubanfangmingcheng$2,20);"
							ID='子表2.主办方名称$2' COLS='20' limit='20' CLASS='boder12-0_29'
							onChange='createNo(this);' readonly ></textarea></TD>
						<TD class=font12size3>
							<textarea CLASS='boder12-0_29' COLS='12' rows='3' limit='18'readonly ></textarea></TD>
					</TR>
					<TR align=middle>
						<TD class=font12size2 height=32><input value='3' CLASS='boder12-0_29' SIZE='2'	readOnly='true' style='text-align:center'></TD>
						<TD class=font12size2 height=32><textarea
							name='query$form$0$JOIN_OUTER_MEET$huiyimingcheng$3'
							onKeyDown="textCounter(query$form$0$JOIN_OUTER_MEET$huiyimingcheng$3,28);"
							onKeyUp="textCounter(query$form$0$JOIN_OUTER_MEET$huiyimingcheng$3,28);"
							ID='子表2.会议名称$3' COLS='28' limit='28' CLASS='boder12-0_29'
							onChange='createNo(this);' readonly ></textarea></TD>
						<TD class=font12size2 height=32>
							<textarea CLASS='boder12-0_29' COLS='12' rows='3' limit='18'readonly ></textarea></TD>
						<TD class=font12size2 height=32>
							<textarea CLASS='boder12-0_29' COLS='12' rows='3' limit='18'readonly ></textarea></TD>
						<TD class=font12size2><textarea
							name='query$form$0$JOIN_OUTER_MEET$zhubanfangmingcheng$3'
							onKeyDown="textCounter(query$form$0$JOIN_OUTER_MEET$zhubanfangmingcheng$3,20);"
							onKeyUp="textCounter(query$form$0$JOIN_OUTER_MEET$zhubanfangmingcheng$3,20);"
							ID='子表2.主办方名称$3' COLS='20' limit='20' CLASS='boder12-0_29'
							onChange='createNo(this);' readonly ></textarea></TD>
						<TD class=font12size3>
							<textarea CLASS='boder12-0_29' COLS='12' rows='3' limit='18'readonly ></textarea></TD>
					</TR>
					<TR align=middle>
						<TD class=font12size2 height=32><input value='4' CLASS='boder12-0_29' SIZE='2'	readOnly='true' style='text-align:center'></TD>
						<TD class=font12size2 height=32><textarea
							name='query$form$0$JOIN_OUTER_MEET$huiyimingcheng$4'
							onKeyDown="textCounter(query$form$0$JOIN_OUTER_MEET$huiyimingcheng$4,28);"
							onKeyUp="textCounter(query$form$0$JOIN_OUTER_MEET$huiyimingcheng$4,28);"
							ID='子表2.会议名称$4' COLS='28' limit='28' CLASS='boder12-0_29'
							onChange='createNo(this);' readonly ></textarea></TD>
						<TD class=font12size2 height=32>
							<textarea CLASS='boder12-0_29' COLS='12' rows='3' limit='18'readonly ></textarea></TD>
						<TD class=font12size2 height=32>
							<textarea CLASS='boder12-0_29' COLS='12' rows='3' limit='18'readonly ></textarea></TD>
						<TD class=font12size2><textarea
							name='query$form$0$JOIN_OUTER_MEET$zhubanfangmingcheng$4'
							onKeyDown="textCounter(query$form$0$JOIN_OUTER_MEET$zhubanfangmingcheng$4,20);"
							onKeyUp="textCounter(query$form$0$JOIN_OUTER_MEET$zhubanfangmingcheng$4,20);"
							ID='子表2.主办方名称$4' COLS='20' limit='20' CLASS='boder12-0_29'
							onChange='createNo(this);' readonly ></textarea></TD>
						<TD class=font12size3>
							<textarea CLASS='boder12-0_29' COLS='12' rows='3' limit='18'readonly ></textarea></TD>
					</TR>
					<TR align=middle>
						<TD class=font12size4 height=32><input value='5' CLASS='boder12-0_29' SIZE='2'	readOnly='true' style='text-align:center'></TD>
						<TD class=font12size4 height=32><textarea
							name='query$form$0$JOIN_OUTER_MEET$huiyimingcheng$5'
							onKeyDown="textCounter(query$form$0$JOIN_OUTER_MEET$huiyimingcheng$5,28);"
							onKeyUp="textCounter(query$form$0$JOIN_OUTER_MEET$huiyimingcheng$5,28);"
							ID='子表2.会议名称$5' COLS='28' limit='28' CLASS='boder12-0_29'
							onChange='createNo(this);' readonly ></textarea></TD>
						<TD class=font12size4 height=32>
							<textarea CLASS='boder12-0_29' COLS='12' rows='3' limit='18'readonly ></textarea></TD>
						<TD class=font12size4 height=32>
							<textarea CLASS='boder12-0_29' COLS='12' rows='3' limit='18'readonly ></textarea></TD>
						<TD class=font12size4><textarea
							name='query$form$0$JOIN_OUTER_MEET$zhubanfangmingcheng$5'
							onKeyDown="textCounter(query$form$0$JOIN_OUTER_MEET$zhubanfangmingcheng$5,20);"
							onKeyUp="textCounter(query$form$0$JOIN_OUTER_MEET$zhubanfangmingcheng$5,20);"
							ID='子表2.主办方名称$5' COLS='20' limit='20' CLASS='boder12-0_29'
							onChange='createNo(this);' readonly ></textarea></TD>
						<TD >
							<textarea CLASS='boder12-0_29' COLS='12' rows='3' limit='18'readonly ></textarea></TD>
					</TR>
				</TBODY>
			</TABLE>
			</TD>
		</TR>
		<TR>
			<TD vAlign=top height=24>&nbsp;</TD>
		</TR>
		<TR>
			<TD align=middle height=14>
			<div align='center'><STRONG>3. 参加国际组织情况</STRONG></div>
			</TD>
		</TR>
		<TR>
			<TD height=14>&nbsp;</TD>
		</TR>
		<TR>
			<TD vAlign=top height=193>
			<TABLE id=internationalOrganization class=unnamed1 cellSpacing=0 cellPadding=0 width='100%'
				border=0>
				<TBODY>
					<TR class=font12size2 align=middle>
						<TD class=font12size2 width='32' height=32>序号</TD>
						<TD class=font12size2 width='156' height=32>国际组织名称（中文全称）</TD>
						<TD class=font12size2 width='238' height=32>国际组织名称（英文全称）</TD>
						<TD class=font12size2 width='78' height=32>参加时间</TD>
						<TD class=font12size2 width='78' height=32>批准部门</TD>
						<TD class=font12size3 width='67'>担任何职务</TD>
					</TR>
					<TR class=font12size2 align=middle>
						<TD class=font12size2 height=31><input value='1' CLASS='boder12-0_29' SIZE='2'	readOnly='true' style='text-align:center'></TD>
						<TD class=font12size2 height=31><textarea
							name='query$form$0$JOIN_OUTER_ORG$zhongwenquancheng$1'
							onKeyDown="textCounter(query$form$0$JOIN_OUTER_ORG$zhongwenquancheng$1,36);"
							onKeyUp="textCounter(query$form$0$JOIN_OUTER_ORG$zhongwenquancheng$1,36);"
							ID='子表3.中文全称$5' COLS='24' rows='3' limit='36' CLASS='boder12-0_29'
							onChange='createNo(this);' readonly ></textarea></TD>
						<TD class=font12size2 height=31><textarea
							name='query$form$0$JOIN_OUTER_ORG$yingwenquancheng$1'
							onKeyDown="textCounter(query$form$0$JOIN_OUTER_ORG$yingwenquancheng$1,110);"
							onKeyUp="textCounter(query$form$0$JOIN_OUTER_ORG$yingwenquancheng$1,110);"
							ID='子表3.英文全称$5' COLS='38' rows='3' limit='110' CLASS='boder12-0_29'
							onChange='createNo(this);' readonly ></textarea></TD>
						<TD class=font12size2 vAlign=middle height=31>
							&nbsp;<label style='width:80px' CLASS='boder12-0_29' format="Y-m-d" onclick="LoushangDate(this);" readonly style='text-align:center'></TD>
						<TD class=font12size2><textarea
							name='query$form$0$JOIN_OUTER_ORG$pizhunbumen$1'
							onKeyDown="textCounter(query$form$0$JOIN_OUTER_ORG$pizhunbumen$1,18);"
							onKeyUp="textCounter(query$form$0$JOIN_OUTER_ORG$pizhunbumen$1,18);"
							ID='子表3.批准部门$1' COLS='12' rows='3' limit='18' CLASS='boder12-0_29'
							onChange='createNo(this);' readonly ></textarea></TD>
						<TD class=font12size3>
							<textarea CLASS='boder12-0_29' COLS='12' rows='3' limit='18'readonly ></textarea></TD>
					</TR>
					<TR class=font12size2 align=middle>
						<TD class=font12size2 height=32><input value='2' CLASS='boder12-0_29' SIZE='2'	readOnly='true' style='text-align:center'></TD>
						<TD class=font12size2 height=32><textarea
							name='query$form$0$JOIN_OUTER_ORG$zhongwenquancheng$2'
							onKeyDown="textCounter(query$form$0$JOIN_OUTER_ORG$zhongwenquancheng$2,36);"
							onKeyUp="textCounter(query$form$0$JOIN_OUTER_ORG$zhongwenquancheng$2,36);"
							ID='子表3.中文全称$5' COLS='24' rows='3' limit='36' CLASS='boder12-0_29'
							onChange='createNo(this);' readonly ></textarea></TD>
						<TD class=font12size2 height=32><textarea
							name='query$form$0$JOIN_OUTER_ORG$yingwenquancheng$2'
							onKeyDown="textCounter(query$form$0$JOIN_OUTER_ORG$yingwenquancheng$2,110);"
							onKeyUp="textCounter(query$form$0$JOIN_OUTER_ORG$yingwenquancheng$2,110);"
							ID='子表3.英文全称$5' COLS='38' rows='3' limit='110' CLASS='boder12-0_29'
							onChange='createNo(this);' readonly ></textarea></TD>
						<TD class=font12size2 vAlign=middle height=32>
							&nbsp;<label CLASS='boder12-0_29' format="Y-m-d" onclick="LoushangDate(this);" readonly style='text-align:center'></TD>
						<TD class=font12size2><textarea
							name='query$form$0$JOIN_OUTER_ORG$pizhunbumen$2'
							onKeyDown="textCounter(query$form$0$JOIN_OUTER_ORG$pizhunbumen$2,18);"
							onKeyUp="textCounter(query$form$0$JOIN_OUTER_ORG$pizhunbumen$2,18);"
							ID='子表3.批准部门$2' COLS='12' rows='3' limit='18' CLASS='boder12-0_29'
							onChange='createNo(this);' readonly ></textarea></TD>
						<TD class=font12size3>
							<textarea CLASS='boder12-0_29' COLS='12' rows='3' limit='18'readonly ></textarea></TD>
					</TR>
					<TR align=middle>
						<TD class=font12size2 height=32><input value='3' CLASS='boder12-0_29' SIZE='2'	readOnly='true' style='text-align:center'></TD>
						<TD class=font12size2 height=32><textarea
							name='query$form$0$JOIN_OUTER_ORG$zhongwenquancheng$3'
							onKeyDown="textCounter(query$form$0$JOIN_OUTER_ORG$zhongwenquancheng$3,36);"
							onKeyUp="textCounter(query$form$0$JOIN_OUTER_ORG$zhongwenquancheng$3,36);"
							ID='子表3.中文全称$5' COLS='24' rows='3' limit='36' CLASS='boder12-0_29'
							onChange='createNo(this);' readonly ></textarea></TD>
						<TD class=font12size2 height=32><textarea
							name='query$form$0$JOIN_OUTER_ORG$yingwenquancheng$3'
							onKeyDown="textCounter(query$form$0$JOIN_OUTER_ORG$yingwenquancheng$3,110);"
							onKeyUp="textCounter(query$form$0$JOIN_OUTER_ORG$yingwenquancheng$3,110);"
							ID='子表3.英文全称$5' COLS='38' rows='3' limit='110' CLASS='boder12-0_29'
							onChange='createNo(this);' readonly ></textarea></TD>
						<TD class=font12size2 vAlign=middle height=32>
							&nbsp;<label CLASS='boder12-0_29' format="Y-m-d" onclick="LoushangDate(this);" readonly style='text-align:center'></TD>
						<TD class=font12size2><textarea
							name='query$form$0$JOIN_OUTER_ORG$pizhunbumen$3'
							onKeyDown="textCounter(query$form$0$JOIN_OUTER_ORG$pizhunbumen$3,18);"
							onKeyUp="textCounter(query$form$0$JOIN_OUTER_ORG$pizhunbumen$3,18);"
							ID='子表3.批准部门$3' COLS='12' rows='3' limit='18' CLASS='boder12-0_29'
							onChange='createNo(this);' readonly ></textarea></TD>
						<TD class=font12size3>
							<textarea CLASS='boder12-0_29' COLS='12' rows='3' limit='18'readonly ></textarea></TD>
					</TR>
					<TR align=middle>
						<TD class=font12size2 height=32><input value='4' CLASS='boder12-0_29' SIZE='2'	readOnly='true' style='text-align:center'></TD>
						<TD class=font12size2 height=32><textarea
							name='query$form$0$JOIN_OUTER_ORG$zhongwenquancheng$4'
							onKeyDown="textCounter(query$form$0$JOIN_OUTER_ORG$zhongwenquancheng$4,36);"
							onKeyUp="textCounter(query$form$0$JOIN_OUTER_ORG$zhongwenquancheng$4,36);"
							ID='子表3.中文全称$5' COLS='24' rows='3' limit='36' CLASS='boder12-0_29'
							onChange='createNo(this);' readonly ></textarea></TD>
						<TD class=font12size2 height=32><textarea
							name='query$form$0$JOIN_OUTER_ORG$yingwenquancheng$4'
							onKeyDown="textCounter(query$form$0$JOIN_OUTER_ORG$yingwenquancheng$4,110);"
							onKeyUp="textCounter(query$form$0$JOIN_OUTER_ORG$yingwenquancheng$4,110);"
							ID='子表3.英文全称$5' COLS='38' rows='3' limit='110' CLASS='boder12-0_29'
							onChange='createNo(this);' readonly ></textarea></TD>
						<TD class=font12size2 vAlign=middle height=32>
							&nbsp;<label CLASS='boder12-0_29' format="Y-m-d" onclick="LoushangDate(this);" readonly style='text-align:center'></TD>
						<TD class=font12size2><textarea
							name='query$form$0$JOIN_OUTER_ORG$pizhunbumen$4'
							onKeyDown="textCounter(query$form$0$JOIN_OUTER_ORG$pizhunbumen$4,18);"
							onKeyUp="textCounter(query$form$0$JOIN_OUTER_ORG$pizhunbumen$4,18);"
							ID='子表3.批准部门$4' COLS='12' rows='3' limit='18' CLASS='boder12-0_29'
							onChange='createNo(this);' readonly ></textarea></TD>
						<TD class=font12size3>
							<textarea CLASS='boder12-0_29' COLS='12' rows='3' limit='18'readonly ></textarea></TD>
					</TR>
					<TR align=middle>
						<TD class=font12size4 height=32><input value='5' CLASS='boder12-0_29' SIZE='2'	readOnly='true' style='text-align:center'></TD>
						<TD class=font12size4 height=32><textarea
							name='query$form$0$JOIN_OUTER_ORG$zhongwenquancheng$5'
							onKeyDown="textCounter(query$form$0$JOIN_OUTER_ORG$zhongwenquancheng$5,36);"
							onKeyUp="textCounter(query$form$0$JOIN_OUTER_ORG$zhongwenquancheng$5,36);"
							ID='子表3.中文全称$5' COLS='24' rows='3' limit='36' CLASS='boder12-0_29'
							onChange='createNo(this);' readonly ></textarea></TD>
						<TD class=font12size4 height=32><textarea
							name='query$form$0$JOIN_OUTER_ORG$yingwenquancheng$5'
							onKeyDown="textCounter(query$form$0$JOIN_OUTER_ORG$yingwenquancheng$5,110);"
							onKeyUp="textCounter(query$form$0$JOIN_OUTER_ORG$yingwenquancheng$5,110);"
							ID='子表3.英文全称$5' COLS='38' rows='3' limit='110' CLASS='boder12-0_29'
							onChange='createNo(this);' readonly ></textarea></TD>
						<TD class=font12size4 valign=middle height=32>
							&nbsp;<label CLASS='boder12-0_29' format="Y-m-d" onclick="LoushangDate(this);" readonly style='text-align:center'></TD>
						<TD class=font12size4><textarea
							name='query$form$0$JOIN_OUTER_ORG$pizhunbumen$5'
							onKeyDown="textCounter(query$form$0$JOIN_OUTER_ORG$pizhunbumen$5,18);"
							onKeyUp="textCounter(query$form$0$JOIN_OUTER_ORG$pizhunbumen$5,18);"
							ID='子表3.批准部门$5' COLS='12' rows='3' limit='18' CLASS='boder12-0_29'
							onChange='createNo(this);' readonly ></textarea></TD>
						<TD >
							<textarea CLASS='boder12-0_29' COLS='12' rows='3' limit='18'readonly ></textarea></TD>
					</TR>
				</TBODY>
			</TABLE>
			</TD>
		</TR>
		<TR>
			<TD vAlign=top height=14>&nbsp;</TD>
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
