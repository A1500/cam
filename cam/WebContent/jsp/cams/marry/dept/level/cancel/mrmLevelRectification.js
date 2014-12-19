var mesg="noCheck";
var jgxz="";
var deptName= '' ;
var organCode = '';
function init() {
	var infocommand = new L5.Command("com.inspur.cams.comm.informUtil.InformSessionCmd");
	infocommand.execute("getUserInfo");
	var userLoginName ="";
	if (!infocommand.error) {
		var info = infocommand.getReturn("userInfo");
	  	userLoginName =info.userLoginName;//通过登录账号查找对应的婚姻登记处。
	  	organCode =info.cantCode;//通过登录账号查找对应的婚姻登记处。
	}
	deptNameDataSet.setParameter("DEPT_CODE@=",deptCode);
 	deptNameDataSet.load();
 	deptNameDataSet.on('load',function(){
 		deptName= deptNameDataSet.get("name");
 		ds.setParameter("DEPT_CODE@=",deptCode);
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
			var applyDs=L5.DatasetMgr.lookup("applyDs");
			if(method=="UPDATE" || method=="END"){
			    applyDs.setParameter("APPLY_ID@=",applyId);
			 	applyDs.load();
			}else{
				applyDs.newRecord({"applyId":appId,"applyType":applyType,"organName":deptName,"organCode":deptCode,
					"applyLevel":skinValue,"applyTime":curDate, "cancelOrganName":organName, 
						"organLevel":organCode.indexOf("000000"),"organType":jgxz,"ifFinish":"0",
							"townOrganName":organName,"cityOrganName":cityName+"民政局",
								"provinceOrganName":"山东省民政厅","departmentOrganName":"中华人民共和国民政部"});
			}
	 	
		});
 	});
}
//保存按钮
function save(){
	var applyDsIsValidate = applyDs.isValidate();
	if(applyDsIsValidate != true){
		L5.Msg.alert("提示",applyDsIsValidate);
		return false;
	}
	
	var applyRecord=applyDs.getCurrent();
	applyRecord.set('dealOrganType',organType);
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
//返回
function undo(){
 	history.go(-1);
}
//提交按钮
function submit(){
	var applyDsIsValidate = applyDs.isValidate();
	if(applyDsIsValidate != true){
		L5.Msg.alert("提示",applyDsIsValidate);
		return false;
	}
	
	var applyRecord=applyDs.getCurrent();
	var command=new L5.Command("com.inspur.cams.marry.application.cmd.MrmLevelApplyCmd");
	applyRecord.set('townOpinionId',"1");
	applyRecord.set('dealOrganType',organType);
	command.setParameter("applyRecord",applyRecord);
	if(method=="UPDATE"){
		command.execute("updateAndSend");
	}else if(method=="INSERT"){
		command.execute("insertAndSend");
	}else{
		command.execute("updateAndSend");
	}
	
	if (!command.error) {
		L5.Msg.alert('提示',"提交成功!",function(){
			undo();
		});
	}else{
		L5.Msg.alert('提示',"提交时出现错误！"+command.error);
	}
}

function submitEnd(){
	var applyRecord=applyDs.getCurrent();
	applyRecord.set("departmentOpinionId","1");
	submit();
}

function cancelEnd(){
	var applyRecord=applyDs.getCurrent();
	applyRecord.set("departmentOpinionId","0");
	submit();
}
