var mesg="noCheck";
var jgxz="";
function init() {
	var infocommand = new L5.Command("com.inspur.cams.comm.informUtil.InformSessionCmd");
	infocommand.execute("getUserInfo");
	var userLoginName ="";
	if (!infocommand.error) {
		var info = infocommand.getReturn("userInfo");
	  	userLoginName =info.userLoginName;//通过登录账号查找对应的婚姻登记处。
	  	organCode =info.cantCode;//通过登录账号查找对应的婚姻登记处。
	}
	var mrmBasePersonCommand = new L5.Command("com.inspur.cams.marry.base.cmd.MrmBasePersonCommand");
	mrmBasePersonCommand.setParameter("loginId",userLoginName);
	mrmBasePersonCommand.execute("getDeptId");
	if (!mrmBasePersonCommand.error) {
	 	deptId = mrmBasePersonCommand.getReturn("deptId");
	 	deptName=mrmBasePersonCommand.getReturn("deptName");
	}
	
	if(deptId=="" || deptId==null){
		ds.newRecord();
		alert("没有对应的婚姻登记处！");
		return false;
	
	}
    ds.setParameter("DEPT_CODE@=",deptId);
 	ds.load();
 	ds.on("load",function(){
 		if(ds.getAt(0).get("types")=="01"){
 			jgxz="1";
 		}
 		if(ds.getAt(0).get("types")=="02"){
 			jgxz="2";
 		}
 		if(ds.getAt(0).get("types")=="03"){
 			jgxz="3";
 		}
 		$("creatDate").value=nowDate;
		var applyDs=L5.DatasetMgr.lookup("applyDs");
		if(method=="UPDATE"){
		    applyDs.setParameter("APPLY_ID@=",applyId);
		 	applyDs.load();
		}else{
			applyDs.newRecord({"applyType":"0"});
			applyDs.set("organName",deptName);
			applyDs.set("townOrganName",organName);		
			applyDs.set("cityOrganName",cityName+"民政局");		
			applyDs.set("provinceOrganName","山东省民政厅");		
			applyDs.set("departmentOrganName","中华人民共和国民政部");
		}
 	
	});
 	var queryDs=L5.DatasetMgr.lookup("queryDs");
	queryDs.setParameter("DEPT_CODE",deptId);
	queryDs.load();
	queryDs.on('load',function(){
		//if(queryDs.getCurrent().get("skinValue")=='00'){
		//	L5.Msg.alert('提示',"当前登记机关无等级，不能申请取消");
			//undo();
		if(queryDs.getCurrent().get("skinValue")=='01'){
			$("skinValue").innerHTML+='国家3A级'+$("skinValue").innerHTML;
			$("applyLev").innerHTML='国家3A级';
		}else if(queryDs.getCurrent().get("skinValue")=='02'){
			$("skinValue").innerHTML+="国家4A级"+$("skinValue").innerHTML;
			$("applyLev").innerHTML='国家4A级';
		}else if(queryDs.getCurrent().get("skinValue")=='03'){
			$("skinValue").innerHTML+='国家5A级'+$("skinValue").innerHTML;
			$("applyLev").innerHTML='国家5A级';
		}else{
			$("skinValue").innerHTML+='';
			$("applyLev").innerHTML='';
		}
	});
	applyDs.on("load",function(){
 		var applyRecord=applyDs.getAt(0);
 		var recod=ds.getAt(0);
 		recod.set("townOpinionId",applyRecord.get("townOpinionId"));
 		$("townOpinion").value=applyRecord.get("townOpinion");
 		recod.set("cityOpinionId",applyRecord.get("cityOpinionId"));
 		$("cityOpinion").value=applyRecord.get("cityOpinion");
 		recod.set("provinceOpinionId",applyRecord.get("provinceOpinionId"));
 		$("provinceOpinion").value=applyRecord.get("provinceOpinion");
 		recod.set("departmentOpinionId",applyRecord.get("departmentOpinionId"));
 		$("departmentOpinion").value=applyRecord.get("departmentOpinion");
		var townAuditTime=applyRecord.get("townAuditTime");
		if(townAuditTime && townAuditTime.length>10){
			$("townAuditTime").innerHTML=townAuditTime.substring(0,4)+"年 "+townAuditTime.substring(5,7)+"月 "+townAuditTime.substring(8,10)+"日";
		}
		
		var cityAuditTime=applyRecord.get("cityAuditTime");
		if(cityAuditTime && cityAuditTime.length>10){
			$("cityAuditTime").innerHTML=cityAuditTime.substring(0,4)+"年 "+cityAuditTime.substring(5,7)+"月 "+cityAuditTime.substring(8,10)+"日";
		}
		var provinceAuditTime=applyRecord.get("provinceAuditTime");
		if(provinceAuditTime && provinceAuditTime.length>10){
			$("provinceAuditTime").innerHTML=provinceAuditTime.substring(0,4)+"年 "+provinceAuditTime.substring(5,7)+"月 "
			+provinceAuditTime.substring(8,10)+"日";
		}
		var departmentAuditTime=applyRecord.get("departmentAuditTime");
		if(departmentAuditTime && departmentAuditTime.length>10){
			$("departmentAuditTime").innerHTML=departmentAuditTime.substring(0,4)+"年 "+departmentAuditTime.substring(5,7)+"月 "
			+departmentAuditTime.substring(8,10)+"日";
		}
 	});
	//过滤等级
	evaluLevelDataSet.filterBy(function(record, id){
		if(record.get('value') != '00' ){
			return record;
		}
	});
	

	L5.QuickTips.init(); 
}
function save(){
	var applyRecord=applyDs.getCurrent();
	setApplyRecord();
	var command=new L5.Command("com.inspur.cams.marry.application.cmd.MrmLevelApplyCmd");
	command.setParameter("applyRecord",applyRecord);
	if(method=="UPDATE"){
		command.execute("update");
	}else{
		command.execute("insert");
	}
	if (!command.error) {
		L5.Msg.alert('提示',"保存成功!",function(){
			undo();
		});
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
function getTimes(item) {
	LoushangDate(item.previousSibling);
}


function setApplyRecord(){
	var record=ds.getCurrent();
	var applyDs=L5.DatasetMgr.lookup("applyDs");
	var applyRecord=applyDs.getCurrent();
	var creatDate=document.getElementById("creatDate").value;
	applyRecord.set("applyTime",creatDate);
	if(method=="INSERT"){
	     //申请婚姻登记机关代码
	     applyRecord.set("applyId",appId);
	}
	applyRecord.set("applyTime",document.getElementById('creatDate').value);
	// 申请婚姻登记机关
	applyRecord.set("organCode",deptId);
	// 申请婚姻登记机关名称
	//applyRecord.set("organName",record.get("deptName"));
	// 申请婚姻登记机关级别
	applyRecord.set("organLevel",organCode.indexOf("000000"));
	// 申请等级
	applyRecord.set("applyLevel",queryDs.getCurrent().get("skinValue"));
	//机构性质
	//applyRecord.set("organType",jgxz);
}
function showDiv(){
	var creatDate=document.getElementById("creatDate").value;
	var reason=document.getElementById("reason").value;
	    if(creatDate==""){
	    	L5.Msg.alert('提示',"校验未通过，请填写申报时间");
	    	return false;
	    }
	    if(reason==""){
	    	L5.Msg.alert('提示',"校验未通过，请填写退出原因");
	    	return false;
	    }
	  return true;
}
var printTitle;
function printBill(){
	if(mesg=="noCheck"){
		L5.Msg.alert("提示","请先校验！");
		return false;
	}else if(mesg!=""){
		L5.Msg.alert("提示","校验不通过，无法打印！");
		return false;
	}
	var printDataset=L5.DatasetMgr.lookup("ds");

	doPrint(printDataset);
}
function doPrint(printDataset){
	printReport(getPrintDataByDataSet(printTitle,printDataset),L5.webPath+'/jsp/cams/marry/reports/marryQApply.fr3');
}

var str;
function getPrintDataByDataSet(reportName,printDataset,CreateOrgan,ReportNo,ReportType){
	var pp="sfsdf";
	var applyLevel=document.getElementById("skinValue").value;
	var creatDate=document.getElementById("creatDate").value;
	var xmlStr="<?xml version='1.0' encoding='GBK' standalone='no'?>";
	xmlStr+="<Report ReportName='' Creater='"+applyLevel+"' CreateOrgan='"+pp+"' ReportNo='"+applyLevel+"' ReportType='"+creatDate+"'>";
	var records=printDataset.getAllRecords();
	xmlStr +="<Info>";
	var item =records[0].fields.items;
	var showStr="";
	for(var i=0;i<records[0].fields.getCount();i++){		
		xmlStr+="<"+item[i].name+">"+showStr+"</"+item[i].name+">";
	}
	xmlStr +="</Info>";
	xmlStr +="</Report>";
	return xmlStr;
	
}
//返回
function undo(){
 	history.go(-1);
}
function submit(){
	var creatDate=document.getElementById("creatDate").value;
	var reason=document.getElementById("reason").value;
    if(creatDate==""){
    	L5.Msg.alert('提示',"校验未通过，请填写申报时间");
    	return false;
    }
    if(reason==""){
    	L5.Msg.alert('提示',"校验未通过，请填写退出原因");
    	return false;
    }
	var applyQueryDataSet=L5.DatasetMgr.lookup("applyQueryDataSet");
    applyQueryDataSet.setParameter("ORGAN_CODE@=",deptId);
	applyQueryDataSet.setParameter("CHECK_STATUS@IN","11,21,31,32,41,42,52");
	applyQueryDataSet.setParameter("APPLY_TYPE",0);
 	applyQueryDataSet.load();
 	applyQueryDataSet.on("load",function(ds){
 		//alert(applyQueryDataSet.print());
 		if(ds.getCount()>0){
			L5.Msg.alert("提示","存在审核状态为“在审”的申报，不能提交！");
			return false; 			
 		}
		var applyDs=L5.DatasetMgr.lookup("applyDs");
		var applyRecord=applyDs.getCurrent();
		setApplyRecord();
		var command=new L5.Command("com.inspur.cams.marry.application.cmd.MrmLevelApplyCmd");
		command.setParameter("applyRecord",applyRecord);
		if(method=="INSERT"){
		    command.execute("insertAndSend");
		}else{
			command.execute("insertuAndSend");
		}
		if (!command.error) {
			L5.Msg.alert('提示',"提交成功!",function(){
				undo();
			});
		}else{
			L5.Msg.alert('提示',"提交时出现错误！"+command.error);
		}
	});	
}
