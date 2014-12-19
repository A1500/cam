function init(){
	var applyDs=L5.DatasetMgr.lookup("applyDs");
	applyDs.setParameter("APPLY_ID",applyId);
	applyDs.load();
	applyDs.on('load',function(ds){
		var record=ds.getAt(0);
 		var auditResult=record.get("auditResult");
 		if(method=="UPDATE" && organType=="13"){
 			var townOpinionId=record.get("townOpinionId");
 			if(!townOpinionId){
	 			record.set("townOpinionId","1");
 			}
 			if(auditResult=="2"){
	 			record.set("townOpinionId","0");
	 			record.set("townOpinion","");
 				$("townOpinionId").disabled=true;
 			}
 			$("townAuditTime").innerHTML=curDate.substring(0,4)+"年 "+curDate.substring(5,7)+"月 "+curDate.substring(8,10)+"日";
 		}else{
 			var townAuditTime=record.get("townAuditTime");
 			if(townAuditTime && townAuditTime.length>10){
 				$("townAuditTime").innerHTML=townAuditTime.substring(0,4)+"年 "+townAuditTime.substring(5,7)+"月 "+townAuditTime.substring(8,10)+"日";
 			}
 		}
 		if(method=="UPDATE" && organType=="12"){
 			var cityOpinionId=record.get("cityOpinionId");
 			if(!cityOpinionId){
	 			record.set("cityOpinionId","1");
 			}
 			if(auditResult=="2"){
	 			record.set("cityOpinionId","0");
	 			record.set("cityOpinion","");
 				$("cityOpinionId").disabled=true;
 			}
 			$("cityAuditTime").innerHTML=curDate.substring(0,4)+"年 "+curDate.substring(5,7)+"月 "+curDate.substring(8,10)+"日";
 		}else{
 			var cityAuditTime=record.get("cityAuditTime");
 			if(cityAuditTime && cityAuditTime.length>10){
 				$("cityAuditTime").innerHTML=cityAuditTime.substring(0,4)+"年 "+cityAuditTime.substring(5,7)+"月 "+cityAuditTime.substring(8,10)+"日";
 			}
 		}
 		if(method=="UPDATE" && organType=="11"){
 			var provinceOpinionId=record.get("provinceOpinionId");
 			if(!provinceOpinionId){
	 			record.set("provinceOpinionId","1");
 			}
 			if(auditResult=="2"){
	 			record.set("provinceOpinionId","0");
	 			record.set("provinceOpinion","");
 				$("provinceOpinionId").disabled=true;
 			}
 			$("provinceAuditTime").innerHTML=curDate.substring(0,4)+"年 "+curDate.substring(5,7)+"月 "+curDate.substring(8,10)+"日";
 		}else{
 			var provinceAuditTime=record.get("provinceAuditTime");
 			if(provinceAuditTime && provinceAuditTime.length>10){
 				$("provinceAuditTime").innerHTML=provinceAuditTime.substring(0,4)+"年 "+provinceAuditTime.substring(5,7)+"月 "
 				+provinceAuditTime.substring(8,10)+"日";
 			}
 		}
 		if(method=="UPDATE" && organType=="0"){
 			var departmentOpinionId=record.get("departmentOpinionId");
 			if(!departmentOpinionId){
	 			record.set("departmentOpinionId","1");
 			}
 			if(auditResult=="2"){
	 			record.set("departmentOpinionId","0");
	 			record.set("departmentOpinion","");
 				$("departmentOpinionId").disabled=true;
 			}
 			$("departmentAuditTime").innerHTML=curDate.substring(0,4)+"年 "+curDate.substring(5,7)+"月 "+curDate.substring(8,10)+"日";
 		}else{
 			var departmentAuditTime=record.get("departmentAuditTime");
 			if(departmentAuditTime && departmentAuditTime.length>10){
 				$("departmentAuditTime").innerHTML=departmentAuditTime.substring(0,4)+"年 "+departmentAuditTime.substring(5,7)+"月 "
 				+departmentAuditTime.substring(8,10)+"日";
 			}
 		}
	});
}
function save(){
	var applyRecord=applyDs.getCurrent();
	var command=new L5.Command("com.inspur.cams.marry.application.cmd.MrmLevelApplyCmd");
	command.setParameter("applyRecord",applyRecord);
	command.execute("update");
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
function showDiv(){
	if(!_$("applyLevel")){
		L5.Msg.alert("提示","请选择申报等级！");
		return false;
	}
	$("jgDiv").style.display="";
	$("djyDiva").style.display="";
	$("djyDivb").style.display="";
	$("bzyDiv").style.display="";
	
	$("fdyDiv").style.display="";
	$("maWinDiv").style.display="";
	$("maAreaDiv").style.display="";
	$("hdtbchiarDiv").style.display="";
	$("lhAreaWinDiv").style.display="";
	$("fdsDiv").style.display="";
	$("bzdtDiv").style.display="";
	
	$("threeResDiv").style.display="";
	$("fourResDiv").style.display="";
	
	$("wlyyDiv").style.display="";
	$("fourResDiv").style.display="";
	$("fourResDiv").style.display="";
	checkLevel();

}
//返回
function undo(){
 	history.go(-1);
}
function submit(){
	if(!checkSave()){
		return false;
	}
	
	if(organType == '0'){
		curOrganCode="999";
		curOrganName="中华人民共和国民政部";
	}
	var applyRecord=applyDs.getCurrent();
	//applyRecord.set("curOrganCode",curOrganCode);
	//applyRecord.set("curOrganName",curOrganName);
	applyRecord.set("dealOrganType",organType);
	var command=new L5.Command("com.inspur.cams.marry.application.cmd.MrmLevelApplyCmd");
	command.setParameter("applyRecord",applyRecord);
	command.execute("updateAndSend");
	if (!command.error) {
		L5.Msg.alert('提示',"提交成功!",function(){
			undo();
		});
	}else{
		L5.Msg.alert('提示',"提交时出现错误！"+command.error);
	}
}

function checkSave(){
	var applyRecord=applyDs.getCurrent();
	if(organType=="13" && !applyRecord.get("townOpinionId")){
		L5.Msg.alert('提示',"县级人民政府民政部门审核意见不能为空!");
		return false;
	}
	if(organType=="12" && !applyRecord.get("cityOpinionId")){
		L5.Msg.alert('提示',"地市级人民政府民政部门审核意见不能为空!");
		return false;
	}
	if(organType=="11" && !applyRecord.get("provinceOpinionId")){
		L5.Msg.alert('提示',"省级人民政府民政部门审核意见不能为空!");
		return false;
	}
	if(organType=="0" && !applyRecord.get("departmentOpinionId")){
		L5.Msg.alert('提示',"民政部审批意见不能为空!");
		return false;
	}
	return true;
}