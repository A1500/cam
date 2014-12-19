function init() {
	if(method=="INSERT"){
		somOrganDataSet.newRecord({"cnName":userId,"sorgCode":sorgCode,"sorgId":sorgId,"sorgStatus":'31',"sorgType":"M","ifBranch":'0',"morgName":userId,"morgArea":morgArea});
		somApplyDataSet.newRecord({"sorgName":userId,"curActivity":"受理","curOpinionId":"1","taskCode":taskCode,"dataSource":"ONLINE","sorgType":"M","acceptArea":morgArea,"createOrgan":morgArea,"createPerson":userId,"ifFinish":"0"});
		somElectronicDataSet_load();
	}else{
		somOrganDataSet.setParameter("SORG_ID",sorgId);
		somOrganDataSet.load();
		//加载电子档案
		somElectronicDataSet_load();
	}
	somOrganDataSet.on("load",function(){
		somApplyDataSet.setParameter("TASK_CODE", taskCode);
		somApplyDataSet.load();
		somApplyDataSet.on("load",loadSomLiqpeopleDataSet);
	});
	//电子档案上传窗口关闭事件
	var win=L5.getCmp("uploadList");
	win.on("hide",function(el){
		somElectronicDataSet_load();
	});
	L5.QuickTips.init();
}
function loadSomLiqpeopleDataSet(){
	//加载社会组织清算组织人员信息
	somLiqpeopleDataSet.setParameter("SORG_ID@=",sorgId);
	somLiqpeopleDataSet.load();
}
function loadCancelReasonDesc(){
	if(_$("cancelReason") == "4"){
		$("cancelReasonDescTr").style.display = "block";
	}else{
		$("cancelReasonDescTr").style.display = "none";
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
	if(somOrganDataSetIsValidate!=true){
		L5.Msg.alert("提示",somOrganDataSetIsValidate);
		L5.getCmp("tabSomOrgan").setActiveTab("0");
		return;
	}
	//校验社会组织清算人员信息
	//if(somLiqpeopleDataSet.getCount() < 1){
		//L5.Msg.alert("提示","还未增加清算组织人员");
		//L5.getCmp("tabSomOrgan").setActiveTab("1");
		//return;
	//}
	//校验业务意见
	if(somApplyDataSetIsValidate!=true){
		L5.Msg.alert("提示",somApplyDataSetIsValidate);
		L5.getCmp("tabSomOrgan").setActiveTab("0");
		return;
	}

	/*var somOrganQueryDataSet = L5.DatasetMgr.lookup("somOrganQueryDataSet");
	somOrganQueryDataSet.setParameter("SORG_ID@=", sorgId);
	somOrganQueryDataSet.on("load",function(ds){
		var sorgStatus = ds.get("sorgStatus");
		if(method=="INSERT"){
			if(sorgStatus!="22"){
				L5.Msg.alert("提示","社会团体不是已成立状态，不能进行注销操作！",function(){
					goBack();
				});
				return;
			}
		}else{
			if(sorgStatus!="32"){
				L5.Msg.alert("提示","社会团体不是已注销状态，不能进行修改操作！",function(){
					goBack();
				});
				return;
			}
		}
	});*/

		//查看是否已注销分支
		/*command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomOrganCmd");
		command.setParameter("mainSorgId",sorgId);
		command.execute("branchStatusNum");
		var branchNum = command.getReturn("num");
		if(branchNum != 0){
			somOrganDataSet.newRecord();
			L5.Msg.alert("提示","该社会团体还有"+branchNum+"个未被注销的分支(代表)机构，请先将其注销！",function(){
				goBack();
			});
			return;
		}	*/

	var command = new L5.Command("com.inspur.cams.sorg.online.apply.ungov.cmd.SomUngovOnlineCmd");
	//提交保存
	somApplyRd.set("sorgName",somOrganRd.get("cnName"));
	somApplyRd.set("borgName",somOrganRd.get("borgName"));
	command.setParameter("somOrganRd",somOrganRd);
	command.setParameter("somLiqpeopleRds",somLiqpeopleRds);
	command.setParameter("somApplyRd",somApplyRd);
	if(method=="INSERT"){
		command.execute("saveCancel");
	}else if(method=="UPDATE"){
		command.execute("updateCancel");
	}
	if(!command.error){
		somLiqpeopleDataSet.commitChanges();
		L5.Msg.alert('提示','保存成功！',function(){
			//goBack();
			method="UPDATE";
			somOrganDataSet.setParameter("SORG_ID",sorgId);
			somOrganDataSet.load();
		});
	}else{
		L5.Msg.alert("错误","保存时出现错误！"+command.error);
	}
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


//点击增加上传附件按钮
function clickUploadFile(){
	uploadFile();
}