var sorgId="";
var sorgIdExist='';
var applyType="103";
function init() {
	somApplyDataSet.setParameter("TASK_CODE@=", taskCode);
	somApplyDataSet.on("load", loadInfo);
	somApplyDataSet.load();
	//电子档案上传窗口关闭事件
	var win=L5.getCmp("uploadList");
	win.on("hide",function(el){
		somElectronicDataSet_load();
	});	
	//过滤处理意见
	opinionSelect.filterBy(function(record, id){
		if("1".indexOf(record.get("value"))>-1){
			return record;
		}
	});
	L5.QuickTips.init();
}
function loadInfo(){
	//加载社会组织信息
	sorgId = somApplyDataSet.get("sorgId");
	somOrganQueryDataSet.setParameter("SORG_ID@=", sorgId);
	somOrganQueryDataSet.on("load",function(){
		loadSorg();
	});
	somOrganQueryDataSet.load();
	//加载社会组织清算组织人员信息
	somLiqpeopleDataSet.setParameter("SORG_ID@=",sorgId);
	somLiqpeopleDataSet.load();
	//加载电子档案
	somElectronicDataSet_load();
}
//根据登记证号加载社会组织信息
function loadSorg(){
	var sorgCode=somOrganQueryDataSet.get("sorgCode");
	if(sorgCode==null||sorgCode==""){
		return;
	}
	somOrganDataSet.setParameter("SORG_CODE",sorgCode);
	somOrganDataSet.setParameter("SORG_TYPE","M");
	somOrganDataSet.setParameter("SORG_STATUS@=","22");
	somOrganDataSet.setParameter("MORG_AREA@=",morgArea);
	somOrganDataSet.load();
	somOrganDataSet.on("load",funAdd);	
}
//加载时触发事件
function funAdd(somOrganDataset){
	var num=somOrganDataset.getCount();
	if(num!=1){
		somOrganDataSet.newRecord();
		document.forms["cbForm"].reset();
		L5.Msg.alert("提示","根据录入的登记证号没有查到相应的社会组织，不能进行注销登记，请确认并修改登记证号！");
	}else{
		sorgIdExist=somOrganDataset.get("sorgId");
		somOrganDataSet.set("cancelDate",somOrganQueryDataSet.get("cancelDate"));
		somOrganDataSet.set("cancelReason",somOrganQueryDataSet.get("cancelReason"));
		somOrganDataSet.set("liqResult",somOrganQueryDataSet.get("liqResult"));
	}
}
//根据登记证号加载社会组织信息
function checkSorgCode(){
	var sorgCode=_$("sorgCode");
	if(sorgCode==null||sorgCode==""){
		return;
	}
	somOrganDataSet.setParameter("SORG_CODE",sorgCode);
	somOrganDataSet.setParameter("SORG_TYPE","M");
	somOrganDataSet.setParameter("SORG_STATUS@=","22");
	somOrganDataSet.setParameter("MORG_AREA@=",morgArea);
	somOrganDataSet.load();
}
//保存
function save(){
	var somOrganRd = somOrganDataSet.getCurrent();	
	var somLiqpeopleRds = somLiqpeopleDataSet.getAllRecords();
	for(var i=0;i<somLiqpeopleRds.length;i++){
			somLiqpeopleRds[i].state = L5.model.Record.STATE_NEW;
			somLiqpeopleRds[i].set("sorgId",sorgIdExist);
	}
	var somApplyRd = somApplyDataSet.getCurrent();
	somApplyRd.set("sorgId",sorgIdExist);
	//somOrganRd.set("cancelDate",_$("cancelDate"));
	//somOrganRd.set("cancelReason",_$("cancelReason"));
	//somOrganRd.set("cancelReasonDesc",_$("cancelReasonDesc"));
	//somOrganRd.set("liqResult",_$("liqResult"));
	var somOrganDataSetIsValidate = somOrganDataSet.isValidate();
	var somApplyDataSetIsValidate = somApplyDataSet.isValidate();
	//校验社会组织信息
	if(somOrganDataSetIsValidate!=true){
		L5.Msg.alert("提示",somOrganDataSetIsValidate);
		L5.getCmp("tabSomOrgan").setActiveTab("0");
		return;
	}
	//校验社会组织清算人员信息
	/*if(somLiqpeopleDataSet.getCount() < 1){
		L5.Msg.alert("提示","还未增加清算组织人员");
		L5.getCmp("tabSomOrgan").setActiveTab("1");
		return;
	}*/
	//校验业务意见
	if(somApplyDataSetIsValidate!=true){
		L5.Msg.alert("提示",somApplyDataSetIsValidate);
		L5.getCmp("tabSomOrgan").setActiveTab("0");
		return;
	}	
	
	var command = new L5.Command("com.inspur.cams.sorg.apply.ungov.cmd.UngovCancelCmd");
	//查看社会组织状态
	command.setParameter("sorgId",sorgIdExist);
	command.execute("querySorgStatus");
	var sorgStatus = command.getReturn("sorgStatus");
	if(sorgStatus!="22"){
		L5.Msg.alert("提示","民办非企业单位不是已成立状态，不能进行注销操作！",function(){
			goBack();
		});
		return;
	}	

	command = new L5.Command("com.inspur.cams.sorg.apply.ungov.cmd.UngovCancelCmd");
	//提交保存
	command.setParameter("somOrganRd",somOrganRd);
	command.setParameter("somLiqpeopleRds",somLiqpeopleRds);	
	command.setParameter("somApplyRd",somApplyRd);
	command.execute("create");
	if(!command.error){	
		somLiqpeopleDataSet.commitChanges();
		var url='jsp/cams/sorg/online/preapply/ungov/cancel/ungovCancelPreList.jsp';
		L5.Msg.alert('提示','保存成功！',function(){	
			updateOnlineStatusAccept();
			L5.forward(url);
		});
	}else{
		L5.Msg.alert("错误","保存时出现错误！"+command.error);	
	}
}
//提交
function submit() {
	var somOrganRd = somOrganDataSet.getCurrent();	
	var somLiqpeopleRds = somLiqpeopleDataSet.getAllRecords();
	var somApplyRd = somApplyDataSet.getCurrent();
	for(var i=0;i<somLiqpeopleRds.length;i++){
			somLiqpeopleRds[i].state = L5.model.Record.STATE_NEW;
			somLiqpeopleRds[i].set("sorgId",sorgIdExist);
	}
	somApplyRd.set("sorgId",sorgIdExist);
	//somOrganRd.set("cancelDate",_$("cancelDate"));
	//somOrganRd.set("cancelReason",_$("cancelReason"));
	//somOrganRd.set("cancelReasonDesc",_$("cancelReasonDesc"));
	//somOrganRd.set("liqResult",_$("liqResult"));	
	var somOrganDataSetIsValidate = somOrganDataSet.isValidate();
	var somApplyDataSetIsValidate = somApplyDataSet.isValidate();
	//校验社会组织信息
	if(somOrganDataSetIsValidate!=true){
		L5.Msg.alert("提示",somOrganDataSetIsValidate);
		L5.getCmp("tabSomOrgan").setActiveTab("0");
		return;
	}
	//校验社会组织清算人员信息
	/*if(somLiqpeopleDataSet.getCount() < 1){
		L5.Msg.alert("提示","还未增加清算组织人员");
		L5.getCmp("tabSomOrgan").setActiveTab("1");
		return;
	}*/
	//校验业务意见
	if(somApplyDataSetIsValidate!=true){
		L5.Msg.alert("提示",somApplyDataSetIsValidate);
		L5.getCmp("tabSomOrgan").setActiveTab("0");
		return;
	}

	var command = new L5.Command("com.inspur.cams.sorg.apply.ungov.cmd.UngovCancelCmd");
	//查看社会组织状态
	command.setParameter("sorgId",sorgIdExist);
	command.execute("querySorgStatus");
	var sorgStatus = command.getReturn("sorgStatus");
	if(sorgStatus!="22"){
		L5.Msg.alert("提示","民办非企业单位不是已成立状态，不能进行注销操作！",function(){
			goBack();
		});
		return;
	}	

	command = new L5.Command("com.inspur.cams.sorg.apply.ungov.cmd.UngovCancelCmd");
	command.setParameter("somOrganRd",somOrganRd);
	command.setParameter("somLiqpeopleRds",somLiqpeopleRds);
	command.setParameter("somApplyRd",somApplyRd);
	command.execute("createAndSend");
	if(!command.error){
		somLiqpeopleDataSet.commitChanges();
		var url='jsp/cams/sorg/online/preapply/ungov/cancel/ungovCancelPreList.jsp';
		L5.Msg.alert('提示','成功提交至下一环节！',function(){
		updateOnlineStatusAccept();	
			L5.forward(url);
		});
	}else{
		L5.Msg.alert("提示","提交时出现错误！"+command.error);
	}
}
//打印不予受理通知
function printNoAccept(){
	var cnName=$("cnName").innerHTML;
	if(cnName==""){
		L5.Msg.alert("提示","请先输入民办非企业单位登记证号！");
		return;
	}
	var url=rootPath+"/jsp/cams/sorg/comm/print/noAcceptForPrint.jsp?sorgType=M";
	url+="&taskCode="+taskCode+"&applyType="+applyType+"&cnName="+encodeURIComponent(encodeURIComponent(cnName));	
	window.open(url);
}
//打印受理通知
function printAccept(){
	var cnName=$("cnName").innerHTML;
	if(cnName==""){
		L5.Msg.alert("提示","请先输入民办非企业单位登记证号！");
		return;
	}
	var url=rootPath+"/jsp/cams/sorg/comm/print/acceptForPrint.jsp?sorgType=M";
	url+="&taskCode="+taskCode+"&applyType="+applyType+"&cnName="+encodeURIComponent(encodeURIComponent(cnName));	
	window.open(url);
}
//打印一次性补正材料通知
function sendForPolishing(){

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

//确认流程历史意见窗口
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
