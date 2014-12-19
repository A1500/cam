var sorgId="";
var taskCode="";
var mainSorgId="";
var applyType="206";
function init() {	
	somApplyDataSet.setParameter("PROCESS_ID@=", processId);
	somApplyDataSet.load();
	somApplyDataSet.on("load", loadInfo);
	
	//过滤tab页
	if(method == "yiban"||method=="end"){
		L5.getCmp("tab").remove(3);
	}
			
	//电子档案上传窗口关闭事件
	var win=L5.getCmp("uploadList");
	if(win!=null){
		win.on("hide",function(el){
			somElectronicDataSet_load();
		});		
	}
	//过滤处理意见	
	opinionSelect.filterBy(function(record, id){
		if(act=="watch"){
			if("0,1".indexOf(record.get("value"))>-1){
				return record;
			}
		}else if(act=="examin"){
			if("0,1,2".indexOf(record.get("value"))>-1){
				return record;
			}
		}else if(act=="check"){
			if("0,1,2".indexOf(record.get("value"))>-1){
				return record;
			}
		}else if(act=="audit"){
			if("0,1,2".indexOf(record.get("value"))>-1){
				return record;
			}
		}else if(act=="regain"){
			if("1".indexOf(record.get("value"))>-1){
				return record;
			}
		}else if(act=="inform"){
			if("1".indexOf(record.get("value"))>-1){
				return record;
			}
		}
	});
	L5.QuickTips.init();
}
function loadInfo(){
	var somApplyRd=somApplyDataSet.getCurrent();
	sorgId = somApplyRd.get("sorgId");
	taskCode = somApplyRd.get("taskCode");
	somApplyRd.set("curActivity", getActDefName());
	somApplyRd.set("curOpinionId", "1");	
	if(act=='inform'){//是通知受理人
		var somFlowQuery=L5.DatasetMgr.lookup("somFlowQuery");
		somFlowQuery.setParameter("TASK_CODE@=",taskCode);
		somFlowQuery.setParameter("ACTIVITY@=","批准");
		somFlowQuery.setParameter("OPINION_ID@=","1");
		somFlowQuery.load();
		somFlowQuery.on('load',function (ds){
			if(ds.getCount()==0){
				somApplyDataSet.getCurrent().set("curOpinionId","0");
				//过滤流程意见
				opinionSelect.filterBy(function(record, id){
					if("0".indexOf(record.get('value'))>-1){
						return record;
					}
				});
				//document.getElementById("curOpinionId").disabled="disabled";
			}else if(ds.getCount()==1){
				somApplyDataSet.getCurrent().set("curOpinionId","1");
				//过滤流程意见
				opinionSelect.filterBy(function(record, id){
					if("1".indexOf(record.get('value'))>-1){
						return record;
					}
				});
				//document.getElementById("curOpinionId").disabled="disabled";
			}
		});
	}	
	//社会组织信息
	somOrganDataSet.setParameter("SORG_ID@=",sorgId);
	somOrganDataSet.load();
	//电子档案
	somElectronicDataSet_load();
	//流程历史意见
	somFlowDataSet.setParameter("TASK_CODE@=", taskCode);
	somFlowDataSet.load();
}
function getActDefName(){
	if(act=="watch"){
		return "现场勘查";
	}else if(act=="examin"){
		return "初审";
	}else if(act=="check"){
		return "审核";
	}else if(act=="audit"){
		return "批准";
	}else if(act=="regain"){
		return "颁发注销证明文件";
	}else if(act=="inform"){
		return "通知申请人";
	}else if(act=='supply'){
		return "补齐补正";
	}else{
		return "受理";
	}
}

//保存
function save(){
	var somOrganRd = somOrganDataSet.getCurrent();	
	var somApplyRd = somApplyDataSet.getCurrent();	
	var somOrganDataSetIsValidate = somOrganDataSet.isValidate();
	var somApplyDataSetIsValidate = somApplyDataSet.isValidate();
	//校验社会组织信息
	/*if(somOrganDataSetIsValidate!=true){
		L5.Msg.alert("提示",somOrganDataSetIsValidate);
		L5.getCmp("tabSomOrgan").setActiveTab("0");
		return;
	}*/
	//校验业务意见
	if(somApplyDataSetIsValidate!=true){
		L5.Msg.alert("提示",somApplyDataSetIsValidate);
		L5.getCmp("tabSomOrgan").setActiveTab("2");
		return;
	}
	
	var command = new L5.Command("com.inspur.cams.sorg.apply.fund.cmd.FundBranchCancelCmd");	
	command.setParameter("somOrganRd",somOrganRd);
	command.setParameter("somApplyRd",somApplyRd);
	command.execute("update");
	if(!command.error){	
		L5.Msg.alert("提示","保存成功！",function(){
			goBack();
		});
	}else{
		L5.Msg.alert("错误","保存时出现错误！"+command.error);	
	}
}
//提交
function submit(){
	var somOrganRd = somOrganDataSet.getCurrent();	
	var somApplyRd = somApplyDataSet.getCurrent();
	var somOrganDataSetIsValidate = somOrganDataSet.isValidate();
	var somApplyDataSetIsValidate = somApplyDataSet.isValidate();
	//校验社会组织信息
	/*if(somOrganDataSetIsValidate!=true){
		L5.Msg.alert("提示",somOrganDataSetIsValidate);
		L5.getCmp("tabSomOrgan").setActiveTab("0");
		return;
	}*/
	if(somApplyDataSetIsValidate!=true){
		L5.Msg.alert("提示",somApplyDataSetIsValidate);
		L5.getCmp("tabSomOrgan").setActiveTab("2");
		return;
	}
	
	var command = new L5.Command("com.inspur.cams.sorg.apply.fund.cmd.FundBranchCancelCmd");	
	command.setParameter("somOrganRd",somOrganRd);
	command.setParameter("somApplyRd",somApplyRd);
	command.execute("updateAndSend");
	if(!command.error){
		if(act=='inform' ){
			L5.Msg.alert("提示","成功结束流程!",function(){
				window.history.go(-1);
			});
		}else{
			L5.Msg.alert("提示","成功提交至下一环节!",function(){
				if(act == 'audit'){
					if(somApplyRecord.get("curOpinionId")=="1"){ //同意-批准通过-根据taskCode更改外网业务状态
						updateOnlineStatusPass(somApplyRd.get("taskCode"));
					}
					if(somApplyRecord.get("curOpinionId")=="0"){ //不同意-批准不通过-根据taskCode更改外网业务状态
						updateOnlineStatusNoPass(somApplyRd.get("taskCode"));
					}
				}
				window.history.go(-1);
			});
		}
	}else{
		L5.Msg.alert("提示","提交时出现错误！"+command.error);
	}
}
//返回
function goBack(){
	history.go(-1);
}

//查看流程历史意见
function detailSomFlow(){
	var grid = L5.getCmp("gridSomFlow");
	var sm = grid.getSelectionModel();
	var record = sm.getSelected();
	if(!record){
		L5.Msg.alert("提示","请选择一条记录!");
		return;
	}
	var winSomFlowDataSet = L5.DatasetMgr.lookup("winSomFlowDataSet");
	winSomFlowDataSet.removeAll();
	var newRecord = winSomFlowDataSet.newRecord();
	var win = L5.getCmp("winSomFlow");
	win.show();
	newRecord.set("activity",record.get("activity"));
	newRecord.set("organId",record.get("organId"));
	newRecord.set("deptId",record.get("deptId"));
	newRecord.set("actorId",record.get("actorId"));
	newRecord.set("commitTime",record.get("commitTime"));
	newRecord.set("opinionId",record.get("opinionId"));
	newRecord.set("opinion",record.get("opinion"));
}
//关闭流程历史意见窗口
function winCloseSomFlow(){
	var win = L5.getCmp("winSomFlow");
	win.setVisible(false);
}
