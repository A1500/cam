var sorgId="";
var taskCode="";
var applyType="203";
function init() {	
	somApplyDataSet.setParameter("PROCESS_ID@=", processId);
	somApplyDataSet.load();
	somApplyDataSet.on("load", loadInfo);
	
	//过滤tab页
	if(method == "yiban"||method=="end"){
		L5.getCmp("tab").remove(4);
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
	somApplyDataSet.set("curActivity", getActDefName());
	sorgId = somApplyDataSet.get("sorgId");
	taskCode = somApplyDataSet.get("taskCode");
	somApplyDataSet.set("curOpinionId", "1");	
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
	//社会组织清算组织人员信息
	somLiqpeopleDataSet.setParameter("SORG_ID@=",sorgId);
	somLiqpeopleDataSet.load();	
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
	var somLiqpeopleRds = somLiqpeopleDataSet.getAllChangedRecords();
	var somApplyRd = somApplyDataSet.getCurrent();	
	var somOrganDataSetIsValidate = somOrganDataSet.isValidate();
	var somApplyDataSetIsValidate = somApplyDataSet.isValidate();
	//校验社会组织信息
	/*if(somOrganDataSetIsValidate!=true){
		L5.Msg.alert("提示",somOrganDataSetIsValidate);
		L5.getCmp("tabSomOrgan").setActiveTab("0");
		return;
	}*/
	//校验社会组织清算人员信息
	/*if(somLiqpeopleDataSet.getCount() < 1){
		L5.Msg.alert("提示","还未增加清算组织人员");
		L5.getCmp("tabSomOrgan").setActiveTab("1");
		return;
	}*/
	//校验业务意见
	if(somApplyDataSetIsValidate!=true){
		L5.Msg.alert("提示",somApplyDataSetIsValidate);
		L5.getCmp("tabSomOrgan").setActiveTab("3");
		return;
	}
	
	var command = new L5.Command("com.inspur.cams.sorg.apply.fund.cmd.FundCancelCmd");
	command.setParameter("somOrganRd",somOrganRd);
	if(somLiqpeopleRds!=null){
		command.setParameter("somLiqpeopleRds",somLiqpeopleRds);	
	}
	command.setParameter("somApplyRd",somApplyRd);
	command.execute("update");
	if(!command.error){	
		somLiqpeopleDataSet.commitChanges();
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
	var somLiqpeopleRds = somLiqpeopleDataSet.getAllChangedRecords();
	var somApplyRd = somApplyDataSet.getCurrent();
	var somOrganDataSetIsValidate = somOrganDataSet.isValidate();
	var somApplyDataSetIsValidate = somApplyDataSet.isValidate();
	//校验社会组织信息
	/*if(somOrganDataSetIsValidate!=true){
		L5.Msg.alert("提示",somOrganDataSetIsValidate);
		L5.getCmp("tabSomOrgan").setActiveTab("0");
		return;
	}*/
	//校验社会组织清算人员信息
	/*if(somLiqpeopleDataSet.getCount() < 1){
		L5.Msg.alert("提示","还未增加清算组织人员");
		L5.getCmp("tabSomOrgan").setActiveTab("1");
		return;
	}*/	
	if(somApplyDataSetIsValidate!=true){
		L5.Msg.alert("提示",somApplyDataSetIsValidate);
		L5.getCmp("tab").setActiveTab("3");
		return;
	}
	
	var command = new L5.Command("com.inspur.cams.sorg.apply.fund.cmd.FundCancelCmd");
	command.setParameter("somOrganRd",somOrganRd);
	if(somLiqpeopleRds!=null){
		command.setParameter("somLiqpeopleRds",somLiqpeopleRds);	
	}
	command.setParameter("somApplyRd",somApplyRd);
	command.execute("updateAndSend");
	if(!command.error){
		somLiqpeopleDataSet.commitChanges();
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
function printYesCancel(){

}
//返回
function goBack(){
	history.go(-1);
}

var liqpeopleRecord=null;
//增加清算组织人员
function addLiqpeople(){
	liqpeopleRecord=null;
	var grid = L5.getCmp("gridLiqpeople");
	grid.stopEditing();
	var winLiqpeopleDataSet=L5.DatasetMgr.lookup("winLiqpeopleDataSet");
	winLiqpeopleDataSet.removeAll();
	winLiqpeopleDataSet.newRecord({"ifChief":"1"});
	var win = L5.getCmp("winLiqpeople");
	win.show();
}
//修改清算组织人员
function editLiqpeople(){
	var grid = L5.getCmp("gridLiqpeople");
	var sm = grid.getSelectionModel();
	var record = sm.getSelected();
	if(!record){
		L5.Msg.alert("提示","请选择一条记录!");
		return;
	}
	liqpeopleRecord=record;
	var winLiqpeopleDataSet=L5.DatasetMgr.lookup("winLiqpeopleDataSet");
	winLiqpeopleDataSet.removeAll();
	var newRecord = winLiqpeopleDataSet.newRecord();
	var win = L5.getCmp("winLiqpeople");
	win.show();
	newRecord.set("name",record.get("name"));
	newRecord.set("workName",record.get("workName"));
	newRecord.set("workDuties",record.get("workDuties"));
	newRecord.set("liqDuties",record.get("liqDuties"));
	newRecord.set("ifChief",record.get("ifChief"));
}
//删除清算组织人员
function delLiqpeople(){
	var grid = L5.getCmp("gridLiqpeople");
	var sm = grid.getSelectionModel();
	var record = sm.getSelected();
	if(!record){
		L5.Msg.alert("提示","请选中一行后删除!");
		return;
	}
	L5.MessageBox.confirm('确定', '你确定要删除吗？',function(sta){
		if(sta=="yes"){	
			var somLiqpeopleRd = somLiqpeopleDataSet.getCurrent();
			somLiqpeopleDataSet.remove(somLiqpeopleRd);
		}
	});
}
//确定添加清算组织成员
function saveWinLiqpeople(){
	//清算人员信息校验
	var winLiqpeopleDataSet=L5.DatasetMgr.lookup("winLiqpeopleDataSet");
	var winLiqpeopleDataSetIsValidate = winLiqpeopleDataSet.isValidate();
	if(winLiqpeopleDataSetIsValidate!=true){	
		L5.Msg.alert("提示",winLiqpeopleDataSetIsValidate);
		return;
	}	
	var currentRecord = winLiqpeopleDataSet.getCurrent();
	if(liqpeopleRecord == null){
		somLiqpeopleDataSet.insert(somLiqpeopleDataSet.getCount(),currentRecord);
	}else{
		liqpeopleRecord.set("name",currentRecord.get("name"));
		liqpeopleRecord.set("workName",currentRecord.get("workName"));
		liqpeopleRecord.set("workDuties",currentRecord.get("workDuties"));
		liqpeopleRecord.set("liqDuties",currentRecord.get("liqDuties"));
		liqpeopleRecord.set("ifChief",currentRecord.get("ifChief"));
	}
	var win = L5.getCmp("winLiqpeople");
	win.setVisible(false);
}
//取消清算组织人员
function undoLiqpeople(){
	somLiqpeopleDataSet.rejectChanges();
}
//关闭添加清算组织成员
function closeWinLiqpeople(){
	var win = L5.getCmp("winLiqpeople");
	win.setVisible(false);
}

//查看清算组织人员信息
function detailSomLiqpeople(){
	var grid = L5.getCmp("gridSomLiqpeople");
	var sm = grid.getSelectionModel();
	var record = sm.getSelected();
	if(!record){
		L5.Msg.alert("提示","请选择一条记录!");
		return;
	}
	var winSomLiqpeopleDataSet = L5.DatasetMgr.lookup("winSomLiqpeopleDataSet");
	winSomLiqpeopleDataSet.removeAll();
	var newRecord = winSomLiqpeopleDataSet.newRecord();
	var win = L5.getCmp("winSomLiqpeople");
	win.show();
	newRecord.set("name",record.get("name"));
	newRecord.set("workName",record.get("workName"));
	newRecord.set("workDuties",record.get("workDuties"));
	newRecord.set("liqDuties",record.get("liqDuties"));
	newRecord.set("ifChief",record.get("ifChief"));
}
//关闭清算组织人员信息窗口
function winCloseSomLiqpeople(){
	var win = L5.getCmp("winSomLiqpeople");
	win.setVisible(false);
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
